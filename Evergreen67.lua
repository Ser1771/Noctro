--// Services \\--
local cloneref = cloneref or function(Instance_) return Instance_ end
local function GetService(Name) return cloneref(game:GetService(Name)) end

local CoreGui = GetService("CoreGui")
local Players = GetService("Players")
local RunService = GetService("RunService")
local UserInputService = GetService("UserInputService")
local TweenService = GetService("TweenService")
local Teams = GetService("Teams")

local getgenv = getgenv or function() return shared end
local protectgui = protectgui or (syn and syn.protect_gui) or function() end
local gethui = gethui or function() return CoreGui end

local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Mouse = LocalPlayer:GetMouse()

--// Themes \\--
local Themes = {
    Dark = {
        Window = Color3.fromRGB(30, 30, 32),
        Sidebar = Color3.fromRGB(37, 37, 40),
        Titlebar = Color3.fromRGB(44, 44, 47),
        Card = Color3.fromRGB(44, 44, 47),
        Control = Color3.fromRGB(62, 62, 66),
        ControlHover = Color3.fromRGB(74, 74, 79),
        Popup = Color3.fromRGB(50, 50, 54),
        Segment = Color3.fromRGB(96, 96, 102),
        Track = Color3.fromRGB(84, 84, 88),
        SliderFill = Color3.fromRGB(248, 248, 250),
        Outline = Color3.fromRGB(70, 70, 75),
        Text = Color3.fromRGB(245, 245, 247),
        SubText = Color3.fromRGB(152, 152, 160),
        Accent = Color3.fromRGB(48, 209, 88),
        AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 69, 58),
        IsLight = false,
    },
    Graphite = {
        Window = Color3.fromRGB(22, 22, 24),
        Sidebar = Color3.fromRGB(28, 28, 30),
        Titlebar = Color3.fromRGB(34, 34, 36),
        Card = Color3.fromRGB(34, 34, 37),
        Control = Color3.fromRGB(52, 52, 56),
        ControlHover = Color3.fromRGB(64, 64, 69),
        Popup = Color3.fromRGB(40, 40, 44),
        Segment = Color3.fromRGB(84, 84, 90),
        Track = Color3.fromRGB(70, 70, 75),
        SliderFill = Color3.fromRGB(248, 248, 250),
        Outline = Color3.fromRGB(56, 56, 61),
        Text = Color3.fromRGB(240, 240, 244),
        SubText = Color3.fromRGB(140, 140, 150),
        Accent = Color3.fromRGB(48, 209, 88),
        AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 69, 58),
        IsLight = false,
    },
    Midnight = {
        Window = Color3.fromRGB(13, 17, 30), Sidebar = Color3.fromRGB(17, 22, 40), Titlebar = Color3.fromRGB(24, 30, 54),
        Card = Color3.fromRGB(22, 28, 50), Control = Color3.fromRGB(38, 47, 78), ControlHover = Color3.fromRGB(50, 61, 98),
        Popup = Color3.fromRGB(28, 35, 62), Segment = Color3.fromRGB(70, 84, 130), Track = Color3.fromRGB(58, 68, 104),
        SliderFill = Color3.fromRGB(235, 240, 255), Outline = Color3.fromRGB(46, 56, 92), Text = Color3.fromRGB(236, 240, 255),
        SubText = Color3.fromRGB(135, 146, 184), Accent = Color3.fromRGB(10, 132, 255), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 69, 58), IsLight = false,
    },
    Mocha = {
        Window = Color3.fromRGB(30, 26, 24), Sidebar = Color3.fromRGB(38, 33, 30), Titlebar = Color3.fromRGB(46, 40, 36),
        Card = Color3.fromRGB(45, 39, 35), Control = Color3.fromRGB(66, 58, 52), ControlHover = Color3.fromRGB(80, 70, 63),
        Popup = Color3.fromRGB(52, 45, 40), Segment = Color3.fromRGB(104, 92, 82), Track = Color3.fromRGB(88, 78, 70),
        SliderFill = Color3.fromRGB(250, 244, 236), Outline = Color3.fromRGB(74, 65, 58), Text = Color3.fromRGB(248, 242, 235),
        SubText = Color3.fromRGB(165, 152, 140), Accent = Color3.fromRGB(255, 159, 10), AccentText = Color3.fromRGB(30, 20, 10),
        Red = Color3.fromRGB(255, 99, 88), IsLight = false,
    },
    Rose = {
        Window = Color3.fromRGB(28, 22, 26), Sidebar = Color3.fromRGB(36, 28, 33), Titlebar = Color3.fromRGB(44, 34, 40),
        Card = Color3.fromRGB(43, 33, 39), Control = Color3.fromRGB(64, 50, 58), ControlHover = Color3.fromRGB(78, 62, 71),
        Popup = Color3.fromRGB(50, 39, 46), Segment = Color3.fromRGB(102, 82, 94), Track = Color3.fromRGB(86, 69, 79),
        SliderFill = Color3.fromRGB(255, 240, 246), Outline = Color3.fromRGB(72, 56, 65), Text = Color3.fromRGB(250, 240, 245),
        SubText = Color3.fromRGB(168, 146, 158), Accent = Color3.fromRGB(255, 55, 95), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 120, 100), IsLight = false,
    },
    Light = {
        Window = Color3.fromRGB(246, 246, 247),
        Sidebar = Color3.fromRGB(236, 236, 239),
        Titlebar = Color3.fromRGB(232, 232, 235),
        Card = Color3.fromRGB(255, 255, 255),
        Control = Color3.fromRGB(235, 235, 238),
        ControlHover = Color3.fromRGB(224, 224, 228),
        Popup = Color3.fromRGB(255, 255, 255),
        Segment = Color3.fromRGB(255, 255, 255),
        Track = Color3.fromRGB(205, 205, 210),
        SliderFill = Color3.fromRGB(40, 184, 78),
        Outline = Color3.fromRGB(210, 210, 215),
        Text = Color3.fromRGB(28, 28, 30),
        SubText = Color3.fromRGB(112, 112, 120),
        Accent = Color3.fromRGB(40, 184, 78),
        AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 59, 48),
        IsLight = true,
    },
    Ocean = {
        Window = Color3.fromRGB(12, 28, 36), Sidebar = Color3.fromRGB(16, 36, 46), Titlebar = Color3.fromRGB(20, 44, 56),
        Card = Color3.fromRGB(22, 46, 58), Control = Color3.fromRGB(32, 64, 80), ControlHover = Color3.fromRGB(42, 80, 98),
        Popup = Color3.fromRGB(26, 52, 66), Segment = Color3.fromRGB(48, 96, 118), Track = Color3.fromRGB(40, 78, 96),
        SliderFill = Color3.fromRGB(220, 245, 255), Outline = Color3.fromRGB(40, 72, 88), Text = Color3.fromRGB(230, 246, 255),
        SubText = Color3.fromRGB(130, 170, 190), Accent = Color3.fromRGB(0, 199, 190), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 99, 88), IsLight = false,
    },
    Forest = {
        Window = Color3.fromRGB(18, 26, 20), Sidebar = Color3.fromRGB(24, 34, 26), Titlebar = Color3.fromRGB(30, 42, 32),
        Card = Color3.fromRGB(28, 40, 30), Control = Color3.fromRGB(42, 58, 44), ControlHover = Color3.fromRGB(54, 72, 56),
        Popup = Color3.fromRGB(34, 48, 36), Segment = Color3.fromRGB(64, 92, 68), Track = Color3.fromRGB(52, 74, 56),
        SliderFill = Color3.fromRGB(230, 250, 235), Outline = Color3.fromRGB(48, 66, 50), Text = Color3.fromRGB(232, 245, 234),
        SubText = Color3.fromRGB(140, 170, 148), Accent = Color3.fromRGB(52, 199, 89), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 99, 88), IsLight = false,
    },
    Sunset = {
        Window = Color3.fromRGB(32, 18, 22), Sidebar = Color3.fromRGB(40, 24, 28), Titlebar = Color3.fromRGB(50, 30, 34),
        Card = Color3.fromRGB(48, 28, 32), Control = Color3.fromRGB(72, 42, 48), ControlHover = Color3.fromRGB(88, 52, 58),
        Popup = Color3.fromRGB(56, 34, 38), Segment = Color3.fromRGB(110, 64, 72), Track = Color3.fromRGB(90, 54, 60),
        SliderFill = Color3.fromRGB(255, 236, 220), Outline = Color3.fromRGB(78, 46, 52), Text = Color3.fromRGB(255, 240, 235),
        SubText = Color3.fromRGB(190, 150, 145), Accent = Color3.fromRGB(255, 120, 50), AccentText = Color3.fromRGB(40, 15, 10),
        Red = Color3.fromRGB(255, 90, 80), IsLight = false,
    },
    Lavender = {
        Window = Color3.fromRGB(28, 24, 38), Sidebar = Color3.fromRGB(36, 30, 48), Titlebar = Color3.fromRGB(44, 38, 58),
        Card = Color3.fromRGB(42, 36, 56), Control = Color3.fromRGB(62, 54, 82), ControlHover = Color3.fromRGB(76, 66, 98),
        Popup = Color3.fromRGB(50, 44, 68), Segment = Color3.fromRGB(98, 86, 130), Track = Color3.fromRGB(80, 70, 108),
        SliderFill = Color3.fromRGB(245, 238, 255), Outline = Color3.fromRGB(70, 60, 96), Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(165, 155, 195), Accent = Color3.fromRGB(175, 130, 255), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 110, 120), IsLight = false,
    },
    Nord = {
        Window = Color3.fromRGB(36, 41, 51), Sidebar = Color3.fromRGB(46, 52, 64), Titlebar = Color3.fromRGB(59, 66, 82),
        Card = Color3.fromRGB(54, 60, 74), Control = Color3.fromRGB(67, 76, 94), ControlHover = Color3.fromRGB(76, 86, 106),
        Popup = Color3.fromRGB(50, 56, 70), Segment = Color3.fromRGB(94, 106, 130), Track = Color3.fromRGB(76, 86, 106),
        SliderFill = Color3.fromRGB(236, 239, 244), Outline = Color3.fromRGB(67, 76, 94), Text = Color3.fromRGB(236, 239, 244),
        SubText = Color3.fromRGB(136, 146, 170), Accent = Color3.fromRGB(136, 192, 208), AccentText = Color3.fromRGB(20, 28, 36),
        Red = Color3.fromRGB(191, 97, 106), IsLight = false,
    },
    Dracula = {
        Window = Color3.fromRGB(30, 31, 41), Sidebar = Color3.fromRGB(40, 42, 54), Titlebar = Color3.fromRGB(48, 50, 64),
        Card = Color3.fromRGB(44, 46, 60), Control = Color3.fromRGB(68, 71, 90), ControlHover = Color3.fromRGB(80, 84, 106),
        Popup = Color3.fromRGB(52, 54, 70), Segment = Color3.fromRGB(98, 104, 128), Track = Color3.fromRGB(78, 82, 104),
        SliderFill = Color3.fromRGB(248, 248, 242), Outline = Color3.fromRGB(68, 71, 90), Text = Color3.fromRGB(248, 248, 242),
        SubText = Color3.fromRGB(152, 158, 180), Accent = Color3.fromRGB(189, 147, 249), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 85, 85), IsLight = false,
    },
    Cyber = {
        Window = Color3.fromRGB(8, 12, 18), Sidebar = Color3.fromRGB(12, 18, 28), Titlebar = Color3.fromRGB(16, 24, 36),
        Card = Color3.fromRGB(14, 22, 34), Control = Color3.fromRGB(24, 40, 58), ControlHover = Color3.fromRGB(32, 54, 76),
        Popup = Color3.fromRGB(18, 28, 42), Segment = Color3.fromRGB(40, 70, 100), Track = Color3.fromRGB(30, 52, 74),
        SliderFill = Color3.fromRGB(180, 255, 240), Outline = Color3.fromRGB(30, 50, 70), Text = Color3.fromRGB(220, 255, 250),
        SubText = Color3.fromRGB(100, 160, 170), Accent = Color3.fromRGB(0, 255, 200), AccentText = Color3.fromRGB(0, 20, 18),
        Red = Color3.fromRGB(255, 60, 100), IsLight = false,
    },
    Sand = {
        Window = Color3.fromRGB(42, 36, 28), Sidebar = Color3.fromRGB(52, 44, 34), Titlebar = Color3.fromRGB(62, 52, 40),
        Card = Color3.fromRGB(58, 50, 38), Control = Color3.fromRGB(80, 68, 52), ControlHover = Color3.fromRGB(96, 82, 62),
        Popup = Color3.fromRGB(66, 56, 44), Segment = Color3.fromRGB(120, 100, 76), Track = Color3.fromRGB(98, 84, 64),
        SliderFill = Color3.fromRGB(255, 245, 230), Outline = Color3.fromRGB(86, 72, 56), Text = Color3.fromRGB(250, 242, 228),
        SubText = Color3.fromRGB(180, 160, 130), Accent = Color3.fromRGB(230, 180, 80), AccentText = Color3.fromRGB(40, 28, 10),
        Red = Color3.fromRGB(220, 90, 70), IsLight = false,
    },
    Arctic = {
        Window = Color3.fromRGB(232, 238, 244), Sidebar = Color3.fromRGB(220, 228, 236), Titlebar = Color3.fromRGB(210, 220, 230),
        Card = Color3.fromRGB(248, 250, 252), Control = Color3.fromRGB(220, 228, 236), ControlHover = Color3.fromRGB(200, 212, 224),
        Popup = Color3.fromRGB(255, 255, 255), Segment = Color3.fromRGB(255, 255, 255), Track = Color3.fromRGB(190, 202, 214),
        SliderFill = Color3.fromRGB(30, 120, 200), Outline = Color3.fromRGB(190, 200, 210), Text = Color3.fromRGB(28, 36, 48),
        SubText = Color3.fromRGB(100, 118, 136), Accent = Color3.fromRGB(30, 144, 220), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(220, 70, 70), IsLight = true,
    },
    Emerald = {
        Window = Color3.fromRGB(14, 28, 22), Sidebar = Color3.fromRGB(18, 36, 28), Titlebar = Color3.fromRGB(24, 44, 34),
        Card = Color3.fromRGB(22, 42, 32), Control = Color3.fromRGB(34, 62, 48), ControlHover = Color3.fromRGB(44, 78, 60),
        Popup = Color3.fromRGB(28, 50, 38), Segment = Color3.fromRGB(52, 96, 72), Track = Color3.fromRGB(42, 78, 58),
        SliderFill = Color3.fromRGB(200, 255, 220), Outline = Color3.fromRGB(36, 64, 48), Text = Color3.fromRGB(230, 255, 240),
        SubText = Color3.fromRGB(130, 180, 150), Accent = Color3.fromRGB(16, 185, 129), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(248, 113, 113), IsLight = false,
    },
    Crimson = {
        Window = Color3.fromRGB(28, 14, 16), Sidebar = Color3.fromRGB(36, 18, 20), Titlebar = Color3.fromRGB(46, 22, 26),
        Card = Color3.fromRGB(44, 20, 24), Control = Color3.fromRGB(68, 32, 38), ControlHover = Color3.fromRGB(86, 40, 48),
        Popup = Color3.fromRGB(52, 26, 30), Segment = Color3.fromRGB(110, 48, 58), Track = Color3.fromRGB(88, 40, 48),
        SliderFill = Color3.fromRGB(255, 220, 225), Outline = Color3.fromRGB(72, 34, 40), Text = Color3.fromRGB(255, 236, 238),
        SubText = Color3.fromRGB(190, 140, 148), Accent = Color3.fromRGB(239, 68, 68), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(255, 100, 100), IsLight = false,
    },
    Sky = {
        Window = Color3.fromRGB(16, 24, 40), Sidebar = Color3.fromRGB(20, 32, 52), Titlebar = Color3.fromRGB(28, 42, 68),
        Card = Color3.fromRGB(26, 40, 64), Control = Color3.fromRGB(40, 60, 92), ControlHover = Color3.fromRGB(52, 76, 112),
        Popup = Color3.fromRGB(32, 48, 76), Segment = Color3.fromRGB(64, 96, 140), Track = Color3.fromRGB(50, 76, 112),
        SliderFill = Color3.fromRGB(220, 240, 255), Outline = Color3.fromRGB(44, 66, 100), Text = Color3.fromRGB(232, 244, 255),
        SubText = Color3.fromRGB(140, 170, 210), Accent = Color3.fromRGB(56, 189, 248), AccentText = Color3.fromRGB(10, 20, 40),
        Red = Color3.fromRGB(251, 113, 133), IsLight = false,
    },
    OLED = {
        Window = Color3.fromRGB(0, 0, 0), Sidebar = Color3.fromRGB(8, 8, 8), Titlebar = Color3.fromRGB(12, 12, 12),
        Card = Color3.fromRGB(14, 14, 14), Control = Color3.fromRGB(28, 28, 28), ControlHover = Color3.fromRGB(40, 40, 40),
        Popup = Color3.fromRGB(18, 18, 18), Segment = Color3.fromRGB(48, 48, 48), Track = Color3.fromRGB(36, 36, 36),
        SliderFill = Color3.fromRGB(240, 240, 240), Outline = Color3.fromRGB(32, 32, 32), Text = Color3.fromRGB(245, 245, 245),
        SubText = Color3.fromRGB(140, 140, 140), Accent = Color3.fromRGB(0, 255, 140), AccentText = Color3.fromRGB(0, 0, 0),
        Red = Color3.fromRGB(255, 60, 60), IsLight = false,
    },
    Catppuccin = {
        Window = Color3.fromRGB(30, 30, 46), Sidebar = Color3.fromRGB(24, 24, 37), Titlebar = Color3.fromRGB(49, 50, 68),
        Card = Color3.fromRGB(49, 50, 68), Control = Color3.fromRGB(69, 71, 90), ControlHover = Color3.fromRGB(88, 91, 112),
        Popup = Color3.fromRGB(49, 50, 68), Segment = Color3.fromRGB(108, 112, 134), Track = Color3.fromRGB(69, 71, 90),
        SliderFill = Color3.fromRGB(205, 214, 244), Outline = Color3.fromRGB(69, 71, 90), Text = Color3.fromRGB(205, 214, 244),
        SubText = Color3.fromRGB(166, 173, 200), Accent = Color3.fromRGB(203, 166, 247), AccentText = Color3.fromRGB(30, 30, 46),
        Red = Color3.fromRGB(243, 139, 168), IsLight = false,
    },
    Cream = {
        Window = Color3.fromRGB(250, 245, 235), Sidebar = Color3.fromRGB(242, 234, 220), Titlebar = Color3.fromRGB(235, 226, 210),
        Card = Color3.fromRGB(255, 252, 245), Control = Color3.fromRGB(235, 226, 210), ControlHover = Color3.fromRGB(220, 210, 190),
        Popup = Color3.fromRGB(255, 252, 245), Segment = Color3.fromRGB(255, 255, 255), Track = Color3.fromRGB(210, 198, 180),
        SliderFill = Color3.fromRGB(180, 120, 60), Outline = Color3.fromRGB(210, 198, 180), Text = Color3.fromRGB(50, 40, 30),
        SubText = Color3.fromRGB(120, 105, 90), Accent = Color3.fromRGB(200, 140, 70), AccentText = Color3.fromRGB(255, 255, 255),
        Red = Color3.fromRGB(200, 80, 70), IsLight = true,
    },
}

--// Library \\--
local Labels, Buttons, Toggles, Options = {}, {}, {}, {}

local Library = {
    Version = "1.0.0",
    AppName = "Evergreen",
    Themes = Themes,

    Labels = Labels,
    Buttons = Buttons,
    Toggles = Toggles,
    Options = Options,

    Toggled = false,
    Unloaded = false,
    IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled,
    IsPicking = false,
    CantDragForced = false,
    ForceCheckbox = false,

    Window = nil,
    ActiveTab = nil,
    Tabs = {},
    TabList = {},

    DependencyBoxes = {},
    Notifications = {},
    NotifySide = "Right",
    KeybindPickers = {},
    KeybindListEnabled = false,

    Searching = false,
    SearchText = "",

    ToggleKeybind = Enum.KeyCode.RightControl,
    CurrentPopup = nil,

    Signals = {},
    UnloadSignals = {},
    Registry = {},

    TweenInfo = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    SlowTween = TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    PopTween = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),

    Scheme = {
        Font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        FontBold = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    },
}
for Key, Value in Themes.Dark do
    Library.Scheme[Key] = Value
end
Library.DPIScale = 1
Library.DPIScales = {} -- UIScale -> true (strong; cleaned on removal)
Library.Surfaces = {}  -- Frame -> { Base, Factor } for UI transparency
Library.UITransparency = 0
Library.BlurEnabled = false
Library.BlurSize = 16
Library.ThemeHooks = {}

local Templates = {
    Window = {
        Title = "Evergreen",
        Subtitle = nil,
        Footer = "",
        Icon = nil,

        Size = UDim2.fromOffset(780, 520),
        Position = UDim2.fromOffset(40, 40),
        MinSize = Vector2.new(600, 380),
        Center = true,
        AutoShow = true,
        Resizable = true,
        CornerRadius = 12,

        SidebarWidth = 190,
        ShowUserChip = true,
        ShowTrafficLights = true,
        DisableSearch = false,

        NotifySide = "Right",
        ToggleKeybind = Enum.KeyCode.RightControl,
        UnlockMouseWhileOpen = true,
        ShowMobileButton = true,

        CloseUnloads = false,
        OnClose = nil,

        Theme = "Dark",
        Accent = nil,
        SearchStyle = 1, -- 1 = collapsible title-bar search, 2 = spotlight search
        Transparency = 0, -- 0 - 0.9 (also Library:SetTransparency)
        Blur = false,     -- blur the game behind the UI (also Library:SetBlur)
        BlurSize = 16,
        DPIScale = 100,
        Glass = false,    -- frosted glass look (transparency + blur)
        Wallpaper = nil,  -- rbxassetid:// or image URL behind the window content
        WallpaperTransparency = 0.55,
    },
    Groupbox = { Side = 1, Name = "Groupbox", IconName = nil, Description = nil, Visible = true, Collapsed = false, DisableCollapsing = false },
    Tabbox = { Side = 1, Name = nil },
    Dialog = { Title = "Dialog", Description = "", Icon = nil, AutoDismiss = true, OutsideClickDismiss = false, FooterButtons = {} },
    Toggle = { Text = "Toggle", Default = false, Callback = function() end, Changed = function() end, Risky = false, Disabled = false, Visible = true, Checkbox = false },
    Input = { Text = "Input", Default = "", AnimatePlaceholder = false, PlaceholderSpeed = 0.055, Finished = false, Numeric = false, ClearTextOnFocus = false, Placeholder = "", AllowEmpty = true, EmptyReset = "---", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Slider = { Text = "Slider", Default = 0, Min = 0, Max = 100, Rounding = 0, Prefix = "", Suffix = "", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    RangeSlider = { Text = "Range", Default = { 20, 80 }, Min = 0, Max = 100, Rounding = 0, Prefix = "", Suffix = "", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Dropdown = { Values = {}, DisabledValues = {}, Multi = false, MaxVisibleDropdownItems = 8, Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    List = { Text = "List", Values = {}, DisabledValues = {}, Multi = false, Height = 140, MaxVisibleItems = 6, AllowNull = true, Extended = false, Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Skeleton = { Rows = 3, Height = 18, Gap = 8, Visible = true },
    Image = { Image = "", Height = 160, Color = Color3.new(1, 1, 1), Transparency = 0, ScaleType = Enum.ScaleType.Fit, Visible = true },
    UIPassthrough = { Instance = nil, Height = 24, Visible = true },
    KeyPicker = { Text = "Keybind", Default = "None", Mode = "Toggle", Modes = { "Always", "Toggle", "Hold" }, SyncToggleState = false, Callback = function() end, ChangedCallback = function() end, Changed = function() end, Clicked = function() end },
    ColorPicker = { Default = Color3.new(1, 1, 1), Callback = function() end, Changed = function() end },
}

--// Basic helpers \\--
local function Tween(Object, Props, Info)
    local T = TweenService:Create(Object, Info or Library.TweenInfo, Props)
    T:Play()
    return T
end

local function Anim(Object, Props, Instant)
    if Instant then
        for K, V in Props do
            Object[K] = V
        end
    else
        Tween(Object, Props)
    end
end

local function StopTween(T)
    if T and T.PlaybackState == Enum.PlaybackState.Playing then
        T:Cancel()
    end
end

local function Trim(S) return (tostring(S):match("^%s*(.-)%s*$")) end
local function MousePos() return Vector2.new(Mouse.X, Mouse.Y) end

local function IsOver(Gui, Pos)
    if not Gui or not Gui.Parent then return false end
    local P, S = Gui.AbsolutePosition, Gui.AbsoluteSize
    return Pos.X >= P.X and Pos.X <= P.X + S.X and Pos.Y >= P.Y and Pos.Y <= P.Y + S.Y
end

local function IsPress(Input)
    return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
end

local function IsArray(T)
    if typeof(T) ~= "table" then return false end
    local N = 0
    for _ in T do N += 1 end
    return N == #T
end

local function Round(Value, Rounding)
    if Rounding <= 0 then return math.floor(Value + 0.5) end
    return tonumber(string.format("%." .. Rounding .. "f", Value))
end

local function Lighten(C, Amount)
    return Color3.new(math.clamp(C.R + Amount, 0, 1), math.clamp(C.G + Amount, 0, 1), math.clamp(C.B + Amount, 0, 1))
end

local function NormalizeSearch(S) return (tostring(S):lower():gsub("%s+", "")) end
local function Fuzzy(Text, Search)
    if typeof(Text) ~= "string" or Text == "" or Search == "" then return false end
    Text = NormalizeSearch(Text)
    if Text:find(Search, 1, true) then return true end
    if #Search < 3 or #Search > #Text then return false end
    local I = 1
    for C = 1, #Text do
        if Text:sub(C, C) == Search:sub(I, I) then
            I += 1
            if I > #Search then return true end
        end
    end
    return false
end

function Library:Validate(Table, Template)
    if typeof(Table) ~= "table" then Table = {} end
    for K, V in Template do
        if Table[K] == nil then
            Table[K] = typeof(V) == "table" and table.clone(V) or V
        end
    end
    return Table
end

function Library:GiveSignal(Connection)
    if typeof(Connection) == "RBXScriptConnection" then
        table.insert(Library.Signals, Connection)
    end
    return Connection
end

function Library:OnUnload(Callback) table.insert(Library.UnloadSignals, Callback) end

function Library:SafeCallback(Func, ...)
    if typeof(Func) ~= "function" then return end
    local Result = table.pack(xpcall(Func, function(Err)
        task.defer(error, debug.traceback(tostring(Err), 2))
        return Err
    end, ...))
    if not Result[1] then return nil end
    return table.unpack(Result, 2, Result.n)
end

--// Instance creation + theme registry \\--
local Templ = {
    Frame = { BorderSizePixel = 0 },
    ImageLabel = { BackgroundTransparency = 1, BorderSizePixel = 0 },
    ImageButton = { AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0 },
    ScrollingFrame = { BorderSizePixel = 0, BackgroundTransparency = 1, ScrollBarThickness = 0, ScrollBarImageTransparency = 1 },
    TextLabel = { BorderSizePixel = 0, BackgroundTransparency = 1, FontFace = "Font", RichText = true, TextColor3 = "Text", TextSize = 13 },
    TextButton = { AutoButtonColor = false, BorderSizePixel = 0, BackgroundTransparency = 1, FontFace = "Font", RichText = true, TextColor3 = "Text", TextSize = 13, Text = "" },
    TextBox = { BorderSizePixel = 0, BackgroundTransparency = 1, FontFace = "Font", TextColor3 = "Text", PlaceholderColor3 = "SubText", TextSize = 13, Text = "" },
}

local function Resolve(Prop, Value)
    if typeof(Value) == "string" and (Prop == "FontFace" or Prop:find("Color")) and Library.Scheme[Value] ~= nil then
        return Library.Scheme[Value], true
    elseif typeof(Value) == "function" then
        return Value(), true
    end
    return Value, false
end

local function Fill(Inst, Props)
    local Theme = Library.Registry[Inst] or {}
    for K, V in Props do
        if K ~= "Parent" then
            local RV, Themed = Resolve(K, V)
            Theme[K] = Themed and V or nil
            Inst[K] = RV
        end
    end
    if next(Theme) then Library.Registry[Inst] = Theme end
end

local function New(Class, Props)
    local Inst = Instance.new(Class)
    if Templ[Class] then Fill(Inst, Templ[Class]) end
    Fill(Inst, Props)
    if Props.Parent then Inst.Parent = Props.Parent end
    return Inst
end

local function Bind(Inst, Prop, Key)
    local T = Library.Registry[Inst]
    if not T then
        T = {}
        Library.Registry[Inst] = T
    end
    T[Prop] = Key
end

local function Corner(Parent, R) return New("UICorner", { CornerRadius = UDim.new(0, R), Parent = Parent }) end
local function Stroke(Parent, Color, Thickness, Transparency)
    return New("UIStroke", {
        Color = Color or "Outline", Thickness = Thickness or 1, Transparency = Transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = Parent,
    })
end
local function Pad(Parent, T, R, B, L)
    return New("UIPadding", {
        PaddingTop = UDim.new(0, T or 0), PaddingRight = UDim.new(0, R or 0),
        PaddingBottom = UDim.new(0, B or 0), PaddingLeft = UDim.new(0, L or 0), Parent = Parent,
    })
end
local function List(Parent, Padding, Dir, HA, VA)
    return New("UIListLayout", {
        Padding = UDim.new(0, Padding or 0), FillDirection = Dir or Enum.FillDirection.Vertical,
        HorizontalAlignment = HA or Enum.HorizontalAlignment.Left, VerticalAlignment = VA or Enum.VerticalAlignment.Top,
        SortOrder = Enum.SortOrder.LayoutOrder, Parent = Parent,
    })
end
local function Flex(Parent) return New("UIFlexItem", { FlexMode = Enum.UIFlexMode.Fill, Parent = Parent }) end

--// Gradients (re-evaluated whenever the theme changes) \--
Library.Gradients = {}
local function Two(Key, TopAdd, BottomAdd)
    return function()
        local C = Library.Scheme[Key]
        return ColorSequence.new(Lighten(C, TopAdd), Lighten(C, BottomAdd))
    end
end
local function Grad(Inst, Fn, Rotation)
    local G = New("UIGradient", { Rotation = Rotation or 90, Parent = Inst })
    G.Color = Fn()
    Library.Gradients[G] = Fn
    return G
end
function Library:UpdateGradients()
    for G, Fn in Library.Gradients do
        pcall(function() G.Color = Fn() end)
    end
end

function Library:UpdateColorsUsingRegistry()
    for Inst, Props in Library.Registry do
        for Prop, Key in Props do
            local RV, Themed = Resolve(Prop, Key)
            if Themed then pcall(function() Inst[Prop] = RV end) end
        end
    end
end

function Library:RefreshTheme()
    Library:UpdateColorsUsingRegistry()
    Library:UpdateGradients()
    for _, E in Toggles do if E.Display then pcall(E.Display, E, true) end end
    for _, E in Options do if E.Display then pcall(E.Display, E, true) end end
    for _, T in Library.TabList do pcall(T.RefreshStyle, T) end
    for _, Fn in Library.ThemeHooks do pcall(Fn) end
end

function Library:RegisterTheme(Name, Theme)
    Themes[Name] = Theme
end

-- SetTheme("Name") replaces the whole palette; SetTheme({ Accent = ... }) merges on top of the current one.
function Library:SetTheme(Theme)
    if typeof(Theme) == "string" then
        local Found = Themes[Theme]
        if not Found then return end
        for K, V in Themes.Dark do Library.Scheme[K] = V end
        for K, V in Found do Library.Scheme[K] = V end
        Library.ThemeName = Theme
    elseif typeof(Theme) == "table" then
        for K, V in Theme do Library.Scheme[K] = V end
    else
        return
    end

    if Library.AccentOverride then
        Library.Scheme.Accent = Library.AccentOverride
        if Library.Scheme.IsLight then Library.Scheme.SliderFill = Library.AccentOverride end
    end
    Library:RefreshTheme()
end

function Library:SetAccent(Color)
    if typeof(Color) ~= "Color3" then return end
    Library.AccentOverride = Color
    Library.Scheme.Accent = Color
    if Library.Scheme.IsLight then Library.Scheme.SliderFill = Color end
    Library:RefreshTheme()
end

function Library:ResetAccent()
    Library.AccentOverride = nil
    Library:SetTheme(Library.ThemeName or "Dark")
end

function Library:SetFont(FontFace)
    if typeof(FontFace) == "EnumItem" then FontFace = Font.fromEnum(FontFace) end
    Library.Scheme.Font = FontFace
    Library:UpdateColorsUsingRegistry()
end

--// Icons \\--
local IconModule
pcall(function()
    IconModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/lucide-roblox-direct/refs/heads/main/source.lua"))()
end)

function Library:GetIcon(Name)
    if not IconModule or typeof(Name) ~= "string" then return nil end
    local Ok, Icon = pcall(IconModule.GetAsset, Name)
    return Ok and Icon or nil
end

function Library:GetCustomIcon(Name)
    if Name == nil or Name == "" then return nil end
    if tonumber(Name) then Name = "rbxassetid://" .. tostring(Name) end
    if typeof(Name) ~= "string" then return nil end
    if Name:match("^rbxassetid://") or Name:match("^rbxasset://") or Name:match("^rbxthumb://") or Name:match("^content://") or Name:match("roblox%.com/asset") then
        return { Url = Name, ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero, Custom = true }
    end
    return Library:GetIcon(Name)
end

function Library:ApplyIcon(Img, Icon)
    if not Img or not Icon then return end
    Img.Image = Icon.Url or ""
    Img.ImageRectOffset = Icon.ImageRectOffset or Vector2.zero
    Img.ImageRectSize = Icon.ImageRectSize or Vector2.zero
end

--// Glyph: lucide icon with a text fallback \\--
local function Glyph(Parent, IconName, Fallback, Props)
    Props = Props or {}
    Props.Parent = Parent
    local Icon = Library:GetIcon(IconName)
    if Icon then
        local Img = New("ImageLabel", {
            AnchorPoint = Props.AnchorPoint, Position = Props.Position, Size = Props.Size or UDim2.fromOffset(14, 14),
            ImageColor3 = Props.Color or "SubText", Rotation = Props.Rotation or 0, LayoutOrder = Props.LayoutOrder or 0,
            Visible = Props.Visible ~= false, Parent = Parent,
        })
        Library:ApplyIcon(Img, Icon)
        return Img
    end
    return New("TextLabel", {
        AnchorPoint = Props.AnchorPoint, Position = Props.Position, Size = Props.Size or UDim2.fromOffset(14, 14),
        Text = Fallback, TextSize = 13, TextColor3 = Props.Color or "SubText", Rotation = Props.Rotation or 0,
        LayoutOrder = Props.LayoutOrder or 0, Visible = Props.Visible ~= false, Parent = Parent,
    })
end
local function GlyphTransparency(G, T)
    if G:IsA("ImageLabel") then G.ImageTransparency = T else G.TextTransparency = T end
end

--// Root GUI \\--
local ScreenGui = New("ScreenGui", { Name = "Evergreen", DisplayOrder = 998, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
pcall(protectgui, ScreenGui)
local ParentOk = pcall(function() ScreenGui.Parent = gethui() end)
if not ParentOk or not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end
Library.ScreenGui = ScreenGui

ScreenGui.DescendantRemoving:Connect(function(Inst)
    task.defer(function()
        if Inst.Parent and Inst:IsDescendantOf(ScreenGui) then return end
        Library.Registry[Inst] = nil
        Library.Gradients[Inst] = nil
        Library.DPIScales[Inst] = nil
        Library.Surfaces[Inst] = nil
    end)
end)

local ModalElement = New("TextButton", { Modal = false, Size = UDim2.fromOffset(0, 0), ZIndex = -999, Parent = ScreenGui })
local Floats = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 10, Parent = ScreenGui })
local Overlay = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 20, Parent = ScreenGui })
Library.Floats, Library.Overlay = Floats, Overlay

--// Dragging \\--
function Library:MakeDraggable(Target, Handle, IsWindow)
    local Dragging, StartPos, StartFrame = false, nil, nil
    Library:GiveSignal(Handle.InputBegan:Connect(function(Input)
        if not IsPress(Input) or (IsWindow and Library.CantDragForced) then return end
        Dragging, StartPos, StartFrame = true, Input.Position, Target.Position
        local C; C = Input.Changed:Connect(function()
            if Input.UserInputState == Enum.UserInputState.End then
                Dragging = false
                C:Disconnect()
            end
        end)
    end))
    Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
        if not Dragging then return end
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            local D = Input.Position - StartPos
            Target.Position = UDim2.new(StartFrame.X.Scale, StartFrame.X.Offset + D.X, StartFrame.Y.Scale, StartFrame.Y.Offset + D.Y)
        end
    end))
end

--// UI transparency (must exist before load-time surfaces like the keybind list) \\--
function Library:AddSurface(Frame, Base, Factor)
    Base, Factor = Base or 0, Factor or 1
    Library.Surfaces[Frame] = { Base = Base, Factor = Factor }
    Frame.BackgroundTransparency = Base + (1 - Base) * Library.UITransparency * Factor
end

function Library:SetTransparency(T)
    T = math.clamp(tonumber(T) or 0, 0, 0.9)
    Library.UITransparency = T
    for Frame, D in Library.Surfaces do
        if Frame.Parent then
            Frame.BackgroundTransparency = D.Base + (1 - D.Base) * T * D.Factor
        end
    end
end

--// Popups (dropdown, color picker, key mode menu) \\--
function Library:CreatePopup(Anchor, Opt)
    Opt = Opt or {}
    local Popup = { Active = false, Anchor = Anchor, Destroyed = false, Connections = {} }

    local Frame = New("Frame", {
        BackgroundColor3 = "Popup", Visible = false, ClipsDescendants = true,
        Size = UDim2.fromOffset(Opt.Width or 150, Opt.Height or 100), Parent = Overlay,
    })
    if Opt.AutoY then
        Frame.AutomaticSize = Enum.AutomaticSize.Y
        Frame.Size = UDim2.fromOffset(Opt.Width or 150, 0)
    end
    Corner(Frame, 9)
    Stroke(Frame, "Outline", 1, 0.2)
    local Scale = New("UIScale", { Scale = Library.DPIScale, Parent = Frame })
    Library.DPIScales[Scale] = true
    Library:AddSurface(Frame, 0, 0.5)
    Popup.Frame = Frame

    function Popup:UpdatePosition()
        if not Anchor.Parent then return end
        local AP, AS, FS = Anchor.AbsolutePosition, Anchor.AbsoluteSize, Frame.AbsoluteSize
        local View = ScreenGui.AbsoluteSize
        local X = AP.X + (Opt.AlignRight and (AS.X - FS.X) or 0)
        local Y = AP.Y + AS.Y + 4
        if Y + FS.Y > View.Y - 8 then Y = AP.Y - FS.Y - 4 end
        X = math.clamp(X, 8, math.max(8, View.X - FS.X - 8))
        Frame.Position = UDim2.fromOffset(math.floor(X), math.floor(Y))
    end

    function Popup:SetSize(Size)
        Frame.Size = Size
        if Popup.Active then Popup:UpdatePosition() end
    end

    function Popup:Open()
        if Popup.Active or Popup.Destroyed then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        Library.CurrentPopup = Popup
        Popup.Active = true
        if Opt.OnOpen then Library:SafeCallback(Opt.OnOpen, Popup) end

        Frame.Visible = true
        Scale.Scale = 0.95 * Library.DPIScale
        Tween(Scale, { Scale = Library.DPIScale }, Library.PopTween)
        Popup:UpdatePosition()

        Popup.Connections = {
            Anchor:GetPropertyChangedSignal("AbsolutePosition"):Connect(function() Popup:UpdatePosition() end),
            Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() Popup:UpdatePosition() end),
        }
        if Opt.OnToggle then Library:SafeCallback(Opt.OnToggle, true) end
    end

    function Popup:Close()
        if not Popup.Active then return end
        Popup.Active = false
        if Library.CurrentPopup == Popup then Library.CurrentPopup = nil end
        for _, C in Popup.Connections do C:Disconnect() end
        Popup.Connections = {}
        Frame.Visible = false
        if Opt.OnToggle then Library:SafeCallback(Opt.OnToggle, false) end
    end

    function Popup:Toggle()
        if Popup.Active then Popup:Close() else Popup:Open() end
    end

    function Popup:Destroy()
        Popup:Close()
        Popup.Destroyed = true
        Frame:Destroy()
    end

    return Popup
