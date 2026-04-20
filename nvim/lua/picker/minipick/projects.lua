return {
	setup = function(pick)
		return function(_, opts)
			local projects = {}
			local projects_dir = vim.fn.expand("~/dev")

			-- Directly list all directories under ~/dev as projects
			for project_name, project_type in vim.fs.dir(projects_dir) do
				if project_type == "directory" then
					table.insert(projects, {
						text = project_name, -- Just the project name, no prefix
						dir = projects_dir .. "/" .. project_name,
					})
				end
			end

			local choose = function(item)
				if not item then
					return
				end
				vim.fn.chdir(item.dir)

				-- Schedule to focus mini.files, as it doesn't otherwise.
				vim.schedule(function()
					vim.cmd("Explorer")
				end)
			end

			local preview = function(buf_id, item)
				if not item then
					return
				end

				local files = {}
				for name, type in vim.fs.dir(item.dir) do
					if type == "file" and not name:match("^%.") then
						table.insert(files, name)
					end
				end

				vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, files)
			end

			local source = {
				items = projects,
				name = "Projects",
				choose = choose,
				preview = preview,
			}
			opts = vim.tbl_deep_extend("force", { source = source }, opts or {})

			local projects_picker = pick.start(opts)

			Do.map("<leader>P", projects_picker, "[P]rojects")

			return projects_picker
		end
	end,
}
