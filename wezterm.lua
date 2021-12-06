local wezterm = require 'wezterm';
-- The powerline </> symbol
local LEFT_ARROW = utf8.char(0xe0b3);
local SOLID_LEFT_ARROW = utf8.char(0xe0b2);
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0);


local color_tabbar_background = "#0b0022"
-- background, forground, intensity, underline
local color_tab_inactive={"#3c1361", "#808080", "Bold", "None"};
local color_tab_hoover={"#3c1361", "#909090", "Bold", "Single"};
local color_tab_active={"#52307c", "#c0c0c0", "Bold", "None"};
-- meh: chars and width are only broadly related...
local tab_max_width = 50
local tab_max_chars = 30

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover)
	local tab_is_toolbox = (tab.active_pane.user_vars.in_toolbox or "false") == "true";
	local tab_is_hover = hover;
	local tab_is_active = tab.is_active;

	if tab_is_active then
		c = color_tab_active;
	elseif tab_is_hover then
		c=color_tab_hoover;
	else
		c=color_tab_inactive;
	end

	bg=c[1]
	fg=c[2]
	b=c[3]
	u=c[4]

	title = tab.active_pane.title;
	-- we can at maximum only display some predefined chars and have to add 
	-- the numbering ("xx: ", 4 chars) and maybe a dot + space (3 chars))
	available_chars = tab_max_chars - 4 - 3;
	title_chars = string.len(title)
	if title_chars > available_chars then
		title = "…" .. string.sub(title, title_chars - available_chars) ;
	end

	if tab_is_toolbox then
		title = "🔴 " .. title
	end

	if #tabs > 1 then
		title = string.format("%d: %s", tab.tab_index + 1, title);
	end

	return {
		{Background={Color=color_tabbar_background}},
		{Foreground={Color=bg}},
		{Text=SOLID_LEFT_ARROW},
		{Background={Color=bg}},
		{Foreground={Color=fg}},
		{Text=" "},
		{Attribute={Underline=u}},
		{Attribute={Intensity=b}},
		{Text=title},
		{Attribute={Intensity="Normal"}},
		{Attribute={Underline="None"}},
		{Text=" "},
		{Background={Color=color_tabbar_background}},
		{Foreground={Color=bg}},
		{Text=SOLID_RIGHT_ARROW},

	}


end)


local empty = ""

return {
	-- color_scheme = "Dracula+",
	color_scheme = "IC_Orange_PPL",
	-- color_scheme = "jubi",
	color_scheme = "lovelace",
	-- color_scheme = "Material",
	-- color_scheme = "OceanicMaterial",
	-- color_scheme = "Popping and Locking",
	-- color_scheme = "Urple",
	font = wezterm.font("VictorMono Nerd Font"),
	-- font = wezterm.font("Iosevka Nerd Font"),
	font_size = 16.0,
	font_antialias = 'Subpixel',
	harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
	-- font_rules = {
	-- 	{

	-- 	},
	-- },

	-- How many lines of scrollback you want to retain per tab
	scrollback_lines = 81920,

	-- Enable the scrollbar.
	-- It will occupy the right window padding space.
	-- If right padding is set to 0 then it will be increased
	-- to a single cell width
	enable_scroll_bar = true,

	tab_max_width = tab_max_width,
	-- intentionally both empty as we use the title bar function
	tab_bar_style = {
		active_tab_left = empty,
		active_tab_right = empty,
		inactive_tab_left = empty,
		inactive_tab_right = empty,
		inactive_tab_hover_left = empty,
		inactive_tab_hover_right = empty,
	},
	colors = {
		tab_bar = {},
	},

	-- window_background_image = "/Users/jiamu/Pictures/bing-wallpapers/BingWallpaper.jpg",
	-- window_background_opacity = 0.3,

	keys = {
		{key="d", mods="SUPER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
		{key="d", mods="SUPER|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
		{key="LeftArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Left"}},
		{key="RightArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Right"}},
		{key="UpArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Up"}},
		{key="DownArrow", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Down"}},
		{key="h", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Left"}},
		{key="l", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Right"}},
		{key="k", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Up"}},
		{key="j", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Down"}},
		{key = "z", mods="SUPER", action="TogglePaneZoomState"},
	}
}