end

Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input)
    if Library.Unloaded then return end
    local Type = Input.UserInputType
    if Type == Enum.UserInputType.MouseButton1 or Type == Enum.UserInputType.MouseButton2 or Type == Enum.UserInputType.Touch then
        local P = Library.CurrentPopup
        if P then
            local M = MousePos()
            if not IsOver(P.Frame, M) and not IsOver(P.Anchor, M) then P:Close() end
        end
    elseif Input.KeyCode == Enum.KeyCode.Escape then
        if UserInputService:GetFocusedTextBox() then return end
        if Library.CurrentModal then Library.CurrentModal:Close() return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
    end
end))

--// Tooltips \\--
local TooltipLabel = New("TextLabel", {
    BackgroundColor3 = "Popup", BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.XY,
    Size = UDim2.fromOffset(0, 0), TextSize = 12, TextWrapped = true, Visible = false, ZIndex = 60, Parent = ScreenGui,
})
Corner(TooltipLabel, 6)
Stroke(TooltipLabel, "Outline", 1, 0.2)
Pad(TooltipLabel, 5, 8, 5, 8)
New("UISizeConstraint", { MaxSize = Vector2.new(260, math.huge), Parent = TooltipLabel })
Library.DPIScales[New("UIScale", { Parent = TooltipLabel })] = true

local HoverTarget
Library:GiveSignal(RunService.RenderStepped:Connect(function()
    if HoverTarget then
        if not HoverTarget.Parent or not HoverTarget.Visible or Library.CurrentPopup then
            TooltipLabel.Visible = false
            HoverTarget = nil
            return
        end
        TooltipLabel.Position = UDim2.fromOffset(Mouse.X + 14, Mouse.Y + 14)
    end
end))

function Library:AddTooltip(Text, Target)
    if typeof(Text) ~= "string" or not Target then return end
    Library:GiveSignal(Target.MouseEnter:Connect(function()
        if Library.CurrentPopup then return end
        HoverTarget = Target
        TooltipLabel.Text = Text
        TooltipLabel.Visible = true
    end))
    Library:GiveSignal(Target.MouseLeave:Connect(function()
        if HoverTarget == Target then
            HoverTarget = nil
            TooltipLabel.Visible = false
        end
    end))
end

--// Keybind list (floating macOS-style HUD) \\--
local KeybindFrame = New("Frame", {
    BackgroundColor3 = "Card", AutomaticSize = Enum.AutomaticSize.XY, AnchorPoint = Vector2.new(0, 0.5),
    Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(0, 0), Visible = false, Parent = Floats,
})
Corner(KeybindFrame, 10)
Library:AddSurface(KeybindFrame, 0, 0.6)
Stroke(KeybindFrame, "Outline", 1, 0.2)
Pad(KeybindFrame, 8, 12, 10, 12)
List(KeybindFrame, 4)
New("TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 16), Text = "Keybinds", FontFace = "FontBold", TextSize = 12, LayoutOrder = -1, Parent = KeybindFrame })
local KeybindContainer = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 0), Parent = KeybindFrame })
List(KeybindContainer, 2)
Library.KeybindFrame, Library.KeybindContainer = KeybindFrame, KeybindContainer
Library:MakeDraggable(KeybindFrame, KeybindFrame)
Library.DPIScales[New("UIScale", { Parent = KeybindFrame })] = true

function Library:UpdateKeybindList()
    local Any = false
    for _, KP in Library.KeybindPickers do
        if KP.Row and KP.Row.Visible then Any = true break end
    end
    KeybindFrame.Visible = Library.KeybindListEnabled and Any
end
function Library:SetKeybindListVisible(Value)
    Library.KeybindListEnabled = Value == true
    Library:UpdateKeybindList()
end

--// Players / Teams \\--
local function GetPlayers(ExcludeLocal)
    local L = Players:GetPlayers()
    if ExcludeLocal then
        local I = table.find(L, LocalPlayer)
        if I then table.remove(L, I) end
    end
    table.sort(L, function(A, B) return A.Name:lower() < B.Name:lower() end)
    return L
end
local function GetTeams()
    local L = Teams:GetTeams()
    table.sort(L, function(A, B) return A.Name:lower() < B.Name:lower() end)
    return L
end

--// Rich text: custom tags, inline icons/images, click-to-copy, text animations \\--
--  <Copyable>text</Copyable>  <Link=url>..</Link>  <Title> <Subtitle> <Muted> <Accent> <Red> <Green> <Blue> <Yellow> ...
--  <B> <I> <U> <S> <Code> <Size=18> <Color=#ff8800> <Br/> <Icon=house Size=14/> <Image=rbxassetid://123 Size=32/>
--  Animations: <Rainbow> <Wave> <Pulse> <Shake> <Typewriter>.  Closing with <Tag/> works too.
local RichNamed = {
    blue = Color3.fromRGB(64, 156, 255), green = Color3.fromRGB(48, 209, 88), yellow = Color3.fromRGB(255, 214, 10),
    orange = Color3.fromRGB(255, 159, 10), purple = Color3.fromRGB(191, 90, 242), pink = Color3.fromRGB(255, 55, 95),
    cyan = Color3.fromRGB(90, 200, 250), white = Color3.new(1, 1, 1), gray = Color3.fromRGB(150, 150, 158),
}
local RichKeys = { accent = "Accent", muted = "SubText", subtext = "SubText", red = "Red", text = "Text" }
local RichAnims = { rainbow = true, wave = true, pulse = true, shake = true, typewriter = true }
local RichFonts = {
    Italic = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Italic),
    BoldItalic = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Italic),
    Code = Font.fromEnum(Enum.Font.Code),
}

local function Esc(S)
    return (S:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end

local function ParseColor(V)
    if not V then return nil end
    local L = tostring(V):lower()
    if RichKeys[L] then return RichKeys[L] end
    if RichNamed[L] then return RichNamed[L] end
    if L:sub(1, 1) == "#" then
        local Ok, C = pcall(Color3.fromHex, L)
        if Ok then return C end
    end
    local R, G, B = L:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
    if R then return Color3.fromRGB(tonumber(R), tonumber(G), tonumber(B)) end
    return nil
end

function Library:HasRich(Text)
    return typeof(Text) == "string" and Text:find("<[/%a]") ~= nil
end

function Library:ParseRich(Text)
    Text = tostring(Text or "")
    local Segs, Stack, Cur = {}, {}, {}

    local function AddText(T)
        if T == "" then return end
        local Lines = T:split("\n")
        for I, Line in Lines do
            if I > 1 then table.insert(Segs, { Type = "br" }) end
            if Line ~= "" then
                if Cur.CopyRef then Cur.CopyRef.Text ..= Line end
                table.insert(Segs, { Type = "text", Text = Line, Style = table.clone(Cur) })
            end
        end
    end

    local function Apply(Name, Val, Attrs)
        if Name == "copyable" or Name == "copy" then
            Cur.CopyRef = { Text = "" }; Cur.Color = RichNamed.blue; Cur.Underline = true
        elseif Name == "link" or Name == "url" then
            Cur.Link = Val or Attrs.url or Attrs.href or ""; Cur.Color = RichNamed.blue; Cur.Underline = true
        elseif Name == "title" then Cur.Size = 20; Cur.Bold = true
        elseif Name == "subtitle" then Cur.Size = 16; Cur.Bold = true
        elseif Name == "b" or Name == "bold" then Cur.Bold = true
        elseif Name == "i" or Name == "italic" then Cur.Italic = true
        elseif Name == "u" or Name == "underline" then Cur.Underline = true
        elseif Name == "s" or Name == "strike" then Cur.Strike = true
        elseif Name == "code" then Cur.Code = true; Cur.Color = "Accent"
        elseif Name == "size" then Cur.Size = tonumber(Val) or Cur.Size
        elseif Name == "color" or Name == "colour" or Name == "c" then Cur.Color = ParseColor(Val) or Cur.Color
        elseif RichKeys[Name] or RichNamed[Name] then Cur.Color = RichKeys[Name] or RichNamed[Name]
        elseif RichAnims[Name] then Cur.Anim = Name
        else return false end
        return true
    end

    local Pos = 1
    while Pos <= #Text do
        local S, E, Close, Name, Rest = Text:find("<(/?)%s*([%a_][%w_]*)([^<>]-)>", Pos)
        if not S then AddText(Text:sub(Pos)) break end
        AddText(Text:sub(Pos, S - 1))
        Pos = E + 1

        local LName = Name:lower()
        local SelfClose = false
        if Rest:sub(-1) == "/" then SelfClose = true; Rest = Rest:sub(1, -2) end
        Rest = Rest:match("^%s*(.-)%s*$")

        local Val, Attrs = nil, {}
        if Rest:sub(1, 1) == "=" then
            local Quoted = Rest:match('^=%s*"[^"]*"')
            local Plain = Quoted or Rest:match("^=%s*%S+")
            Val = Quoted and Quoted:match('"([^"]*)"') or (Plain and Plain:match("^=%s*(%S+)"))
            Rest = Rest:sub(#(Plain or "") + 1)
        end
        for K, V in Rest:gmatch('([%w_]+)%s*=%s*"?([^"%s]+)"?') do Attrs[K:lower()] = V end

        local function CloseTag()
            for I = #Stack, 1, -1 do
                if Stack[I].Name == LName then
                    Cur = Stack[I].Prev
                    for J = #Stack, I, -1 do table.remove(Stack, J) end
                    return true
                end
            end
            return false
        end

        if Close == "/" then
            if not CloseTag() then AddText(Text:sub(S, E)) end
        elseif LName == "br" then
            table.insert(Segs, { Type = "br" })
        elseif LName == "icon" or LName == "img" or LName == "image" then
            table.insert(Segs, {
                Type = "icon", Value = Val or Attrs.name or Attrs.id or Attrs.src, IsImage = LName ~= "icon",
                Size = tonumber(Attrs.size) or Cur.Size or 14, Color = Attrs.color and ParseColor(Attrs.color) or Cur.Color,
            })
        elseif SelfClose then
            if not CloseTag() then AddText(Text:sub(S, E)) end
        else
            local Prev = table.clone(Cur)
            if Apply(LName, Val, Attrs) then
                table.insert(Stack, { Name = LName, Prev = Prev })
            else
                Cur = Prev
                AddText(Text:sub(S, E))
            end
        end
    end
    return Segs
end

function Library:StripRich(Text)
    Text = tostring(Text or "")
    if not Text:find("<[/%a]") then return Text end
    local Out = {}
    for _, Seg in Library:ParseRich(Text) do
        if Seg.Type == "text" then table.insert(Out, Seg.Text) elseif Seg.Type == "br" then table.insert(Out, " ") end
    end
    return table.concat(Out)
end

-- single-label version: converts custom tags to Roblox RichText (not clickable, no inline icons)
function Library:ToRichText(Text)
    Text = tostring(Text or "")
    if not Text:find("<[/%a]") then return Text end
    local Out = {}
    for _, Seg in Library:ParseRich(Text) do
        if Seg.Type == "br" then
            table.insert(Out, "\n")
        elseif Seg.Type == "text" then
            local St, T = Seg.Style, Esc(Seg.Text)
            if St.Strike then T = "<s>" .. T .. "</s>" end
            if St.Underline then T = "<u>" .. T .. "</u>" end
            if St.Italic then T = "<i>" .. T .. "</i>" end
            if St.Bold then T = "<b>" .. T .. "</b>" end
            if St.Color then
                local C3 = typeof(St.Color) == "string" and Library.Scheme[St.Color] or St.Color
                if typeof(C3) == "Color3" then T = string.format('<font color="#%s">%s</font>', C3:ToHex(), T) end
            end
            if St.Size then T = string.format('<font size="%d">%s</font>', St.Size, T) end
            table.insert(Out, T)
        end
    end
    return table.concat(Out)
end

-- search highlight (Roblox RichText)
function Library:HighlightText(Text, Query)
    local Plain = Library:StripRich(Text)
    Query = Trim(tostring(Query or "")):lower()
    if Query == "" then return Library:ToRichText(Text) end
    local A, B = Plain:lower():find(Query, 1, true)
    if not A then return Library:ToRichText(Text) end
    return string.format('%s<font color="#%s"><b>%s</b></font>%s',
        Esc(Plain:sub(1, A - 1)), Library.Scheme.Accent:ToHex(), Esc(Plain:sub(A, B)), Esc(Plain:sub(B + 1)))
end

--// Text animations \\--
Library.TextAnims = {}
function Library:AnimateText(Label, Kind, Index, Count)
    Kind = tostring(Kind):lower()
    if not RichAnims[Kind] then return end
    if Kind == "typewriter" then Label.TextTransparency = 1 end
    table.insert(Library.TextAnims, { L = Label, K = Kind, I = Index or 0, N = Count or 1, T0 = os.clock() })
end

Library:GiveSignal(RunService.RenderStepped:Connect(function()
    local Now = os.clock()
    for I = #Library.TextAnims, 1, -1 do
        local A = Library.TextAnims[I]
        local L = A.L
        if not L.Parent then
            table.remove(Library.TextAnims, I)
        else
            local T = Now - A.T0
            if A.K == "rainbow" then
                L.TextColor3 = Color3.fromHSV((T * 0.35 + A.I * 0.045) % 1, 0.7, 1)
            elseif A.K == "wave" then
                L.Rotation = math.sin(T * 5 + A.I * 0.6) * 7
            elseif A.K == "pulse" then
                L.TextTransparency = 0.3 - 0.3 * math.cos(T * 3)
            elseif A.K == "shake" then
                L.Rotation = (math.random() - 0.5) * 6
            elseif A.K == "typewriter" then
                if T >= A.I * 0.045 then
                    L.TextTransparency = 0
                    if A.I >= A.N - 1 or T > A.N * 0.045 + 0.2 then table.remove(Library.TextAnims, I) end
                end
            end
        end
    end
end))

-- Full renderer: flowing words as separate widgets so Copyable/Link/icons/animations work inline.
function Library:RenderRich(Parent, Text, Opt)
    Opt = Opt or {}
    local BaseSize = Opt.Size or 13
    local Host = New("Frame", {
        BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0),
        LayoutOrder = Opt.LayoutOrder or 0, Visible = Opt.Visible ~= false, Parent = Parent,
    })
    New("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal, Wraps = true, SortOrder = Enum.SortOrder.LayoutOrder,
        HorizontalAlignment = Opt.Align == "Center" and Enum.HorizontalAlignment.Center or (Opt.Align == "Right" and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left),
        Parent = Host,
    })
    local Rich = { Host = Host, Text = tostring(Text or "") }

    function Rich:Render(NewText)
        Rich.Text = tostring(NewText or "")
        for _, C in Host:GetChildren() do
            if C:IsA("GuiObject") then C:Destroy() end
        end

        local Order = 0
        local Groups = {}
        local function Next() Order += 1 return Order end
        local BaseLine = math.ceil(BaseSize * 1.45)

        local function CopyOut(Str, Group)
            local Fn = setclipboard or toclipboard
            if Fn then pcall(Fn, Str) end
            for _, P in Group do
                if P.Parent then
                    local Prev = P.TextColor3
                    P.TextColor3 = RichNamed.green
                    task.delay(0.8, function() if P.Parent then P.TextColor3 = Prev end end)
                end
            end
        end

        local function MakePiece(Str, St, Idx, Count)
            local Size = St.Size or BaseSize
            local Interactive = St.CopyRef ~= nil or (St.Link ~= nil and St.Link ~= "")
            local Face = "Font"
            if St.Code then Face = RichFonts.Code
            elseif (St.Bold or Opt.Bold) and St.Italic then Face = RichFonts.BoldItalic
            elseif St.Bold or Opt.Bold then Face = "FontBold"
            elseif St.Italic then Face = RichFonts.Italic end

            local Content = Esc(Str)
            if St.Strike then Content = "<s>" .. Content .. "</s>" end
            if St.Underline then Content = "<u>" .. Content .. "</u>" end

            local P = New(Interactive and "TextButton" or "TextLabel", {
                BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, math.ceil(Size * 1.45)),
                Text = Content, TextSize = Size, FontFace = Face, TextColor3 = St.Color or Opt.Color or "Text",
                TextYAlignment = Enum.TextYAlignment.Center, LayoutOrder = Next(), Parent = Host,
            })
            if St.Code then
                P.BackgroundTransparency = 0.75
                P.BackgroundColor3 = Library.Scheme.Control
                Bind(P, "BackgroundColor3", "Control")
                Corner(P, 4)
                Pad(P, 0, 3, 0, 3)
            end
            if Interactive then
                local Group = St.CopyRef and Groups[St.CopyRef]
                if St.CopyRef and not Group then Group = {}; Groups[St.CopyRef] = Group end
                if not Group then Group = { P } else table.insert(Group, P) end
                local Payload = St.CopyRef and St.CopyRef or { Text = St.Link }
                P.MouseEnter:Connect(function() Tween(P, { TextTransparency = 0.3 }) end)
                P.MouseLeave:Connect(function() Tween(P, { TextTransparency = 0 }) end)
                P.MouseButton1Click:Connect(function() CopyOut(Payload.Text, Group) end)
                Library:AddTooltip(St.Link and "Click to copy link" or "Click to copy", P)
            end
            if St.Anim then Library:AnimateText(P, St.Anim, Idx, Count) end
            return P
        end

        for _, Seg in Library:ParseRich(Rich.Text) do
            if Seg.Type == "br" then
                New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = Next(), Parent = Host })
            elseif Seg.Type == "icon" then
                local Sz = Seg.Size
                local W = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromOffset(Sz + 4, math.max(BaseLine, Sz + 2)), LayoutOrder = Next(), Parent = Host })
                local Data = Library:GetCustomIcon(Seg.Value)
                if Data then
                    local Img = New("ImageLabel", {
                        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(Sz, Sz),
                        ImageColor3 = Seg.IsImage and Color3.new(1, 1, 1) or (Seg.Color or Opt.Color or "Text"), Parent = W,
                    })
                    Library:ApplyIcon(Img, Data)
                end
            else
                local St = Seg.Style
                if St.Anim then
                    local Chars = {}
                    for _, Code in utf8.codes(Seg.Text) do table.insert(Chars, utf8.char(Code)) end
                    for I, Ch in Chars do MakePiece(Ch, St, I - 1, #Chars) end
                else
                    local Any = false
                    for Word in Seg.Text:gmatch("%s*%S+%s*") do
                        Any = true
                        MakePiece(Word, St)
                    end
                    if not Any then MakePiece(Seg.Text, St) end
                end
            end
        end
    end

    function Rich:SetText(NewText) Rich:Render(NewText) end
    Rich:Render(Text)
    return Rich
end

--// Elements \\--
local Funcs = {}
local BaseGroupbox = { __index = Funcs }
local AddonFuncs = {}
local BaseAddons = { __index = AddonFuncs }

local function SetSidesScrolling(Enabled)
    if Library.ActiveTab and Library.ActiveTab.Sides then
        for _, S in Library.ActiveTab.Sides do S.ScrollingEnabled = Enabled end
    end
end

local function Finalize(Group, Element, Holder, Store, Idx, Info)
    Element.Holder = Holder
    Element.Parent = Group
    Element.Connections = Element.Connections or {}
    if Element.Visible == nil then Element.Visible = true end
    Element.Tooltip = Info and Info.Tooltip
    table.insert(Group.Elements, Element)

    if Store then
        if Idx ~= nil then Store[Idx] = Element else table.insert(Store, Element) end
    end

    function Element:SetVisible(V)
        Element.Visible = V
        Holder.Visible = V
        if Library.Searching then Library:UpdateSearch(Library.SearchText) end
    end

    function Element:Destroy()
        if Element.Destroyed then return end
        Element.Destroyed = true
        for _, C in Element.Connections do C:Disconnect() end
        if Element.Addons then
            for I = #Element.Addons, 1, -1 do
                if Element.Addons[I].Destroy then Element.Addons[I]:Destroy() end
            end
        end
        Holder:Destroy()
        local I = table.find(Group.Elements, Element)
        if I then table.remove(Group.Elements, I) end
        if Store then
            if Idx ~= nil then Store[Idx] = nil else
                local J = table.find(Store, Element)
                if J then table.remove(Store, J) end
            end
        end
    end

    if Info and typeof(Info.Tooltip) == "string" then
        Library:AddTooltip(Info.Tooltip, Holder)
    end
end

local function MakeRow(Group, Height, AsButton)
    local Row = New(AsButton and "TextButton" or "Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Height or 22), Parent = Group.Container })
    List(Row, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
    return Row
end

local function MakeAddonHolder(Row)
    local H = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), LayoutOrder = 2, Parent = Row })
    List(H, 6, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
    return H
end

--// Divider \\--
function Funcs:AddDivider(Text)
    if self.Destroyed then return end
    if typeof(Text) == "table" then Text = Text.Text end
    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 12), Parent = Group.Container })
    local Div = { Type = "Divider", Visible = true }
    if Text then
        List(Holder, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
        local L1 = New("Frame", { BackgroundColor3 = "Outline", Size = UDim2.new(0, 0, 0, 1), Parent = Holder }); Flex(L1)
        New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 12), Text = Text, TextSize = 11, TextColor3 = "SubText", Parent = Holder })
        local L2 = New("Frame", { BackgroundColor3 = "Outline", Size = UDim2.new(0, 0, 0, 1), Parent = Holder }); Flex(L2)
    else
        New("Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = "Outline", Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1), Parent = Holder })
    end
    Finalize(Group, Div, Holder)
    return Div
end

--// Label \\--
function Funcs:AddLabel(...)
    if self.Destroyed then return end
    local First, Second = ...
    local Data = {}
    if typeof(First) == "table" or typeof(Second) == "table" then
        local P = typeof(First) == "table" and First or Second
        Data.Text, Data.DoesWrap, Data.Size = P.Text or "", P.DoesWrap or false, P.Size or 13
        Data.Visible = P.Visible ~= false
        Data.Idx = typeof(Second) == "table" and First or nil
    else
        Data.Text, Data.DoesWrap, Data.Size, Data.Visible = First or "", Second or false, 13, true
        Data.Idx = select(3, ...)
    end

    local Group = self
    local IsRich = Data.Rich == true or Library:HasRich(Data.Text)
    local Label = { Type = "Label", Text = Data.Text, DoesWrap = Data.DoesWrap, Addons = {}, Visible = Data.Visible }
    local Row, TextLabel, RichObj

    if IsRich then
        Row = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 20), Parent = Group.Container })
        RichObj = Library:RenderRich(Row, Data.Text, { Size = Data.Size, Align = Group.IsKeyTab and "Center" or "Left" })
        Label.AddonHolder = MakeAddonHolder(Row)
        Label.AddonHolder.AnchorPoint = Vector2.new(1, 0)
        Label.AddonHolder.Position = UDim2.fromScale(1, 0)
        Label.AddonHolder.Size = UDim2.fromOffset(0, 20)
        Label.TextLabel = Row
        function Label:SetText(T) Label.Text = T; RichObj:SetText(T) end
    else
        Row = MakeRow(Group, 20)
        if Data.DoesWrap then Row.AutomaticSize = Enum.AutomaticSize.Y end
        TextLabel = New("TextLabel", {
            Size = Data.DoesWrap and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 0, 1, 0),
            AutomaticSize = Data.DoesWrap and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
            Text = Library:ToRichText(Data.Text), TextSize = Data.Size, TextWrapped = Data.DoesWrap,
            TextXAlignment = Group.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 1, Parent = Row,
        })
        if not Data.DoesWrap then TextLabel.TextYAlignment = Enum.TextYAlignment.Center end
        Flex(TextLabel)
        Label.TextLabel = TextLabel
        Label.LabelObj = TextLabel
        Label.AddonHolder = MakeAddonHolder(Row)
        function Label:SetText(T) Label.Text = T; TextLabel.Text = Library:ToRichText(T) end
    end
    Row.Visible = Label.Visible
    setmetatable(Label, BaseAddons)
    Finalize(Group, Label, Row, Labels, Data.Idx)
    return Label
