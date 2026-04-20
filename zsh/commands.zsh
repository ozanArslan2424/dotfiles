function lfcd() {
	cd "$(command lf -print-last-dir "$@")"
}


function rangercd() {
	local tmp="$(mktemp -t "ranger-cwd.XXXXXX")" cwd
	ranger "$@" --choosedir="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function gap() {
	if [ -z "$1" ]; then
		echo "Commit message required"
		return 1
	fi

	git add .
	git commit -a -m "$1"
	git push
}

function listports() {
	local filter="${1:-}"

	local output
	output=$(lsof -iTCP -iUDP -nP 2>/dev/null | grep LISTEN)

	if [ -z "$output" ]; then
		echo "No listening ports found"
		return 0
	fi

	printf "%-10s %-8s %-8s %s\n" "PORT" "PID" "PROTO" "COMMAND"
	printf "%-10s %-8s %-8s %s\n" "----" "---" "-----" "-------"

	echo "$output" | awk '!seen[$2$9]++' | while IFS= read -r line; do
		local cmd pid proto port
		cmd=$(awk '{print $1}' <<< "$line")
		pid=$(awk '{print $2}' <<< "$line")
		proto=$(awk '{print $8}' <<< "$line")
		port=$(awk '{print $9}' <<< "$line" | rev | cut -d: -f1 | rev)

		if [ -n "$filter" ] && [[ "$port" != *"$filter"* ]] && [[ "$cmd" != *"$filter"* ]]; then
			continue
		fi

		printf "%-10s %-8s %-8s %s\n" "$port" "$pid" "$proto" "$cmd"
	done
}

function killport() {
	if [ -z "$1" ]; then
		echo "Usage: killport <port>"
		return 1
	fi

	local pids=$(lsof -ti:"$1")

	if [ -z "$pids" ]; then
		echo "No processes found on port $1"
		return 0
	fi

	echo "Killing processes on port $1: $pids"
	kill -9 $pids 2>/dev/null
}


function pngtojpg() {
	# Convert PNG to JPG
	# Usage: pngToJpg input.png output.jpg
	ffmpeg -i "$1" -q:v 2 "$2"
}

function pngtowebp() {
	# Convert PNG to WEBP
	# Usage: pngtowebp input.png output.webp
	ffmpeg -i "$1" -q:v 80 "$2"
}

function alljpgtowebp() {
	# Converts all .jpg and .jpeg images in a folder to .webp format
	# Usage: alljpgtowebp /path/to/folder

	# Check if the folder exists
	if [ ! -d "$1" ]; then
		echo "Directory $1 does not exist."
		return 1
	fi

	# Loop over all .jpg and .jpeg files in the directory
	for img in "$1"/*.{jpg,jpeg}; do
		if [ -f "$img" ]; then
			# Get the filename without extension
			filename=$(basename "$img" | sed 's/\.[^.]*$//')
			# Convert to .webp
			ffmpeg -i "$img" -q:v 80 "$1/$filename.webp"
			echo "Converted $img to $filename.webp"
		fi
	done
}

function allpngtowebp() {
	# Converts all .png images in a folder to .webp format
	# Usage: allpngtowebp /path/to/folder

	# Check if the folder exists
	if [ ! -d "$1" ]; then
		echo "Directory $1 does not exist."
		return 1
	fi

	# Loop over all .png files in the directory
	for img in "$1"/*.png; do
		if [ -f "$img" ]; then
			# Get the filename without extension
			filename=$(basename "$img" | sed 's/\.[^.]*$//')
			# Convert to .webp
			ffmpeg -i "$img" -q:v 80 "$1/$filename.webp"
			echo "Converted $img to $filename.webp"
		fi
	done
}

function shrinkpdf() {
	# Usage: shrinkpdf input.pdf output.pdf [screen|ebook|printer|prepress|default]
	gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"ebook"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
}

function movtomp4() {
	# Convert MOV to MP4 with high quality
	# Usage: movtomp4 input.mov output.mp4
	ffmpeg -i "$1" -q:v 0 "$2"
}

function shrinkmp4() {
	# Shrink MP4 size by converting it with h264 codec and yuv420p pixel format
	# Usage: shrinkmp4 input.mp4 output.mp4
	ffmpeg -i "$1" -c:v libx264 -pix_fmt yuv420p "$2"
}

function convertmov() {
	# Convert MOV to MP4, then shrink the MP4 size
	# Usage: convertAndShrinkMov input.mov output.mp4
	temp_mp4="/tmp/temporary_output.mp4"

	# Step 1: Convert MOV to MP4 with high quality
	ffmpeg -i "$1" -q:v 0 "$temp_mp4"

	# Step 2: Shrink the MP4 using h264 codec and yuv420p pixel format
	ffmpeg -i "$temp_mp4" -c:v libx264 -pix_fmt yuv420p "$2"

	# Cleanup: remove the temporary MP4
	rm "$temp_mp4"
}

function burnsubs() {
	local files=("$@")

	for file in "${files[@]}"; do
		local base_name="${file%.*}"  # Remove extension

		echo "Processing: $file"
		ffmpeg -i "$file" -vf "subtitles=$file" -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 192k "${base_name}.mp4"

		if [ $? -eq 0 ]; then
			echo "Successfully processed: $file"
			rm "$file"
		else
			echo "Error processing: $file"
		fi
	done
}
