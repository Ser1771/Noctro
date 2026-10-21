--[[
    ███████╗██╗   ██╗███████╗██████╗  ██████╗ ██████╗ ███████╗███████╗███╗   ██╗
    Evergreen UI Library  -  macOS-inspired Roblox UI library
    Title bar / traffic lights / sidebar / switches / segmented tabboxes / sheets
    Layout & API follow Obsidian (two-column tabs, groupboxes, tabboxes, depboxes).

    Quick start:
        local Library = loadstring(readfile("Evergreen.lua"))()
        local Window = Library:CreateWindow({ Title = "Evergreen", Subtitle = "v1.0", Footer = "Premium" })
        Window:AddSection("General")
        local Tab = Window:AddTab({ Name = "Main", Icon = "house", Description = "Core features" })
        local Box = Tab:AddLeftGroupbox("Player", "user")
        Box:AddToggle("Fly", { Text = "Fly", Default = false, Callback = function(v) end })
            :AddKeyPicker("FlyKey", { Default = "F", Mode = "Toggle", Text = "Fly" })
        Box:AddSlider("Speed", { Text = "Speed", Min = 16, Max = 200, Default = 16, Rounding = 0 })
        Library:Notify({ Title = "Evergreen", Description = "Loaded!", Time = 4 })
]]

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
    Registry = setmetatable({}, { __mode = "k" }),

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
    },
    Groupbox = { Side = 1, Name = "Groupbox", IconName = nil, Description = nil, Visible = true, Collapsed = false, DisableCollapsing = false },
    Tabbox = { Side = 1, Name = nil },
    Dialog = { Title = "Dialog", Description = "", Icon = nil, AutoDismiss = true, OutsideClickDismiss = false, FooterButtons = {} },
    Toggle = { Text = "Toggle", Default = false, Callback = function() end, Changed = function() end, Risky = false, Disabled = false, Visible = true, Checkbox = false },
    Input = { Text = "Input", Default = "", Finished = false, Numeric = false, ClearTextOnFocus = false, Placeholder = "", AllowEmpty = true, EmptyReset = "---", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Slider = { Text = "Slider", Default = 0, Min = 0, Max = 100, Rounding = 0, Prefix = "", Suffix = "", Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
    Dropdown = { Values = {}, DisabledValues = {}, Multi = false, MaxVisibleDropdownItems = 8, Callback = function() end, Changed = function() end, Disabled = false, Visible = true },
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
Library.Gradients = setmetatable({}, { __mode = "k" })
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

function Library:SetTheme(Theme)
    if typeof(Theme) == "string" then Theme = Themes[Theme] end
    if typeof(Theme) ~= "table" then return end
    for K, V in Theme do Library.Scheme[K] = V end
    Library:UpdateColorsUsingRegistry()
    Library:UpdateGradients()
    for _, E in Toggles do if E.Display then E:Display(true) end end
    for _, E in Options do if E.Display then pcall(E.Display, E, true) end end
    for _, T in Library.TabList do T:RefreshStyle() end
end

function Library:SetAccent(Color)
    Library.Scheme.Accent = Color
    Library:SetTheme({})
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
    local Scale = New("UIScale", { Parent = Frame })
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
        Scale.Scale = 0.95
        Tween(Scale, { Scale = 1 }, Library.PopTween)
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
Stroke(KeybindFrame, "Outline", 1, 0.2)
Pad(KeybindFrame, 8, 12, 10, 12)
List(KeybindFrame, 4)
New("TextLabel", { AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 16), Text = "Keybinds", FontFace = "FontBold", TextSize = 12, LayoutOrder = -1, Parent = KeybindFrame })
local KeybindContainer = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.fromOffset(0, 0), Parent = KeybindFrame })
List(KeybindContainer, 2)
Library.KeybindFrame, Library.KeybindContainer = KeybindFrame, KeybindContainer
Library:MakeDraggable(KeybindFrame, KeybindFrame)

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
    local Row = MakeRow(Group, 20)
    if Data.DoesWrap then Row.AutomaticSize = Enum.AutomaticSize.Y end

    local Label = { Type = "Label", Text = Data.Text, DoesWrap = Data.DoesWrap, Addons = {}, Visible = Data.Visible }
    local TextLabel = New("TextLabel", {
        Size = Data.DoesWrap and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 0, 1, 0),
        AutomaticSize = Data.DoesWrap and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
        Text = Data.Text, TextSize = Data.Size, TextWrapped = Data.DoesWrap,
        TextXAlignment = Group.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 1, Parent = Row,
    })
    if not Data.DoesWrap then TextLabel.TextYAlignment = Enum.TextYAlignment.Center end
    Flex(TextLabel)

    Label.TextLabel = TextLabel
    Label.AddonHolder = MakeAddonHolder(Row)
    function Label:SetText(T) Label.Text = T; TextLabel.Text = T end
    Row.Visible = Label.Visible
    setmetatable(Label, BaseAddons)
    Finalize(Group, Label, Row, Labels, Data.Idx)
    return Label
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

        local Icon = Library:GetCustomIcon(B.Icon)
        local TextColor = B.Primary and "AccentText" or (B.Risky and "Red" or "Text")
        B.Label = New("TextLabel", { Size = UDim2.fromScale(1, 1), Text = B.Text, TextColor3 = TextColor, Parent = B.Base })
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
                B.Label.Text = B.Text
                B.Locked = false
                if Clicked then Library:SafeCallback(B.Func) end
                return
            end
            Library:SafeCallback(B.Func)
        end))

        function B:SetDisabled(D) B.Disabled = D; B:UpdateColors(); Library:UpdateAddons(B) end
        function B:SetText(T) B.Text = T; B.Label.Text = T end
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
    local Label = New("TextLabel", { Size = UDim2.new(0, 0, 1, 0), Text = Toggle.Text, TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Toggle.Risky and "Red" or "Text", LayoutOrder = 1, Parent = Row })
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
    function Toggle:SetText(T) Toggle.Text = T; Label.Text = T end

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
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = Input.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = Holder })
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
    function Input:SetText(T) Input.Text = T; Label.Text = T end

    if Input.Finished then
        table.insert(Input.Connections, Box.FocusLost:Connect(function(Enter)
            if Enter then Input:SetValue(Box.Text) else Box.Text = Input.Value end
        end))
    else
        table.insert(Input.Connections, Box:GetPropertyChangedSignal("Text"):Connect(function()
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
    local Label = New("TextLabel", { Size = UDim2.new(0.6, 0, 1, 0), Text = Slider.Text, TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
    local ValueBox = New("TextBox", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.4, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = "SubText", ClearTextOnFocus = false, Text = "", Parent = Top,
    })
    local KS = 24 -- knob size
    local Area = New("TextButton", { Size = UDim2.new(1, 0, 0, 28), Parent = Holder })
    local Track = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 20), Parent = Area })
    Corner(Track, 99)
    Stroke(Track, "Outline", 1, 0.6)
    local FillBar = New("Frame", { BackgroundColor3 = "SliderFill", Size = UDim2.fromScale(0.5, 1), Parent = Track })
    Corner(FillBar, 99)
    local Knob = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(KS, KS), Parent = Track })
    Corner(Knob, 99)
    Stroke(Knob, Color3.new(0, 0, 0), 1.5, 0.82)

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
    function Slider:SetText(T) Slider.Text = T; Label.Text = T end
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
        while Input.UserInputState ~= Enum.UserInputState.End and not Slider.Destroyed do
            local X = (Mouse.X - Track.AbsolutePosition.X - KS / 2) / math.max(Track.AbsoluteSize.X - KS, 1)
            local V = Round(Slider.Min + (Slider.Max - Slider.Min) * math.clamp(X, 0, 1), Slider.Rounding)
            if V ~= Slider.Value then
                Slider.Value = V
                Slider:Display()
                Slider:RunChanged()
            end
            RunService.RenderStepped:Wait()
        end
        SetSidesScrolling(true)
    end))

    Slider.Default = Slider.Value
    Slider:Display()
    Finalize(Group, Slider, Holder, Options, Idx, Info)
    return Slider