end

--// Title / Paragraph / Callout (all use the rich text renderer) \--
function Funcs:AddTitle(Text, Info)
    if self.Destroyed then return end
    if typeof(Text) == "table" then Info = Text; Text = Info.Text end
    Info = Info or {}
    local Group = self
    local Title = { Type = "Title", Text = tostring(Text or ""), Visible = Info.Visible ~= false }
    local Rich = Library:RenderRich(Group.Container, Title.Text, {
        Size = Info.Size or 17, Bold = true, Align = Info.Align or (Group.IsKeyTab and "Center" or "Left"),
    })
    Rich.Host.Visible = Title.Visible
    function Title:SetText(T) Title.Text = tostring(T); Rich:SetText(T) end
    Finalize(Group, Title, Rich.Host)
    return Title
end

function Funcs:AddParagraph(...)
    if self.Destroyed then return end
    local First, Second = ...
    local Info = typeof(First) == "table" and First or { Title = First, Text = Second }
    local Group = self
    local Para = { Type = "Paragraph", Title = tostring(Info.Title or ""), Body = tostring(Info.Text or ""), Visible = Info.Visible ~= false }
    Para.Text = Para.Title .. " " .. Para.Body

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Para.Visible, Parent = Group.Container })
    List(Holder, 3)
    local TitleRich
    if Para.Title ~= "" then
        TitleRich = Library:RenderRich(Holder, Para.Title, { Size = 13, Bold = true, LayoutOrder = 1 })
    end
    local BodyRich = Library:RenderRich(Holder, Para.Body, { Size = 12, Color = "SubText", LayoutOrder = 2 })

    function Para:SetText(T) Para.Body = tostring(T); Para.Text = Para.Title .. " " .. Para.Body; BodyRich:SetText(T) end
    function Para:SetTitle(T)
        Para.Title = tostring(T); Para.Text = Para.Title .. " " .. Para.Body
        if TitleRich then TitleRich:SetText(T) end
    end
    Finalize(Group, Para, Holder)
    return Para
end

function Funcs:AddCallout(Info)
    if self.Destroyed then return end
    Info = Info or {}
    local Group = self
    local Kind = tostring(Info.Type or "Info"):lower()
    local Look = ({
        info = { RichNamed.blue, "info" }, warning = { RichNamed.yellow, "triangle-alert" },
        success = { RichNamed.green, "circle-check" }, error = { Color3.fromRGB(255, 69, 58), "circle-x" },
    })[Kind] or { RichNamed.blue, "info" }

    local Call = { Type = "Callout", Title = tostring(Info.Title or ""), Body = tostring(Info.Text or ""), Visible = Info.Visible ~= false }
    Call.Text = Call.Title .. " " .. Call.Body

    local Holder = New("Frame", { BackgroundColor3 = Look[1], BackgroundTransparency = 0.88, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Call.Visible, Parent = Group.Container })
    Corner(Holder, 8)
    Stroke(Holder, Look[1], 1, 0.6)
    Pad(Holder, 9, 10, 9, 10)
    local IconData = Library:GetIcon(Look[2])
    if IconData then
        local Img = New("ImageLabel", { Position = UDim2.fromOffset(0, 1), Size = UDim2.fromOffset(16, 16), ImageColor3 = Look[1], Parent = Holder })
        Library:ApplyIcon(Img, IconData)
    end
    local Inner = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(IconData and 24 or 0, 0), Size = UDim2.new(1, IconData and -24 or 0, 0, 0), Parent = Holder })
    List(Inner, 2)
    local TitleRich
    if Call.Title ~= "" then TitleRich = Library:RenderRich(Inner, Call.Title, { Size = 13, Bold = true, LayoutOrder = 1 }) end
    local BodyRich = Library:RenderRich(Inner, Call.Body, { Size = 12, LayoutOrder = 2 })
    function Call:SetText(T) Call.Body = tostring(T); Call.Text = Call.Title .. " " .. Call.Body; BodyRich:SetText(T) end
    function Call:SetTitle(T) Call.Title = tostring(T); if TitleRich then TitleRich:SetText(T) end end
    Finalize(Group, Call, Holder)
    return Call
end

--// Button \\--
function Funcs:AddButton(...)
    if self.Destroyed then return end
    local function GetInfo(...)
        local First, Second = ...
        local I = {}
        if typeof(First) == "table" or typeof(Second) == "table" then
            local P = typeof(First) == "table" and First or Second
            I.Text, I.Func = P.Text or "", P.Func or P.Callback or function() end
            I.DoubleClick, I.Icon, I.Risky, I.Primary = P.DoubleClick, P.Icon, P.Risky, P.Primary
            I.Tooltip, I.Disabled = P.Tooltip, P.Disabled or false
            I.Visible = P.Visible ~= false
            I.Idx = typeof(Second) == "table" and First or nil
        else
            I.Text, I.Func, I.Disabled, I.Visible = First or "", Second or function() end, false, true
            I.Idx = select(3, ...)
        end
        return I
    end

    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), Parent = Group.Container })
    List(Holder, 8, Enum.FillDirection.Horizontal)

    local function Build(Info, Type)
        local B = {
            Type = Type, Text = Info.Text, Func = Info.Func, DoubleClick = Info.DoubleClick, Risky = Info.Risky,
            Primary = Info.Primary, Disabled = Info.Disabled, Visible = Info.Visible, Locked = false, Addons = {},
            Connections = {}, Icon = Info.Icon,
        }
        local BaseKey = B.Primary and "Accent" or "Control"
        B.Base = New("TextButton", { BackgroundColor3 = BaseKey, BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), Visible = B.Visible, Parent = Holder })
        Flex(B.Base)
        Corner(B.Base, 7)
        B.Stroke = Stroke(B.Base, "Outline", 1, 0.55)
        New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78)), Parent = B.Base })

        local Icon = Library:GetCustomIcon(B.Icon)
        local TextColor = B.Primary and "AccentText" or (B.Risky and "Red" or "Text")
        B.Label = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Library:ToRichText(B.Text), TextColor3 = TextColor, Parent = B.Base })
        B.LabelObj = B.Label
        if Icon then
            B.Label.Position = UDim2.fromOffset(10, 0)
            B.Label.Size = UDim2.new(1, -10, 1, 0)
            local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(14, 14), ImageColor3 = TextColor, Parent = B.Base })
            Library:ApplyIcon(Img, Icon)
        end

        local function Colors(Hover)
            local Normal, Hovered
            if B.Primary then
                Normal, Hovered = Library.Scheme.Accent, Lighten(Library.Scheme.Accent, 0.07)
            else
                Normal, Hovered = Library.Scheme.Control, Library.Scheme.ControlHover
            end
            return Hover and Hovered or Normal
        end

        function B:UpdateColors()
            B.Label.TextTransparency = B.Disabled and 0.55 or 0
            B.Stroke.Transparency = B.Disabled and 0.8 or 0.55
            B.Base.BackgroundTransparency = B.Disabled and 0.5 or 0
            B.Base.Active = not B.Disabled
        end

        table.insert(B.Connections, B.Base.MouseEnter:Connect(function()
            if not B.Disabled then Tween(B.Base, { BackgroundColor3 = Colors(true) }) end
        end))
        table.insert(B.Connections, B.Base.MouseLeave:Connect(function()
            if not B.Disabled then Tween(B.Base, { BackgroundColor3 = Colors(false) }) end
        end))
        table.insert(B.Connections, B.Base.MouseButton1Down:Connect(function()
            if not B.Disabled then Tween(B.Base, { BackgroundColor3 = Lighten(Colors(false), B.Primary and -0.06 or 0.08) }) end
        end))
        table.insert(B.Connections, B.Base.MouseButton1Click:Connect(function()
            if B.Disabled or B.Locked then return end
            if B.DoubleClick then
                B.Locked = true
                B.Label.Text = "Click again to confirm"
                local Clicked = false
                local C = B.Base.MouseButton1Click:Once(function() Clicked = true end)
                task.wait(1.4)
                if C.Connected then C:Disconnect() end
                B.Label.Text = Library:ToRichText(B.Text)
                B.Locked = false
                if Clicked then Library:SafeCallback(B.Func) end
                return
            end
            Library:SafeCallback(B.Func)
        end))

        function B:SetDisabled(D) B.Disabled = D; B:UpdateColors(); Library:UpdateAddons(B) end
        function B:SetText(T) B.Text = T; B.Label.Text = Library:ToRichText(T) end
        function B:SetVisible(V)
            B.Visible = V
            B.Base.Visible = V
            local Other = Type == "Button" and B.SubButton or B.Main
            Holder.Visible = V or (Other ~= nil and Other.Visible)
        end

        B.AddonHolder = Holder
        B.TextLabel = B.Base
        B:UpdateColors()
        if typeof(Info.Tooltip) == "string" then Library:AddTooltip(Info.Tooltip, B.Base) end
        setmetatable(B, BaseAddons)
        return B
    end

    local Info = GetInfo(...)
    local Button = Build(Info, "Button")
    Holder.Visible = Button.Visible

    function Button:AddButton(...)
        local SubInfo = GetInfo(...)
        local Sub = Build(SubInfo, "SubButton")
        Sub.Main = Button
        Button.SubButton = Sub
        Holder.Visible = true
        if SubInfo.Idx then Buttons[SubInfo.Idx] = Sub else table.insert(Buttons, Sub) end
        function Sub:Destroy()
            for _, C in Sub.Connections do C:Disconnect() end
            Sub.Base:Destroy()
            Button.SubButton = nil
        end
        return Sub
    end

    Finalize(Group, Button, Holder, Buttons, Info.Idx, { Tooltip = nil })
    -- Finalize overrides Destroy/SetVisible; restore button-aware versions
    function Button:SetVisible(V)
        Button.Visible = V
        Button.Base.Visible = V
        Holder.Visible = V or (Button.SubButton ~= nil and Button.SubButton.Visible)
        if Library.Searching then Library:UpdateSearch(Library.SearchText) end
    end
    local BaseDestroy = Button.Destroy
    function Button:Destroy()
        if Button.SubButton then Button.SubButton:Destroy() end
        for _, C in Button.Connections do C:Disconnect() end
        BaseDestroy(Button)
    end
    return Button
end

--// Toggle / Checkbox \\--
function Funcs:AddToggle(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.Toggle)
    local Group = self
    local Style = (Library.ForceCheckbox or Info.Checkbox) and "Checkbox" or "Switch"

    local Toggle = {
        Type = "Toggle", Text = Info.Text, Value = Info.Default == true, Callback = Info.Callback, Changed = Info.Changed,
        Risky = Info.Risky, Disabled = Info.Disabled, Visible = Info.Visible, Addons = {}, AnyKeyPickerPicking = false, Connections = {},
    }

    local Row = MakeRow(Group, 22, true)
    Row.Visible = Toggle.Visible
    local Click = Row
    local Label = New("TextLabel", { Size = UDim2.new(0, 0, 1, 0), Text = Library:ToRichText(Toggle.Text), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Toggle.Risky and "Red" or "Text", LayoutOrder = 1, Parent = Row })
    Toggle.LabelObj = Label
    Flex(Label)
    Toggle.AddonHolder = MakeAddonHolder(Row)
    Toggle.TextLabel = Label

    local Switch, Knob, Check
    if Style == "Switch" then
        Switch = New("Frame", { BackgroundColor3 = "Track", Size = UDim2.fromOffset(34, 20), LayoutOrder = 3, Parent = Row })
        Corner(Switch, 99)
        Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.fromOffset(16, 16), Parent = Switch })
        Corner(Knob, 99)
        Stroke(Knob, Color3.new(0, 0, 0), 1, 0.88)
    else
        Switch = New("Frame", { BackgroundColor3 = "Control", Size = UDim2.fromOffset(18, 18), LayoutOrder = 3, Parent = Row })
        Corner(Switch, 5)
        Stroke(Switch, "Outline", 1, 0.2)
        Check = Glyph(Switch, "check", "✓", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(12, 12), Color = "AccentText" })
        GlyphTransparency(Check, 1)
    end

    function Toggle:Display(Instant)
        if Library.Unloaded then return end
        local On = Toggle.Value
        local Dim = Toggle.Disabled and 0.55 or 0
        if Style == "Switch" then
            Anim(Switch, { BackgroundColor3 = On and Library.Scheme.Accent or Library.Scheme.Track, BackgroundTransparency = Dim }, Instant)
            Bind(Switch, "BackgroundColor3", On and "Accent" or "Track")
            Anim(Knob, { Position = On and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0), BackgroundTransparency = Dim }, Instant)
        else
            Anim(Switch, { BackgroundColor3 = On and Library.Scheme.Accent or Library.Scheme.Control, BackgroundTransparency = Dim }, Instant)
            Bind(Switch, "BackgroundColor3", On and "Accent" or "Control")
            GlyphTransparency(Check, On and Dim or 1)
        end
        Anim(Label, { TextTransparency = Toggle.Disabled and 0.55 or 0 }, Instant)
    end

    function Toggle:OnChanged(F) Toggle.Changed = F end
    function Toggle:RunChanged()
        if Toggle.Disabled then return end
        Library:SafeCallback(Toggle.Callback, Toggle.Value)
        Library:SafeCallback(Toggle.Changed, Toggle.Value)
    end
    function Toggle:SetValue(V)
        V = V == true
        if V == Toggle.Value then return end
        Toggle.Value = V
        Toggle:Display()
        for _, A in Toggle.Addons do
            if A.Type == "KeyPicker" and A.SyncToggleState then
                A.Toggled = V
                A:Update()
            end
        end
        if not Toggle.Disabled then Library:UpdateDependencyBoxes() end
        if not Toggle.AnyKeyPickerPicking then Toggle:RunChanged() end
    end
    function Toggle:SetDisabled(D)
        Toggle.Disabled = D
        Click.Active = not D
        Toggle:Display()
        Library:UpdateAddons(Toggle)
        Library:UpdateDependencyBoxes()
    end
    function Toggle:SetText(T) Toggle.Text = T; Label.Text = Library:ToRichText(T) end

    table.insert(Toggle.Connections, Click.MouseButton1Click:Connect(function()
        if not Toggle.Disabled then Toggle:SetValue(not Toggle.Value) end
    end))

    Toggle:Display(true)
    Toggle.Default = Toggle.Value
    setmetatable(Toggle, BaseAddons)
    Finalize(Group, Toggle, Row, Toggles, Idx, Info)
    return Toggle
end

function Funcs:AddCheckbox(Idx, Info)
    Info = Info or {}
    Info.Checkbox = true
    return Funcs.AddToggle(self, Idx, Info)
end

--// Input \\--
function Funcs:AddInput(Idx, Info)
    if self.Destroyed then return end
    if typeof(Info) == "table" and typeof(Info.VerifyValue) == "function" then Info.Finished = true end
    Info = Library:Validate(Info, Templates.Input)
    local Group = self

    local Input = {
        Type = "Input", Text = Info.Text, Value = Info.Default, Finished = Info.Finished, Numeric = Info.Numeric,
        AllowEmpty = Info.AllowEmpty, EmptyReset = Info.EmptyReset, Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible, Connections = {},
    }

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Input.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = Library:ToRichText(Input.Text), TextXAlignment = Enum.TextXAlignment.Left, Parent = Holder })
    Input.LabelObj = Label
    local Box = New("TextBox", {
        BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28), Text = Input.Value,
        PlaceholderText = Info.Placeholder, ClearTextOnFocus = Info.ClearTextOnFocus, TextXAlignment = Enum.TextXAlignment.Left,
        TextEditable = not Input.Disabled, ClipsDescendants = true, Parent = Holder,
    })
    Corner(Box, 7)
    Pad(Box, 0, 10, 0, 10)
    local BoxStroke = Stroke(Box, "Outline", 1, 0.4)

    function Input:UpdateColors()
        Label.TextTransparency = Input.Disabled and 0.55 or 0
        Box.TextTransparency = Input.Disabled and 0.55 or 0
    end
    function Input:OnChanged(F) Input.Changed = F end
    function Input:RunChanged()
        if Input.Disabled then return end
        Library:SafeCallback(Input.Callback, Input.Value)
        Library:SafeCallback(Input.Changed, Input.Value)
    end
    function Input:SetValue(Text)
        Text = tostring(Text)
        if not Input.AllowEmpty and Trim(Text) == "" then Text = Input.EmptyReset end
        if Info.MaxLength and #Text > Info.MaxLength then Text = Text:sub(1, Info.MaxLength) end
        if Input.Numeric and #Text > 0 and not tonumber(Text) then Text = tostring(Input.Value) end
        if typeof(Info.VerifyValue) == "function" and Text ~= Input.EmptyReset and Info.VerifyValue(Text) ~= true then
            Text = Input.EmptyReset
        end
        Input.Value = Text
        Box.Text = Text
        Input:RunChanged()
    end
    function Input:SetDisabled(D)
        Input.Disabled = D
        Box.TextEditable = not D
        Input:UpdateColors()
    end
    function Input:SetText(T) Input.Text = T; Label.Text = Library:ToRichText(T) end

    if Input.Finished then
        table.insert(Input.Connections, Box.FocusLost:Connect(function(Enter)
            if Enter then Input:SetValue(Box.Text) else Box.Text = Input.Value end
        end))
    else
        table.insert(Input.Connections, Box:GetPropertyChangedSignal("Text"):Connect(function()
            if Input._Typing then return end
            if Box.Text ~= Input.Value then Input:SetValue(Box.Text) end
        end))
    end
    table.insert(Input.Connections, Box.Focused:Connect(function()
        if Input.Disabled then return end
        Bind(BoxStroke, "Color", "Accent")
        Tween(BoxStroke, { Color = Library.Scheme.Accent, Transparency = 0, Thickness = 1.5 })
    end))
    table.insert(Input.Connections, Box.FocusLost:Connect(function()
        Bind(BoxStroke, "Color", "Outline")
        Tween(BoxStroke, { Color = Library.Scheme.Outline, Transparency = 0.4, Thickness = 1 })
    end))

    --// typing animations: animated placeholder + Input:Type(text)
    local function UtfLen(Str) return utf8.len(Str) or #Str end
    local function UtfSub(Str, N)
        if N <= 0 then return "" end
        if N >= UtfLen(Str) then return Str end
        local Off = utf8.offset(Str, N + 1)
        return Off and Str:sub(1, Off - 1) or Str
    end

    local Phrases = Info.Placeholders
    if typeof(Phrases) ~= "table" or #Phrases == 0 then
        Phrases = (Info.AnimatePlaceholder and Info.Placeholder ~= "") and { Info.Placeholder } or nil
    end
    if Phrases then
        local Speed = Info.PlaceholderSpeed or 0.055
        local Static = Info.Placeholder ~= "" and Info.Placeholder or tostring(Phrases[1])
        local function CanAnimate()
            return not Input.Destroyed and not Library.Unloaded and Box.Parent ~= nil and Box.Text == "" and not Box:IsFocused() and Library.Toggled
        end
        task.spawn(function()
            local I = 1
            while not Input.Destroyed and not Library.Unloaded do
                local Phrase = tostring(Phrases[I])
                local N = UtfLen(Phrase)
                for C = 1, N do
                    if not CanAnimate() then break end
                    Box.PlaceholderText = UtfSub(Phrase, C) .. "|"
                    task.wait(Speed)
                end
                if CanAnimate() then
                    for B = 1, 6 do
                        if not CanAnimate() then break end
                        Box.PlaceholderText = Phrase .. (B % 2 == 0 and "|" or "")
                        task.wait(0.25)
                    end
                    for C = N - 1, 0, -1 do
                        if not CanAnimate() then break end
                        Box.PlaceholderText = UtfSub(Phrase, C) .. "|"
                        task.wait(Speed * 0.5)
                    end
                end
                if not CanAnimate() then
                    Box.PlaceholderText = Static
                    repeat task.wait(0.25) until Input.Destroyed or Library.Unloaded or CanAnimate()
                end
                I = I % #Phrases + 1
            end
        end)
    end

    function Input:Type(Text, Speed)
        Text = tostring(Text)
        Speed = Speed or 0.04
        Input._TypeId = (Input._TypeId or 0) + 1
        local Id = Input._TypeId
        task.spawn(function()
            Input._Typing = true
            Box.Text = ""
            for C = 1, UtfLen(Text) do
                if Input.Destroyed or Input._TypeId ~= Id then return end
                Box.Text = UtfSub(Text, C)
                task.wait(Speed)
            end
            Input._Typing = false
            if not Input.Destroyed then Input:SetValue(Text) end
        end)
    end

    Input.Default = Input.Value
    Input:UpdateColors()
    Finalize(Group, Input, Holder, Options, Idx, Info)
    return Input
end

--// Slider \\--
function Funcs:AddSlider(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.Slider)
    local Group = self

    local Slider = {
        Type = "Slider", Text = Info.Text, Value = Info.Default, Min = Info.Min, Max = Info.Max, Rounding = Info.Rounding,
        Prefix = Info.Prefix, Suffix = Info.Suffix, Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible, Connections = {},
    }

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = Slider.Visible, Parent = Group.Container })
    List(Holder, 4)
    local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16), Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(0.6, 0, 1, 0), Text = Library:ToRichText(Slider.Text), TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
    Slider.LabelObj = Label
    local ValueBox = New("TextBox", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.4, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = "SubText", ClearTextOnFocus = false, Text = "", Parent = Top,
    })
    local KS = 28 -- knob is taller than the track so it visibly sticks out of it
    local Area = New("TextButton", { Size = UDim2.new(1, 0, 0, 40), ClipsDescendants = false, Parent = Holder })
    local Track = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 20), ClipsDescendants = false, Parent = Area })
    Corner(Track, 99)
    Stroke(Track, "Outline", 1, 0.6)
    local FillBar = New("Frame", { BackgroundColor3 = "SliderFill", Size = UDim2.fromScale(0.5, 1), Parent = Track })
    Corner(FillBar, 99)
    local Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(KS, KS), ZIndex = 3, Parent = Area })
    Corner(Knob, 99)
    Stroke(Knob, Color3.new(0, 0, 0), 1, 0.8)

    local function Format(V)
        local N = Slider.Rounding > 0 and string.format("%." .. Slider.Rounding .. "f", V) or tostring(V)
        return Slider.Prefix .. N .. Slider.Suffix
    end

    function Slider:Display()
        if Library.Unloaded then return end
        local X = (Slider.Value - Slider.Min) / math.max(Slider.Max - Slider.Min, 1e-9)
        FillBar.Size = UDim2.new(X, (0.5 - X) * KS, 1, 0)
        Knob.Position = UDim2.new(X, (0.5 - X) * KS, 0.5, 0)
        ValueBox.Text = Info.FormatDisplayValue and tostring(Info.FormatDisplayValue(Slider, Slider.Value)) or Format(Slider.Value)
        local D = Slider.Disabled and 0.55 or 0
        Label.TextTransparency, ValueBox.TextTransparency = D, D
        FillBar.BackgroundColor3 = Slider.Disabled and Library.Scheme.Outline or Library.Scheme.SliderFill
        Bind(FillBar, "BackgroundColor3", Slider.Disabled and "Outline" or "SliderFill")
    end
    function Slider:OnChanged(F) Slider.Changed = F end
    function Slider:RunChanged()
        if Slider.Disabled then return end
        Library:SafeCallback(Slider.Callback, Slider.Value)
        Library:SafeCallback(Slider.Changed, Slider.Value)
    end
    function Slider:SetValue(V)
        V = tonumber(V)
        if not V then return end
        V = Round(math.clamp(V, Slider.Min, Slider.Max), Slider.Rounding)
        if V == Slider.Value then Slider:Display() return end
        Slider.Value = V
        Slider:Display()
        Slider:RunChanged()
    end
    function Slider:SetMax(V) Slider.Max = V; Slider:SetValue(math.clamp(Slider.Value, Slider.Min, V)); Slider:Display() end
    function Slider:SetMin(V) Slider.Min = V; Slider:SetValue(math.clamp(Slider.Value, V, Slider.Max)); Slider:Display() end
    function Slider:SetDisabled(D) Slider.Disabled = D; Area.Active = not D; ValueBox.TextEditable = not D; Slider:Display() end
    function Slider:SetText(T) Slider.Text = T; Label.Text = Library:ToRichText(T) end
    function Slider:SetPrefix(P) Slider.Prefix = P; Slider:Display() end
    function Slider:SetSuffix(S) Slider.Suffix = S; Slider:Display() end

    table.insert(Slider.Connections, ValueBox.FocusLost:Connect(function()
        local N = tonumber((ValueBox.Text:gsub("[^%d%.%-]", "")))
        if N then Slider:SetValue(N) else Slider:Display() end
    end))
    table.insert(Slider.Connections, ValueBox.Focused:Connect(function() ValueBox.Text = tostring(Slider.Value) end))

    table.insert(Slider.Connections, Area.InputBegan:Connect(function(Input)
        if Slider.Disabled or not IsPress(Input) then return end
        SetSidesScrolling(false)
        local IsTouch = Input.UserInputType == Enum.UserInputType.Touch
        local Moved = false
        while Input.UserInputState ~= Enum.UserInputState.End and not Slider.Destroyed do
            local MX = IsTouch and Input.Position.X or UserInputService:GetMouseLocation().X
            local K = math.max(Knob.AbsoluteSize.X, 1) -- knob width in real pixels (includes every UIScale)
            local X = (MX - Track.AbsolutePosition.X - K / 2) / math.max(Track.AbsoluteSize.X - K, 1)
            local V = Round(Slider.Min + (Slider.Max - Slider.Min) * math.clamp(X, 0, 1), Slider.Rounding)
            if V ~= Slider.Value then
                Slider.Value = V
                Slider:Display()
                Moved = true
                if not Info.Deferred then Slider:RunChanged() end
            end
            RunService.RenderStepped:Wait()
        end
        if Info.Deferred and Moved then Slider:RunChanged() end
        SetSidesScrolling(true)
    end))

    Slider.Default = Slider.Value
    Slider:Display()
    Finalize(Group, Slider, Holder, Options, Idx, Info)
    return Slider
end

--// Range slider (dual-thumb min/max) \\--
function Funcs:AddRangeSlider(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.RangeSlider)
    local Group = self

    local Def = Info.Default
    local Low, High = Info.Min, Info.Max
    if typeof(Def) == "table" then
        Low = tonumber(Def[1] or Def.Min or Def.Low) or Info.Min
        High = tonumber(Def[2] or Def.Max or Def.High) or Info.Max
    end
    Low = Round(math.clamp(Low, Info.Min, Info.Max), Info.Rounding)
    High = Round(math.clamp(math.max(Low, High), Info.Min, Info.Max), Info.Rounding)

    local RS = {
        Type = "RangeSlider", Text = Info.Text, Min = Info.Min, Max = Info.Max, Rounding = Info.Rounding,
        Prefix = Info.Prefix, Suffix = Info.Suffix, Callback = Info.Callback, Changed = Info.Changed,
        Disabled = Info.Disabled, Visible = Info.Visible, Connections = {},
        Value = { Low, High }, ValueMin = Low, ValueMax = High,
    }

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = RS.Visible, Parent = Group.Container })
    List(Holder, 4)
    local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 16), Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(0.55, 0, 1, 0), Text = Library:ToRichText(RS.Text), TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
    RS.LabelObj = Label
    local ValueLbl = New("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.45, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = "SubText", Text = "", Parent = Top,
    })
    local KS = 26
    local Area = New("TextButton", { Size = UDim2.new(1, 0, 0, 40), ClipsDescendants = false, Parent = Holder })
    local Track = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 20), Parent = Area })
    Corner(Track, 99)
    Stroke(Track, "Outline", 1, 0.6)
    local FillBar = New("Frame", { BackgroundColor3 = "SliderFill", Size = UDim2.fromScale(0.5, 1), Parent = Track })
    Corner(FillBar, 99)

    local function MakeKnob()
        local Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(KS, KS), ZIndex = 3, Parent = Area })
        Corner(Knob, 99)
        Stroke(Knob, Color3.new(0, 0, 0), 1, 0.8)
        return Knob
    end
    local KnobL = MakeKnob()
    local KnobR = MakeKnob()

    local function Format(V)
        local N = RS.Rounding > 0 and string.format("%." .. RS.Rounding .. "f", V) or tostring(V)
        return RS.Prefix .. N .. RS.Suffix
    end
    local function Span() return math.max(RS.Max - RS.Min, 1e-9) end
    local function XOf(V) return (V - RS.Min) / Span() end

    function RS:Display()
        if Library.Unloaded then return end
        local XL, XR = XOf(RS.ValueMin), XOf(RS.ValueMax)
        FillBar.Position = UDim2.new(XL, (0.5 - XL) * KS, 0, 0)
        FillBar.Size = UDim2.new(XR - XL, (XL - XR) * KS, 1, 0)
        local function Place(Knob, X)
            Knob.Position = UDim2.new(X, (0.5 - X) * KS, 0.5, 0)
        end
        Place(KnobL, XL)
        Place(KnobR, XR)
        ValueLbl.Text = Format(RS.ValueMin) .. "  –  " .. Format(RS.ValueMax)
        local D = RS.Disabled and 0.55 or 0
        Label.TextTransparency, ValueLbl.TextTransparency = D, D
        FillBar.BackgroundColor3 = RS.Disabled and Library.Scheme.Outline or Library.Scheme.SliderFill
        Bind(FillBar, "BackgroundColor3", RS.Disabled and "Outline" or "SliderFill")
    end
    function RS:OnChanged(F) RS.Changed = F end
    function RS:RunChanged()
        if RS.Disabled then return end
        Library:SafeCallback(RS.Callback, RS.ValueMin, RS.ValueMax)
        Library:SafeCallback(RS.Changed, RS.ValueMin, RS.ValueMax)
    end
    function RS:SetValue(A, B)
        if typeof(A) == "table" then B = A[2] or A.Max or A.High; A = A[1] or A.Min or A.Low end
        A, B = tonumber(A), tonumber(B)
        if not A or not B then return end
        A = Round(math.clamp(A, RS.Min, RS.Max), RS.Rounding)
        B = Round(math.clamp(B, RS.Min, RS.Max), RS.Rounding)
        if A > B then A, B = B, A end
        if A == RS.ValueMin and B == RS.ValueMax then RS:Display() return end
        RS.ValueMin, RS.ValueMax = A, B
        RS.Value = { A, B }
        RS:Display()
        RS:RunChanged()
    end
    function RS:SetMin(V) RS.Min = V; RS:SetValue(math.max(RS.ValueMin, V), math.max(RS.ValueMax, V)) end
    function RS:SetMax(V) RS.Max = V; RS:SetValue(math.min(RS.ValueMin, V), math.min(RS.ValueMax, V)) end
    function RS:SetDisabled(D) RS.Disabled = D; Area.Active = not D; RS:Display() end
    function RS:SetText(T) RS.Text = T; Label.Text = Library:ToRichText(T) end

    local ActiveKnob = nil
    table.insert(RS.Connections, Area.InputBegan:Connect(function(Input)
        if RS.Disabled or not IsPress(Input) then return end
        SetSidesScrolling(false)
        local IsTouch = Input.UserInputType == Enum.UserInputType.Touch
        local MX = IsTouch and Input.Position.X or UserInputService:GetMouseLocation().X
        local K = math.max(KnobL.AbsoluteSize.X, 1)
        local Rel = (MX - Track.AbsolutePosition.X - K / 2) / math.max(Track.AbsoluteSize.X - K, 1)
        local At = RS.Min + Span() * math.clamp(Rel, 0, 1)
        ActiveKnob = math.abs(At - RS.ValueMin) <= math.abs(At - RS.ValueMax) and "L" or "R"
        local Moved = false
        while Input.UserInputState ~= Enum.UserInputState.End and not RS.Destroyed do
            MX = IsTouch and Input.Position.X or UserInputService:GetMouseLocation().X
            Rel = (MX - Track.AbsolutePosition.X - K / 2) / math.max(Track.AbsoluteSize.X - K, 1)
            local V = Round(RS.Min + Span() * math.clamp(Rel, 0, 1), RS.Rounding)
            if ActiveKnob == "L" then
                V = math.min(V, RS.ValueMax)
                if V ~= RS.ValueMin then RS.ValueMin = V; RS.Value = { RS.ValueMin, RS.ValueMax }; RS:Display(); Moved = true; if not Info.Deferred then RS:RunChanged() end end
            else
                V = math.max(V, RS.ValueMin)
                if V ~= RS.ValueMax then RS.ValueMax = V; RS.Value = { RS.ValueMin, RS.ValueMax }; RS:Display(); Moved = true; if not Info.Deferred then RS:RunChanged() end end
            end
            RunService.RenderStepped:Wait()
        end
        if Info.Deferred and Moved then RS:RunChanged() end
        ActiveKnob = nil
        SetSidesScrolling(true)
    end))

    RS.Default = { RS.ValueMin, RS.ValueMax }
    RS:Display()
    Finalize(Group, RS, Holder, Options, Idx, Info)
    return RS
