import { getLfConfigWriter } from "./getLfConfigWriter";

const {
  getconfig,
  set,
  setlocal,
  lfcmd,
  shcmd,
  mapkeys,
  comment,
  q,
  join,
  line,
} = getLfConfigWriter();

// MY CONFIG:
comment("single column on small panes");
line(
  `$[ $lf_width -le 80 ] && lf -remote "send $id :set nopreview; set ratios 1" || exit 0`,
);

set({
  icons: undefined,
  relativenumber: undefined,
  number: undefined,
  dircounts: undefined,
  ratios: "2:3:4",
  shell: "sh",
  shellopts: q("-eu"),
  ifs: q("\\n"),
  period: 1,
  tabstop: 4,
  scrolloff: 8,
  wrapscroll: undefined,
  "hidden!": undefined,
  hiddenfiles: q(".DS_Store"),
  smartcase: undefined,
  incsearch: undefined,
  incfilter: undefined,
  truncatechar: q("…"),
  info: `time:size`,
  cursorpreviewfmt: q(join("\\033[7]", "2m")),
  promptfmt: q(join("\\033[38", "2", "255", "255", "255m %w")),
  waitmsg: q(join("\\033[1", "31m⏎\\033[m")),
  timefmt: q("02/01/2006 15:04:05 "),
  infotimefmtnew: q("02/01 15:04"),
  infotimefmtold: q("02/01/06"),
  errorfmt: q(join("\\033[1", "31m")),
  numberfmt: q(join("\\033[38", "2", "75", "87", "116m")),
  previewer: "~/.config/lf/previewer",
  cleaner: "~/.config/lf/cleaner",
});

setlocal("~/Downloads", "sortby", q("atime"));
setlocal("~/Downloads", "reverse");

lfcmd(
  "trash",
  `
	mkdir -p ~/.Trash
	echo "Move to trash: $fx"
	printf "Confirm? (y/n): "
	read confirm

	if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
		# Generate unique name to avoid overwrites
		for file in $fx; do
			base=$(basename "$file")
			target="$HOME/.trash/$base"

			# If file already exists in trash, add timestamp
			if [ -e "$target" ]; then
				timestamp=$(date +%Y%m%d_%H%M%S)
				target="$HOME/.trash/\${base}_$timestamp"
			fi

			mv "$file" "$target"
			echo "Moved: $file -> $target"
		done
		echo "Done"
	else
		echo "Cancelled"
	fi
`,
);

shcmd(
  "chmod",
  `
	[ $# -ne 1 ] && exit
	eval "chmod u$1 '$f'"
	lf -remote "send $id reload"
`,
);

lfcmd(
  "mkdir",
  `
	IFS=" "
	mkdir -p -- "$*"
	lf -remote "send $id select \\"$*\\""
`,
);

lfcmd(
  "touch",
  `
	IFS=" "
	if [ -z "$*" ]; then echo "name required"; exit; fi
	if [ -f "$*" ]; then echo "file exists"; exit; fi
	if [ -d "$*" ]; then echo "there is a directory with the same name"; exit; fi
	touch "$*"
	lf -remote "send $id select \\"$*\\""
`,
);

lfcmd(
  "create",
  `
	IFS=" "
	if [ -z "$*" ]; then echo "name required"; exit; fi
	if [[ "$*" == */ ]] ; then
		mkdir -p -- "$*"
		lf -remote "send $id select \\"$*\\""
		exit 0
	fi
	base=$(dirname -- "$*")
	[ "$base" != . ] && mkdir -p -- "$base"
	touch "$*"
	lf -remote "send $id select \\"$*\\""
`,
);

shcmd(
  "fzf_jump",
  `
	pwd=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
	res="$(fd . $pwd -H -I -d 6 -E .git -E node_modules | fzf +m | sed 's/\\\\/\\\\\\\\/g;s/"/\\\\"/g')"
	if [ -d "$res" ] ; then
		cmd="cd"
	elif [ -f "$res" ] ; then
		cmd="select"
	else
		exit 0
	fi
	lf -remote "send $id $cmd \\"$res\\""
`,
);

shcmd(
  "fzf_search_all",
  `
	res="$(\\
		RG_PREFIX="rg --column --line-number --no-heading --color=always \\
			--smart-case "
		FZF_DEFAULT_COMMAND="$RG_PREFIX ''" \\
			fzf --ansi --bind "change:reload:$RG_PREFIX {q} || true" \\
			| cut -d':' -f1
	)"
	[ ! -z "$res" ] && lf -remote "send $id select \\"$res\\""
`,
);

shcmd(
  "fzf_grep",
  `
	res="$( \\
		rg --column --line-number --no-heading --color=always --smart-case -e "$*"| \\
		fzf --ansi | cut -d':' -f1
	)"
	[ ! -z "$res" ] && lf -remote "send $id select \\"$res\\""
`,
);

mapkeys({
  a: "push :create<space>",
  "+x": "chmod +x",
  R: ":reload; recol; cfg_reload",
  sr: "set reverse!",
  sd: "set dirfirst!",
  o: '$open $f; lf -remote "send ${id} quit"',
  O: "$open -R $fx",
  Q: '$lf -remote "send quit"',
  i: '$$lf_previewer "$f"',
  I: '%file "$f"',
  y: undefined,
  yy: "copy",
  yp: '$printf "%s" "$fx" | pbcopy', // fullpath
  yn: '$printf "%s" "${fx##*/}" | pbcopy', // filename
  yd: '$printf "%s" "${fx%/*}" | pbcopy', // dirname
  d: "trash",
  x: "cut",
  DD: "delete",
  p: "paste",
  "<enter>": "open",
  // F: "fzf_jump"
  // f: undefined,
  // fa: "fzf_search_all",
  // fg: "push :fzf_grep<space>",
  // "f<space>": "filter",
  // ff: "filter",
  // fc: "setfilter",
  // fz: "fzf_jump",
  // "<c-p>": "fzf_jump"
});

const config = getconfig();

export { config };
