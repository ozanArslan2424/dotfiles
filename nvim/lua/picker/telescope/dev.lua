return {
	setup = function(pick)
		local actions = pick.actions
		local finders = pick.finders
		local pickers = pick.pickers
		local conf = pick.conf
		local action_state = pick.action_state

		local function dev_picker(opts)
			opts = opts or {}
			local dev_dir = vim.fn.expand("~/dev")
			local files = {}

			local function collect_files(dir)
				local success, iter = pcall(vim.fs.dir, dir)
				if not success then
					return
				end
				for name, type in iter do
					local full_path = dir .. "/" .. name
					if type == "file" then
						local relative_path = full_path:gsub(dev_dir .. "/", "")
						table.insert(
							files,
							{ text = relative_path, path = full_path }
						)
					elseif type == "directory" and not name:match("^%.") then
						collect_files(full_path)
					end
				end
			end

			collect_files(dev_dir)

			pickers
				.new(opts, {
					prompt_title = "Dev Files",
					finder = finders.new_table({
						results = files,
						entry_maker = function(entry)
							return {
								value = entry,
								display = entry.text,
								ordinal = entry.text,
								path = entry.path,
							}
						end,
					}),
					previewer = conf.file_previewer(opts),
					sorter = conf.generic_sorter(opts),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							if selection then
								vim.cmd(
									"edit "
										.. vim.fn.fnameescape(selection.path)
								)
							end
						end)
						return true
					end,
				})
				:find()
		end

		Do.map("<leader>sdd", dev_picker, "[S]earch [D]ev [D]irectory")
		return dev_picker
	end,
}