end

--// List (always-visible selectable list; dropdown without a popup) \\--
function Funcs:AddList(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.List)
    local Group = self

    local LS = {
        Type = "List", Text = typeof(Info.Text) == "string" and Info.Text or nil, Values = Info.Values,
        DisabledValues = Info.DisabledValues, Multi = Info.Multi, AllowNull = Info.AllowNull ~= false,
        Height = Info.Height, MaxVisibleItems = Info.MaxVisibleItems,
        Callback = Info.Callback, Changed = Info.Changed, Disabled = Info.Disabled, Visible = Info.Visible,
        Value = Info.Multi and {} or nil, Connections = {},
    }

    local function HasIcons()
        for _, Raw in LS.Values do
            if typeof(Raw) == "table" and (Raw.Icon ~= nil or Raw[3] ~= nil) then return true end
        end
        return false
    end
    LS.Extended = Info.Extended
    if LS.Extended == nil then LS.Extended = HasIcons() end

    local function GetItems()
        local Out = {}
        local Arr = IsArray(LS.Values)
        for K, Raw in LS.Values do
            local Item
            if typeof(Raw) == "table" and (Raw.Name ~= nil or Raw[1] ~= nil) then
                local Name = Raw.Name ~= nil and Raw.Name or Raw[1]
                local Val = Raw.Value ~= nil and Raw.Value or Raw[2]
                if Val == nil then Val = Name end
                Item = { Value = Val, Display = tostring(Name), Icon = Raw.Icon ~= nil and Raw.Icon or Raw[3] }
            else
                Item = { Value = Arr and Raw or K, Display = tostring(Raw) }
            end
            Item.Disabled = table.find(LS.DisabledValues, Item.Value) ~= nil
            table.insert(Out, Item)
        end
        if not Arr then table.sort(Out, function(A, B) return A.Display < B.Display end) end
        return Out
    end
    local function IsSelected(Val)
        if LS.Multi then return LS.Value[Val] == true end
        return LS.Value == Val
    end

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = LS.Visible, Parent = Group.Container })
    List(Holder, 5)
    local TitleRow = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18), Visible = LS.Text ~= nil or LS.Extended, Parent = Holder })
    local Label = New("TextLabel", { Size = UDim2.new(1, LS.Extended and -28 or 0, 1, 0), Text = Library:ToRichText(LS.Text or ""), TextXAlignment = Enum.TextXAlignment.Left, Visible = LS.Text ~= nil, Parent = TitleRow })
    LS.LabelObj = Label
    local ExpandBtn = New("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(22, 22),
        Visible = LS.Extended, Parent = TitleRow,
    })
    Glyph(ExpandBtn, "maximize-2", "⤢", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 13) })

    local Frame = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, LS.Height), ClipsDescendants = true, Parent = Holder })
    Corner(Frame, 8)
    Stroke(Frame, "Outline", 1, 0.55)
    local Scroll = New("ScrollingFrame", {
        BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3, Parent = Frame,
    })
    Pad(Scroll, 4, 4, 4, 4)
    List(Scroll, 2)
    local RowRefs = {}

    function LS:Display()
        if Library.Unloaded then return end
        for _, R in RowRefs do
            local Sel = IsSelected(R.Value)
            R.Btn.BackgroundTransparency = Sel and 0 or 1
            R.Btn.BackgroundColor3 = Sel and Library.Scheme.Accent or Library.Scheme.ControlHover
            Bind(R.Btn, "BackgroundColor3", Sel and "Accent" or "ControlHover")
            R.Lbl.TextColor3 = Sel and Library.Scheme.AccentText or Library.Scheme.Text
            Bind(R.Lbl, "TextColor3", Sel and "AccentText" or "Text")
            if R.IconImg then
                R.IconImg.ImageColor3 = Sel and Library.Scheme.AccentText or Library.Scheme.Text
            end
        end
        local D = LS.Disabled and 0.55 or 0
        Label.TextTransparency = D
        Frame.BackgroundTransparency = LS.Disabled and 0.4 or 0
    end

    local function Rebuild()
        for _, C in Scroll:GetChildren() do
            if C:IsA("GuiObject") then C:Destroy() end
        end
        RowRefs = {}
        for _, It in GetItems() do
            local Row = New("TextButton", {
                BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28),
                AutoButtonColor = false, Parent = Scroll,
            })
            Corner(Row, 6)
            local IconWrap
            if It.Icon ~= nil then
                IconWrap = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 4), Size = UDim2.fromOffset(20, 20), Parent = Row })
            end
            local Lbl = New("TextLabel", {
                Position = UDim2.fromOffset(It.Icon ~= nil and 30 or 10, 0), Size = UDim2.new(1, It.Icon ~= nil and -36 or -16, 1, 0),
                Text = It.Display, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row,
            })
            local IconImg
            if IconWrap then
                local Data = Library:GetCustomIcon(It.Icon)
                if Data then
                    IconImg = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = "Text", Parent = IconWrap })
                    Library:ApplyIcon(IconImg, Data)
                end
            end
            local Ref = { Btn = Row, Lbl = Lbl, Value = It.Value, IconImg = IconImg }
            table.insert(RowRefs, Ref)
            if not It.Disabled then
                Row.MouseButton1Click:Connect(function()
                    if LS.Disabled then return end
                    if LS.Multi then
                        LS.Value[It.Value] = not LS.Value[It.Value] or nil
                        if LS.Value[It.Value] == nil then LS.Value[It.Value] = nil end
                        if not LS.Value[It.Value] then LS.Value[It.Value] = nil else LS.Value[It.Value] = true end
                        -- toggle properly
                        if IsSelected(It.Value) then
                            LS.Value[It.Value] = nil
                        else
                            LS.Value[It.Value] = true
                        end
                    else
                        if LS.Value == It.Value and LS.AllowNull then
                            LS.Value = nil
                        else
                            LS.Value = It.Value
                        end
                    end
                    LS:Display()
                    Library:SafeCallback(LS.Callback, LS.Value)
                    Library:SafeCallback(LS.Changed, LS.Value)
                end)
            else
                Lbl.TextTransparency = 0.5
            end
        end
        LS:Display()
    end

    -- Fix multi toggle logic (cleaner)
    for _, Conn in LS.Connections do end -- placeholder; rebuild wires clicks

    function LS:SetValues(V)
        LS.Values = V or {}
        if LS.Multi then
            local Keep = {}
            for Val in LS.Value do
                local Found = false
                for _, It in GetItems() do if It.Value == Val then Found = true break end end
                if Found then Keep[Val] = true end
            end
            LS.Value = Keep
        else
            local Found = false
            for _, It in GetItems() do if It.Value == LS.Value then Found = true break end end
            if not Found then LS.Value = nil end
        end
        Rebuild()
    end
    function LS:SetValue(V)
        if LS.Multi then
            LS.Value = {}
            if typeof(V) == "table" then
                if IsArray(V) then for _, X in V do LS.Value[X] = true end
                else for X, On in V do if On then LS.Value[X] = true end end end
            end
        else
            LS.Value = V
        end
        LS:Display()
        Library:SafeCallback(LS.Callback, LS.Value)
        Library:SafeCallback(LS.Changed, LS.Value)
    end
    function LS:GetActiveValues()
        if LS.Multi then
            local T = {}
            for V in LS.Value do table.insert(T, V) end
            return T
        end
        return LS.Value ~= nil and { LS.Value } or {}
    end
    function LS:SetDisabled(D) LS.Disabled = D; LS:Display() end
    function LS:SetText(T) LS.Text = T; Label.Text = Library:ToRichText(T or ""); Label.Visible = T ~= nil and T ~= "" end
    function LS:OnChanged(F) LS.Changed = F end

    -- cleaner row click wiring inside Rebuild
    local function RebuildClean()
        for _, C in Scroll:GetChildren() do
            if C:IsA("GuiObject") then C:Destroy() end
        end
        RowRefs = {}
        for _, It in GetItems() do
            local Row = New("TextButton", {
                BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28),
                AutoButtonColor = false, Parent = Scroll,
            })
            Corner(Row, 6)
            local hasIcon = It.Icon ~= nil
            local IconWrap = hasIcon and New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 4), Size = UDim2.fromOffset(20, 20), Parent = Row }) or nil
            local Lbl = New("TextLabel", {
                Position = UDim2.fromOffset(hasIcon and 30 or 10, 0), Size = UDim2.new(1, hasIcon and -36 or -16, 1, 0),
                Text = It.Display, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row,
            })
            local IconImg
            if IconWrap then
                local Data = Library:GetCustomIcon(It.Icon)
                if Data then
                    IconImg = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = "Text", Parent = IconWrap })
                    Library:ApplyIcon(IconImg, Data)
                end
            end
            table.insert(RowRefs, { Btn = Row, Lbl = Lbl, Value = It.Value, IconImg = IconImg })
            if It.Disabled then
                Lbl.TextTransparency = 0.5
            else
                Row.MouseButton1Click:Connect(function()
                    if LS.Disabled then return end
                    if LS.Multi then
                        if LS.Value[It.Value] then LS.Value[It.Value] = nil else LS.Value[It.Value] = true end
                    else
                        if LS.Value == It.Value and LS.AllowNull then LS.Value = nil else LS.Value = It.Value end
                    end
                    LS:Display()
                    Library:SafeCallback(LS.Callback, LS.Value)
                    Library:SafeCallback(LS.Changed, LS.Value)
                end)
            end
        end
        local ItemH = 28 + 2
        local Count = math.min(#GetItems(), LS.MaxVisibleItems or 6)
        if Info.Height then
            Frame.Size = UDim2.new(1, 0, 0, Info.Height)
        else
            Frame.Size = UDim2.new(1, 0, 0, math.max(Count * ItemH + 8, 40))
        end
        LS:Display()
    end

    LS.SetValues = function(_, V)
        LS.Values = V or {}
        RebuildClean()
    end

    if Info.Default ~= nil then
        if LS.Multi then
            LS.Value = {}
            local D = Info.Default
            if typeof(D) == "table" then
                if IsArray(D) then for _, X in D do LS.Value[X] = true end
                else for X, On in D do if On then LS.Value[X] = true end end end
            end
        else
            LS.Value = Info.Default
        end
    elseif not LS.Multi and not LS.AllowNull then
        local Items = GetItems()
        if Items[1] then LS.Value = Items[1].Value end
    end

    local Modal
    function LS:CloseModal()
        if not Modal then return end
        local M = Modal
        Modal = nil
        if Library.CurrentModal == M then Library.CurrentModal = nil end
        Tween(M.Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
        Tween(M.Scale, { Scale = 0.95 }, Library.TweenInfo)
        task.delay(0.16, function() if M.Dim then M.Dim:Destroy() end end)
    end

    function LS:OpenModal()
        if LS.Disabled or Modal then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if Library.CurrentModal and Library.CurrentModal.Close then Library.CurrentModal:Close() end

        local Win = Library.Window
        local Host = Win and Win.MainFrame or Overlay
        local Real = Host.AbsoluteSize / (Host == Overlay and 1 or Library.DPIScale)
        local PW = math.clamp(Real.X - 70, 320, 660)
        local PH = math.clamp(Real.Y - 70, 280, 480)

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 80, Parent = Host })
        if Win then Corner(Dim, Win.Info.CornerRadius) end
        Tween(Dim, { BackgroundTransparency = 0.45 }, Library.SlowTween)

        local Panel = New("Frame", {
            BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(PW, PH), ZIndex = 81, Parent = Dim,
        })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        local PScale = New("UIScale", { Scale = 0.95, Parent = Panel })
        Tween(PScale, { Scale = 1 }, Library.SlowTween)

        New("TextLabel", {
            Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -110, 0, 22),
            Text = Library:ToRichText(LS.Text or "Select"), FontFace = "FontBold", TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Panel,
        })
        local Done = New("TextButton", {
            BackgroundColor3 = "Accent", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(64, 24),
            Text = LS.Multi and "Done" or "Close", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Panel,
        })
        Corner(Done, 99)

        local Search = New("TextBox", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0, PlaceholderText = "Search",
            Position = UDim2.fromOffset(16, 46), Size = UDim2.new(1, -32, 0, 30),
            TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = Panel,
        })
        Corner(Search, 99)
        Pad(Search, 0, 12, 0, 14)

        local Grid = New("ScrollingFrame", {
            Position = UDim2.fromOffset(0, 86), Size = UDim2.new(1, 0, 1, -86),
            CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Panel,
        })
        New("UIGridLayout", {
            CellSize = UDim2.fromOffset(100, 118), CellPadding = UDim2.fromOffset(10, 10),
            SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Grid,
        })
        Pad(Grid, 4, 12, 16, 12)

        Modal = { Dim = Dim, Scale = PScale, Close = function() LS:CloseModal() end }
        Library.CurrentModal = Modal

        local function Build()
            for _, C in Grid:GetChildren() do
                if C:IsA("TextButton") then C:Destroy() end
            end
            local Q = NormalizeSearch(Search.Text)
            local N = 0
            for _, It in GetItems() do
                if Q == "" or Fuzzy(It.Display, Q) then
                    N += 1
                    local Cell = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, LayoutOrder = N, Parent = Grid })
                    Corner(Cell, 12)
                    local CStroke = Stroke(Cell, "Accent", 2, IsSelected(It.Value) and 0 or 1)
                    local IconBox = New("Frame", {
                        BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0),
                        Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.fromOffset(66, 66), Parent = Cell,
                    })
                    local Data = It.Icon and Library:GetCustomIcon(It.Icon)
                    if Data then
                        local Img = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = "Text", Parent = IconBox })
                        Library:ApplyIcon(Img, Data)
                    else
                        New("TextLabel", {
                            Size = UDim2.fromScale(1, 1), Text = It.Display:sub(1, 1):upper(),
                            FontFace = "FontBold", TextSize = 30, TextColor3 = "SubText", Parent = IconBox,
                        })
                    end
                    New("TextLabel", {
                        Position = UDim2.fromOffset(6, 80), Size = UDim2.new(1, -12, 0, 32), Text = It.Display,
                        TextSize = 11, TextWrapped = true, TextTruncate = Enum.TextTruncate.AtEnd,
                        TextTransparency = It.Disabled and 0.6 or 0, Parent = Cell,
                    })
                    local Badge = New("Frame", {
                        BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(1, 0),
                        Position = UDim2.new(1, -6, 0, 6), Size = UDim2.fromOffset(18, 18),
                        Visible = IsSelected(It.Value), Parent = Cell,
                    })
                    Corner(Badge, 99)
                    New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = "✓", TextSize = 11, TextColor3 = "AccentText", FontFace = "FontBold", Parent = Badge })

                    if not It.Disabled then
                        Cell.MouseButton1Click:Connect(function()
                            if LS.Multi then
                                if LS.Value[It.Value] then LS.Value[It.Value] = nil else LS.Value[It.Value] = true end
                            else
                                if LS.Value == It.Value and LS.AllowNull then LS.Value = nil else LS.Value = It.Value end
                            end
                            LS:Display()
                            Library:SafeCallback(LS.Callback, LS.Value)
                            Library:SafeCallback(LS.Changed, LS.Value)
                            if LS.Multi then Build() else LS:CloseModal() end
                        end)
                    end
                end
            end
        end

        Search:GetPropertyChangedSignal("Text"):Connect(Build)
        Done.MouseButton1Click:Connect(function() LS:CloseModal() end)
        Dim.MouseButton1Click:Connect(function() LS:CloseModal() end)
        Build()
    end

    ExpandBtn.MouseButton1Click:Connect(function()
        if not LS.Disabled then LS:OpenModal() end
    end)

    RebuildClean()
    Finalize(Group, LS, Holder, Options, Idx, Info)
    local BaseDestroy = LS.Destroy
    function LS:Destroy()
        LS:CloseModal()
        if BaseDestroy then BaseDestroy(LS) end
    end
    return LS
end

--// Skeleton loader (placeholder shimmer rows) \\--
function Funcs:AddSkeleton(Idx, Info)
    if self.Destroyed then return end
    if typeof(Idx) == "table" then Info = Idx; Idx = nil end
    Info = Library:Validate(Info or {}, Templates.Skeleton)
    local Group = self

    local Sk = {
        Type = "Skeleton", Rows = Info.Rows, Height = Info.Height, Gap = Info.Gap,
        Visible = Info.Visible, Connections = {}, Bars = {},
    }

    local Holder = New("Frame", {
        BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0),
        Visible = Sk.Visible, Parent = Group.Container,
    })
    List(Holder, Sk.Gap)

    local function MakeBar(WidthScale)
        local Bar = New("Frame", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0.15,
            Size = UDim2.new(WidthScale or 1, 0, 0, Sk.Height), Parent = Holder,
        })
        Corner(Bar, 6)
        local Shine = New("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.85,
            Size = UDim2.new(0.35, 0, 1, 0), Position = UDim2.fromScale(-0.35, 0), Parent = Bar,
        })
        local GradObj = New("UIGradient", {
            Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(0.5, 0.4),
                NumberSequenceKeypoint.new(1, 1),
            }),
            Parent = Shine,
        })
        table.insert(Sk.Bars, { Bar = Bar, Shine = Shine })
        return Bar
    end

    local Widths = { 1, 0.72, 0.88, 0.55, 0.94 }
    for I = 1, Sk.Rows do
        MakeBar(Widths[((I - 1) % #Widths) + 1])
    end

    local AnimToken = 0
    function Sk:Play()
        AnimToken += 1
        local Token = AnimToken
        task.spawn(function()
            while Token == AnimToken and not Sk.Destroyed and Holder.Parent do
                for _, B in Sk.Bars do
                    if B.Shine and B.Shine.Parent then
                        B.Shine.Position = UDim2.fromScale(-0.4, 0)
                        local T = TweenService:Create(B.Shine, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Position = UDim2.fromScale(1.1, 0) })
                        T:Play()
                    end
                end
                task.wait(1.25)
            end
        end)
    end
    function Sk:Stop() AnimToken += 1 end
    function Sk:SetRows(N)
        N = math.max(1, tonumber(N) or 1)
        Sk.Rows = N
        for _, C in Holder:GetChildren() do
            if C:IsA("Frame") then C:Destroy() end
        end
        Sk.Bars = {}
        for I = 1, N do MakeBar(Widths[((I - 1) % #Widths) + 1]) end
        if Holder.Visible then Sk:Play() end
    end

    Sk:Play()
    Finalize(Group, Sk, Holder, nil, Idx, Info)
    local OldDestroy = Sk.Destroy
    function Sk:Destroy()
        Sk:Stop()
        if OldDestroy then OldDestroy(Sk) end
    end
    return Sk
end

--// Dropdown (macOS pop-up button + extended grid modal) \\--
-- Values accept: { "A", "B" }  |  { Key = "Display" }  |  { { Name, Value, Icon }, { Name = "", Value = "", Icon = id } }
-- Icon can be an asset id, a lucide name, a ViewportFrame, or a Model / BasePart (rendered in a viewport).
local function MakeIconInstance(Parent, Icon)
    if Icon == nil or Icon == "" then return nil end
    if typeof(Icon) == "Instance" then
        local Was = Icon.Archivable
        Icon.Archivable = true
        local Clone = Icon:Clone()
        Icon.Archivable = Was
        if not Clone then return nil end

        if Icon:IsA("ViewportFrame") then
            Clone.AnchorPoint, Clone.Position, Clone.Size = Vector2.new(0.5, 0.5), UDim2.fromScale(0.5, 0.5), UDim2.fromScale(1, 1)
            Clone.BackgroundTransparency = 1
            Clone.Parent = Parent
            local Cam = Clone:FindFirstChildOfClass("Camera")
            if Cam then Clone.CurrentCamera = Cam end
            return Clone
        elseif Icon:IsA("Model") or Icon:IsA("BasePart") then
            local VF = New("ViewportFrame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = Parent })
            Clone.Parent = VF
            local Cam = Instance.new("Camera")
            Cam.Parent = VF
            VF.CurrentCamera = Cam
            local Pivot = Clone:GetPivot().Position
            local Ext = Clone:IsA("Model") and select(2, Clone:GetBoundingBox()) or Clone.Size
            local M = math.max(Ext.X, Ext.Y, Ext.Z, 0.5)
            Cam.CFrame = CFrame.new(Pivot + Vector3.new(M * 0.7, M * 0.55, M * 1.7), Pivot)
            return VF
        elseif Icon:IsA("GuiObject") then
            Clone.Parent = Parent
            return Clone
        end
        Clone:Destroy()
        return nil
    end

    local Data = Library:GetCustomIcon(Icon)
    if not Data then return nil end
    local Img = New("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(1, 1),
        ScaleType = Enum.ScaleType.Fit, ImageColor3 = Data.Custom and Color3.new(1, 1, 1) or "Text", Parent = Parent,
    })
    Library:ApplyIcon(Img, Data)
    return Img
end
function Library:MakeIcon(Parent, Icon) return MakeIconInstance(Parent, Icon) end

function Funcs:AddDropdown(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.Dropdown)
    local Group = self

    if Info.SpecialType == "Player" then
        Info.Values = GetPlayers(Info.ExcludeLocalPlayer); Info.AllowNull = true
    elseif Info.SpecialType == "Team" then
        Info.Values = GetTeams(); Info.AllowNull = true
    end

    local DD = {
        Type = "Dropdown", Text = typeof(Info.Text) == "string" and Info.Text or nil, Values = Info.Values,
        DisabledValues = Info.DisabledValues, Multi = Info.Multi, AllowNull = Info.AllowNull,
        SpecialType = Info.SpecialType, ExcludeLocalPlayer = Info.ExcludeLocalPlayer,
        Callback = Info.Callback, Changed = Info.Changed, Disabled = Info.Disabled, Visible = Info.Visible,
        Value = Info.Multi and {} or nil, Connections = {},
    }

    --// item normalisation
    local function GetItems()
        local Out = {}
        local Arr = IsArray(DD.Values)
        for K, Raw in DD.Values do
            local Item
            if typeof(Raw) == "table" and (Raw.Name ~= nil or Raw[1] ~= nil) then
                local Name = Raw.Name ~= nil and Raw.Name or Raw[1]
                local Val = Raw.Value ~= nil and Raw.Value or Raw[2]
                if Val == nil then Val = Name end
                Item = { Value = Val, Display = tostring(Name), Icon = Raw.Icon ~= nil and Raw.Icon or Raw[3] }
            else
                local Disp = tostring(Info.FormatListValue and Info.FormatListValue(Raw) or Raw)
                Item = { Value = Arr and Raw or K, Display = Disp }
            end
            Item.Disabled = table.find(DD.DisabledValues, Item.Value) ~= nil
            table.insert(Out, Item)
        end
        if not Arr then table.sort(Out, function(A, B) return A.Display < B.Display end) end
        return Out
    end

    local function Lookup(Val)
        for _, It in GetItems() do
            if It.Value == Val then return It end
        end
        return nil
    end
    local function HasIcons()
        for _, It in GetItems() do
            if It.Icon ~= nil then return true end
        end
        return false
    end
    local function IsSelected(Val)
        if DD.Multi then return DD.Value[Val] == true end
        return DD.Value == Val
    end

    DD.Extended = Info.Extended
    if DD.Extended == nil then DD.Extended = HasIcons() end
    DD.ModalOnly = Info.ModalOnly == true

    --// ui
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = DD.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = Library:ToRichText(DD.Text or ""), TextXAlignment = Enum.TextXAlignment.Left, Visible = DD.Text ~= nil, Parent = Holder })
    DD.LabelObj = Label
    local Button = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28), Parent = Holder })
    Corner(Button, 7)
    Stroke(Button, "Outline", 1, 0.55)
    local Display = New("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -34, 1, 0), Text = "---", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Button })
    local Chevron = Glyph(Button, "chevrons-up-down", "⌃⌄", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14) })

    local ExpandBtn = New("TextButton", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -28, 0.5, 0), Size = UDim2.fromOffset(20, 20), Visible = DD.Extended, Parent = Button })
    local ExpandIcon = Glyph(ExpandBtn, "maximize-2", "⤢", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(13, 13) })

    local function LayoutButton()
        ExpandBtn.Visible = DD.Extended
        Display.Size = UDim2.new(1, DD.Extended and -56 or -34, 1, 0)
    end
    LayoutButton()

    local SearchBox, Popup, Scroll

    local function Entries()
        local Out = {}
        local Q = SearchBox and NormalizeSearch(SearchBox.Text) or ""
        for _, It in GetItems() do
            if Q == "" or Fuzzy(It.Display, Q) then table.insert(Out, It) end
        end
        return Out
    end

    local function DisplayOf(Val)
        local It = Lookup(Val)
        local D = It and It.Display or tostring(Val)
        if Info.FormatDisplayValue then D = tostring(Info.FormatDisplayValue(D)) end
        return D
    end

    function DD:GetActiveValues()
        local T = {}
        if DD.Multi then
            for V in DD.Value do table.insert(T, V) end
        elseif DD.Value ~= nil then
            table.insert(T, DD.Value)
        end
        return T
    end

    function DD:Display()
        if Library.Unloaded then return end
        local Str = ""
        if DD.Multi then
            local Parts = {}
            for V in DD.Value do table.insert(Parts, DisplayOf(V)) end
            table.sort(Parts)
            Str = table.concat(Parts, ", ")
        elseif DD.Value ~= nil then
            Str = DisplayOf(DD.Value)
        end
        Display.Text = Str == "" and "---" or Str
        local D = DD.Disabled and 0.55 or 0
        Display.TextTransparency = D
        Label.TextTransparency = D
        GlyphTransparency(Chevron, DD.Disabled and 0.7 or 0.2)
        GlyphTransparency(ExpandIcon, DD.Disabled and 0.7 or 0.35)
    end

    function DD:OnChanged(F) DD.Changed = F end
    function DD:RunChanged()
        if DD.Disabled then return end
        Library:SafeCallback(DD.Callback, DD.Value)
        Library:SafeCallback(DD.Changed, DD.Value)
    end

    -- shared selection logic; returns true when the menu should close
    local function Select(It)
        if It.Disabled then return false end
        local Sel = IsSelected(It.Value)
        if DD.Multi then
            if Sel and #DD:GetActiveValues() == 1 and not DD.AllowNull then return false end
            DD.Value[It.Value] = (not Sel) or nil
        else
            if Sel then
                if not DD.AllowNull then return true end
                DD.Value = nil
            else
                DD.Value = It.Value
            end
        end
        DD:Display()
        Library:UpdateDependencyBoxes()
        DD:RunChanged()
        return not DD.Multi
    end

    --// popup list
    function DD:BuildList()
        if not Scroll then return end
        for _, C in Scroll:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end

        local Ents = Entries()
        for I, E in Ents do
            local Row = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = I, Parent = Scroll })
            Corner(Row, 5)
            local Selected = IsSelected(E.Value)
            local Check = Glyph(Row, "check", "✓", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(12, 12), Color = "Text", Visible = Selected })
            local TextX = 26
            if E.Icon ~= nil then
                local IconBox = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 26, 0.5, 0), Size = UDim2.fromOffset(18, 18), Parent = Row })
                MakeIconInstance(IconBox, E.Icon)
                TextX = 50
            end
            local Txt = New("TextLabel", {
                Position = UDim2.fromOffset(TextX, 0), Size = UDim2.new(1, -TextX - 4, 1, 0), Text = E.Display, TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = E.Disabled and 0.6 or 0, Parent = Row,
            })

            Row.MouseEnter:Connect(function()
                if E.Disabled then return end
                Row.BackgroundTransparency = 0
                Txt.TextColor3 = Library.Scheme.AccentText
                if Check:IsA("ImageLabel") then Check.ImageColor3 = Library.Scheme.AccentText else Check.TextColor3 = Library.Scheme.AccentText end
            end)
            Row.MouseLeave:Connect(function()
                Row.BackgroundTransparency = 1
                Txt.TextColor3 = Library.Scheme.Text
                if Check:IsA("ImageLabel") then Check.ImageColor3 = Library.Scheme.Text else Check.TextColor3 = Library.Scheme.Text end
            end)
            Row.MouseButton1Click:Connect(function()
                if Select(E) then Popup:Close() else DD:BuildList() end
            end)
        end

        local SearchH = SearchBox and 34 or 0
        local H = math.clamp(#Ents, 1, Info.MaxVisibleDropdownItems) * 24 + 8
        Scroll.CanvasSize = UDim2.fromOffset(0, #Ents * 24 + 8)
        Popup:SetSize(UDim2.fromOffset(Button.AbsoluteSize.X / Library.DPIScale, H + SearchH))
    end

    Popup = Library:CreatePopup(Button, {
        Width = 200, Height = 100,
        OnOpen = function() DD:BuildList() end,
        OnToggle = function(Active) if SearchBox then SearchBox.Text = "" end end,
    })
    DD.Popup = Popup

    Scroll = New("ScrollingFrame", {
        Position = UDim2.fromOffset(0, Info.Searchable and 34 or 0), Size = UDim2.new(1, 0, 1, Info.Searchable and -34 or 0),
        CanvasSize = UDim2.new(), ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Popup.Frame,
    })
    List(Scroll, 1)
    Pad(Scroll, 4, 4, 4, 4)

    if Info.Searchable then
        SearchBox = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, PlaceholderText = "Search", Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, 24), TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = Popup.Frame })
        Corner(SearchBox, 12)
        Pad(SearchBox, 0, 10, 0, 10)
        table.insert(DD.Connections, SearchBox:GetPropertyChangedSignal("Text"):Connect(function() DD:BuildList() end))
    end

    --// extended modal (grid with icon + name under it)
    local Modal
    function DD:CloseModal()
        if not Modal then return end
        local M = Modal
        Modal = nil
        Library.CurrentModal = nil
        Tween(M.Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
        Tween(M.Scale, { Scale = 0.95 }, Library.TweenInfo)
        task.delay(0.16, function() M.Dim:Destroy() end)
    end

    function DD:OpenModal()
        if DD.Disabled or Modal then return end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if Library.CurrentModal then Library.CurrentModal:Close() end

        local Win = Library.Window
        local Host = Win and Win.MainFrame or Overlay
        local Real = Host.AbsoluteSize / (Host == Overlay and 1 or Library.DPIScale)
        local PW = math.clamp(Real.X - 70, 320, 660)
        local PH = math.clamp(Real.Y - 70, 280, 480)

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 80, Parent = Host })
        if Win then Corner(Dim, Win.Info.CornerRadius) end
        Tween(Dim, { BackgroundTransparency = 0.45 }, Library.SlowTween)

        local Panel = New("Frame", { BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(PW, PH), ZIndex = 81, Parent = Dim })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        local PScale = New("UIScale", { Scale = 0.95, Parent = Panel })
        Tween(PScale, { Scale = 1 }, Library.SlowTween)

        New("TextLabel", { Position = UDim2.fromOffset(18, 12), Size = UDim2.new(1, -110, 0, 22), Text = Library:ToRichText(DD.Text or "Select"), FontFace = "FontBold", TextSize = 16, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Panel })
        local Done = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 0, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -14, 0, 12), Size = UDim2.fromOffset(64, 24), Text = DD.Multi and "Done" or "Close", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Panel })
        Corner(Done, 99)

        local Search = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, PlaceholderText = "Search", Position = UDim2.fromOffset(16, 46), Size = UDim2.new(1, -32, 0, 30), TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = Panel })
        Corner(Search, 99)
        Pad(Search, 0, 12, 0, 14)

        local Grid = New("ScrollingFrame", { Position = UDim2.fromOffset(0, 86), Size = UDim2.new(1, 0, 1, -86), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Panel })
        New("UIGridLayout", { CellSize = UDim2.fromOffset(100, 118), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center, Parent = Grid })
        Pad(Grid, 4, 12, 16, 12)

        Modal = { Dim = Dim, Scale = PScale, Close = function() DD:CloseModal() end }
        Library.CurrentModal = Modal

        local Cells = {}
        local function Build()
            for _, C in Grid:GetChildren() do
                if C:IsA("TextButton") then C:Destroy() end
            end
            table.clear(Cells)
            local Q = NormalizeSearch(Search.Text)
            local N = 0
            for _, It in GetItems() do
                if Q == "" or Fuzzy(It.Display, Q) then
                    N += 1
                    local Cell = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, LayoutOrder = N, Parent = Grid })
                    Corner(Cell, 12)
                    local CStroke = Stroke(Cell, "Accent", 2, 1)
                    local IconBox = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 10), Size = UDim2.fromOffset(66, 66), Parent = Cell })
                    if not MakeIconInstance(IconBox, It.Icon) then
                        New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = It.Display:sub(1, 1):upper(), FontFace = "FontBold", TextSize = 30, TextColor3 = "SubText", Parent = IconBox })
                    end
                    New("TextLabel", {
                        Position = UDim2.fromOffset(6, 80), Size = UDim2.new(1, -12, 0, 32), Text = It.Display, TextSize = 11, TextWrapped = true,
                        TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = It.Disabled and 0.6 or 0, Parent = Cell,
                    })
                    local Badge = New("Frame", { BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 6), Size = UDim2.fromOffset(18, 18), Parent = Cell })
                    Corner(Badge, 99)
                    Glyph(Badge, "check", "✓", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(11, 11), Color = "AccentText" })

                    local function Update()
                        local Sel = IsSelected(It.Value)
                        Badge.Visible = Sel
                        CStroke.Transparency = Sel and 0 or 1
                    end
                    Update()
                    table.insert(Cells, Update)

                    Cell.MouseEnter:Connect(function() if not It.Disabled then Tween(Cell, { BackgroundColor3 = Library.Scheme.ControlHover }) end end)
                    Cell.MouseLeave:Connect(function() Tween(Cell, { BackgroundColor3 = Library.Scheme.Control }) end)
                    Cell.MouseButton1Click:Connect(function()
                        local Close = Select(It)
                        for _, U in Cells do U() end
                        if Close then DD:CloseModal() end
                    end)
                end
            end
        end
        Build()
        Search:GetPropertyChangedSignal("Text"):Connect(Build)
        Done.MouseButton1Click:Connect(function() DD:CloseModal() end)
        Dim.MouseButton1Click:Connect(function()
            if not IsOver(Panel, MousePos()) then DD:CloseModal() end
        end)
    end

    --// value api
    local function ValueExists(V) return Lookup(V) ~= nil end

    function DD:SetValue(V)
        if DD.Multi then
            if typeof(V) == "string" or typeof(V) == "number" then V = { [V] = true } end
            local T = {}
            if typeof(V) == "table" then
                if IsArray(V) then
                    for _, Val in V do if ValueExists(Val) then T[Val] = true end end
                else
                    for Val, On in V do if On and ValueExists(Val) then T[Val] = true end end
                end
            end
            DD.Value = T
        else
            if V ~= nil and ValueExists(V) then DD.Value = V elseif V == nil then DD.Value = nil end
        end
        DD:Display()
        if Popup.Active then DD:BuildList() end
        if not DD.Disabled then Library:UpdateDependencyBoxes() end
        DD:RunChanged()
    end

    function DD:SetValues(Values)
        DD.Values = Values
        local Changed = false
        if DD.Multi then
            for V in DD.Value do if not ValueExists(V) then DD.Value[V] = nil; Changed = true end end
        elseif DD.Value ~= nil and not ValueExists(DD.Value) then
            DD.Value = nil; Changed = true
        end
        if Info.Extended == nil then DD.Extended = HasIcons() end
        LayoutButton()
        DD:Display()
        if Popup.Active then DD:BuildList() end
        if Changed then
            Library:UpdateDependencyBoxes()
            DD:RunChanged()
        end
    end
    function DD:AddValues(V)
        if typeof(V) == "table" and V.Name == nil and V.Value == nil then
            for _, X in V do table.insert(DD.Values, X) end
        else
            table.insert(DD.Values, V)
        end
        if Info.Extended == nil then DD.Extended = HasIcons() end
        LayoutButton()
        if Popup.Active then DD:BuildList() end
    end
    function DD:SetDisabledValues(V) DD.DisabledValues = V; if Popup.Active then DD:BuildList() end end
    function DD:SetDisabled(D) DD.Disabled = D; Popup:Close(); DD:CloseModal(); Button.Active = not D; DD:Display(); Library:UpdateDependencyBoxes() end
    function DD:SetText(T) DD.Text = T; Label.Text = Library:ToRichText(T or ""); Label.Visible = T ~= nil end

    table.insert(DD.Connections, Button.MouseButton1Click:Connect(function()
        if DD.Disabled then return end
        if DD.ModalOnly then DD:OpenModal() else Popup:Toggle() end
    end))
    table.insert(DD.Connections, ExpandBtn.MouseButton1Click:Connect(function() DD:OpenModal() end))
    table.insert(DD.Connections, Button.MouseEnter:Connect(function() if not DD.Disabled then Tween(Button, { BackgroundColor3 = Library.Scheme.ControlHover }) end end))
    table.insert(DD.Connections, Button.MouseLeave:Connect(function() Tween(Button, { BackgroundColor3 = Library.Scheme.Control }) end))

    --// defaults (value, name, index, or list of those)
    local Resolved = {}
    local function Find(Cand)
        local Items0 = GetItems()
        for _, It in Items0 do if It.Value == Cand then return It.Value end end
        for _, It in Items0 do if It.Display == Cand then return It.Value end end
        if typeof(Cand) == "number" and IsArray(DD.Values) and Items0[Cand] then return Items0[Cand].Value end
        return nil
    end
    local Def = Info.Default
    if typeof(Def) == "table" then
        for K, V in Def do
            local Cand
            if typeof(K) == "number" then Cand = V elseif V then Cand = K end
            local F = Cand ~= nil and Find(Cand)
            if F ~= nil and F ~= false then table.insert(Resolved, F) end
        end
    elseif Def ~= nil then
        local F = Find(Def)
        if F ~= nil then table.insert(Resolved, F) end
    end
    for _, V in Resolved do
        if DD.Multi then DD.Value[V] = true else DD.Value = V break end
    end
    DD.Default = Resolved

    DD:Display()
    Finalize(Group, DD, Holder, Options, Idx, Info)
    local BaseDestroy = DD.Destroy
    function DD:Destroy() Popup:Destroy(); DD:CloseModal(); BaseDestroy(DD) end
    return DD
