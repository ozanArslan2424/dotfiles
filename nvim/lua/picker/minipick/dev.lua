return {
	setup = function(pick)
		return function(_, opts)
			local files = {}
			local dev_dir = vim.fn.expand("~/dev")

			-- Function to recursively collect files
			local function collect_files(dir)
				local success, iter = pcall(vim.fs.dir, dir)
				if not success then
					return
				end

				for name, type in iter do
					local full_path = dir .. "/" .. name

					if type == "file" then
						-- Get relative path from dev_dir
						local relative_path = full_path:gsub(dev_dir .. "/", "")
						table.insert(files, {
							text = relative_path,
							path = full_path,
						})
					elseif type == "directory" and not name:match("^%.") then
						-- Skip hidden directories and continue searching
						collect_files(full_path)
					end
				end
			end

			-- Start collecting files from dev_dir
			collect_files(dev_dir)

			local choose = function(item)
				if not item then
					return
				end

				-- Open the selected file
				vim.cmd("edit " .. vim.fn.fnameescape(item.path))
			end

			local preview = function(buf_id, item)
				if not item then
					return
				end

				-- Read and preview file content
				local lines = {}
				local success, file_lines = pcall(vim.fn.readfile, item.path)

				if success then
					-- Show first 50 lines or all lines if less
					local max_lines = math.min(50, #file_lines)
					for i = 1, max_lines do
						table.insert(lines, file_lines[i])
					end
					if #file_lines > 50 then
						table.insert(
							lines,
							"\n... (" .. (#file_lines - 50) .. " more lines)"
						)
					end
				else
					table.insert(lines, "Unable to read file")
				end

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
			end

			local source = {
				items = files,
				name = "Dev Files",
				choose = choose,
				preview = preview,
			}

			opts = vim.tbl_deep_extend("force", { source = source }, opts or {})
			local dev = pick.start(opts)

			Do.map("<leader>sdd", dev, "[S]earch [D]ev [D]irectory")

			return dev
		end
	end,
}
