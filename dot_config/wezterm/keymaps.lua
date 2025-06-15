local wezterm = require("wezterm")
local act = wezterm.action
local keys = {}

local function map(key, mode, action)
	table.insert(keys, {
		key = key,
		mods = mode,
		action = action,
	})
end

local LC_MODS = "LEADER|CTRL"
local LS_MODS = "LEADER|SHIFT"
local CS_MODS = "CTRL|SHIFT"
local CA_MODS = "CTRL|ALT"

-- Send "CTRL-B" to the terminal when pressing CTRL-B, CTRL-B
map("b", LC_MODS, act.SendKey({ key = "b", mods = "CTRL" }))

-- tab
map("c", "LEADER", act.SpawnTab("CurrentPaneDomain"))
map("t", CA_MODS, act.SpawnTab("CurrentPaneDomain"))
map("p", CA_MODS, act.ActivateLastTab)
map("l", CA_MODS, act.ActivateTabRelative(1))
map("h", CA_MODS, act.ActivateTabRelative(-1))
for i = 1, 9 do
	map(tostring(i), CA_MODS, act.ActivateTab(i - 1))
end

-- pane
map("h", LC_MODS, act.ActivatePaneDirection("Left"))
map("l", LC_MODS, act.ActivatePaneDirection("Right"))
map("j", LC_MODS, act.ActivatePaneDirection("Down"))
map("k", LC_MODS, act.ActivatePaneDirection("Up"))
map("L", LS_MODS, act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
map("J", LS_MODS, act.SplitVertical({ domain = "CurrentPaneDomain" }))

return keys