end

--// Image / UIPassthrough \\--
function Funcs:AddImage(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.Image)
    local Group = self
    local Img = { Type = "Image", Height = Info.Height, Visible = Info.Visible, Connections = {} }
    local Holder = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, Info.Height), Visible = Img.Visible, Parent = Group.Container })
    Corner(Holder, 8)
    local Label = New("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageColor3 = Info.Color, ImageTransparency = Info.Transparency, ScaleType = Info.ScaleType, Parent = Holder })
    function Img:SetImage(I)
        local Icon = Library:GetCustomIcon(I)
        assert(Icon, "Invalid image.")
        Library:ApplyIcon(Label, Icon)
    end
    function Img:SetHeight(H) Holder.Size = UDim2.new(1, 0, 0, H) end
    if Info.Image ~= "" then Img:SetImage(Info.Image) end
    Finalize(Group, Img, Holder, Options, Idx)
    return Img
end

function Funcs:AddUIPassthrough(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.UIPassthrough)
    assert(typeof(Info.Instance) == "Instance" and Info.Instance:IsA("GuiBase2d"), "Instance must inherit from GuiBase2d.")
    local Group = self
    local PT = { Type = "UIPassthrough", Instance = Info.Instance, Visible = Info.Visible, Connections = {} }
    local Holder = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, Info.Height), Visible = PT.Visible, Parent = Group.Container })
    Info.Instance.Parent = Holder
    function PT:SetHeight(H) Holder.Size = UDim2.new(1, 0, 0, H) end
    Finalize(Group, PT, Holder, Options, Idx)
    return PT
end

--// Dependency box \\--
function Library:UpdateDependencyBoxes()
    for _, D in Library.DependencyBoxes do D:Update(true) end
    if Library.Searching then Library:UpdateSearch(Library.SearchText) end
end

function Library:UpdateAddons(Parent)
    if Parent and Parent.Addons then
        for _, A in Parent.Addons do if A.Update then A:Update() end end
    end
end

function Funcs:AddDependencyBox()
    if self.Destroyed then return end
    local Group = self
    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = false, Parent = Group.Container })
    List(Holder, 10)

    local Depbox = {
        Type = "DependencyBox", Visible = false, Dependencies = {}, Holder = Holder, Container = Holder,
        Elements = {}, DependencyBoxes = {}, Tab = Group.Tab, Connections = {},
    }

    function Depbox:Update(NoSearch)
        for _, Dep in Depbox.Dependencies do
            local E, V = Dep[1], Dep[2]
            local Ok = not E.Disabled
            if Ok and E.Type == "Toggle" then Ok = E.Value == V
            elseif Ok and E.Type == "Dropdown" then
                if typeof(E.Value) == "table" then Ok = E.Value[V] == true else Ok = E.Value == V end
            end
            if not Ok then
                Holder.Visible, Depbox.Visible = false, false
                return
            end
        end
        Depbox.Visible, Holder.Visible = true, true
        if Library.Searching and not NoSearch then Library:UpdateSearch(Library.SearchText) end
    end

    function Depbox:SetupDependencies(Deps)
        for _, D in Deps do
            assert(typeof(D) == "table" and D[1] ~= nil and D[2] ~= nil, "Dependency must be { Element, ExpectedValue }")
        end
        Depbox.Dependencies = Deps
        Depbox:Update()
    end

    function Depbox:Destroy()
        Depbox.Destroyed = true
        for I = #Depbox.Elements, 1, -1 do Depbox.Elements[I]:Destroy() end
        Holder:Destroy()
        for _, L in { Group.DependencyBoxes, Library.DependencyBoxes } do
            local I = table.find(L, Depbox)
            if I then table.remove(L, I) end
        end
    end

    setmetatable(Depbox, BaseGroupbox)
    table.insert(Group.DependencyBoxes, Depbox)
    table.insert(Library.DependencyBoxes, Depbox)
    return Depbox
end

--// KeyPicker addon \\--
local SpecialKeys = { MB1 = Enum.UserInputType.MouseButton1, MB2 = Enum.UserInputType.MouseButton2, MB3 = Enum.UserInputType.MouseButton3 }
local SpecialKeysInput = { [Enum.UserInputType.MouseButton1] = "MB1", [Enum.UserInputType.MouseButton2] = "MB2", [Enum.UserInputType.MouseButton3] = "MB3" }

function AddonFuncs:AddKeyPicker(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.KeyPicker)
    local Parent = self
    local IsButton = Parent.Type == "Button" or Parent.Type == "SubButton"
    if IsButton then Info.Mode = "Press" end

    local KP = {
        Type = "KeyPicker", ParentObj = Parent, Text = Info.Text ~= "Keybind" and Info.Text or (Parent.Text or "Keybind"),
        Value = Info.Default, Mode = Info.Mode, Modes = Info.Modes, SyncToggleState = Info.SyncToggleState,
        Toggled = false, NoUI = Info.NoUI, Callback = Info.Callback, ChangedCallback = Info.ChangedCallback,
        Changed = Info.Changed, Clicked = Info.Clicked, Connections = {},
    }
    if KP.Mode == "Press" then KP.Modes = { "Press" }; KP.SyncToggleState = false end
    if KP.SyncToggleState and Parent.Type == "Toggle" then
        KP.Modes = { "Toggle", "Hold" }
        if not table.find(KP.Modes, KP.Mode) then KP.Mode = "Toggle" end
    end

    local Picking = false
    Parent.Addons = Parent.Addons or {}

    local Pill = New("TextButton", {
        BackgroundColor3 = "Control", BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 20),
        Text = KP.Value, TextSize = 11, TextColor3 = "SubText", LayoutOrder = #Parent.Addons + 2, Parent = Parent.AddonHolder,
    })
    Corner(Pill, 6)
    Pad(Pill, 0, 8, 0, 8)

    -- keybind list row
    if not KP.NoUI then
        KP.Row = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 16), Text = "", TextSize = 12, TextColor3 = "SubText", Visible = false, Parent = KeybindContainer })
        table.insert(Library.KeybindPickers, KP)
    end

    -- mode menu
    local Menu = Library:CreatePopup(Pill, { Width = 90, AutoY = true })
    List(Menu.Frame, 1)
    Pad(Menu.Frame, 4, 4, 4, 4)
    local ModeButtons = {}
    for _, M in KP.Modes do
        local B = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22), Text = M, TextTransparency = 0.3, Parent = Menu.Frame })
        Corner(B, 5)
        B.MouseEnter:Connect(function() Tween(B, { BackgroundTransparency = 0.7 }) end)
        B.MouseLeave:Connect(function() Tween(B, { BackgroundTransparency = KP.Mode == M and 0.4 or 1 }) end)
        B.MouseButton1Click:Connect(function()
            KP.Mode = M
            Menu:Close()
            KP:Update()
        end)
        ModeButtons[M] = B
    end

    function KP:GetState()
        if KP.Mode == "Always" then return true end
        return KP.Toggled
    end

    function KP:Update()
        local Disabled = Parent.Disabled == true
        local DisplayText = KP.Value
        Pill.Text = Picking and "..." or DisplayText
        Pill.TextTransparency = Disabled and 0.6 or 0
        for M, B in ModeButtons do B.BackgroundTransparency = KP.Mode == M and 0.4 or 1 end

        local State = KP:GetState()
        if KP.SyncToggleState and Parent.Value ~= nil and Parent.Value ~= State and Parent.Type == "Toggle" then
            Parent:SetValue(State)
        end
        if KP.Row then
            KP.Row.Text = string.format("[%s]  %s", KP.Value, KP.Text)
            KP.Row.TextColor3 = State and Library.Scheme.Accent or Library.Scheme.SubText
            KP.Row.Visible = KP.Value ~= "None" and not Disabled
            Library:UpdateKeybindList()
        end
    end

    function KP:OnChanged(F) KP.Changed = F end
    function KP:OnClick(F) KP.Clicked = F end

    function KP:DoClick()
        if Picking or Parent.Disabled then return end
        Library:SafeCallback(KP.Callback, KP.Toggled)
        Library:SafeCallback(KP.Clicked, KP.Toggled)
        if IsButton then Library:SafeCallback(Parent.Func, KP.Toggled) end
        if Library.ToggleKeybind == KP then Library:Toggle() end
    end

    function KP:SetValue(Data)
        local Key, Mode = Data[1], Data[2]
        local Valid = Key == "None" or SpecialKeys[Key] ~= nil or pcall(function() return Enum.KeyCode[Key] end)
        KP.Value = (Key == nil or Key == "None") and "None" or (Valid and Key or "Unknown")
        if Mode and ModeButtons[Mode] then KP.Mode = Mode end
        KP:Update()
        local Code
        if KP.Value ~= "None" and KP.Value ~= "Unknown" then
            Code = SpecialKeys[KP.Value] or Enum.KeyCode[KP.Value]
        end
        Library:SafeCallback(KP.ChangedCallback, Code, {})
        Library:SafeCallback(KP.Changed, Code, {})
    end

    function KP:SetText(T) KP.Text = T; KP:Update() end
    function KP:SetMenuVisibility(V) if KP.Row then KP.Row.Visible = V; Library:UpdateKeybindList() end end

    table.insert(KP.Connections, Pill.MouseButton1Click:Connect(function()
        if Picking or Library.IsPicking or Parent.Disabled then return end
        Picking, Library.IsPicking = true, true
        Parent.AnyKeyPickerPicking = true
        KP:Update()
        local Conn
        Conn = UserInputService.InputBegan:Connect(function(Input)
            local Key
            if Input.UserInputType == Enum.UserInputType.Keyboard then
                Key = Input.KeyCode == Enum.KeyCode.Escape and "None" or Input.KeyCode.Name
            elseif SpecialKeysInput[Input.UserInputType] then
                Key = SpecialKeysInput[Input.UserInputType]
            else
                return
            end
            Conn:Disconnect()
            task.defer(function()
                Picking, Library.IsPicking = false, false
                Parent.AnyKeyPickerPicking = false
                KP.Toggled = Parent.Type == "Toggle" and Parent.Value or false
                KP:SetValue({ Key, KP.Mode })
            end)
        end)
        table.insert(KP.Connections, Conn)
    end))
    table.insert(KP.Connections, Pill.MouseButton2Click:Connect(function()
        if not Parent.Disabled and #KP.Modes > 1 then Menu:Toggle() end
    end))

    table.insert(KP.Connections, UserInputService.InputBegan:Connect(function(Input)
        if Library.Unloaded or Picking or Library.IsPicking or Parent.Disabled or KP.Mode == "Always" then return end
        if KP.Value == "None" or KP.Value == "Unknown" or UserInputService:GetFocusedTextBox() then return end
        local Hit = (SpecialKeysInput[Input.UserInputType] == KP.Value and not Library.Toggled)
            or (Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == KP.Value)
        if not Hit then return end

        if KP.Mode == "Toggle" then
            KP.Toggled = not KP.Toggled
            KP:DoClick()
        elseif KP.Mode == "Press" then
            KP:DoClick()
        elseif KP.Mode == "Hold" then
            KP.Toggled = true
            KP:DoClick()
        end
        KP:Update()
    end))
    table.insert(KP.Connections, UserInputService.InputEnded:Connect(function(Input)
        if KP.Mode ~= "Hold" or not KP.Toggled then return end
        if (SpecialKeysInput[Input.UserInputType] == KP.Value) or (Input.UserInputType == Enum.UserInputType.Keyboard and Input.KeyCode.Name == KP.Value) then
            KP.Toggled = false
            KP:DoClick()
            KP:Update()
        end
    end))

    function KP:Destroy()
        KP.Destroyed = true
        Library.ThemeHooks[KP] = nil
        for _, C in KP.Connections do C:Disconnect() end
        Menu:Destroy()
        Pill:Destroy()
        if KP.Row then
            KP.Row:Destroy()
            local I = table.find(Library.KeybindPickers, KP)
            if I then table.remove(Library.KeybindPickers, I) end
            Library:UpdateKeybindList()
        end
        local I = table.find(Parent.Addons, KP)
        if I then table.remove(Parent.Addons, I) end
        Options[Idx] = nil
    end

    KP:Update()
    Library.ThemeHooks[KP] = function() KP:Update() end
    KP.Default = KP.Value
    table.insert(Parent.Addons, KP)
    Options[Idx] = KP
    return self
end

--// ColorPicker addon \\--
function AddonFuncs:AddColorPicker(Idx, Info)
    if self.Destroyed then return end
    Info = Library:Validate(Info, Templates.ColorPicker)
    local Parent = self
    Parent.Addons = Parent.Addons or {}

    local CP = {
        Type = "ColorPicker", ParentObj = Parent, Value = Info.Default, Transparency = Info.Transparency or 0,
        HasAlpha = Info.Transparency ~= nil, Title = Info.Title, Callback = Info.Callback, Changed = Info.Changed, Connections = {},
    }
    CP.Hue, CP.Sat, CP.Val = CP.Value:ToHSV()

    local Swatch = New("TextButton", { BackgroundColor3 = CP.Value, BackgroundTransparency = 0, Size = UDim2.fromOffset(18, 18), LayoutOrder = #Parent.Addons + 2, Parent = Parent.AddonHolder })
    Corner(Swatch, 99)
    Stroke(Swatch, "Text", 1, 0.75)

    local Popup = Library:CreatePopup(Swatch, { Width = 214, AutoY = true, AlignRight = true })
    local Content = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = Popup.Frame })
    List(Content, 8)
    Pad(Content, 12, 12, 12, 12)

    if typeof(CP.Title) == "string" then
        New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = CP.Title, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, Parent = Content })
    end

    local SV = New("TextButton", { BackgroundColor3 = Color3.fromHSV(CP.Hue, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 120), ClipsDescendants = true, Parent = Content })
    Corner(SV, 6)
    local WhiteOverlay = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), Parent = SV })
    New("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }), Parent = WhiteOverlay })
    local BlackOverlay = New("Frame", { BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), Parent = SV })
    New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }), Parent = BlackOverlay })
    local SVCursor = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(12, 12), Parent = SV })
    Corner(SVCursor, 99)
    Stroke(SVCursor, Color3.new(1, 1, 1), 2, 0)

    local function MakeBar(Height)
        local Bar = New("TextButton", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, Height), Parent = Content })
        Corner(Bar, 99)
        local Cur = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(Height + 2, Height + 2), Parent = Bar })
        Corner(Cur, 99)
        Stroke(Cur, Color3.new(0, 0, 0), 1, 0.7)
        return Bar, Cur
    end

    local HueBar, HueCursor = MakeBar(12)
    local Seq = {}
    for I = 0, 6 do table.insert(Seq, ColorSequenceKeypoint.new(I / 6, Color3.fromHSV(I / 6, 1, 1))) end
    New("UIGradient", { Color = ColorSequence.new(Seq), Parent = HueBar })

    local AlphaBar, AlphaCursor, AlphaGradient
    if CP.HasAlpha then
        AlphaBar, AlphaCursor = MakeBar(12)
        AlphaBar.BackgroundColor3 = Color3.fromRGB(120, 120, 120)
        local Over = New("Frame", { BackgroundColor3 = CP.Value, Size = UDim2.fromScale(1, 1), Parent = AlphaBar })
        Corner(Over, 99)
        AlphaGradient = New("UIGradient", { Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }), Parent = Over })
        CP.AlphaOverlay = Over
        AlphaCursor.ZIndex = 5
    end

    local Hex = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 24), ClearTextOnFocus = false, Text = "", Parent = Content })
    Corner(Hex, 6)

    function CP:Display()
        if Library.Unloaded then return end
        CP.Value = Color3.fromHSV(CP.Hue, CP.Sat, CP.Val)
        Swatch.BackgroundColor3 = CP.Value
        Swatch.BackgroundTransparency = CP.HasAlpha and CP.Transparency * 0.8 or 0
        SV.BackgroundColor3 = Color3.fromHSV(CP.Hue, 1, 1)
        SVCursor.Position = UDim2.fromScale(CP.Sat, 1 - CP.Val)
        HueCursor.Position = UDim2.fromScale(CP.Hue, 0.5)
        if CP.HasAlpha then
            CP.AlphaOverlay.BackgroundColor3 = CP.Value
            AlphaCursor.Position = UDim2.fromScale(1 - CP.Transparency, 0.5)
        end
        Hex.Text = "#" .. CP.Value:ToHex():upper()
    end

    function CP:RunChanged()
        if Parent.Disabled then return end
        Library:SafeCallback(CP.Callback, CP.Value)
        Library:SafeCallback(CP.Changed, CP.Value)
    end
    function CP:Update() CP:Display(); CP:RunChanged() end
    function CP:OnChanged(F) CP.Changed = F end
    function CP:SetValueRGB(Color, Transparency)
        CP.Transparency = CP.HasAlpha and (Transparency or 0) or 0
        CP.Hue, CP.Sat, CP.Val = Color:ToHSV()
        CP:Update()
    end
    function CP:SetValue(HSV, Transparency)
        if typeof(HSV) == "Color3" then return CP:SetValueRGB(HSV, Transparency) end
        CP:SetValueRGB(Color3.fromHSV(HSV[1], HSV[2], HSV[3]), Transparency)
    end

    local function Drag(Gui, Fn)
        table.insert(CP.Connections, Gui.InputBegan:Connect(function(Input)
            if not IsPress(Input) then return end
            while Input.UserInputState ~= Enum.UserInputState.End and not CP.Destroyed do
                Fn(MousePos())
                RunService.RenderStepped:Wait()
            end
        end))
    end
    Drag(SV, function(M)
        CP.Sat = math.clamp((M.X - SV.AbsolutePosition.X) / math.max(SV.AbsoluteSize.X, 1), 0, 1)
        CP.Val = 1 - math.clamp((M.Y - SV.AbsolutePosition.Y) / math.max(SV.AbsoluteSize.Y, 1), 0, 1)
        CP:Update()
    end)
    Drag(HueBar, function(M)
        CP.Hue = math.clamp((M.X - HueBar.AbsolutePosition.X) / math.max(HueBar.AbsoluteSize.X, 1), 0, 1)
        CP:Update()
    end)
    if AlphaBar then
        Drag(AlphaBar, function(M)
            CP.Transparency = 1 - math.clamp((M.X - AlphaBar.AbsolutePosition.X) / math.max(AlphaBar.AbsoluteSize.X, 1), 0, 1)
            CP:Update()
        end)
    end
    table.insert(CP.Connections, Hex.FocusLost:Connect(function()
        local Ok, C = pcall(Color3.fromHex, Hex.Text)
        if Ok and typeof(C) == "Color3" then CP.Hue, CP.Sat, CP.Val = C:ToHSV() end
        CP:Update()
    end))
    table.insert(CP.Connections, Swatch.MouseButton1Click:Connect(function()
        if not Parent.Disabled then Popup:Toggle() end
    end))

    function CP:Destroy()
        CP.Destroyed = true
        for _, C in CP.Connections do C:Disconnect() end
        Popup:Destroy()
        Swatch:Destroy()
        local I = table.find(Parent.Addons, CP)
        if I then table.remove(Parent.Addons, I) end
        Options[Idx] = nil
    end

    CP:Display()
    CP.Default = CP.Value
    table.insert(Parent.Addons, CP)
    Options[Idx] = CP
    return self
end

--// Search \\--
local function ElementMatches(El, S)
    if Fuzzy(Library:StripRich(El.Text), S) or Fuzzy(El.Tooltip, S) then return true end
    if El.SubButton and Fuzzy(El.SubButton.Text, S) then return true end
    if El.Type == "Dropdown" and typeof(El.Values) == "table" then
        local N = 0
        for _, V in El.Values do
            N += 1
            if N > 150 then break end
            if Fuzzy(tostring(V), S) then return true end
        end
    end
    return false
end

local function SetHL(El, Query)
    for _, Target in { El, El.SubButton } do
        local L = Target.LabelObj
        if L and L.Parent and typeof(Target.Text) == "string" then
            L.Text = (Query and Query ~= "") and Library:HighlightText(Target.Text, Query) or Library:ToRichText(Target.Text)
        end
    end
end

local function ApplyBox(Box, S, Force)
    local Count = 0
    for _, El in Box.Elements do
        if El.Type == "Divider" then
            El.Holder.Visible = false
        else
            local Vis = El.Visible ~= false and (Force or ElementMatches(El, S))
            El.Holder.Visible = Vis
            SetHL(El, Vis and Library.SearchRaw or nil)
            if Vis then Count += 1 end
        end
    end
    for _, D in Box.DependencyBoxes do
        if D.Visible then
            local C = ApplyBox(D, S, Force)
            D.Holder.Visible = C > 0
            Count += C
        end
    end
    return Count
end

local function ResetBox(Box)
    for _, El in Box.Elements do
        El.Holder.Visible = El.Visible ~= false
        SetHL(El, nil)
    end
    for _, D in Box.DependencyBoxes do
        D.Holder.Visible = D.Visible
        ResetBox(D)
    end
end

function Library:BuildSearchIndex()
    local Index = {}
    local function Add(E) E.Order = #Index + 1; table.insert(Index, E) end
    local function Join(A, B, C, D)
        local P = {}
        for _, V in { A or false, B or false, C or false, D or false } do
            if V then table.insert(P, V) end
        end
        return table.concat(P, "  ›  ")
    end
    local function Walk(Box, Ctx)
        for _, El in Box.Elements do
            if El.Type ~= "Divider" and typeof(El.Text) == "string" and El.Text ~= "" then
                Add({ Tab = Ctx.Tab, Page = Ctx.Page, Group = Ctx.Group, SubTab = Ctx.SubTab, Element = El, Target = El.Holder,
                    Text = Library:StripRich(El.Text), Extra = El.Tooltip, Type = El.Type, Path = Ctx.Path })
            end
        end
        for _, D in Box.DependencyBoxes do Walk(D, Ctx) end
    end

    for _, Tab in Library.TabList do
        if not Tab.IsKeyTab then
            Add({ Tab = Tab, Text = Tab.Name, Type = "Tab", Path = "Tab", Extra = Tab.Description })
            local PageOf = {}
            for _, P in Tab.Pages do
                PageOf[P] = true
                Add({ Tab = Tab, Page = P, Text = P.Name, Type = "Page", Path = Tab.Name })
                for _, G in P.Groupboxes do PageOf[G] = P end
                for _, TB in P.Tabboxes do PageOf[TB] = P end
            end
            for _, G in Tab.Groupboxes do
                local P = PageOf[G]
                Add({ Tab = Tab, Page = P, Group = G, Target = G.BoxHolder, Text = G.Name, Type = "Group", Path = Join(Tab.Name, P and P.Name) })
                Walk(G, { Tab = Tab, Page = P, Group = G, Path = Join(Tab.Name, P and P.Name, G.Name) })
            end
            for _, TB in Tab.Tabboxes do
                local P = PageOf[TB]
                for SName, ST in TB.Tabs do
                    Add({ Tab = Tab, Page = P, Group = TB, SubTab = ST, Target = TB.BoxHolder, Text = tostring(SName), Type = "Tabbox", Path = Join(Tab.Name, P and P.Name) })
                    Walk(ST, { Tab = Tab, Page = P, Group = TB, SubTab = ST, Path = Join(Tab.Name, P and P.Name, tostring(SName)) })
                end
            end
        end
    end
    Library.SearchIndex = Index
    return Index
end

