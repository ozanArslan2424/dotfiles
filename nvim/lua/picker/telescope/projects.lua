return {
	setup = function(pick)
		local actions = pick.actions
		local finders = pick.finders
		local pickers = pick.pickers
		local conf = pick.conf
		local action_state = pick.action_state
		local previewers = pick.previewers

		local function projects_picker(opts)
			opts = opts or {}
			local projects_dir = vim.fn.expand("~/dev")
			local projects = {}

			for name, type in vim.fs.dir(projects_dir) do
				if type == "directory" then
					table.insert(projects, {
						text = name,
						dir = projects_dir .. "/" .. name,
					})
				end
			end

			pickers
				.new(opts, {
					prompt_title = "Projects",
					finder = finders.new_table({
						results = projects,
						entry_maker = function(entry)
							return {
								value = entry,
								display = entry.text,
								ordinal = entry.text,
								path = entry.dir,
							}
						end,
					}),
					previewer = previewers.new_buffer_previewer({
						title = "Project Files",
						define_preview = function(self, entry)
							local files = {}
							for name, ftype in vim.fs.dir(entry.value.dir) do
								if
									ftype == "file" and not name:match("^%.")
								then
									table.insert(files, name)
								end
							end
							vim.api.nvim_buf_set_lines(
								self.state.bufnr,
								0,
								-1,
								false,
								files
							)
						end,
					}),
					sorter = conf.generic_sorter(opts),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							if selection then
								vim.fn.chdir(selection.value.dir)
								vim.schedule(function()
									vim.cmd("Explorer")
								end)
							end
						end)
						return true
					end,
				})
				:find()
		end

		Do.map("<leader>P", projects_picker, "[P]rojects")
		return projects_picker
	end,
}
