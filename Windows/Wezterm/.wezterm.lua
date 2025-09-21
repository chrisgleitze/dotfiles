-- Pull in the wezterm API
local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}

wezterm.on("gui-attached", function(domain)
	-- maximize all displayed windows on startup
	local workspace = mux.get_active_workspace()
	for _, window in ipairs(mux.all_windows()) do
		if window:get_workspace() == workspace then
			window:gui_window():maximize()
		end
	end
end)

-- window numbering
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d.] ", tab.tab_index + 1, #tabs)
	end

	return zoomed .. index .. tab.active_pane.title
end)

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.automatically_reload_config = true
config.enable_tab_bar = false

-- colorscheme, font (imported below from Powershell config!)
config.color_scheme = "Dracula"
config.font = wezterm.font("FiraCode Nerd Font")

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Set the default program to PowerShell
config.default_prog = { "C:\\Program Files\\PowerShell\\7\\pwsh.exe", "-NoLogo" }

-- Automatically load your PowerShell profile and run your config
config.default_cwd = "C:\\Users\\asus" -- Set this to your home directory,

return config