function Library:SearchEntries(Query, Limit)
    local Index = Library.SearchIndex or Library:BuildSearchIndex()
    local Q = Trim(tostring(Query or "")):lower()
    local N = NormalizeSearch(Q)
    local Scored = {}
    for _, E in Index do
        local Score = 0
        if N == "" then
            Score = 1
        else
            local Lo = E.Text:lower()
            local A = Lo:find(Q, 1, true)
            if A then Score = 1000 - A + (A == 1 and 200 or 0) - #Lo * 0.2
            elseif Fuzzy(E.Text, N) then Score = 100
            elseif E.Extra and Fuzzy(tostring(E.Extra), N) then Score = 50
            elseif Fuzzy(E.Path, N) then Score = 20 end
            if E.Type == "Tab" or E.Type == "Page" or E.Type == "Group" then Score *= 0.9 end
        end
        if Score > 0 then table.insert(Scored, { E = E, S = Score }) end
    end
    table.sort(Scored, function(A, B)
        if A.S ~= B.S then return A.S > B.S end
        return A.E.Order < B.E.Order
    end)
    local Out = {}
    for I = 1, math.min(#Scored, Limit or 40) do Out[I] = Scored[I].E end
    return Out
end

function Library:JumpTo(E)
    if not E or not E.Tab then return end
    E.Tab:Show()
    if E.Page then E.Page:Show() end
    if E.Group and E.Group.Type == "Groupbox" and E.Group.Collapsed then E.Group:SetCollapsed(false) end
    if E.SubTab then E.SubTab:Show() end
    local Target = E.Target
    if not Target then return end

    task.spawn(function()
        RunService.RenderStepped:Wait()
        RunService.RenderStepped:Wait()
        if not Target.Parent then return end
        local Side = Target:FindFirstAncestorOfClass("ScrollingFrame")
        if Side then
            local Y = Target.AbsolutePosition.Y - Side.AbsolutePosition.Y + Side.CanvasPosition.Y - 56
            Tween(Side, { CanvasPosition = Vector2.new(0, math.max(0, Y)) }, Library.SlowTween)
        end
        local L = E.Element and E.Element.LabelObj
        if L then
            local Orig = L.TextColor3
            for _ = 1, 3 do
                if not L.Parent then return end
                L.TextColor3 = Library.Scheme.Accent
                task.wait(0.25)
                if not L.Parent then return end
                L.TextColor3 = Orig
                task.wait(0.2)
            end
        end
    end)
end

function Library:UpdateSearch(Text)
    Library.SearchText = Text
    Library.SearchRaw = Trim(Text)
    for _, Tab in Library.TabList do Tab:ResetSearch() end

    local S = NormalizeSearch(Text)
    if S == "" then
        Library.Searching = false
        return
    end
    Library.Searching = true

    local First, ActiveHas
    for _, Tab in Library.TabList do
        local Has = Tab:ApplySearch(S)
        Tab.Button.Visible = Has and Tab.TabVisible ~= false
        if Has then
            First = First or Tab
            if Tab == Library.ActiveTab then ActiveHas = true end
        end
    end
    if not ActiveHas and First then First:Show() end
end

--// Notifications \\--
local NotifyArea = New("Frame", {
    BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12),
    Size = UDim2.new(0, 330, 1, -24), ZIndex = 50, Parent = ScreenGui,
})
local NotifyList = List(NotifyArea, 8)
Library.DPIScales[New("UIScale", { Parent = NotifyArea })] = true

function Library:SetNotifySide(Side)
    Library.NotifySide = Side
    local Left = tostring(Side):lower() == "left"
    NotifyArea.AnchorPoint = Left and Vector2.new(0, 0) or Vector2.new(1, 0)
    NotifyArea.Position = Left and UDim2.new(0, 12, 0, 12) or UDim2.new(1, -12, 0, 12)
    NotifyList.HorizontalAlignment = Left and Enum.HorizontalAlignment.Left or Enum.HorizontalAlignment.Right
end

function Library:Notify(...)
    local Info = ...
    local Data = {}
    if typeof(Info) == "table" then
        Data.Title = Info.Title and tostring(Info.Title) or Library.AppName
        Data.Description = Info.Description and tostring(Info.Description) or ""
        Data.Time = Info.Time or 5
        Data.Persist = Info.Persist
        Data.Icon = Info.Icon
        Data.IconColor = Info.IconColor
        Data.Callback = Info.Callback
    else
        Data.Title = Library.AppName
        Data.Description = tostring(Info)
        Data.Time = select(2, ...) or 5
    end

    local Left = Library.NotifySide:lower() == "left"
    local Wrapper = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = NotifyArea })
    local Card = New("TextButton", {
        BackgroundColor3 = "Popup", BackgroundTransparency = 0.04, AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromOffset(Left and -360 or 360, 0), Size = UDim2.new(1, 0, 0, 0), Parent = Wrapper,
    })
    Corner(Card, 14)
    Library:AddSurface(Card, 0.04, 0.5)
    Stroke(Card, "Outline", 1, 0.3)
    Pad(Card, 10, 12, 10, 12)

    local Content = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 34), Parent = Card })
    local Badge = New("Frame", { BackgroundColor3 = Data.IconColor or "Accent", Size = UDim2.fromOffset(34, 34), Parent = Content })
    Corner(Badge, 9)
    local BadgeIcon = Library:GetCustomIcon(Data.Icon or "leaf")
    if BadgeIcon then
        local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(20, 20), ImageColor3 = "AccentText", Parent = Badge })
        Library:ApplyIcon(Img, BadgeIcon)
    else
        New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Data.Title:sub(1, 1):upper(), FontFace = "FontBold", TextSize = 16, TextColor3 = "AccentText", Parent = Badge })
    end

    local Texts = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(44, 0), Size = UDim2.new(1, -44, 0, 0), Parent = Content })
    List(Texts, 2)
    local TitleRich = Library:RenderRich(Texts, Data.Title, { Size = 13, Bold = true, LayoutOrder = 1 })
    local Desc
    if Data.Description ~= "" then
        Desc = Library:RenderRich(Texts, Data.Description, { Size = 12, Color = "SubText", LayoutOrder = 2 })
    end

    function Data:ChangeDescription(T) if Desc then Desc:SetText(tostring(T)) end end
    function Data:ChangeTitle(T) TitleRich:SetText(tostring(T)) end
    function Data:Destroy(Reason)
        if Data.Destroyed then return end
        Data.Destroyed = true
        Library.Notifications[Wrapper] = nil
        if typeof(Data.Callback) == "function" then pcall(Data.Callback, Reason or "script") end
        Tween(Card, { Position = UDim2.fromOffset(Left and -360 or 360, 0) }, Library.SlowTween)
        task.delay(0.3, function() Wrapper:Destroy() end)
    end

    Card.MouseButton1Click:Connect(function() Data:Destroy("user") end)
    Library.Notifications[Wrapper] = Data
    Tween(Card, { Position = UDim2.fromOffset(0, 0) }, Library.SlowTween)

    if not Data.Persist then
        task.delay(Data.Time, function() Data:Destroy("timer") end)
    end
    return Data
end

--// Window \\--
--// UI blur / glass / wallpaper \\--
local Lighting = GetService("Lighting")
local BlurEffect
function Library:UpdateBlur(Instant)
    local Want = Library.BlurEnabled and Library.Toggled and not Library.Unloaded
    if not Want and not BlurEffect then return end
    if not BlurEffect or not BlurEffect.Parent then
        BlurEffect = Instance.new("BlurEffect")
        BlurEffect.Name = string.sub(tostring({}), 8, 17)
        BlurEffect.Size = 0
        BlurEffect.Parent = Lighting
    end
    local Target = Want and Library.BlurSize or 0
    if Instant then BlurEffect.Size = Target else Tween(BlurEffect, { Size = Target }, Library.SlowTween) end
end

-- SetBlur(true, 18) / SetBlur(false) / SetBlur(18)
function Library:SetBlur(Enabled, Size)
    if typeof(Enabled) == "number" then Size = Enabled; Enabled = Enabled > 0 end
    Library.BlurEnabled = Enabled == true
    if Size then Library.BlurSize = math.clamp(tonumber(Size) or 16, 0, 56) end
    Library:UpdateBlur()
end

Library.GlassEnabled = false
Library.GlassTransparency = 0.35
Library._PreGlassTransparency = nil
Library._PreGlassBlur = nil

-- Frosted glass: raises UI transparency and enables background blur.
function Library:SetGlass(Enabled, Transparency)
    Enabled = Enabled == true
    if Transparency then Library.GlassTransparency = math.clamp(tonumber(Transparency) or 0.35, 0.1, 0.7) end
    if Enabled and not Library.GlassEnabled then
        Library._PreGlassTransparency = Library.UITransparency
        Library._PreGlassBlur = Library.BlurEnabled
        Library.GlassEnabled = true
        Library:SetTransparency(math.max(Library.UITransparency, Library.GlassTransparency))
        Library:SetBlur(true, Library.BlurSize > 0 and Library.BlurSize or 18)
    elseif not Enabled and Library.GlassEnabled then
        Library.GlassEnabled = false
        Library:SetTransparency(Library._PreGlassTransparency or 0)
        if Library._PreGlassBlur == false then Library:SetBlur(false) end
        Library._PreGlassTransparency, Library._PreGlassBlur = nil, nil
    elseif Enabled then
        Library:SetTransparency(math.max(Library.UITransparency, Library.GlassTransparency))
        Library:SetBlur(true, Library.BlurSize > 0 and Library.BlurSize or 18)
    end
end

Library.WallpaperImage = nil
Library.WallpaperTransparency = 0.55

function Library:SetWallpaper(Image, Transparency)
    if Transparency ~= nil then
        Library.WallpaperTransparency = math.clamp(tonumber(Transparency) or 0.55, 0, 0.95)
    end
    if Image == false or Image == nil or Image == "" then
        Library.WallpaperImage = nil
    else
        local Url = tostring(Image)
        if tonumber(Url) then Url = "rbxassetid://" .. Url end
        Library.WallpaperImage = Url
    end
    local W = Library.Window
    if W and W.Wallpaper then
        if Library.WallpaperImage then
            W.Wallpaper.Image = Library.WallpaperImage
            W.Wallpaper.ImageTransparency = Library.WallpaperTransparency
            W.Wallpaper.Visible = true
        else
            W.Wallpaper.Visible = false
        end
    end
end

function Library:DestroyBlur()
    if BlurEffect then BlurEffect:Destroy() BlurEffect = nil end
end

function Library:SetDPIScale(Percent)
    Percent = math.clamp(tonumber(Percent) or 100, 50, 150)
    local Old, NewScale = Library.DPIScale, Percent / 100
    if Library.CurrentPopup then Library.CurrentPopup:Close() end

    local Root = Library.Window and Library.Window.Root
    if Root then -- keep the window centered on the same point
        local Half = Vector2.new(Root.Size.X.Offset, Root.Size.Y.Offset) * (Old - NewScale) / 2
        Root.Position = Root.Position + UDim2.fromOffset(Half.X, Half.Y)
    end

    Library.DPIScale = NewScale
    for S in Library.DPIScales do
        if S.Parent then S.Scale = NewScale end
    end
    NotifyArea.Size = UDim2.new(0, 330, 1 / NewScale, -24 / NewScale)
end

function Library:Toggle(Value)
    if Library.Window then Library.Window:Toggle(Value) end
end