end

--// Dropdown (macOS pop-up button) \\--
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

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = DD.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), Text = DD.Text or "", TextXAlignment = Enum.TextXAlignment.Left, Visible = DD.Text ~= nil, Parent = Holder })
    local Button = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28), Parent = Holder })
    Corner(Button, 7)
    Stroke(Button, "Outline", 1, 0.55)
    local Display = New("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -34, 1, 0), Text = "---", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Button })
    local Chevron = Glyph(Button, "chevrons-up-down", "⌃⌄", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14) })

    local SearchBox
    local Popup
    local Scroll

    local function Entries()
        local Out = {}
        local Arr = IsArray(DD.Values)
        local Q = SearchBox and NormalizeSearch(SearchBox.Text) or ""
        for K, Raw in DD.Values do
            local Val = Arr and Raw or K
            local Disp = tostring(Info.FormatListValue and Info.FormatListValue(Raw) or Raw)
            if Q == "" or Fuzzy(Disp, Q) then
                table.insert(Out, { Value = Val, Display = Disp, Disabled = table.find(DD.DisabledValues, Val) ~= nil })
            end
        end
        if not Arr then table.sort(Out, function(A, B) return A.Display < B.Display end) end
        return Out
    end

    local function IsSelected(Val)
        if DD.Multi then return DD.Value[Val] == true end
        return DD.Value == Val
    end

    local function DisplayOf(Val)
        local Arr = IsArray(DD.Values)
        local Raw = Arr and Val or DD.Values[Val]
        return tostring(Info.FormatDisplayValue and Info.FormatDisplayValue(Raw) or Raw)
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
    end

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
            local Txt = New("TextLabel", {
                Position = UDim2.fromOffset(26, 0), Size = UDim2.new(1, -30, 1, 0), Text = E.Display, TextXAlignment = Enum.TextXAlignment.Left,
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
                if E.Disabled then return end
                local Sel = IsSelected(E.Value)
                if DD.Multi then
                    if Sel and #DD:GetActiveValues() == 1 and not DD.AllowNull then return end
                    DD.Value[E.Value] = (not Sel) or nil
                else
                    if Sel then
                        if not DD.AllowNull then Popup:Close() return end
                        DD.Value = nil
                    else
                        DD.Value = E.Value
                    end
                end
                DD:Display()
                Library:UpdateDependencyBoxes()
                DD:RunChanged()
                if DD.Multi then DD:BuildList() else Popup:Close() end
            end)
        end

        local SearchH = SearchBox and 34 or 0
        local H = math.clamp(#Ents, 1, Info.MaxVisibleDropdownItems) * 24 + 8
        Scroll.CanvasSize = UDim2.fromOffset(0, #Ents * 24 + 8)
        Popup:SetSize(UDim2.fromOffset(Button.AbsoluteSize.X, H + SearchH))
    end

    Popup = Library:CreatePopup(Button, {
        Width = 200, Height = 100,
        OnOpen = function() DD:BuildList() end,
        OnToggle = function(Active)
            Tween(Chevron, {}, Library.TweenInfo)
            if SearchBox then SearchBox.Text = "" end
        end,
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

    function DD:OnChanged(F) DD.Changed = F end
    function DD:RunChanged()
        if DD.Disabled then return end
        Library:SafeCallback(DD.Callback, DD.Value)
        Library:SafeCallback(DD.Changed, DD.Value)
    end

    local function ValueExists(V)
        if IsArray(DD.Values) then return table.find(DD.Values, V) ~= nil end
        return DD.Values[V] ~= nil
    end

    function DD:SetValue(V)
        if DD.Multi then
            if typeof(V) == "string" then V = V == "" and {} or { [V] = true } end
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
        DD:Display()
        if Popup.Active then DD:BuildList() end
        if Changed then
            Library:UpdateDependencyBoxes()
            DD:RunChanged()
        end
    end
    function DD:AddValues(V)
        if typeof(V) == "table" then for _, X in V do table.insert(DD.Values, X) end else table.insert(DD.Values, V) end
        if Popup.Active then DD:BuildList() end
    end
    function DD:SetDisabledValues(V) DD.DisabledValues = V; if Popup.Active then DD:BuildList() end end
    function DD:SetDisabled(D) DD.Disabled = D; Popup:Close(); Button.Active = not D; DD:Display(); Library:UpdateDependencyBoxes() end
    function DD:SetText(T) DD.Text = T; Label.Text = T or ""; Label.Visible = T ~= nil end

    table.insert(DD.Connections, Button.MouseButton1Click:Connect(function()
        if not DD.Disabled then Popup:Toggle() end
    end))
    table.insert(DD.Connections, Button.MouseEnter:Connect(function() if not DD.Disabled then Tween(Button, { BackgroundColor3 = Library.Scheme.ControlHover }) end end))
    table.insert(DD.Connections, Button.MouseLeave:Connect(function() Tween(Button, { BackgroundColor3 = Library.Scheme.Control }) end))

    -- defaults
    local Def = Info.Default
    local Resolved = {}
    local Arr = IsArray(DD.Values)
    if typeof(Def) == "number" and Arr and DD.Values[Def] ~= nil then
        table.insert(Resolved, DD.Values[Def])
    elseif typeof(Def) == "table" then
        for K, V in Def do
            local Cand = (typeof(K) == "number") and V or K
            if ValueExists(Cand) then table.insert(Resolved, Cand) end
        end
    elseif Def ~= nil and ValueExists(Def) then
        table.insert(Resolved, Def)
    end
    for _, V in Resolved do
        if DD.Multi then DD.Value[V] = true else DD.Value = V break end
    end
    DD.Default = Resolved

    function DD:OnDestroy() Popup:Destroy() end
    DD:Display()
    Finalize(Group, DD, Holder, Options, Idx, Info)
    local BaseDestroy = DD.Destroy
    function DD:Destroy() Popup:Destroy(); BaseDestroy(DD) end
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
    if Fuzzy(El.Text, S) or Fuzzy(El.Tooltip, S) then return true end
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

local function ApplyBox(Box, S, Force)
    local Count = 0
    for _, El in Box.Elements do
        if El.Type == "Divider" then
            El.Holder.Visible = false
        else
            local Vis = El.Visible ~= false and (Force or ElementMatches(El, S))
            El.Holder.Visible = Vis
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
    end
    for _, D in Box.DependencyBoxes do
        D.Holder.Visible = D.Visible
        ResetBox(D)
    end
end

function Library:UpdateSearch(Text)
    Library.SearchText = Text
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
    New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = Data.Title, FontFace = "FontBold", TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = Texts })
    local Desc
    if Data.Description ~= "" then
        Desc = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = Data.Description, TextSize = 12, TextColor3 = "SubText", TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Parent = Texts })
    end

    function Data:ChangeDescription(T)
        if Desc then Desc.Text = tostring(T) end
    end
    function Data:ChangeTitle(T)
        Texts:FindFirstChildWhichIsA("TextLabel").Text = tostring(T)
    end
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
    local Main = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = Root })
    Corner(Main, WindowInfo.CornerRadius)
    Stroke(Main, "Outline", 1, 0.25)
    Grad(Main, Two("Window", 0.05, -0.015), 125)
    local MainScale = New("UIScale", { Parent = Main })

    Window.Root, Window.MainFrame = Root, Main

    --// Title bar
    local TitleBar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, TitleH), ZIndex = 3, Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 0.3, Parent = TitleBar })
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

    -- search pill
    local SearchBox
    if not WindowInfo.DisableSearch then
        SearchBox = New("TextBox", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0.25, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
            Size = UDim2.fromOffset(180, 24), PlaceholderText = "Search", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, Parent = TitleBar,
        })
        Corner(SearchBox, 99)
        Pad(SearchBox, 0, 10, 0, 28)
        local SStroke = Stroke(SearchBox, "Outline", 1, 0.5)
        local SIcon = Glyph(SearchBox, "search", "⌕", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -18, 0.5, 0), Size = UDim2.fromOffset(14, 14) })
        SearchBox.Focused:Connect(function()
            Bind(SStroke, "Color", "Accent")
            Tween(SStroke, { Color = Library.Scheme.Accent, Transparency = 0, Thickness = 1.5 })
            Tween(SearchBox, { Size = UDim2.fromOffset(220, 24) })
        end)
        SearchBox.FocusLost:Connect(function()
            Bind(SStroke, "Color", "Outline")
            Tween(SStroke, { Color = Library.Scheme.Outline, Transparency = 0.5, Thickness = 1 })
            Tween(SearchBox, { Size = UDim2.fromOffset(180, 24) })
        end)
        Library:GiveSignal(SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
            Library:UpdateSearch(SearchBox.Text)
        end))
    end

    --// Sidebar
    local Sidebar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Position = UDim2.fromOffset(0, TitleH), Size = UDim2.new(0, SidebarWidth, 1, -TitleH), Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.3, Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 1, 1, 0), Parent = Sidebar })

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
                local D = Input.Position - StartPos
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
            Tween(Root, { Size = UDim2.fromOffset(VS.X - 24, VS.Y - 24), Position = UDim2.fromOffset(12, 12) }, Library.SlowTween)
        elseif PreMaxState then
            Tween(Root, { Size = PreMaxState[1], Position = PreMaxState[2] }, Library.SlowTween)
        end
    end

    function Window:Toggle(Value)
        if Library.Unloaded then return end
        if typeof(Value) == "boolean" then Library.Toggled = Value else Library.Toggled = not Library.Toggled end
        if Library.CurrentPopup then Library.CurrentPopup:Close() end

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
    function Window:AddSection(Name)
        NextOrder += 1
        local L = New("TextLabel", {
            Size = UDim2.new(1, 0, 0, 26), Text = tostring(Name):upper(), TextSize = 10, FontFace = "FontBold", TextColor3 = "SubText",
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Bottom, LayoutOrder = NextOrder, Parent = TabsList,
        })
        Pad(L, 0, 0, 4, 10)
        return L
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

        local Tab = {
            Name = Name, Description = Description, Button = Btn, Container = Container, Sides = { SideLeft, SideRight },
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

        function Tab:RefreshSides()
            local Offset = WarnHolder.Visible and (WarnHolder.AbsoluteSize.Y + 12) or 0
            SideLeft.Position = UDim2.fromOffset(0, Offset)
            SideLeft.Size = UDim2.new(0.5, 0, 1, -Offset)
            SideRight.Position = UDim2.new(1, 0, 0, Offset)
            SideRight.Size = UDim2.new(0.5, 0, 1, -Offset)
        end
        WarnHolder:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() Tab:RefreshSides() end)

        function Tab:UpdateWarningBox(WInfo)
            WInfo = WInfo or {}
            if typeof(WInfo.Visible) == "boolean" then WarnHolder.Visible = WInfo.Visible end
            if typeof(WInfo.Title) == "string" then WarnTitle.Text = WInfo.Title end
            if typeof(WInfo.Text) == "string" then WarnText.Text = WInfo.Text end
            if typeof(WInfo.IsNormal) == "boolean" then
                WarnHolder.BackgroundColor3 = WInfo.IsNormal and Library.Scheme.Card or Color3.fromRGB(110, 20, 20)
                WarnStroke.Color = WInfo.IsNormal and Library.Scheme.Outline or Color3.fromRGB(255, 69, 58)
                WarnTitle.TextColor3 = WInfo.IsNormal and Library.Scheme.Text or Color3.fromRGB(255, 120, 110)
            end
            task.defer(function() Tab:RefreshSides() end)
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

            PageTitle.Text = Tab.Name
            PageDesc.Text = Tab.Description or ""
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

        function Tab:SetVisible(V)
            Tab.TabVisible = V
            Btn.Visible = V
            if not V and Library.ActiveTab == Tab then Tab:Hide() end
        end

        function Tab:SetTooltip(T) if typeof(T) == "string" then Library:AddTooltip(T, Btn) end end

        function Tab:ResetSearch()
            Btn.Visible = Tab.TabVisible
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
            return Any or TabMatch
        end

        --// Groupbox
        local function SideOf(Side)
            if typeof(Side) == "string" then Side = Side:lower() == "right" and 2 or 1 end
            return Side == 2 and SideRight or SideLeft
        end

        function Tab:AddGroupbox(Info)
            Info = Library:Validate(Info, Templates.Groupbox)

            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = SideOf(Info.Side) })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
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
            }

            function Groupbox:SetCollapsed(C)
                if Info.DisableCollapsing then return end
                Groupbox.Collapsed = C
                Body.Visible, Line.Visible = not C, not C
                Tween(Arrow, { Rotation = C and -90 or 0 }, Library.SlowTween)
            end
            function Groupbox:ToggleCollapsed() Groupbox:SetCollapsed(not Groupbox.Collapsed) end
            function Groupbox:SetVisible(V)
                Groupbox.Visible = V
                Card.Visible = V
                if V and Library.Searching then Library:UpdateSearch(Library.SearchText) end
            end
            function Groupbox:Show() Groupbox:SetVisible(true) end
            function Groupbox:Hide() Groupbox:SetVisible(false) end
            function Groupbox:Resize() end
            function Groupbox:Destroy()
                Groupbox.Destroyed = true
                for I = #Groupbox.Elements, 1, -1 do Groupbox.Elements[I]:Destroy() end
                Card:Destroy()
                local I = table.find(Tab.Groupboxes, Groupbox)
                if I then table.remove(Tab.Groupboxes, I) end
            end

            Head.MouseButton1Click:Connect(function() Groupbox:ToggleCollapsed() end)
            setmetatable(Groupbox, BaseGroupbox)
            table.insert(Tab.Groupboxes, Groupbox)

            if Info.Visible == false then Groupbox:Hide() end
            if Info.Collapsed then Groupbox:SetCollapsed(true) end
            return Groupbox
        end

        function Tab:AddLeftGroupbox(Name, IconName, Visible, Collapsed)
            return Tab:AddGroupbox({ Side = 1, Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end
        function Tab:AddRightGroupbox(Name, IconName, Visible, Collapsed)
            return Tab:AddGroupbox({ Side = 2, Name = Name, IconName = IconName, Visible = Visible, Collapsed = Collapsed })
        end

        --// Tabbox (macOS segmented control)
        function Tab:AddTabbox(Info)
            Info = Library:Validate(Info, Templates.Tabbox)
            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = SideOf(Info.Side) })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
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
                    for I = #SubTab.Elements, 1, -1 do SubTab.Elements[I]:Destroy() end
                    Page:Destroy()
                    Seg:Destroy()
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
            return Tabbox
        end
        function Tab:AddLeftTabbox(Name) return Tab:AddTabbox({ Side = 1, Name = Name }) end
        function Tab:AddRightTabbox(Name) return Tab:AddTabbox({ Side = 2, Name = Name }) end

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
        Tab.Sides[1].Visible, Tab.Sides[2].Visible = false, false

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
        Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)

        local Sheet = New("Frame", {
            BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0), AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2.new(0.5, 0, 0, TitleH - 24), Size = UDim2.fromOffset(340, 0), ZIndex = 51, Parent = Dim,
        })
        Corner(Sheet, 12)
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
        local DTitle = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = Info.Title, FontFace = "FontBold", TextSize = 15, TextWrapped = true, LayoutOrder = 2, ZIndex = 52, Parent = Inner })
        local DDesc = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Text = Info.Description, TextSize = 12, TextColor3 = "SubText", TextWrapped = true, LayoutOrder = 3, Visible = Info.Description ~= "", ZIndex = 52, Parent = Inner })
        local DContainer = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 4, ZIndex = 52, Parent = Inner })
        List(DContainer, 8)
        local BtnRow = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), LayoutOrder = 5, ZIndex = 52, Parent = Inner })
        List(BtnRow, 8, Enum.FillDirection.Horizontal)

        local Dialog = { Destroyed = false, Container = DContainer, Elements = {}, DependencyBoxes = {}, OutsideClickDismiss = Info.OutsideClickDismiss }

        function Dialog:SetTitle(T) DTitle.Text = T end
        function Dialog:SetDescription(T) DDesc.Text = T; DDesc.Visible = T ~= "" end
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
    if WindowInfo.AutoShow then task.defer(function() Window:Toggle(true) end) end
    return Window
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
