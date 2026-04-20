local timer_def_name = "startup"

local timers = {}
local start_times = {}
local end_times = {}

local begin = function(key)
	-- Store start time for this specific timer
	start_times[key] = vim.loop.hrtime()
end

-- Add a stop function for each timer
local stop = function(key)
	end_times[key] = vim.loop.hrtime()
end

local get_result = function()
	local total_end_time = vim.loop.hrtime()
	local total_start_time = start_times[timer_def_name] or 0

	-- Calculate total duration
	local total_time_ns = total_end_time - total_start_time
	local total_time_ms = total_time_ns / 1000000

	-- Calculate elapsed times for each module
	local times = {}
	for key, start_time in pairs(start_times) do
		local end_time = end_times[key] or total_end_time
		local elapsed_ns = end_time - start_time
		local elapsed_ms = elapsed_ns / 1000000

		table.insert(times, {
			name = key,
			elapsed = elapsed_ms,
			start_time = start_time,
			end_time = end_time,
		})
	end

	-- Sort by elapsed time (descending - longest first)
	table.sort(times, function(a, b)
		return a.elapsed > b.elapsed
	end)

	-- Build notification message
	local lines = {}
	table.insert(
		lines,
		string.format("🚀 Startup Performance Report %7.2f ms", total_time_ms)
	)

	for _, t in ipairs(times) do
		if t.name ~= timer_def_name then
			-- Calculate bar length based on elapsed time as percentage of total
			local percentage = (t.elapsed / total_time_ms) * 100
			local bar_length = math.floor(percentage * 40 / 100) -- Scale to 40 chars max
			local bar = string.rep("■", math.max(1, bar_length))

			table.insert(
				lines,
				string.format(
					"%-20s %7.2f ms  %3.0f%%  %s",
					t.name,
					t.elapsed,
					percentage,
					bar
				)
			)
		end
	end

	return table.concat(lines, "\n")
end

local time = function(key, cb)
	begin(key)
	cb()
	stop(key)
end

return {
	timers = timers,
	begin = begin,
	stop = stop,
	time = time,
	get_result = get_result,
}