function Library:CreateWindow(WindowInfo)
    WindowInfo = Library:Validate(WindowInfo, Templates.Window)
    if Library.Window then warn("[Evergreen] A window already exists.") return Library.Window end

    local Camera = workspace.CurrentCamera
    local View = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
    WindowInfo.Size = UDim2.fromOffset(
        math.clamp(WindowInfo.Size.X.Offset, WindowInfo.MinSize.X, math.max(WindowInfo.MinSize.X, View.X - 40)),
        math.clamp(WindowInfo.Size.Y.Offset, WindowInfo.MinSize.Y, math.max(WindowInfo.MinSize.Y, View.Y - 40))
    )

    Library:SetTheme(WindowInfo.Theme)
    if WindowInfo.Accent then Library:SetAccent(WindowInfo.Accent) end
    Library:SetNotifySide(WindowInfo.NotifySide)
    Library.ToggleKeybind = WindowInfo.ToggleKeybind

    local Window = { Info = WindowInfo }
    local SidebarWidth = WindowInfo.SidebarWidth
    local TitleH = 40

    --// Root + shadow + main
    local Root = New("Frame", {
        BackgroundTransparency = 1, Size = WindowInfo.Size, Visible = false, Parent = ScreenGui,
        Position = WindowInfo.Center and UDim2.new(0.5, -WindowInfo.Size.X.Offset / 2, 0.5, -WindowInfo.Size.Y.Offset / 2) or WindowInfo.Position,
    })
    Library.DPIScales[New("UIScale", { Scale = Library.DPIScale, Parent = Root })] = true
    local Main = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = Root })
    Corner(Main, WindowInfo.CornerRadius)
    Stroke(Main, "Outline", 1, 0.25)
    Grad(Main, Two("Window", 0.05, -0.015), 125)
    Library:AddSurface(Main, 0, 1)
    local MainScale = New("UIScale", { Parent = Main })

    -- Wallpaper sits behind all chrome (title/sidebar/content)
    local Wallpaper = New("ImageLabel", {
        BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ScaleType = Enum.ScaleType.Crop,
        ImageTransparency = WindowInfo.WallpaperTransparency or 0.55, Visible = false, ZIndex = 0, Parent = Main,
    })
    Corner(Wallpaper, WindowInfo.CornerRadius)
    Window.Wallpaper = Wallpaper
    if WindowInfo.Wallpaper then
        local Url = tostring(WindowInfo.Wallpaper)
        if tonumber(Url) then Url = "rbxassetid://" .. Url end
        Wallpaper.Image = Url
        Wallpaper.Visible = true
        Library.WallpaperImage = Url
        Library.WallpaperTransparency = WindowInfo.WallpaperTransparency or 0.55
    end

    Window.Root, Window.MainFrame = Root, Main

    --// Title bar
    local TitleBar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, TitleH), ZIndex = 3, Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 0.3, Parent = TitleBar })
    New("UICorner", { TopLeftRadius = UDim.new(0, WindowInfo.CornerRadius), TopRightRadius = UDim.new(0, WindowInfo.CornerRadius), BottomLeftRadius = UDim.new(0, 0), BottomRightRadius = UDim.new(0, 0), Parent = TitleBar })
    Library:AddSurface(TitleBar, 0, 1)
    Grad(TitleBar, Two("Titlebar", 0.07, -0.025), 90)
    Library:MakeDraggable(Root, TitleBar, true)

    local Minimized, Maximized = false, false
    local PreMinSize, PreMaxState

    -- traffic lights
    if WindowInfo.ShowTrafficLights then
        local Lights = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Size = UDim2.fromOffset(64, 16), Parent = TitleBar })
        List(Lights, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
        local Glyphs, Hover = {}, 0
        local function Refresh()
            for _, G in Glyphs do Tween(G, { TextTransparency = Hover > 0 and 0.25 or 1 }) end
        end
        local function MakeLight(Color, Char, Func)
            local B = New("TextButton", { BackgroundColor3 = Color, BackgroundTransparency = 0, Size = UDim2.fromOffset(13, 13), Parent = Lights })
            Corner(B, 99)
            Stroke(B, Color3.new(0, 0, 0), 1, 0.82)
            local G = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = Char, TextSize = 12, FontFace = "FontBold", TextColor3 = Color3.fromRGB(45, 25, 20), TextTransparency = 1, Parent = B })
            table.insert(Glyphs, G)
            B.MouseEnter:Connect(function() Hover += 1; Refresh() end)
            B.MouseLeave:Connect(function() Hover = math.max(0, Hover - 1); task.defer(Refresh) end)
            B.MouseButton1Click:Connect(Func)
        end
        MakeLight(Color3.fromRGB(255, 95, 87), "×", function()
            if typeof(WindowInfo.OnClose) == "function" then Library:SafeCallback(WindowInfo.OnClose) end
            if WindowInfo.CloseUnloads then Library:Unload() else Window:Toggle(false) end
        end)
        MakeLight(Color3.fromRGB(254, 188, 46), "–", function() Window:SetMinimized(not Minimized) end)
        MakeLight(Color3.fromRGB(40, 200, 64), "+", function() Window:SetMaximized(not Maximized) end)
    end

    -- centered title
    local TitleHolder = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -400, 1, 0), Parent = TitleBar })
    List(TitleHolder, 0, nil, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    local TitleLabel = New("TextLabel", { Size = UDim2.new(1, 0, 0, 16), Text = WindowInfo.Title, FontFace = "FontBold", TextTruncate = Enum.TextTruncate.AtEnd, Parent = TitleHolder })
    local SubtitleLabel = New("TextLabel", { Size = UDim2.new(1, 0, 0, 12), Text = WindowInfo.Subtitle or "", TextSize = 10, TextColor3 = "SubText", Visible = WindowInfo.Subtitle ~= nil, Parent = TitleHolder })

    --// Search: style 1 = collapsible bar on the title bar (filters + highlights), style 2 = spotlight (jump to results)
    local SearchStyle = WindowInfo.SearchStyle == 2 and 2 or 1
    Window.SearchStyle = SearchStyle
    local SearchHolder, SearchBox
    local Expanded, LastCollapse = false, 0
    local ExpandSearch, CollapseSearch
    local Spot = { Open = false }

    if not WindowInfo.DisableSearch then
        SearchHolder = New("Frame", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0.25, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(28, 26), ClipsDescendants = true, Parent = TitleBar,
        })
        Corner(SearchHolder, 99)
        local SStroke = Stroke(SearchHolder, "Outline", 1, 0.5)
        local SBtn = New("TextButton", { Size = UDim2.fromOffset(28, 26), Parent = SearchHolder })
        Glyph(SBtn, "search", "⌕", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 14) })
        SearchBox = New("TextBox", { Position = UDim2.fromOffset(28, 0), Size = UDim2.new(1, -36, 1, 0), PlaceholderText = "Search", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Visible = false, Parent = SearchHolder })

        ExpandSearch = function()
            if Expanded or SearchStyle ~= 1 then return end
            Expanded = true
            SearchBox.Visible = true
            Bind(SStroke, "Color", "Accent")
            Tween(SStroke, { Color = Library.Scheme.Accent, Transparency = 0 })
            Tween(SearchHolder, { Size = UDim2.fromOffset(230, 26) }, Library.SlowTween)
            task.defer(function() SearchBox:CaptureFocus() end)
        end
        CollapseSearch = function(Clear)
            if not Expanded then return end
            Expanded = false
            LastCollapse = os.clock()
            if Clear then SearchBox.Text = "" end
            Bind(SStroke, "Color", "Outline")
            Tween(SStroke, { Color = Library.Scheme.Outline, Transparency = 0.5 })
            Tween(SearchHolder, { Size = UDim2.fromOffset(28, 26) }, Library.SlowTween)
            task.delay(0.3, function() if not Expanded then SearchBox.Visible = false end end)
        end

        SearchBox.FocusLost:Connect(function()
            if SearchBox.Text == "" then CollapseSearch(false) end
        end)
        Library:GiveSignal(SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            if SearchStyle == 1 then Library:UpdateSearch(SearchBox.Text) end
        end))

        --// spotlight (style 2)
        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 70, Visible = false, Parent = Main })
        Corner(Dim, WindowInfo.CornerRadius)
        local Panel = New("Frame", { BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(520, 380), ZIndex = 71, Parent = Dim })
        Corner(Panel, 14)
        Stroke(Panel, "Outline", 1, 0.2)
        Library:AddSurface(Panel, 0, 0.5)
        local PScale = New("UIScale", { Parent = Panel })
        Glyph(Panel, "search", "⌕", { Position = UDim2.fromOffset(18, 19), Size = UDim2.fromOffset(18, 18) })
        local Input = New("TextBox", { Position = UDim2.fromOffset(46, 12), Size = UDim2.new(1, -62, 0, 34), PlaceholderText = "Search tabs, pages, groups and features...", TextSize = 15, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Parent = Panel })
        New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, Position = UDim2.fromOffset(0, 54), Size = UDim2.new(1, 0, 0, 1), Parent = Panel })
        local Results = New("ScrollingFrame", { Position = UDim2.fromOffset(0, 56), Size = UDim2.new(1, 0, 1, -84), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, Parent = Panel })
        List(Results, 2)
        Pad(Results, 6, 8, 6, 8)
        New("TextLabel", { AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 26), Text = "↑↓ navigate      ↵ open      esc close", TextSize = 11, TextColor3 = "SubText", Parent = Panel })

        local Rows, Sel, Found = {}, 1, {}
        local function SetSel(I)
            if #Rows == 0 then Sel = 1 return end
            Sel = math.clamp(I, 1, #Rows)
            for K, R in Rows do R.BackgroundTransparency = K == Sel and 0 or 1 end
            local R = Rows[Sel]
            local Top = R.AbsolutePosition.Y - Results.AbsolutePosition.Y + Results.CanvasPosition.Y
            if Top < Results.CanvasPosition.Y then
                Results.CanvasPosition = Vector2.new(0, Top)
            elseif Top + R.AbsoluteSize.Y > Results.CanvasPosition.Y + Results.AbsoluteSize.Y then
                Results.CanvasPosition = Vector2.new(0, Top + R.AbsoluteSize.Y - Results.AbsoluteSize.Y)
            end
        end

        local function Rebuild(Query)
            for _, C in Results:GetChildren() do
                if C:IsA("GuiObject") then C:Destroy() end
            end
            table.clear(Rows)
            Found = Library:SearchEntries(Query, 40)
            if #Found == 0 then
                New("TextLabel", { Size = UDim2.new(1, 0, 0, 60), Text = "No results", TextColor3 = "SubText", Parent = Results })
                return
            end
            for I, E in Found do
                local Row = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 46), LayoutOrder = I, Parent = Results })
                Corner(Row, 8)
                New("TextLabel", { Position = UDim2.fromOffset(12, 5), Size = UDim2.new(1, -110, 0, 18), Text = Library:HighlightText(E.Text, Query), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row })
                New("TextLabel", { Position = UDim2.fromOffset(12, 24), Size = UDim2.new(1, -110, 0, 16), Text = Esc(E.Path), TextSize = 11, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row })
                local Badge = New("TextLabel", { BackgroundColor3 = "Segment", BackgroundTransparency = 0.5, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 18), Text = E.Type, TextSize = 10, TextColor3 = "SubText", Parent = Row })
                Corner(Badge, 5)
                Pad(Badge, 0, 7, 0, 7)
                Row.MouseEnter:Connect(function() SetSel(I) end)
                Row.MouseButton1Click:Connect(function()
                    Spot.Hide()
                    Library:JumpTo(E)
                end)
                Rows[I] = Row
            end
            SetSel(1)
        end

        Spot.Show = function()
            if Spot.Open then return end
            Spot.Open = true
            local Real = Main.AbsoluteSize / Library.DPIScale
            Panel.Size = UDim2.fromOffset(math.clamp(Real.X - 80, 320, 560), math.clamp(Real.Y - 80, 260, 420))
            Library:BuildSearchIndex()
            Dim.Visible = true
            Dim.BackgroundTransparency = 1
            Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)
            PScale.Scale = 0.95
            Tween(PScale, { Scale = 1 }, Library.SlowTween)
            Input.Text = ""
            Rebuild("")
            task.defer(function() Input:CaptureFocus() end)
        end
        Spot.Hide = function()
            if not Spot.Open then return end
            Spot.Open = false
            Input:ReleaseFocus()
            Tween(Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
            task.delay(0.16, function() if not Spot.Open then Dim.Visible = false end end)
        end

        Input:GetPropertyChangedSignal("Text"):Connect(function() if Spot.Open then Rebuild(Input.Text) end end)
        Input.FocusLost:Connect(function(Enter)
            if Enter and Found[Sel] then
                local E = Found[Sel]
                Spot.Hide()
                Library:JumpTo(E)
            end
        end)
        Dim.MouseButton1Click:Connect(function()
            if not IsOver(Panel, MousePos()) then Spot.Hide() end
        end)
        Library:GiveSignal(UserInputService.InputBegan:Connect(function(In)
            if not Spot.Open then return end
            if In.KeyCode == Enum.KeyCode.Escape then Spot.Hide()
            elseif In.KeyCode == Enum.KeyCode.Down then SetSel(Sel + 1)
            elseif In.KeyCode == Enum.KeyCode.Up then SetSel(Sel - 1) end
        end))

        SBtn.MouseButton1Click:Connect(function()
            if SearchStyle == 2 then Spot.Show() return end
            if os.clock() - LastCollapse < 0.2 then return end
            if Expanded then CollapseSearch(true) else ExpandSearch() end
        end)
    end

    function Window:SetSearchStyle(Style)
        SearchStyle = Style == 2 and 2 or 1
        Window.SearchStyle = SearchStyle
        if SearchBox then
            if CollapseSearch then CollapseSearch(true) end
            SearchBox.Text = ""
        end
        if Spot.Open then Spot.Hide() end
        Library:UpdateSearch("")
    end

    --// Sidebar
    local Sidebar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Position = UDim2.fromOffset(0, TitleH), Size = UDim2.new(0, SidebarWidth, 1, -TitleH), Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.3, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 1, 1, 0), Parent = Sidebar })

    New("UICorner", { TopLeftRadius = UDim.new(0, 0), TopRightRadius = UDim.new(0, 0), BottomLeftRadius = UDim.new(0, WindowInfo.CornerRadius), BottomRightRadius = UDim.new(0, 0), Parent = Sidebar })
    Library:AddSurface(Sidebar, 0, 1)
    Grad(Sidebar, Two("Sidebar", 0.04, -0.02), 90)
    local ChipH = WindowInfo.ShowUserChip and 52 or 0
    local TabsList = New("ScrollingFrame", {
        Size = UDim2.new(1, -1, 1, -ChipH), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, Parent = Sidebar,
    })
    List(TabsList, 2)
    Pad(TabsList, 10, 8, 8, 8)

    local FooterLabel
    if WindowInfo.ShowUserChip then
        local Chip = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, -1, 0, ChipH), Parent = Sidebar })
        New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.4, Size = UDim2.new(1, -16, 0, 1), Position = UDim2.fromOffset(8, 0), Parent = Chip })
        local Avatar = New("ImageLabel", { BackgroundColor3 = "Control", BackgroundTransparency = 0, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 1), Size = UDim2.fromOffset(30, 30), Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48", LocalPlayer.UserId), Parent = Chip })
        Corner(Avatar, 99)
        New("TextLabel", { Position = UDim2.fromOffset(50, 9), Size = UDim2.new(1, -58, 0, 16), Text = LocalPlayer.DisplayName, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Chip })
        FooterLabel = New("TextLabel", { Position = UDim2.fromOffset(50, 26), Size = UDim2.new(1, -58, 0, 14), Text = WindowInfo.Footer, TextSize = 11, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Chip })
    end

    --// Content
    local Content = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(SidebarWidth, TitleH), Size = UDim2.new(1, -SidebarWidth, 1, -TitleH), ClipsDescendants = true, Parent = Main })
    local Header = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 54), Parent = Content })
    List(Header, 1, nil, nil, Enum.VerticalAlignment.Center)
    Pad(Header, 0, 16, 0, 20)
    local PageTitle = New("TextLabel", { Size = UDim2.new(1, 0, 0, 24), Text = "", FontFace = "FontBold", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Left, Parent = Header })
    local PageDesc = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = "", TextSize = 12, TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, Visible = false, Parent = Header })
    local Pages = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 54), Size = UDim2.new(1, 0, 1, -54), Parent = Content })

    --// Resize grip
    if WindowInfo.Resizable then
        local Grip = New("TextButton", { AnchorPoint = Vector2.new(1, 1), Position = UDim2.fromScale(1, 1), Size = UDim2.fromOffset(18, 18), ZIndex = 6, Parent = Main })
        local GripIcon = Glyph(Grip, "move-diagonal-2", "◢", { Size = UDim2.fromOffset(12, 12), Position = UDim2.fromOffset(2, 2) })
        GlyphTransparency(GripIcon, 0.5)
        Window.Grip = Grip
        local Resizing, StartPos, StartSize = false, nil, nil
        Grip.InputBegan:Connect(function(Input)
            if not IsPress(Input) or Minimized then return end
            Resizing, StartPos, StartSize = true, Input.Position, Root.Size
            Library.CantDragForced = true
            local C; C = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Resizing = false
                    Library.CantDragForced = false
                    C:Disconnect()
                end
            end)
        end)
        Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
            if not Resizing then return end
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                local D = (Input.Position - StartPos) / Library.DPIScale
                Root.Size = UDim2.fromOffset(
                    math.max(WindowInfo.MinSize.X, StartSize.X.Offset + D.X),
                    math.max(WindowInfo.MinSize.Y, StartSize.Y.Offset + D.Y)
                )
            end
        end))
    end

    --// Window API
    function Window:ChangeTitle(T) TitleLabel.Text = T; WindowInfo.Title = T end
    function Window:SetSubtitle(T) SubtitleLabel.Text = T or ""; SubtitleLabel.Visible = T ~= nil end
    function Window:SetFooter(T) WindowInfo.Footer = T; if FooterLabel then FooterLabel.Text = T end end

    function Window:SetSidebarWidth(W)
        W = math.clamp(tonumber(W) or 190, 100, 320)
        SidebarWidth = W
        WindowInfo.SidebarWidth = W
        Sidebar.Size = UDim2.new(0, W, 1, -TitleH)
        Content.Position = UDim2.fromOffset(W, TitleH)
        Content.Size = UDim2.new(1, -W, 1, -TitleH)
    end

    function Window:SetCornerRadius(R)
        R = math.clamp(tonumber(R) or 12, 0, 28)
        WindowInfo.CornerRadius = R
        local function ApplyCorners(Inst, TL, TR, BL, BR)
            if not Inst then return end
            local C = Inst:FindFirstChildOfClass("UICorner")
            if not C then return end
            if TL ~= nil then
                C.TopLeftRadius = UDim.new(0, TL)
                C.TopRightRadius = UDim.new(0, TR)
                C.BottomLeftRadius = UDim.new(0, BL)
                C.BottomRightRadius = UDim.new(0, BR)
            else
                C.CornerRadius = UDim.new(0, R)
            end
        end
        ApplyCorners(Main)
        ApplyCorners(Wallpaper)
        ApplyCorners(TitleBar, R, R, 0, 0)
        ApplyCorners(Sidebar, 0, 0, R, 0)
    end

    function Window:SetMinimized(V)
        if Maximized then Window:SetMaximized(false) end
        Minimized = V
        if V then
            PreMinSize = Root.Size
            Tween(Root, { Size = UDim2.fromOffset(Root.Size.X.Offset, TitleH) }, Library.SlowTween)
        elseif PreMinSize then
            Tween(Root, { Size = PreMinSize }, Library.SlowTween)
        end
        if Window.Grip then Window.Grip.Visible = not V end
    end

    function Window:SetMaximized(V)
        if Minimized then Window:SetMinimized(false) end
        Maximized = V
        if V then
            PreMaxState = { Root.Size, Root.Position }
            local VS = ScreenGui.AbsoluteSize
            Tween(Root, { Size = UDim2.fromOffset((VS.X - 24) / Library.DPIScale, (VS.Y - 24) / Library.DPIScale), Position = UDim2.fromOffset(12, 12) }, Library.SlowTween)
        elseif PreMaxState then
            Tween(Root, { Size = PreMaxState[1], Position = PreMaxState[2] }, Library.SlowTween)
        end
    end

    function Window:Toggle(Value)
        if Library.Unloaded then return end
        if typeof(Value) == "boolean" then Library.Toggled = Value else Library.Toggled = not Library.Toggled end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
        if not Library.Toggled and Spot.Open then Spot.Hide() end
        Library:UpdateBlur()

        if Library.Toggled then
            Root.Visible = true
            MainScale.Scale = 0.94
            Tween(MainScale, { Scale = 1 }, Library.SlowTween)
        else
            TooltipLabel.Visible = false
            Tween(MainScale, { Scale = 0.94 }, Library.PopTween)
            task.delay(0.12, function()
                if not Library.Toggled then Root.Visible = false end
            end)
        end
        if WindowInfo.UnlockMouseWhileOpen then ModalElement.Modal = Library.Toggled end
    end

    --// Sections / Tabs
    local NextOrder = 0
    local CurrentSection
    Window.Sections = {}

    -- Window:AddSection("Name", { Collapsed = false, Collapsible = true }) -> tabs added after it belong to it
    function Window:AddSection(Name, Opt)
        Opt = Opt or {}
        NextOrder += 1
        local Section = { Name = Name, Tabs = {}, Collapsed = Opt.Collapsed == true, Collapsible = Opt.Collapsible ~= false }

        local Head = New("TextButton", { Size = UDim2.new(1, 0, 0, 26), LayoutOrder = NextOrder, Parent = TabsList })
        local Lbl = New("TextLabel", {
            Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -34, 1, -6), Text = tostring(Name):upper(), TextSize = 10, FontFace = "FontBold",
            TextColor3 = "SubText", TextXAlignment = Enum.TextXAlignment.Left, Parent = Head,
        })
        local Arrow = Glyph(Head, "chevron-down", "▾", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 2), Size = UDim2.fromOffset(12, 12), Visible = Section.Collapsible })
        if Section.Collapsed then Arrow.Rotation = -90 end

        function Section:Apply()
            for _, T in Section.Tabs do T:RefreshButton() end
        end
        function Section:SetCollapsed(V)
            if not Section.Collapsible then return end
            Section.Collapsed = V == true
            Tween(Arrow, { Rotation = Section.Collapsed and -90 or 0 }, Library.SlowTween)
            Section:Apply()
        end
        function Section:Toggle() Section:SetCollapsed(not Section.Collapsed) end

        if Section.Collapsible then
            Head.MouseEnter:Connect(function() Tween(Lbl, { TextColor3 = Library.Scheme.Text }) end)
            Head.MouseLeave:Connect(function() Tween(Lbl, { TextColor3 = Library.Scheme.SubText }) end)
            Head.MouseButton1Click:Connect(function() Section:Toggle() end)
        end

        CurrentSection = Section
        table.insert(Window.Sections, Section)
        return Section
    end

    function Window:AddTab(...)
        local Name, IconName, Description, Tooltip
        if select("#", ...) == 1 and typeof(...) == "table" then
            local I = ...
            Name, IconName, Description, Tooltip = I.Name or "Tab", I.Icon, I.Description, I.Tooltip
        else
            Name, IconName, Description = ...
        end
        Name = Name or "Tab"

        NextOrder += 1
        local Btn = New("TextButton", { BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = NextOrder, Parent = TabsList })
        Corner(Btn, 7)
        local Icon = Library:GetCustomIcon(IconName)
        local IconImg
        if Icon then
            IconImg = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 9, 0.5, 0), Size = UDim2.fromOffset(16, 16), ImageColor3 = Icon.Custom and "AccentText" or "Accent", Parent = Btn })
            Library:ApplyIcon(IconImg, Icon)
        end
        local BtnLabel = New("TextLabel", { Position = UDim2.fromOffset(Icon and 34 or 12, 0), Size = UDim2.new(1, Icon and -40 or -16, 1, 0), Text = Name, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Btn })

        local Container = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = Pages })

        local function MakeSide(Left)
            local S = New("ScrollingFrame", {
                AnchorPoint = Vector2.new(Left and 0 or 1, 0), Position = UDim2.fromScale(Left and 0 or 1, 0), Size = UDim2.fromScale(0.5, 1),
                CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, ScrollBarImageTransparency = 1, Parent = Container,
            })
            List(S, 12)
            Pad(S, 4, Left and 8 or 16, 18, Left and 16 or 8)
            return S
        end
        local SideLeft, SideRight = MakeSide(true), MakeSide(false)

        local Section = CurrentSection
        local Tab = {
            Name = Name, Section = Section, Description = Description, Button = Btn, Container = Container, Sides = { SideLeft, SideRight },
            Groupboxes = {}, Tabboxes = {}, TabVisible = true, Window = Window,
        }

        -- warning / info banner at the top of the page (Obsidian: Tab:UpdateWarningBox)
        local WarnHolder = New("Frame", { BackgroundColor3 = Color3.fromRGB(110, 20, 20), AutomaticSize = Enum.AutomaticSize.Y, Position = UDim2.fromOffset(16, 4), Size = UDim2.new(1, -32, 0, 0), Visible = false, Parent = Container })
        Corner(WarnHolder, 9)
        local WarnStroke = Stroke(WarnHolder, Color3.fromRGB(255, 69, 58), 1, 0.2)
        Pad(WarnHolder, 8, 12, 8, 12)
        List(WarnHolder, 2)
        local WarnTitle = New("TextLabel", { Size = UDim2.new(1, 0, 0, 16), Text = "", FontFace = "FontBold", TextColor3 = Color3.fromRGB(255, 120, 110), TextXAlignment = Enum.TextXAlignment.Left, Parent = WarnHolder })
        local WarnText = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = "", TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = WarnHolder })

        Tab.Pages = {}
        local PageBar

        -- A layout owns either two independent column scrolls, or (once a single groupbox is added)
        -- ONE shared scroll holding rows of two columns + full-width groupboxes.
        local function MakeLayout(L, R)
            local Layout = { L = L, R = R, Unified = false, Shown = true, Order = 0 }

            function Layout:GetScrolls()
                if Layout.Unified then return { Layout.Scroll } end
                return { L, R }
            end
            function Layout:SetVisible(V)
                Layout.Shown = V
                if Layout.Unified then Layout.Scroll.Visible = V else L.Visible = V; R.Visible = V end
            end
            function Layout:Place(Offset)
                if Layout.Unified then
                    Layout.Scroll.Position = UDim2.fromOffset(0, Offset)
                    Layout.Scroll.Size = UDim2.new(1, 0, 1, -Offset)
                else
                    L.Position = UDim2.fromOffset(0, Offset)
                    L.Size = UDim2.new(0.5, 0, 1, -Offset)
                    R.Position = UDim2.new(1, 0, 0, Offset)
                    R.Size = UDim2.new(0.5, 0, 1, -Offset)
                end
            end
            function Layout:NewRow()
                Layout.Order += 1
                local Row = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = Layout.Order, Parent = Layout.Scroll })
                local CL = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(0.5, -6, 0, 0), Parent = Row })
                List(CL, 12)
                local CR = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.5, -6, 0, 0), Parent = Row })
                List(CR, 12)
                Layout.Row = { CL, CR }
            end
            function Layout:Unify()
                if Layout.Unified then return end
                Layout.Unified = true
                local Scroll = New("ScrollingFrame", { AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(), Visible = Layout.Shown, Parent = L.Parent })
                List(Scroll, 12)
                Pad(Scroll, 4, 16, 18, 16)
                Layout.Scroll = Scroll

                local Has = false
                for _, C in { L, R } do
                    for _, Child in C:GetChildren() do
                        if Child:IsA("GuiObject") then Has = true end
                    end
                end
                if Has then
                    Layout:NewRow()
                    for _, Child in L:GetChildren() do if Child:IsA("GuiObject") then Child.Parent = Layout.Row[1] end end
                    for _, Child in R:GetChildren() do if Child:IsA("GuiObject") then Child.Parent = Layout.Row[2] end end
                end
                L.Visible, R.Visible = false, false

                if (Layout == Tab.Layout and not Tab.ActivePage) or (Tab.ActivePage and Tab.ActivePage.Layout == Layout) then
                    Tab.Sides = Layout:GetScrolls()
                end
                Tab:RefreshSides()
            end
            function Layout:Parent(Side, Single)
                if Single then
                    Layout:Unify()
                    Layout.Row = nil
                    Layout.Order += 1
                    return Layout.Scroll, Layout.Order
                end
                if not Layout.Unified then return Side == 2 and R or L end
                if not Layout.Row then Layout:NewRow() end
                return Layout.Row[Side == 2 and 2 or 1]
            end
            function Layout:Destroy()
                if Layout.Scroll then Layout.Scroll:Destroy() end
                L:Destroy()
                R:Destroy()
            end
            return Layout
        end
        Tab.Layout = MakeLayout(SideLeft, SideRight)

        function Tab:RefreshSides()
            local Offset = WarnHolder.Visible and (WarnHolder.AbsoluteSize.Y + 12) or 0
            if PageBar then
                PageBar.Position = UDim2.fromOffset(16, Offset + 4)
                Offset += 44
            end
            Tab.Layout:Place(Offset)
            for _, P in Tab.Pages do P.Layout:Place(Offset) end
        end

        function Tab:UpdateWarningBox(WInfo)
            WInfo = WInfo or {}
            if typeof(WInfo.Visible) == "boolean" then WarnHolder.Visible = WInfo.Visible end
            if typeof(WInfo.Title) == "string" then WarnTitle.Text = Library:ToRichText(WInfo.Title) end
            if typeof(WInfo.Text) == "string" then WarnText.Text = Library:ToRichText(WInfo.Text) end
            if typeof(WInfo.IsNormal) == "boolean" then
                WarnHolder.BackgroundColor3 = WInfo.IsNormal and Library.Scheme.Card or Color3.fromRGB(110, 20, 20)
                WarnStroke.Color = WInfo.IsNormal and Library.Scheme.Outline or Color3.fromRGB(255, 69, 58)
                WarnTitle.TextColor3 = WInfo.IsNormal and Library.Scheme.Text or Color3.fromRGB(255, 120, 110)
            end
            task.defer(function() Tab:RefreshSides() end)
        end

        -- Pages (sub tabs): Tab:AddPage("Name", "icon") returns an object with the same AddGroupbox / AddTabbox API
        function Tab:AddPage(PName, PIcon)
            if typeof(PName) == "table" then PIcon = PName.Icon; PName = PName.Name end
            PName = PName or "Page"

            if not PageBar then
                PageBar = New("Frame", { BackgroundColor3 = "Control", BackgroundTransparency = 0, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 30), Parent = Container })
                Corner(PageBar, 9)
                Pad(PageBar, 2, 2, 2, 2)
                List(PageBar, 2, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
                Tab.Layout:SetVisible(false)
            end

            local PL, PR = MakeSide(true), MakeSide(false)
            local PLayout = MakeLayout(PL, PR)
            PLayout:SetVisible(false)

            local PBtn = New("TextButton", { BackgroundColor3 = "Segment", BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Text = PName, TextColor3 = "SubText", LayoutOrder = #Tab.Pages + 1, Parent = PageBar })
            Corner(PBtn, 7)
            local PIconData = Library:GetCustomIcon(PIcon)
            local PIconImg
            if PIconData then
                Pad(PBtn, 0, 14, 0, 32)
                PIconImg = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -20, 0.5, 0), Size = UDim2.fromOffset(14, 14), ImageColor3 = "SubText", Parent = PBtn })
                Library:ApplyIcon(PIconImg, PIconData)
            else
                Pad(PBtn, 0, 14, 0, 14)
            end

            local Page = setmetatable({
                Type = "Page", Name = PName, Tab = Tab, Button = PBtn, PageSides = { PL, PR }, Layout = PLayout, Groupboxes = {}, Tabboxes = {},
            }, { __index = Tab })

            function Page:Show()
                if Tab.ActivePage == Page then return end
                if Tab.ActivePage then Tab.ActivePage:Hide() end
                Tab.ActivePage = Page
                PLayout:SetVisible(true)
                Tab.Sides = PLayout:GetScrolls()
                Tween(PBtn, { BackgroundTransparency = 0 })
                PBtn.TextColor3 = Library.Scheme.Text
                Bind(PBtn, "TextColor3", "Text")
                if PIconImg then PIconImg.ImageColor3 = Library.Scheme.Text; Bind(PIconImg, "ImageColor3", "Text") end
                Tab:RefreshSides()
            end
            function Page:Hide()
                PLayout:SetVisible(false)
                Tween(PBtn, { BackgroundTransparency = 1 })
                PBtn.TextColor3 = Library.Scheme.SubText
                Bind(PBtn, "TextColor3", "SubText")
                if PIconImg then PIconImg.ImageColor3 = Library.Scheme.SubText; Bind(PIconImg, "ImageColor3", "SubText") end
                if Tab.ActivePage == Page then Tab.ActivePage = nil end
            end
            function Page:SetVisible(V)
                PBtn.Visible = V
                if not V and Tab.ActivePage == Page then
                    Page:Hide()
                    for _, Other in Tab.Pages do
                        if Other ~= Page and Other.Button.Visible then Other:Show() break end
                    end
                end
            end
            function Page:Destroy()
                if Tab.ActivePage == Page then Tab.ActivePage = nil end
                PLayout:Destroy(); PBtn:Destroy()
                local I = table.find(Tab.Pages, Page)
                if I then table.remove(Tab.Pages, I) end
            end

            PBtn.MouseButton1Click:Connect(function() Page:Show() end)
            table.insert(Tab.Pages, Page)
            if not Tab.ActivePage then Page:Show() else Tab:RefreshSides() end
            return Page
        end

        function Tab:RefreshStyle(Hovering)
            local Sel = Library.ActiveTab == Tab
            if Sel then
                Tween(Btn, { BackgroundColor3 = Library.Scheme.Accent, BackgroundTransparency = 0 })
                Bind(Btn, "BackgroundColor3", "Accent")
                BtnLabel.TextColor3 = Library.Scheme.AccentText
                Bind(BtnLabel, "TextColor3", "AccentText")
                if IconImg then IconImg.ImageColor3 = Library.Scheme.AccentText; Bind(IconImg, "ImageColor3", "AccentText") end
            else
                Tween(Btn, { BackgroundColor3 = Library.Scheme.ControlHover, BackgroundTransparency = Hovering and 0.45 or 1 })
                Bind(Btn, "BackgroundColor3", "ControlHover")
                BtnLabel.TextColor3 = Library.Scheme.Text
                Bind(BtnLabel, "TextColor3", "Text")
                if IconImg then
                    local K = Icon.Custom and "AccentText" or "Accent"
                    IconImg.ImageColor3 = Library.Scheme[K]; Bind(IconImg, "ImageColor3", K)
                end
            end
        end

        function Tab:Show()
            if Library.ActiveTab == Tab then return end
            local Prev = Library.ActiveTab
            if Prev then Prev:Hide() end
            Library.ActiveTab = Tab
            if Tab.Section and Tab.Section.Collapsed then Tab.Section:SetCollapsed(false) end

            PageTitle.Text = Tab.Name
            PageDesc.Text = Library:ToRichText(Tab.Description or "")
            PageDesc.Visible = Tab.Description ~= nil and Tab.Description ~= ""

            Container.Visible = true
            Container.Position = UDim2.fromOffset(0, 12)
            Tween(Container, { Position = UDim2.fromOffset(0, 0) }, Library.SlowTween)
            Tab:RefreshStyle()
            if Library.Searching then Library:UpdateSearch(Library.SearchText) end
        end

        function Tab:Hide()
            Container.Visible = false
            if Library.ActiveTab == Tab then Library.ActiveTab = nil end
            Tab:RefreshStyle()
        end

        function Tab:RefreshButton()
            Btn.Visible = Tab.TabVisible ~= false and not (Tab.Section ~= nil and Tab.Section.Collapsed)
        end

        function Tab:SetVisible(V)
            Tab.TabVisible = V
            Tab:RefreshButton()
            if not V and Library.ActiveTab == Tab then Tab:Hide() end
        end

        function Tab:SetTooltip(T) if typeof(T) == "string" then Library:AddTooltip(T, Btn) end end

        function Tab:ResetSearch()
            Tab:RefreshButton()
            for _, G in Tab.Groupboxes do
                ResetBox(G)
                G.BoxHolder.Visible = G.Visible ~= false
            end
            for _, TB in Tab.Tabboxes do
                for _, ST in TB.Tabs do
                    ResetBox(ST)
                    ST.ButtonHolder.Visible = true
                end
                TB.BoxHolder.Visible = true
            end
            for _, P in Tab.Pages do P.Button.Visible = true end
        end

        function Tab:ApplySearch(S)
            local Any = false
            local TabMatch = Fuzzy(Tab.Name, S) or Fuzzy(Tab.Description, S)
            for _, G in Tab.Groupboxes do
                if G.Visible ~= false then
                    local Force = TabMatch or Fuzzy(G.Name, S) or Fuzzy(G.Description, S)
                    local C = ApplyBox(G, S, Force)
                    G.BoxHolder.Visible = C > 0
                    if C > 0 then Any = true end
                end
            end
            for _, TB in Tab.Tabboxes do
                local TotalVisible, FirstMatch, ActiveHas = 0, nil, false
                for _, ST in TB.Tabs do
                    local C = ApplyBox(ST, S, TabMatch or Fuzzy(ST.Name, S))
                    ST.ButtonHolder.Visible = C > 0
                    if C > 0 then
                        TotalVisible += 1
                        FirstMatch = FirstMatch or ST
                        if TB.ActiveTab == ST then ActiveHas = true end
                    end
                end
                TB.BoxHolder.Visible = TotalVisible > 0
                if TotalVisible > 0 then Any = true end
                if not ActiveHas and FirstMatch then FirstMatch:Show() end
            end
            if #Tab.Pages > 0 then
                local FirstP, ActiveHas
                for _, P in Tab.Pages do
                    local Has = false
                    for _, G in P.Groupboxes do
                        if G.BoxHolder.Visible then Has = true break end
                    end
                    if not Has then
                        for _, TB in P.Tabboxes do
                            if TB.BoxHolder.Visible then Has = true break end
                        end
                    end
                    P.Button.Visible = Has
                    if Has then
                        FirstP = FirstP or P
                        if Tab.ActivePage == P then ActiveHas = true end
                    end
                end
                if not ActiveHas and FirstP then FirstP:Show() end
            end
            return Any or TabMatch
        end

        --// Groupbox
        local function SideOf(Side, Owner)
            local Single = false
            if typeof(Side) == "string" then
                local L = Side:lower()
                if L == "single" or L == "full" or L == "both" then Single = true else Side = L == "right" and 2 or 1 end
            elseif Side == 0 or Side == 3 then
                Single = true
            end
            local Layout = (Owner and Owner.Layout) or Tab.Layout
            return Layout:Parent(Side, Single)
        end

        function Tab:AddGroupbox(Info)
            Info = Library:Validate(Info, Templates.Groupbox)

            local CardParent, CardOrder = SideOf(Info.Side, self)
            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = CardOrder or 0, Parent = CardParent })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
            Library:AddSurface(Card, 0, 0.85)
            Grad(Card, Two("Card", 0.035, -0.015), 90)
            List(Card, 0)

            local Head = New("TextButton", { Size = UDim2.new(1, 0, 0, 36), LayoutOrder = 1, Parent = Card })
            local BoxIcon = Library:GetCustomIcon(Info.IconName)
            if BoxIcon then
                local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(16, 16), ImageColor3 = BoxIcon.Custom and "AccentText" or "Accent", Parent = Head })
                Library:ApplyIcon(Img, BoxIcon)
            end
            New("TextLabel", { Position = UDim2.fromOffset(BoxIcon and 36 or 14, 0), Size = UDim2.new(1, -(BoxIcon and 60 or 40), 1, 0), Text = Info.Name, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Head })
            local Arrow = Glyph(Head, "chevron-down", "▾", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(14, 14), Visible = Info.DisableCollapsing ~= true })

            local Line = New("Frame", { BackgroundColor3 = "Outline", BackgroundTransparency = 0.5, Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 2, Parent = Card })
            local Body = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 3, Parent = Card })
            List(Body, 10)
            Pad(Body, 12, 12, 12, 12)

            local Groupbox = {
                Type = "Groupbox", Name = Info.Name, Description = Info.Description, Visible = true, Collapsed = false,
                BoxHolder = Card, Holder = Card, Container = Body, Tab = Tab, Elements = {}, DependencyBoxes = {}, Connections = {},
                Pinned = false, HomeParent = CardParent, HomeOrder = CardOrder or 0,
            }

            local Placeholder = New("TextButton", {
                BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 0, 36),
                LayoutOrder = CardOrder or 0, Visible = false, AutoButtonColor = false, Parent = CardParent,
            })
            Corner(Placeholder, 10)
            Stroke(Placeholder, "Outline", 1, 0.35)
            Library:AddSurface(Placeholder, 0, 0.85)
            Grad(Placeholder, Two("Card", 0.02, -0.01), 90)
            if BoxIcon then
                local PImg = New("ImageLabel", {
                    AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0),
                    Size = UDim2.fromOffset(16, 16), ImageColor3 = BoxIcon.Custom and "AccentText" or "Accent",
                    ImageTransparency = 0.35, Parent = Placeholder,
                })
                Library:ApplyIcon(PImg, BoxIcon)
            end
            New("TextLabel", {
                Position = UDim2.fromOffset(BoxIcon and 36 or 14, 0), Size = UDim2.new(1, -(BoxIcon and 70 or 50), 1, 0),
                Text = Info.Name, FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, TextTransparency = 0.35, Parent = Placeholder,
            })
            local PinHint = Glyph(Placeholder, "pin", "📌", {
                AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.fromOffset(14, 14), Color = "SubText",
            })
            GlyphTransparency(PinHint, 0.35)
            Groupbox.Placeholder = Placeholder

            local FloatScale
            function Groupbox:SetCollapsed(C)
                if Info.DisableCollapsing then return end
                Groupbox.Collapsed = C
                Body.Visible, Line.Visible = not C, not C
                Tween(Arrow, { Rotation = C and -90 or 0 }, Library.SlowTween)
            end
            function Groupbox:ToggleCollapsed() Groupbox:SetCollapsed(not Groupbox.Collapsed) end
            function Groupbox:SetVisible(V)
                Groupbox.Visible = V
                if Groupbox.Pinned then
                    Card.Visible = V
                    Placeholder.Visible = V
                else
                    Card.Visible = V
                end
                if V and Library.Searching then Library:UpdateSearch(Library.SearchText) end
            end
            function Groupbox:Show() Groupbox:SetVisible(true) end
            function Groupbox:Hide() Groupbox:SetVisible(false) end
            function Groupbox:Resize() end

            function Groupbox:Pin(AtPos)
                if Groupbox.Pinned or Groupbox.Destroyed then return end
                Groupbox.Pinned = true
                local AP = Card.AbsolutePosition
                local AS = Card.AbsoluteSize
                local Pos = AtPos or Vector2.new(AP.X, AP.Y)
                local W = math.max(AS.X, 260)

                Placeholder.LayoutOrder = Card.LayoutOrder
                Placeholder.Visible = true
                Card.Parent = Floats
                Card.Size = UDim2.fromOffset(W, 0)
                Card.AutomaticSize = Enum.AutomaticSize.Y
                Card.Position = UDim2.fromOffset(math.floor(Pos.X), math.floor(Pos.Y))
                Card.ZIndex = 40
                if not FloatScale then
                    FloatScale = New("UIScale", { Scale = Library.DPIScale, Parent = Card })
                    Library.DPIScales[FloatScale] = true
                end
                FloatScale.Scale = Library.DPIScale
                Library:Notify({ Title = Info.Name, Description = "Pinned — click the placeholder to restore", Time = 2.5, Icon = "pin" })
            end

            function Groupbox:Unpin()
                if not Groupbox.Pinned or Groupbox.Destroyed then return end
                Groupbox.Pinned = false
                Placeholder.Visible = false
                Card.Parent = Groupbox.HomeParent
                Card.LayoutOrder = Groupbox.HomeOrder
                Card.Size = UDim2.new(1, 0, 0, 0)
                Card.AutomaticSize = Enum.AutomaticSize.Y
                Card.Position = UDim2.new()
                Card.ZIndex = 1
                if FloatScale then
                    Library.DPIScales[FloatScale] = nil
                    FloatScale:Destroy()
                    FloatScale = nil
                end
            end

            function Groupbox:TogglePin()
                if Groupbox.Pinned then Groupbox:Unpin() else Groupbox:Pin() end
            end

            function Groupbox:Destroy()
                Groupbox.Destroyed = true
                if Groupbox.Pinned then Groupbox:Unpin() end
                for I = #Groupbox.Elements, 1, -1 do Groupbox.Elements[I]:Destroy() end
                Placeholder:Destroy()
                Card:Destroy()
                local I = table.find(Tab.Groupboxes, Groupbox)
                if I then table.remove(Tab.Groupboxes, I) end
            end

            local Dragging, DragMoved, DragStart, CardStart, DidPinDrag = false, false, nil, nil, false
            Head.InputBegan:Connect(function(Input)
                if not IsPress(Input) or Groupbox.Destroyed then return end
                Dragging, DragMoved, DidPinDrag = true, false, false
                DragStart = Input.Position
                CardStart = Groupbox.Pinned and Card.Position or nil
                local Conn
                Conn = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                        if Conn then Conn:Disconnect() end
                        if not DragMoved then
                            if not Groupbox.Pinned then Groupbox:ToggleCollapsed() end
                        elseif not Groupbox.Pinned and DidPinDrag then
                            local AP = Card.AbsolutePosition
                            Groupbox:Pin(Vector2.new(AP.X, AP.Y))
                        end
                    end
                end)
            end)
            Library:GiveSignal(UserInputService.InputChanged:Connect(function(Input)
                if not Dragging or Groupbox.Destroyed then return end
                if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
                local Delta = Input.Position - DragStart
                if not DragMoved and (math.abs(Delta.X) > 6 or math.abs(Delta.Y) > 6) then
                    DragMoved = true
                end
                if not DragMoved then return end

                if Groupbox.Pinned then
                    Card.Position = UDim2.fromOffset(CardStart.X.Offset + Delta.X, CardStart.Y.Offset + Delta.Y)
                else
                    local Win = Library.Window and Library.Window.MainFrame
                    local OverWin = Win and IsOver(Win, Vector2.new(Input.Position.X, Input.Position.Y))
                    if not OverWin or math.abs(Delta.X) > 40 or math.abs(Delta.Y) > 40 then
                        DidPinDrag = true
                        if not Groupbox.Pinned then
                            local AP = Card.AbsolutePosition
                            Groupbox:Pin(Vector2.new(AP.X + Delta.X, AP.Y + Delta.Y))
                            CardStart = Card.Position
                            DragStart = Input.Position
                        end
                    end
                end
            end))

            Placeholder.MouseButton1Click:Connect(function()
                Groupbox:Unpin()
            end)
            Library:AddTooltip("Click to restore groupbox", Placeholder)

            setmetatable(Groupbox, BaseGroupbox)
            table.insert(Tab.Groupboxes, Groupbox)
            if self.PageSides then table.insert(self.Groupboxes, Groupbox) end

            if Info.Visible == false then Groupbox:Hide() end
            if Info.Collapsed then Groupbox:SetCollapsed(true) end
            return Groupbox
        end

        function Tab:AddLeftGroupbox(Name, IconName, Visible, Collapsed)
            return self:AddGroupbox({ Side = 1, Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end
        function Tab:AddRightGroupbox(Name, IconName, Visible, Collapsed)
            return self:AddGroupbox({ Side = 2, Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end

        function Tab:AddSingleGroupbox(Name, IconName, Visible, Collapsed)
            return self:AddGroupbox({ Side = "Single", Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end

        --// Tabbox (macOS segmented control)
        function Tab:AddTabbox(Info)
            Info = Library:Validate(Info, Templates.Tabbox)
            local CardParent, CardOrder = SideOf(Info.Side, self)
            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = CardOrder or 0, Parent = CardParent })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
            Library:AddSurface(Card, 0, 0.85)
            Grad(Card, Two("Card", 0.035, -0.015), 90)
            List(Card, 0)

            local SegWrap = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 44), LayoutOrder = 1, Parent = Card })
            Pad(SegWrap, 9, 10, 9, 10)
            local Track = New("Frame", { BackgroundColor3 = "Control", Size = UDim2.fromScale(1, 1), Parent = SegWrap })
            Corner(Track, 8)
            Pad(Track, 2, 2, 2, 2)
            List(Track, 2, Enum.FillDirection.Horizontal)

            local Pagesbox = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 2, Parent = Card })
            List(Pagesbox, 0)

            local Tabbox = { Type = "Tabbox", BoxHolder = Card, Holder = Card, Tabs = {}, ActiveTab = nil, Visible = true, Destroyed = false }
            local Count = 0

            function Tabbox:AddTab(Name, IconName)
                Count += 1
                local Seg = New("TextButton", { BackgroundColor3 = "Segment", BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0), Parent = Track })
                Flex(Seg)
                Corner(Seg, 6)
                local Content_ = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.X, Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(0, 16), Parent = Seg })
                List(Content_, 6, Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
                local SegIcon = Library:GetCustomIcon(IconName)
                local SegIconImg
                if SegIcon then
                    SegIconImg = New("ImageLabel", { Size = UDim2.fromOffset(14, 14), ImageColor3 = "SubText", Parent = Content_ })
                    Library:ApplyIcon(SegIconImg, SegIcon)
                end
                local SegLabel
                if Name and Trim(Name) ~= "" then
                    SegLabel = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 16), Text = Name, TextSize = 12, TextColor3 = "SubText", Parent = Content_ })
                end

                local Page = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = false, Parent = Pagesbox })
                List(Page, 10)
                Pad(Page, 4, 12, 12, 12)

                local SubTab = {
                    Type = "SubTab", Name = Name, ButtonHolder = Seg, Container = Page, Tab = Tab, Tabbox = Tabbox,
                    Elements = {}, DependencyBoxes = {}, Connections = {},
                }

                function SubTab:Show()
                    if Tabbox.ActiveTab then Tabbox.ActiveTab:Hide() end
                    Tabbox.ActiveTab = SubTab
                    Page.Visible = true
                    Tween(Seg, { BackgroundTransparency = 0 })
                    if SegLabel then Tween(SegLabel, { TextColor3 = Library.Scheme.Text }) end
                    if SegIconImg then Tween(SegIconImg, { ImageColor3 = Library.Scheme.Text }) end
                end
                function SubTab:Hide()
                    Page.Visible = false
                    Tween(Seg, { BackgroundTransparency = 1 })
                    if SegLabel then Tween(SegLabel, { TextColor3 = Library.Scheme.SubText }) end
                    if SegIconImg then Tween(SegIconImg, { ImageColor3 = Library.Scheme.SubText }) end
                    if Tabbox.ActiveTab == SubTab then Tabbox.ActiveTab = nil end
                end
                function SubTab:Resize() end
                function SubTab:Destroy()
                    Library.ThemeHooks[SubTab] = nil
                    for I = #SubTab.Elements, 1, -1 do SubTab.Elements[I]:Destroy() end
                    Page:Destroy()
                    Seg:Destroy()
                end

                Library.ThemeHooks[SubTab] = function()
                    local C = Tabbox.ActiveTab == SubTab and Library.Scheme.Text or Library.Scheme.SubText
                    if SegLabel then SegLabel.TextColor3 = C end
                    if SegIconImg then SegIconImg.ImageColor3 = C end
                end
                Seg.MouseButton1Click:Connect(function() SubTab:Show() end)
                setmetatable(SubTab, BaseGroupbox)
                local Key = (Name and Trim(Name) ~= "") and Name or tostring(Count)
                Tabbox.Tabs[Key] = SubTab
                if not Tabbox.ActiveTab then SubTab:Show() end
                return SubTab, Key
            end

            function Tabbox:Resize() end
            function Tabbox:SetVisible(V) Tabbox.Visible = V; Card.Visible = V end
            function Tabbox:Destroy()
                Tabbox.Destroyed = true
                for _, ST in Tabbox.Tabs do ST:Destroy() end
                Card:Destroy()
            end

            if Info.Name then Tab.Tabboxes[Info.Name] = Tabbox else table.insert(Tab.Tabboxes, Tabbox) end
            if self.PageSides then table.insert(self.Tabboxes, Tabbox) end
            return Tabbox
        end
        function Tab:AddLeftTabbox(Name) return self:AddTabbox({ Side = 1, Name = Name }) end
        function Tab:AddRightTabbox(Name) return self:AddTabbox({ Side = 2, Name = Name }) end

        function Tab:Destroy()
            for _, G in Tab.Groupboxes do G:Destroy() end
            for _, TB in Tab.Tabboxes do TB:Destroy() end
            if Library.ActiveTab == Tab then Library.ActiveTab = nil end
            Container:Destroy()
            Btn:Destroy()
            Library.Tabs[Name] = nil
            local I = table.find(Library.TabList, Tab)
            if I then table.remove(Library.TabList, I) end
        end

        Btn.MouseEnter:Connect(function() if Library.ActiveTab ~= Tab then Tab:RefreshStyle(true) end end)
        Btn.MouseLeave:Connect(function() if Library.ActiveTab ~= Tab then Tab:RefreshStyle(false) end end)
        Btn.MouseButton1Click:Connect(function() Tab:Show() end)
        if typeof(Tooltip) == "string" then Tab:SetTooltip(Tooltip) end

        Library.Tabs[Name] = Tab
        table.insert(Library.TabList, Tab)
        if Section then table.insert(Section.Tabs, Tab) end
        Tab:RefreshButton()
        Tab:RefreshStyle()
        if not Library.ActiveTab then Tab:Show() end
        return Tab
    end

    --// Key tab (centered page with a key box, like Obsidian)
    function Window:AddKeyTab(...)
        local Info = ...
        local Name, IconName, Description
        if typeof(Info) == "table" then
            Name, IconName, Description = Info.Name or "Key", Info.Icon, Info.Description
        else
            Name, IconName, Description = ...
        end
        local Tab = Window:AddTab({ Name = Name or "Key", Icon = IconName or "key", Description = Description })
        Tab.IsKeyTab = true
        Tab.Layout:SetVisible(false)

        local Body = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(0.7, 0, 0, 0), Parent = Tab.Container })
        List(Body, 10)
        Tab.Container = Body
        Tab.Elements, Tab.DependencyBoxes, Tab.Tab = {}, {}, Tab

        function Tab:AddKeyBox(Callback)
            local Row = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Parent = Body })
            List(Row, 8, Enum.FillDirection.Horizontal)
            local Box = New("TextBox", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), PlaceholderText = "Key", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Parent = Row })
            Flex(Box)
            Corner(Box, 7)
            Pad(Box, 0, 10, 0, 10)
            Stroke(Box, "Outline", 1, 0.4)
            local Btn = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 0, Size = UDim2.fromOffset(80, 30), Text = "Submit", TextColor3 = "AccentText", FontFace = "FontBold", Parent = Row })
            Corner(Btn, 7)
            Btn.MouseButton1Click:Connect(function() Library:SafeCallback(Callback, Box.Text) end)
            return Box
        end

        setmetatable(Tab, BaseGroupbox)
        return Tab
    end

    --// Sheet dialog (macOS alert sheet attached to the window)
    function Window:AddDialog(Idx, Info)
        Info = Library:Validate(Info, Templates.Dialog)

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 50, Parent = Main })
        Corner(Dim, WindowInfo.CornerRadius)
        Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)

        local Sheet = New("Frame", {
            BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0.5, 0, 0, TitleH - 24), Size = UDim2.fromOffset(340, 0), ZIndex = 51, Parent = Dim,
        })
        Corner(Sheet, 12)
        Library:AddSurface(Sheet, 0, 0.5)
        Stroke(Sheet, "Outline", 1, 0.2)
        Tween(Sheet, { Position = UDim2.new(0.5, 0, 0, TitleH + 8) }, Library.SlowTween)

        local Inner = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), ZIndex = 52, Parent = Sheet })
        List(Inner, 10, nil, Enum.HorizontalAlignment.Center)
        Pad(Inner, 18, 18, 16, 18)

        local Badge = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.fromOffset(48, 48), LayoutOrder = 1, ZIndex = 52, Parent = Inner })
        Corner(Badge, 12)
        local DIcon = Library:GetCustomIcon(Info.Icon or "leaf")
        if DIcon then
            local Img = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(28, 28), ImageColor3 = "AccentText", ZIndex = 53, Parent = Badge })
            Library:ApplyIcon(Img, DIcon)
        end
        local DTitle = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = Library:ToRichText(Info.Title), FontFace = "FontBold", TextSize = 15, TextWrapped = true, LayoutOrder = 2, ZIndex = 52, Parent = Inner })
        local DDesc = Library:RenderRich(Inner, Info.Description, { Size = 12, Color = "SubText", Align = "Center", LayoutOrder = 3, Visible = Info.Description ~= "" })
        local DContainer = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 4, ZIndex = 52, Parent = Inner })
        List(DContainer, 8)
        local BtnRow = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 5, ZIndex = 52, Parent = Inner })
        List(BtnRow, 8, Enum.FillDirection.Horizontal)

        local Dialog = { Destroyed = false, Container = DContainer, Elements = {}, DependencyBoxes = {}, OutsideClickDismiss = Info.OutsideClickDismiss }

        function Dialog:SetTitle(T) DTitle.Text = Library:ToRichText(T) end
        function Dialog:SetDescription(T) DDesc:SetText(T); DDesc.Host.Visible = T ~= "" end
        function Dialog:Dismiss()
            if Dialog.Destroyed then return end
            Dialog.Destroyed = true
            if Library.ActiveDialog == Dialog then Library.ActiveDialog = nil end
            for I = #Dialog.Elements, 1, -1 do Dialog.Elements[I]:Destroy() end
            Tween(Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
            Tween(Sheet, { Position = UDim2.new(0.5, 0, 0, TitleH - 24) }, Library.TweenInfo)
            task.delay(0.2, function() Dim:Destroy() end)
            Library.Dialogues = Library.Dialogues or {}
            Library.Dialogues[Idx] = nil
        end
        function Dialog:AddFooterButton(_, BInfo)
            local Variant = BInfo.Variant or "Secondary"
            local Key = Variant == "Primary" and "Accent" or Variant == "Destructive" and "Red" or "Control"
            local B = New("TextButton", { BackgroundColor3 = Key, BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), Text = BInfo.Title or "OK", TextColor3 = (Variant == "Secondary") and "Text" or "AccentText", FontFace = Variant == "Primary" and "FontBold" or "Font", LayoutOrder = BInfo.Order or 0, ZIndex = 53, Parent = BtnRow })
            Flex(B)
            Corner(B, 7)
            New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78)), Parent = B })
            B.MouseEnter:Connect(function() Tween(B, { BackgroundColor3 = Lighten(Library.Scheme[Key], Variant == "Secondary" and 0.04 or 0.07) }) end)
            B.MouseLeave:Connect(function() Tween(B, { BackgroundColor3 = Library.Scheme[Key] }) end)
            B.MouseButton1Click:Connect(function()
                if BInfo.Callback then Library:SafeCallback(BInfo.Callback, Dialog) end
                if Info.AutoDismiss then Dialog:Dismiss() end
            end)
        end

        Dim.MouseButton1Click:Connect(function()
            if Info.OutsideClickDismiss then Dialog:Dismiss() end
        end)

        for I, BInfo in Info.FooterButtons do Dialog:AddFooterButton(BInfo.Id or I, BInfo) end
        BtnRow.Visible = #Info.FooterButtons > 0

        setmetatable(Dialog, BaseGroupbox)
        Library.Dialogues = Library.Dialogues or {}
        Library.Dialogues[Idx] = Dialog
        Library.ActiveDialog = Dialog
        return Dialog
    end

    --// Input / toggle keybind
    Library:GiveSignal(UserInputService.InputBegan:Connect(function(Input)
        if Library.Unloaded then return end
        if Input.KeyCode == Enum.KeyCode.Escape then
            if UserInputService:GetFocusedTextBox() then return end
            if Library.ActiveDialog and Library.ActiveDialog.OutsideClickDismiss ~= false then
                Library.ActiveDialog:Dismiss()
            end
            return
        end
        if UserInputService:GetFocusedTextBox() or Library.IsPicking then return end
        if typeof(Library.ToggleKeybind) == "EnumItem" and Input.KeyCode == Library.ToggleKeybind then
            Window:Toggle()
        end
    end))

    --// Mobile toggle button
    if Library.IsMobile and WindowInfo.ShowMobileButton then
        local MB = New("TextButton", { BackgroundColor3 = "Card", BackgroundTransparency = 0, Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(88, 34), Text = "Evergreen", Parent = Floats })
        Corner(MB, 99)
        Stroke(MB, "Accent", 1.5, 0)
        Library:MakeDraggable(MB, MB)
        MB.MouseButton1Click:Connect(function() Window:Toggle() end)
    end

    Library.Window = Window
    if WindowInfo.DPIScale ~= 100 then Library:SetDPIScale(WindowInfo.DPIScale) end
    if WindowInfo.Transparency > 0 then Library:SetTransparency(WindowInfo.Transparency) end
    if WindowInfo.Blur then Library:SetBlur(true, WindowInfo.BlurSize) end
    if WindowInfo.Glass then Library:SetGlass(true) end
    if WindowInfo.AutoShow then task.defer(function() Window:Toggle(true) end) end
    return Window
end

--// Draggable label (watermark / FPS pill) \\--
Library.DraggableLabels = {}
function Library:AddDraggableLabel(Text)
    local Holder = New("Frame", {
        BackgroundColor3 = "Popup", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 28),
        Position = UDim2.fromOffset(12, 12 + #Library.DraggableLabels * 36), Parent = Floats,
    })
    Corner(Holder, 99)
    Stroke(Holder, "Outline", 1, 0.25)
    Pad(Holder, 0, 14, 0, 28)
    Library.DPIScales[New("UIScale", { Scale = Library.DPIScale, Parent = Holder })] = true
    local Dot = New("Frame", { BackgroundColor3 = "Accent", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -16, 0.5, 0), Size = UDim2.fromOffset(8, 8), Parent = Holder })
    Corner(Dot, 99)
    local Label = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 28), Text = Text or "", TextSize = 12, Parent = Holder })
    Library:MakeDraggable(Holder, Holder)

    local Obj = { Holder = Holder, Label = Label }
    table.insert(Library.DraggableLabels, Obj)
    function Obj:SetText(T) Label.Text = tostring(T) end
    function Obj:SetVisible(V) Holder.Visible = V end
    function Obj:Destroy()
        local I = table.find(Library.DraggableLabels, Obj)
        if I then table.remove(Library.DraggableLabels, I) end
        Holder:Destroy()
    end
    return Obj
end

--// Loading screen (macOS-style progress window) \\--
function Library:CreateLoading(Info)
    if Library.ActiveLoading then return Library.ActiveLoading end
    Info = Library:Validate(Info, { Title = "Evergreen", Icon = "leaf", Message = "Loading...", Description = "", CurrentStep = 0, TotalSteps = 10 })

    local Gui = New("ScreenGui", { Name = "EvergreenLoading", DisplayOrder = 999, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
    pcall(protectgui, Gui)
    if not pcall(function() Gui.Parent = gethui() end) or not Gui.Parent then
        Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local Loading = { Destroyed = false, CurrentStep = Info.CurrentStep, TotalSteps = math.max(1, Info.TotalSteps), ScreenGui = Gui }
    local Main = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(380, 230), Parent = Gui })
    Corner(Main, 14)
    Stroke(Main, "Outline", 1, 0.25)
    Grad(Main, Two("Window", 0.05, -0.015), 125)
    Library:MakeDraggable(Main, Main, true)

    New("TextLabel", { Size = UDim2.new(1, 0, 0, 32), Text = Info.Title, FontFace = "FontBold", TextSize = 12, TextColor3 = "SubText", Parent = Main })

    local Content = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 1, -32), Parent = Main })
    List(Content, 8, nil, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)

    local Badge = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.fromOffset(54, 54), LayoutOrder = 1, Parent = Content })
    Corner(Badge, 14)
    local Spin
    local SpinIcon = Library:GetIcon("loader-circle") or Library:GetIcon("loader")
    if SpinIcon then
        Spin = New("ImageLabel", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(30, 30), ImageColor3 = "AccentText", Parent = Badge })
        Library:ApplyIcon(Spin, SpinIcon)
    else
        Spin = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = "◐", TextSize = 28, TextColor3 = "AccentText", Parent = Badge })
    end
    local SpinTween = TweenService:Create(Spin, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Rotation = 360 })
    SpinTween:Play()

    local Message = New("TextLabel", { Size = UDim2.new(1, -40, 0, 20), Text = Info.Message, FontFace = "FontBold", TextSize = 15, LayoutOrder = 2, Parent = Content })
    local Desc = New("TextLabel", { Size = UDim2.new(1, -40, 0, 16), Text = Info.Description, TextSize = 12, TextColor3 = "SubText", LayoutOrder = 3, Parent = Content })
    local Bar = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, Size = UDim2.new(0.8, 0, 0, 8), LayoutOrder = 4, Parent = Content })
    Corner(Bar, 99)
    local FillBar = New("Frame", { BackgroundColor3 = "Accent", Size = UDim2.fromScale(0, 1), Parent = Bar })
    Corner(FillBar, 99)
    local StepLabel = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = "", TextSize = 11, TextColor3 = "SubText", LayoutOrder = 5, Parent = Content })

    local ErrorFrame = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 32), Size = UDim2.new(1, 0, 1, -32), Visible = false, Parent = Main })
    List(ErrorFrame, 8, nil, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    New("TextLabel", { Size = UDim2.new(1, -40, 0, 20), Text = "Something went wrong", FontFace = "FontBold", TextSize = 15, TextColor3 = "Red", LayoutOrder = 1, Parent = ErrorFrame })
    local ErrorText = New("TextLabel", { Size = UDim2.new(1, -40, 0, 70), Text = "", TextSize = 12, TextColor3 = "SubText", TextWrapped = true, LayoutOrder = 2, Parent = ErrorFrame })
    local ErrorButtons = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, -40, 0, 30), LayoutOrder = 3, Parent = ErrorFrame })
    List(ErrorButtons, 8, Enum.FillDirection.Horizontal)

    function Loading:SetMessage(T) Message.Text = tostring(T) end
    function Loading:SetDescription(T) Desc.Text = tostring(T) end
    function Loading:SetCurrentStep(N)
        Loading.CurrentStep = math.clamp(N, 0, Loading.TotalSteps)
        Tween(FillBar, { Size = UDim2.fromScale(Loading.CurrentStep / Loading.TotalSteps, 1) }, Library.SlowTween)
        StepLabel.Text = string.format("%d / %d", Loading.CurrentStep, Loading.TotalSteps)
    end
    function Loading:SetTotalSteps(N) Loading.TotalSteps = math.max(1, N); Loading:SetCurrentStep(Loading.CurrentStep) end

    function Loading:ShowError(Text, Buttons)
        Content.Visible, ErrorFrame.Visible = false, true
        ErrorText.Text = tostring(Text)
        for _, C in ErrorButtons:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end
        for _, B in Buttons or { { Title = "Close", Variant = "Secondary", Callback = function() Loading:Destroy() end } } do
            local Variant = B.Variant or "Secondary"
            local Key = Variant == "Primary" and "Accent" or Variant == "Destructive" and "Red" or "Control"
            local Btn = New("TextButton", { BackgroundColor3 = Key, BackgroundTransparency = 0, Size = UDim2.new(0, 0, 1, 0), Text = B.Title or "OK", TextColor3 = Variant == "Secondary" and "Text" or "AccentText", Parent = ErrorButtons })
            Flex(Btn)
            Corner(Btn, 7)
            Btn.MouseButton1Click:Connect(function() Library:SafeCallback(B.Callback, Loading) end)
        end
    end
    function Loading:HideError() Content.Visible, ErrorFrame.Visible = true, false end

    function Loading:Destroy()
        if Loading.Destroyed then return end
        Loading.Destroyed = true
        pcall(function() SpinTween:Cancel() end)
        Gui:Destroy()
        Library.ActiveLoading = nil
    end
    Loading.Continue = Loading.Destroy

    Loading:SetCurrentStep(Loading.CurrentStep)
    Library.ActiveLoading = Loading
    return Loading
end

--// Save manager (configs) \\--
local HttpService = GetService("HttpService")
local SaveManager = { Folder = "Evergreen", Ignore = {} }
Library.SaveManager = SaveManager

local function HasFS()
    return (writefile and readfile and isfile and isfolder and makefolder and listfiles) and true or false
end
local function EnsureFolders()
    if not HasFS() then return false end
    for _, Path in { SaveManager.Folder, SaveManager.Folder .. "/configs" } do
        if not isfolder(Path) then makefolder(Path) end
    end
    return true
end

function SaveManager:SetFolder(Folder) SaveManager.Folder = Folder; EnsureFolders() end
function SaveManager:SetIgnoreIndexes(L) for _, I in L do SaveManager.Ignore[I] = true end end

local function Skip(Idx)
    return typeof(Idx) ~= "string" or SaveManager.Ignore[Idx] or Idx:find("^EvergreenCfg") ~= nil
end

function SaveManager:Serialize()
    local Data = { toggles = {}, options = {} }
    for Idx, E in Toggles do
        if not Skip(Idx) then Data.toggles[Idx] = { value = E.Value } end
    end
    for Idx, E in Options do
        if not Skip(Idx) then
            local T = E.Type
            if T == "Slider" or T == "Input" then
                Data.options[Idx] = { type = T, value = E.Value }
            elseif T == "RangeSlider" then
                Data.options[Idx] = { type = T, value = { E.ValueMin, E.ValueMax } }
            elseif (T == "Dropdown" or T == "List") and not E.SpecialType then
                if E.Multi then
                    local L = {}
                    for K in E.Value do
                        if typeof(K) == "string" or typeof(K) == "number" then table.insert(L, K) end
                    end
                    Data.options[Idx] = { type = T, value = L }
                else
                    Data.options[Idx] = { type = T, value = E.Value }
                end
            elseif T == "KeyPicker" then
                Data.options[Idx] = { type = T, key = E.Value, mode = E.Mode }
            elseif T == "ColorPicker" then
                Data.options[Idx] = { type = T, hex = E.Value:ToHex(), alpha = E.Transparency }
            end
        end
    end
    return Data
end

function SaveManager:Apply(Data)
    for Idx, D in Data.toggles or {} do
        local E = Toggles[Idx]
        if E and not Skip(Idx) then pcall(E.SetValue, E, D.value) end
    end
    for Idx, D in Data.options or {} do
        local E = Options[Idx]
        if E and E.Type == D.type and not Skip(Idx) then
            if D.type == "ColorPicker" then
                pcall(function() E:SetValueRGB(Color3.fromHex(D.hex), D.alpha) end)
            elseif D.type == "KeyPicker" then
                pcall(E.SetValue, E, { D.key, D.mode })
            elseif D.type == "RangeSlider" then
                pcall(E.SetValue, E, D.value)
            else
                pcall(E.SetValue, E, D.value)
            end
        end
    end
end

function SaveManager:Path(Name) return string.format("%s/configs/%s.json", SaveManager.Folder, Name) end

function SaveManager:Save(Name)
    if not Name or Trim(Name) == "" then return false, "Config name is empty." end
    if not EnsureFolders() then return false, "Executor has no file functions." end
    local Ok, Err = pcall(function() writefile(SaveManager:Path(Name), HttpService:JSONEncode(SaveManager:Serialize())) end)
    return Ok, Err
end

function SaveManager:Load(Name)
    if not Name or Name == "" then return false, "No config selected." end
    if not HasFS() or not isfile(SaveManager:Path(Name)) then return false, "Config does not exist." end
    local Ok, Data = pcall(function() return HttpService:JSONDecode(readfile(SaveManager:Path(Name))) end)
    if not Ok then return false, "Invalid config file." end
    SaveManager:Apply(Data)
    return true
end

function SaveManager:Delete(Name)
    if not HasFS() or not isfile(SaveManager:Path(Name)) then return false, "Config does not exist." end
    return pcall(delfile, SaveManager:Path(Name))
end

function SaveManager:List()
    local Out = {}
    if not EnsureFolders() then return Out end
    for _, File in listfiles(SaveManager.Folder .. "/configs") do
        local Name = File:match("([^/\\]+)%.json$")
        if Name then table.insert(Out, Name) end
    end
    table.sort(Out)
    return Out
end

function SaveManager:SetAutoload(Name)
    if not EnsureFolders() then return false end
    writefile(SaveManager.Folder .. "/autoload.txt", Name or "")
    return true
end
function SaveManager:GetAutoload()
    if HasFS() and isfile(SaveManager.Folder .. "/autoload.txt") then
        local N = Trim(readfile(SaveManager.Folder .. "/autoload.txt"))
        if N ~= "" then return N end
    end
    return nil
end
function SaveManager:LoadAutoload()
    local N = SaveManager:GetAutoload()
    if not N then return false end
    local Ok, Err = SaveManager:Load(N)
    if Ok then
        Library:Notify({ Title = "Config", Description = "Autoloaded '" .. N .. "'", Time = 3, Icon = "save" })
    else
        Library:Notify({ Title = "Config", Description = tostring(Err), Time = 4 })
    end
    return Ok
end

-- Builds a ready-made configuration groupbox on a tab (or a page).
function SaveManager:BuildConfigSection(Tab, Side)
    local Box = Tab:AddGroupbox({ Side = Side or 2, Name = "Configuration", IconName = "save" })
    if not EnsureFolders() then
        Box:AddLabel({ Text = "Your executor does not support file functions (writefile / listfiles).", DoesWrap = true })
        return Box
    end

    local function Msg(Ok, Text, Err)
        Library:Notify({ Title = "Config", Description = Ok and Text or tostring(Err), Time = 3, Icon = "save" })
    end

    Box:AddInput("EvergreenCfgName", { Text = "Config name", Placeholder = "my-config" })
    local Dropdown = Box:AddDropdown("EvergreenCfgList", { Text = "Configs", Values = SaveManager:List(), AllowNull = true })
    local AutoLabel = Box:AddLabel("Autoload: " .. (SaveManager:GetAutoload() or "none"))

    local function Refresh() Dropdown:SetValues(SaveManager:List()); Dropdown:SetValue(nil) end

    Box:AddButton({ Text = "Create", Callback = function()
        local Name = Options.EvergreenCfgName.Value
        local Ok, Err = SaveManager:Save(Name)
        Msg(Ok, "Created '" .. tostring(Name) .. "'", Err)
        if Ok then Refresh() end
    end }):AddButton({ Text = "Load", Primary = true, Callback = function()
        local Ok, Err = SaveManager:Load(Dropdown.Value)
        Msg(Ok, "Loaded '" .. tostring(Dropdown.Value) .. "'", Err)
    end })

    Box:AddButton({ Text = "Overwrite", DoubleClick = true, Callback = function()
        local Ok, Err = SaveManager:Save(Dropdown.Value)
        Msg(Ok, "Saved '" .. tostring(Dropdown.Value) .. "'", Err)
    end }):AddButton({ Text = "Delete", Risky = true, DoubleClick = true, Callback = function()
        local Name = Dropdown.Value
        local Ok, Err = SaveManager:Delete(Name)
        Msg(Ok, "Deleted '" .. tostring(Name) .. "'", Err)
        if Ok then Refresh() end
    end })

    Box:AddButton({ Text = "Refresh", Callback = Refresh }):AddButton({ Text = "Set autoload", Callback = function()
        if not Dropdown.Value then return Msg(false, "", "Select a config first.") end
        SaveManager:SetAutoload(Dropdown.Value)
        AutoLabel:SetText("Autoload: " .. Dropdown.Value)
        Msg(true, "Autoload set to '" .. Dropdown.Value .. "'")
    end })

    return Box
end

--// Interface section (theme, accent, scale, menu key) \\--
-- Full UI settings: theme, colors, layout, effects, behavior.
-- Call on a tab: Library:BuildInterfaceSection(Tab)  or  Library:BuildSettingsTab(Window)
function Library:BuildInterfaceSection(Tab, Side)
    local Names = {}
    for N in Themes do table.insert(Names, N) end
    table.sort(Names)

    local function SyncAccentPicker()
        local P = Options.EvergreenAccent
        if P then P:SetValueRGB(Library.Scheme.Accent) end
    end
    local function SyncSchemePickers()
        local Keys = { "Window", "Sidebar", "Titlebar", "Card", "Control", "Text", "SubText", "Outline", "Track", "Popup" }
        for _, K in Keys do
            local P = Options["EvergreenScheme_" .. K]
            if P and typeof(Library.Scheme[K]) == "Color3" then pcall(P.SetValueRGB, P, Library.Scheme[K]) end
        end
        SyncAccentPicker()
    end

    --// Appearance
    local Appear = Tab:AddGroupbox({ Side = Side or 1, Name = "Appearance", IconName = "palette" })
    Appear:AddDropdown("EvergreenTheme", {
        Text = "Theme", Values = Names, Default = Library.ThemeName or "Dark",
        Callback = function(V)
            if not V then return end
            Library:SetTheme(V)
            SyncSchemePickers()
        end,
    })
    Appear:AddLabel("Accent"):AddColorPicker("EvergreenAccent", {
        Default = Library.Scheme.Accent, Title = "Accent",
        Callback = function(C)
            if C:ToHex() ~= Library.Scheme.Accent:ToHex() then Library:SetAccent(C) end
        end,
    })
    Appear:AddButton({ Text = "Reset accent", Callback = function()
        Library:ResetAccent()
        SyncAccentPicker()
    end }):AddButton({ Text = "Reset theme", Callback = function()
        Library:ResetAccent()
        Library:SetTheme(Library.ThemeName or "Dark")
        SyncSchemePickers()
    end })

    --// Custom colors (override any scheme key live)
    local Colors = Tab:AddGroupbox({ Side = Side or 1, Name = "Custom colors", IconName = "pipette" })
    Colors:AddLabel({ Text = "Tweaks apply on top of the current theme.", DoesWrap = true })
    local SchemeKeys = {
        { "Window", "Window" }, { "Sidebar", "Sidebar" }, { "Titlebar", "Title bar" },
        { "Card", "Card" }, { "Control", "Control" }, { "Popup", "Popup" },
        { "Track", "Track" }, { "Outline", "Outline" },
        { "Text", "Text" }, { "SubText", "Sub text" },
    }
    for _, Pair in SchemeKeys do
        local Key, Label = Pair[1], Pair[2]
        Colors:AddLabel(Label):AddColorPicker("EvergreenScheme_" .. Key, {
            Default = typeof(Library.Scheme[Key]) == "Color3" and Library.Scheme[Key] or Color3.new(1, 1, 1),
            Title = Label,
            Callback = function(C)
                Library:SetTheme({ [Key] = C })
            end,
        })
    end

    --// Layout
    local Layout = Tab:AddGroupbox({ Side = (Side == 1 and 2) or (Side == 2 and 1) or 2, Name = "Layout", IconName = "layout" })
    Layout:AddSlider("EvergreenScale", {
        Text = "UI scale", Min = 50, Max = 150, Default = math.floor(Library.DPIScale * 100 + 0.5), Rounding = 0, Suffix = "%",
        Deferred = true, Callback = function(V) Library:SetDPIScale(V) end,
    })
    Layout:AddSlider("EvergreenSidebarWidth", {
        Text = "Sidebar width", Min = 120, Max = 280,
        Default = (Library.Window and Library.Window.Info and Library.Window.Info.SidebarWidth) or 190,
        Rounding = 0, Suffix = "px", Deferred = true,
        Callback = function(V)
            if Library.Window and Library.Window.SetSidebarWidth then Library.Window:SetSidebarWidth(V) end
        end,
    })
    Layout:AddSlider("EvergreenCorner", {
        Text = "Corner radius", Min = 0, Max = 24,
        Default = (Library.Window and Library.Window.Info and Library.Window.Info.CornerRadius) or 12,
        Rounding = 0, Suffix = "px", Deferred = true,
        Callback = function(V)
            if Library.Window and Library.Window.SetCornerRadius then Library.Window:SetCornerRadius(V) end
        end,
    })

    --// Effects
    local Effects = Tab:AddGroupbox({ Side = (Side == 1 and 2) or (Side == 2 and 1) or 2, Name = "Effects", IconName = "sparkles" })
    Effects:AddSlider("EvergreenTransparency", {
        Text = "UI transparency", Min = 0, Max = 80, Default = math.floor(Library.UITransparency * 100 + 0.5), Rounding = 0, Suffix = "%",
        Callback = function(V) Library:SetTransparency(V / 100) end,
    })
    Effects:AddToggle("EvergreenGlass", { Text = "Glass material", Default = Library.GlassEnabled == true, Callback = function(V) Library:SetGlass(V) end })
    Effects:AddToggle("EvergreenBlur", { Text = "Blur behind UI", Default = Library.BlurEnabled == true, Callback = function(V) Library:SetBlur(V) end })
    Effects:AddSlider("EvergreenBlurSize", {
        Text = "Blur size", Min = 2, Max = 40, Default = Library.BlurSize or 16, Rounding = 0,
        Callback = function(V) Library:SetBlur(Library.BlurEnabled, V) end,
    })
    Effects:AddInput("EvergreenWallpaper", {
        Text = "Wallpaper (asset id / url)", Placeholder = "rbxassetid://...", Default = Library.WallpaperImage or "",
        Finished = true, Callback = function(V)
            if V == nil or Trim(tostring(V)) == "" then Library:SetWallpaper(nil) else Library:SetWallpaper(V) end
        end,
    })
    Effects:AddSlider("EvergreenWallpaperT", {
        Text = "Wallpaper transparency", Min = 0, Max = 95,
        Default = math.floor((Library.WallpaperTransparency or 0.55) * 100 + 0.5), Rounding = 0, Suffix = "%",
        Callback = function(V) Library:SetWallpaper(Library.WallpaperImage, V / 100) end,
    })
    Effects:AddButton({ Text = "Clear wallpaper", Callback = function()
        Library:SetWallpaper(nil)
        if Options.EvergreenWallpaper then Options.EvergreenWallpaper:SetValue("") end
    end })

    --// Behavior
    local Behavior = Tab:AddGroupbox({ Side = Side or 1, Name = "Behavior", IconName = "settings" })
    Behavior:AddDropdown("EvergreenSearchStyle", {
        Text = "Search style", Values = { { "Collapsible bar", 1 }, { "Spotlight", 2 } },
        Default = Library.Window and Library.Window.SearchStyle or 1,
        Callback = function(V) if V and Library.Window and Library.Window.SetSearchStyle then Library.Window:SetSearchStyle(V) end end,
    })
    Behavior:AddDropdown("EvergreenNotifySide", {
        Text = "Notification side", Values = { "Left", "Right" }, Default = Library.NotifySide or "Right",
        Callback = function(V) if V then Library:SetNotifySide(V) end end,
    })
    Behavior:AddToggle("EvergreenKeybindList", {
        Text = "Show keybind list", Default = Library.KeybindListEnabled == true,
        Callback = function(V) Library:SetKeybindListVisible(V) end,
    })
    local Start = typeof(Library.ToggleKeybind) == "EnumItem" and Library.ToggleKeybind.Name or "RightControl"
    Behavior:AddLabel("Menu keybind"):AddKeyPicker("MenuKeybind", { Default = Start, Mode = "Press", NoUI = true, Text = "Menu" })
    Library.ToggleKeybind = Options.MenuKeybind

    return { Appearance = Appear, Colors = Colors, Layout = Layout, Effects = Effects, Behavior = Behavior }
end

-- Creates a dedicated Settings tab with every UI option.
function Library:BuildSettingsTab(Window, Info)
    Info = Info or {}
    local Tab = Window:AddTab({
        Name = Info.Name or "Settings",
        Icon = Info.Icon or "settings",
        Description = Info.Description or "Customize the UI",
    })
    Library:BuildInterfaceSection(Tab, 1)
    if SaveManager and SaveManager.BuildConfigSection and Info.Config ~= false then
        SaveManager:BuildConfigSection(Tab, 2)
    end
    return Tab
end

--// Unload \\--
function Library:Unload()
    if Library.Unloaded then return end
    Library.Unloaded = true

    for I = #Library.Signals, 1, -1 do
        local C = table.remove(Library.Signals, I)
        if C and C.Connected then C:Disconnect() end
    end
    for _, Callback in Library.UnloadSignals do Library:SafeCallback(Callback) end
    for _, E in Library.KeybindPickers do if E.Connections then for _, C in E.Connections do pcall(C.Disconnect, C) end end end

    if Library.ActiveLoading then Library.ActiveLoading:Destroy() end
    Library:DestroyBlur()
    pcall(function() ModalElement.Modal = false end)
    ScreenGui:Destroy()

    for _, T in { Labels, Buttons, Toggles, Options, Library.Tabs, Library.TabList, Library.DependencyBoxes, Library.Notifications, Library.KeybindPickers } do
        table.clear(T)
    end
    table.clear(Library.Registry)

    Library.Toggle = function() end
    Library.Window = nil
    getgenv().Library = nil
end

--// Player/Team dropdown refresh \\--
local function RefreshSpecialDropdowns()
    if Library.Unloaded then return end
    for _, D in Options do
        if D.Type == "Dropdown" and D.SpecialType == "Player" then
            D:SetValues(GetPlayers(D.ExcludeLocalPlayer))
        elseif D.Type == "Dropdown" and D.SpecialType == "Team" then
            D:SetValues(GetTeams())
        end
    end
end
Library:GiveSignal(Players.PlayerAdded:Connect(RefreshSpecialDropdowns))
Library:GiveSignal(Players.PlayerRemoving:Connect(RefreshSpecialDropdowns))
Library:GiveSignal(Teams.ChildAdded:Connect(RefreshSpecialDropdowns))
Library:GiveSignal(Teams.ChildRemoved:Connect(RefreshSpecialDropdowns))

getgenv().Library = Library
return Library
