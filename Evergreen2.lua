--[[
    ███████╗██╗   ██╗███████╗██████╗  ██████╗ ██████╗ ███████╗███████╗███╗   ██╗
    Evergreen UI Library  -  macOS-inspired Roblox UI library (Extended Edition)
    Now featuring: Extended Modal Dropdown (Grid/Icons), SearchStyle 1 & 2,
    Custom <Copyable> Tag API, Fixed Slider Knob, Single Groupbox & DPIScale Fix.
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
local setclipboard = setclipboard or toclipboard or (Clipboard and Clipboard.set) or function(...) end

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
        Popup = Color3.fromRGB(42, 42, 46),
        Segment = Color3.fromRGB(96, 96, 102),
        Track = Color3.fromRGB(60, 60, 64),
        SliderFill = Color3.fromRGB(248, 248, 250),
        Outline = Color3.fromRGB(70, 70, 75),
        Text = Color3.fromRGB(245, 245, 247),
        SubText = Color3.fromRGB(152, 152, 160),
        Accent = Color3.fromRGB(48, 209, 88),
        AccentText = Color3.fromRGB(255, 255, 255),
        Blue = Color3.fromRGB(10, 132, 255),
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
        Popup = Color3.fromRGB(36, 36, 40),
        Segment = Color3.fromRGB(84, 84, 90),
        Track = Color3.fromRGB(55, 55, 58),
        SliderFill = Color3.fromRGB(248, 248, 250),
        Outline = Color3.fromRGB(56, 56, 61),
        Text = Color3.fromRGB(240, 240, 244),
        SubText = Color3.fromRGB(140, 140, 150),
        Accent = Color3.fromRGB(48, 209, 88),
        AccentText = Color3.fromRGB(255, 255, 255),
        Blue = Color3.fromRGB(10, 132, 255),
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
        Popup = Color3.fromRGB(250, 250, 252),
        Segment = Color3.fromRGB(255, 255, 255),
        Track = Color3.fromRGB(215, 215, 220),
        SliderFill = Color3.fromRGB(40, 184, 78),
        Outline = Color3.fromRGB(210, 210, 215),
        Text = Color3.fromRGB(28, 28, 30),
        SubText = Color3.fromRGB(112, 112, 120),
        Accent = Color3.fromRGB(40, 184, 78),
        AccentText = Color3.fromRGB(255, 255, 255),
        Blue = Color3.fromRGB(0, 122, 255),
        Red = Color3.fromRGB(255, 59, 48),
        IsLight = true,
    },
}

--// Library Object \\--
local Labels, Buttons, Toggles, Options = {}, {}, {}, {}

local Library = {
    Version = "1.1.0",
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
    DPIScale = 1,
    DPIScales = setmetatable({}, { __mode = "k" }),

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
        MinSize = Vector2.new(620, 400),
        Center = true,
        AutoShow = true,
        Resizable = true,
        CornerRadius = 12,

        SidebarWidth = 190,
        ShowUserChip = true,
        ShowTrafficLights = true,
        DisableSearch = false,
        SearchStyle = 2, -- 1: Expanded Top Bar, 2: Center Modal Spotlight

        NotifySide = "Right",
        ToggleKeybind = Enum.KeyCode.RightControl,
        UnlockMouseWhileOpen = true,
        ShowMobileButton = true,

        CloseUnloads = false,
        OnClose = nil,

        Theme = "Dark",
        Accent = nil,
        DPIScale = 100,
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

--// Basic Utilities \\--
local function Tween(Object, Props, Info)
    local T = TweenService:Create(Object, Info or Library.TweenInfo, Props)
    T:Play()
    return T
end

local function Anim(Object, Props, Instant)
    if Instant then
        for K, V in Props do Object[K] = V end
    else
        Tween(Object, Props)
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
    if #Search < 2 or #Search > #Text then return false end
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

function Library:SafeCallback(Func, ...)
    if typeof(Func) ~= "function" then return end
    local Result = table.pack(xpcall(Func, function(Err)
        task.defer(error, debug.traceback(tostring(Err), 2))
        return Err
    end, ...))
    if not Result[1] then return nil end
    return table.unpack(Result, 2, Result.n)
end

--// Custom Text Format / Copyable Tag Parser \\--
local function ProcessCustomMarkup(RawText)
    local Clean = RawText
    local Copyables = {}
    Clean = Clean:gsub("<Copyable>(.-)</Copyable>", function(Match)
        table.insert(Copyables, Match)
        return string.format('<font color="#%s"><b>%s</b></font>', Library.Scheme.Blue:ToHex(), Match)
    end)
    return Clean, Copyables
end

function Library:ApplyCustomText(TextElement, RawText)
    if typeof(RawText) ~= "string" then
        TextElement.Text = tostring(RawText)
        return
    end

    local Formatted, Copyables = ProcessCustomMarkup(RawText)
    TextElement.RichText = true
    TextElement.Text = Formatted

    if #Copyables > 0 then
        if not TextElement:FindFirstChild("CopyOverlay") then
            local Btn = Instance.new("TextButton")
            Btn.Name = "CopyOverlay"
            Btn.BackgroundTransparency = 1
            Btn.Size = UDim2.fromScale(1, 1)
            Btn.Text = ""
            Btn.ZIndex = TextElement.ZIndex + 1
            Btn.Parent = TextElement

            Btn.MouseButton1Click:Connect(function()
                local Target = Copyables[1] or RawText:gsub("<.->", "")
                setclipboard(Target)
                Library:Notify({
                    Title = "Copied to Clipboard",
                    Description = Target,
                    Time = 2,
                    Icon = "copy",
                })
            end)
        end
    end
end

--// Instance Creation & Registry \\--
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

--// Gradients \\--
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
    if Library.Scheme.IsLight then Library.Scheme.SliderFill = Color end
    Library:SetTheme({})
end

--// Icons Module \\--
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
    if typeof(Name) == "Instance" and (Name:IsA("ViewportFrame") or Name:IsA("ImageLabel")) then
        return { Instance = Name, Custom = true }
    end
    if tonumber(Name) then Name = "rbxassetid://" .. tostring(Name) end
    if typeof(Name) ~= "string" then return nil end
    if Name:match("^rbxassetid://") or Name:match("^rbxasset://") or Name:match("^rbxthumb://") or Name:match("^content://") or Name:match("roblox%.com/asset") then
        return { Url = Name, ImageRectOffset = Vector2.zero, ImageRectSize = Vector2.zero, Custom = true }
    end
    return Library:GetIcon(Name)
end

function Library:ApplyIcon(Img, Icon)
    if not Img or not Icon then return end
    if Icon.Instance then
        local Clone = Icon.Instance:Clone()
        Clone.Size = UDim2.fromScale(1, 1)
        Clone.Position = UDim2.fromScale(0, 0)
        Clone.Parent = Img
        return
    end
    Img.Image = Icon.Url or ""
    Img.ImageRectOffset = Icon.ImageRectOffset or Vector2.zero
    Img.ImageRectSize = Icon.ImageRectSize or Vector2.zero
end

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

--// Root GUI Setup \\--
local ScreenGui = New("ScreenGui", { Name = "Evergreen", DisplayOrder = 998, ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })
pcall(protectgui, ScreenGui)
local ParentOk = pcall(function() ScreenGui.Parent = gethui() end)
if not ParentOk or not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end
Library.ScreenGui = ScreenGui

local ModalElement = New("TextButton", { Modal = false, Size = UDim2.fromOffset(0, 0), ZIndex = -999, Parent = ScreenGui })
local Floats = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 10, Parent = ScreenGui })
local Overlay = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 20, Parent = ScreenGui })
Library.Floats, Library.Overlay = Floats, Overlay

--// DPI Scale \\--
function Library:SetDPIScale(Percent)
    Percent = math.clamp(tonumber(Percent) or 100, 50, 150)
    local Old, NewScale = Library.DPIScale, Percent / 100
    if Library.CurrentPopup then Library.CurrentPopup:Close() end

    local Root = Library.Window and Library.Window.Root
    if Root then
        local Half = Vector2.new(Root.Size.X.Offset, Root.Size.Y.Offset) * (Old - NewScale) / 2
        Root.Position = Root.Position + UDim2.fromOffset(Half.X, Half.Y)
    end

    Library.DPIScale = NewScale
    for S in Library.DPIScales do
        if S.Parent then S.Scale = NewScale end
    end
end

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
            local D = (Input.Position - StartPos) / Library.DPIScale
            Target.Position = UDim2.new(StartFrame.X.Scale, StartFrame.X.Offset + D.X, StartFrame.Y.Scale, StartFrame.Y.Offset + D.Y)
        end
    end))
end

--// Popups \\--
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
    Popup.Frame = Frame

    function Popup:UpdatePosition()
        if not Anchor.Parent then return end
        local AP, AS, FS = Anchor.AbsolutePosition, Anchor.AbsoluteSize, Frame.AbsoluteSize
        local View = ScreenGui.AbsoluteSize
        local X = AP.X + (Opt.AlignRight and (AS.X - FS.X) or 0)
        local Y = AP.Y + AS.Y + 4
        if Y + FS.Y > View.Y - 8 then Y = AP.Y - FS.Y - 4 end
        X = math.clamp(X, 8, math.max(8, View.X - FS.X - 8))
        Frame.Position = UDim2.fromOffset(math.floor(X / Library.DPIScale), math.floor(Y / Library.DPIScale))
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
        if Library.CurrentPopup then Library.CurrentPopup:Close() end
    end
end))

--// Tooltip \\--
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

--// Player / Teams Helper \\--
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

--// Element Finalizer & Base Setup \\--
local Funcs = {}
local BaseGroupbox = { __index = Funcs }
local AddonFuncs = {}
local BaseAddons = { __index = AddonFuncs }

local function SetSidesScrolling(Enabled)
    if Library.ActiveTab then
        if Library.ActiveTab.Sides then
            for _, S in Library.ActiveTab.Sides do S.ScrollingEnabled = Enabled end
        end
        if Library.ActiveTab.SingleScroll then
            Library.ActiveTab.SingleScroll.ScrollingEnabled = Enabled
        end
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
        local Lbl = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromOffset(0, 12), Text = Text, TextSize = 11, TextColor3 = "SubText", Parent = Holder })
        Library:ApplyCustomText(Lbl, Text)
        local L2 = New("Frame", { BackgroundColor3 = "Outline", Size = UDim2.new(0, 0, 0, 1), Parent = Holder }); Flex(L2)
    else
        New("Frame", { AnchorPoint = Vector2.new(0, 0.5), BackgroundColor3 = "Outline", Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1), Parent = Holder })
    end
    Finalize(Group, Div, Holder)
    return Div
end

--// Label / Paragraph \\--
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
        TextSize = Data.Size, TextWrapped = Data.DoesWrap,
        TextXAlignment = Group.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, LayoutOrder = 1, Parent = Row,
    })
    if not Data.DoesWrap then TextLabel.TextYAlignment = Enum.TextYAlignment.Center end
    Flex(TextLabel)
    Library:ApplyCustomText(TextLabel, Data.Text)

    Label.TextLabel = TextLabel
    Label.AddonHolder = MakeAddonHolder(Row)
    function Label:SetText(T) Label.Text = T; Library:ApplyCustomText(TextLabel, T) end
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
        New("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.new(0.78, 0.78, 0.78)), Parent = B.Base })

        local Icon = Library:GetCustomIcon(B.Icon)
        local TextColor = B.Primary and "AccentText" or (B.Risky and "Red" or "Text")
        B.Label = New("TextLabel", { Size = UDim2.fromScale(1, 1), TextColor3 = TextColor, Parent = B.Base })
        Library:ApplyCustomText(B.Label, B.Text)

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
                Library:ApplyCustomText(B.Label, B.Text)
                B.Locked = false
                if Clicked then Library:SafeCallback(B.Func) end
                return
            end
            Library:SafeCallback(B.Func)
        end))

        function B:SetDisabled(D) B.Disabled = D; B:UpdateColors(); Library:UpdateAddons(B) end
        function B:SetText(T) B.Text = T; Library:ApplyCustomText(B.Label, T) end
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
    local Label = New("TextLabel", { Size = UDim2.new(0, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Toggle.Risky and "Red" or "Text", LayoutOrder = 1, Parent = Row })
    Library:ApplyCustomText(Label, Toggle.Text)
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
    function Toggle:SetText(T) Toggle.Text = T; Library:ApplyCustomText(Label, T) end

    table.insert(Toggle.Connections, Click.MouseButton1Click:Connect(function()
        if not Toggle.Disabled then Toggle:SetValue(not Toggle.Value) end
    end))

    Toggle:Display(true)
    Toggle.Default = Toggle.Value
    setmetatable(Toggle, BaseAddons)
    Finalize(Group, Toggle, Row, Toggles, Idx, Info)
    return Toggle
end

--// Accurate Slider \\--
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
    local Label = New("TextLabel", { Size = UDim2.new(0.6, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, Parent = Top })
    Library:ApplyCustomText(Label, Slider.Text)

    local ValueBox = New("TextBox", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0.4, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = "SubText", ClearTextOnFocus = false, Text = "", Parent = Top,
    })

    local KS = 18 -- Knob size
    local Area = New("TextButton", { Size = UDim2.new(1, 0, 0, 24), ClipsDescendants = false, Parent = Holder })
    local Track = New("Frame", { BackgroundColor3 = "Track", BackgroundTransparency = 0.35, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(1, 0, 0, 8), Parent = Area })
    Corner(Track, 99)
    Stroke(Track, "Outline", 1, 0.6)

    local FillBar = New("Frame", { BackgroundColor3 = "SliderFill", Size = UDim2.fromScale(0, 1), Parent = Track })
    Corner(FillBar, 99)

    -- Accurate Anchor Centered Knob
    local Knob = New("Frame", {
        BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(KS, KS), ZIndex = 3, Parent = Area,
    })
    Corner(Knob, 99)
    Stroke(Knob, Color3.new(0, 0, 0), 1.5, 0.8)

    local function Format(V)
        local N = Slider.Rounding > 0 and string.format("%." .. Slider.Rounding .. "f", V) or tostring(V)
        return Slider.Prefix .. N .. Slider.Suffix
    end

    function Slider:Display()
        if Library.Unloaded then return end
        local Alpha = math.clamp((Slider.Value - Slider.Min) / math.max(Slider.Max - Slider.Min, 1e-9), 0, 1)

        -- Precise math: Knob travels across the width of Area minus knob padding
        Knob.Position = UDim2.new(Alpha, 0, 0.5, 0)
        FillBar.Size = UDim2.fromScale(Alpha, 1)

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
    function Slider:SetText(T) Slider.Text = T; Library:ApplyCustomText(Label, T) end

    table.insert(Slider.Connections, ValueBox.FocusLost:Connect(function()
        local N = tonumber((ValueBox.Text:gsub("[^%d%.%-]", "")))
        if N then Slider:SetValue(N) else Slider:Display() end
    end))
    table.insert(Slider.Connections, ValueBox.Focused:Connect(function() ValueBox.Text = tostring(Slider.Value) end))

    table.insert(Slider.Connections, Area.InputBegan:Connect(function(Input)
        if Slider.Disabled or not IsPress(Input) then return end
        SetSidesScrolling(false)

        local function UpdateFromMouse()
            local AbsX = Area.AbsolutePosition.X
            local AbsW = Area.AbsoluteSize.X
            local Ratio = math.clamp((Mouse.X - AbsX) / math.max(AbsW, 1), 0, 1)
            local V = Round(Slider.Min + (Slider.Max - Slider.Min) * Ratio, Slider.Rounding)
            if V ~= Slider.Value then
                Slider.Value = V
                Slider:Display()
                Slider:RunChanged()
            end
        end

        UpdateFromMouse()
        while Input.UserInputState ~= Enum.UserInputState.End and not Slider.Destroyed do
            UpdateFromMouse()
            RunService.RenderStepped:Wait()
        end
        SetSidesScrolling(true)
    end))

    Slider.Default = Slider.Value
    Slider:Display()
    Finalize(Group, Slider, Holder, Options, Idx, Info)
    return Slider
end

--// Modal Extended Dropdown with Grid & Icons \\--
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
        Type = "Dropdown", Text = typeof(Info.Text) == "string" and Info.Text or nil, RawValues = Info.Values,
        Values = {}, DisabledValues = Info.DisabledValues, Multi = Info.Multi, AllowNull = Info.AllowNull,
        SpecialType = Info.SpecialType, ExcludeLocalPlayer = Info.ExcludeLocalPlayer,
        Callback = Info.Callback, Changed = Info.Changed, Disabled = Info.Disabled, Visible = Info.Visible,
        Value = Info.Multi and {} or nil, Connections = {},
    }

    -- Parse { Name, Value, Icon } or basic string/table lists
    local function ParseEntries(InputList)
        local Parsed = {}
        for K, Item in pairs(InputList) do
            if typeof(Item) == "table" and (Item.Name or Item[1]) then
                local Name = Item.Name or Item[1]
                local Val = (Item.Value ~= nil) and Item.Value or Item[2]
                if Val == nil then Val = Name end
                local Icon = Item.Icon or Item[3]
                table.insert(Parsed, { Name = tostring(Name), Value = Val, Icon = Icon })
            else
                local Val = IsArray(InputList) and Item or K
                table.insert(Parsed, { Name = tostring(Item), Value = Val, Icon = nil })
            end
        end
        return Parsed
    end
    DD.Values = ParseEntries(DD.RawValues)

    local Holder = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Visible = DD.Visible, Parent = Group.Container })
    List(Holder, 5)
    local Label = New("TextLabel", { Size = UDim2.new(1, 0, 0, 14), TextXAlignment = Enum.TextXAlignment.Left, Visible = DD.Text ~= nil, Parent = Holder })
    if DD.Text then Library:ApplyCustomText(Label, DD.Text) end

    local Bar = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), Parent = Holder })
    List(Bar, 4, Enum.FillDirection.Horizontal)

    local Button = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.new(1, -32, 1, 0), Parent = Bar })
    Flex(Button)
    Corner(Button, 7)
    Stroke(Button, "Outline", 1, 0.55)

    local Display = New("TextLabel", { Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -34, 1, 0), Text = "---", TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = Button })
    local Chevron = Glyph(Button, "chevrons-up-down", "⌃⌄", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14) })

    -- Modal Expand Button (Icon: ⛶ / maximize)
    local ModalBtn = New("TextButton", { BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.fromOffset(28, 28), Parent = Bar })
    Corner(ModalBtn, 7)
    Stroke(ModalBtn, "Outline", 1, 0.55)
    Glyph(ModalBtn, "maximize-2", "⛶", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 14) })

    local SearchBox
    local Popup
    local Scroll

    local function IsSelected(Val)
        if DD.Multi then return DD.Value[Val] == true end
        return DD.Value == Val
    end

    local function GetItemDisplay(Val)
        for _, Item in DD.Values do
            if Item.Value == Val then return Item.Name end
        end
        return tostring(Val)
    end

    function DD:Display()
        if Library.Unloaded then return end
        local Str = ""
        if DD.Multi then
            local Parts = {}
            for V in pairs(DD.Value) do table.insert(Parts, GetItemDisplay(V)) end
            table.sort(Parts)
            Str = table.concat(Parts, ", ")
        elseif DD.Value ~= nil then
            Str = GetItemDisplay(DD.Value)
        end
        Display.Text = Str == "" and "---" or Str
        local D = DD.Disabled and 0.55 or 0
        Display.TextTransparency = D
        Label.TextTransparency = D
        GlyphTransparency(Chevron, DD.Disabled and 0.7 or 0.2)
    end

    -- Regular Dropdown List
    function DD:BuildList()
        if not Scroll then return end
        for _, C in Scroll:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end

        local Q = SearchBox and NormalizeSearch(SearchBox.Text) or ""
        local Count = 0
        for I, Item in DD.Values do
            if Q == "" or Fuzzy(Item.Name, Q) then
                Count += 1
                local Row = New("TextButton", { BackgroundColor3 = "Accent", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = I, Parent = Scroll })
                Corner(Row, 5)

                local Selected = IsSelected(Item.Value)
                local Check = Glyph(Row, "check", "✓", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(12, 12), Color = "Text", Visible = Selected })
                local Txt = New("TextLabel", {
                    Position = UDim2.fromOffset(26, 0), Size = UDim2.new(1, -30, 1, 0), Text = Item.Name, TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, Parent = Row,
                })

                Row.MouseEnter:Connect(function()
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
                    local Sel = IsSelected(Item.Value)
                    if DD.Multi then
                        DD.Value[Item.Value] = (not Sel) or nil
                    else
                        DD.Value = Sel and (DD.AllowNull and nil or Item.Value) or Item.Value
                    end
                    DD:Display()
                    Library:UpdateDependencyBoxes()
                    DD:RunChanged()
                    if DD.Multi then DD:BuildList() else Popup:Close() end
                end)
            end
        end

        local H = math.clamp(Count, 1, Info.MaxVisibleDropdownItems) * 24 + 8
        Scroll.CanvasSize = UDim2.fromOffset(0, Count * 24 + 8)
        Popup:SetSize(UDim2.fromOffset(Button.AbsoluteSize.X / Library.DPIScale, H + (SearchBox and 34 or 0)))
    end

    Popup = Library:CreatePopup(Button, {
        Width = 200, Height = 100,
        OnOpen = function() DD:BuildList() end,
    })
    DD.Popup = Popup

    Scroll = New("ScrollingFrame", {
        Position = UDim2.fromOffset(0, Info.Searchable and 34 or 0), Size = UDim2.new(1, 0, 1, Info.Searchable and -34 or 0),
        CanvasSize = UDim2.new(), ScrollBarThickness = 0, Parent = Popup.Frame,
    })
    List(Scroll, 1)
    Pad(Scroll, 4, 4, 4, 4)

    -- Full Modal Grid UI
    function DD:OpenModalGrid()
        if Library.CurrentPopup then Library.CurrentPopup:Close() end

        local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 60, Parent = ScreenGui })
        Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)

        local ModalFrame = New("Frame", {
            BackgroundColor3 = "Card", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(540, 380), ZIndex = 61, Parent = Dim,
        })
        Corner(ModalFrame, 12)
        Stroke(ModalFrame, "Outline", 1, 0.3)
        Grad(ModalFrame, Two("Card", 0.04, -0.02), 90)

        -- Header
        local MHead = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 42), ZIndex = 62, Parent = ModalFrame })
        Pad(MHead, 0, 16, 0, 16)
        List(MHead, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)

        local MTitle = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Text = DD.Text or "Select Item", FontFace = "FontBold", TextSize = 14, ZIndex = 62, Parent = MHead })
        Flex(MTitle)

        local MSearch = New("TextBox", {
            BackgroundColor3 = "Control", BackgroundTransparency = 0, Size = UDim2.fromOffset(180, 26),
            PlaceholderText = "Search...", ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 62, Parent = MHead,
        })
        Corner(MSearch, 8)
        Pad(MSearch, 0, 8, 0, 8)

        local MClose = New("TextButton", { BackgroundColor3 = "Control", Size = UDim2.fromOffset(26, 26), Text = "✕", TextSize = 12, ZIndex = 62, Parent = MHead })
        Corner(MClose, 8)

        -- Grid Area
        local GridScroll = New("ScrollingFrame", {
            Position = UDim2.fromOffset(12, 46), Size = UDim2.new(1, -24, 1, -56),
            CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, ZIndex = 62, Parent = ModalFrame,
        })
        local UIGrid = New("UIGridLayout", {
            CellPadding = UDim2.fromOffset(10, 10), CellSize = UDim2.fromOffset(92, 94),
            SortOrder = Enum.SortOrder.LayoutOrder, Parent = GridScroll,
        })
        Pad(GridScroll, 4, 4, 10, 4)

        local function PopulateGrid()
            for _, Child in GridScroll:GetChildren() do
                if Child:IsA("TextButton") then Child:Destroy() end
            end
            local Q = NormalizeSearch(MSearch.Text)
            for _, Item in DD.Values do
                if Q == "" or Fuzzy(Item.Name, Q) then
                    local Sel = IsSelected(Item.Value)
                    local Tile = New("TextButton", {
                        BackgroundColor3 = Sel and "Accent" or "Control", Size = UDim2.fromOffset(92, 94),
                        ZIndex = 63, Parent = GridScroll,
                    })
                    Corner(Tile, 10)
                    Stroke(Tile, Sel and "AccentText" or "Outline", 1, 0.4)

                    -- Icon holder
                    local IconFrame = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 56), ZIndex = 64, Parent = Tile })
                    if Item.Icon then
                        local CustomI = Library:GetCustomIcon(Item.Icon)
                        if CustomI then
                            local IconImg = New("ImageLabel", {
                                AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
                                Size = UDim2.fromOffset(36, 36), ImageColor3 = Sel and "AccentText" or "Text", ZIndex = 65, Parent = IconFrame,
                            })
                            Library:ApplyIcon(IconImg, CustomI)
                        end
                    else
                        Glyph(IconFrame, "box", "📦", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(32, 32), Color = Sel and "AccentText" or "SubText" })
                    end

                    -- Name
                    local TileTxt = New("TextLabel", {
                        Position = UDim2.fromOffset(4, 58), Size = UDim2.new(1, -8, 0, 30),
                        Text = Item.Name, TextSize = 11, TextWrapped = true, TextColor3 = Sel and "AccentText" or "Text",
                        ZIndex = 64, Parent = Tile,
                    })

                    Tile.MouseButton1Click:Connect(function()
                        local CurrentlySelected = IsSelected(Item.Value)
                        if DD.Multi then
                            DD.Value[Item.Value] = (not CurrentlySelected) or nil
                        else
                            DD.Value = CurrentlySelected and (DD.AllowNull and nil or Item.Value) or Item.Value
                        end
                        DD:Display()
                        Library:UpdateDependencyBoxes()
                        DD:RunChanged()
                        if not DD.Multi then
                            Tween(Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
                            task.delay(0.15, function() Dim:Destroy() end)
                        else
                            PopulateGrid()
                        end
                    end)
                end
            end
        end

        MSearch:GetPropertyChangedSignal("Text"):Connect(PopulateGrid)
        MClose.MouseButton1Click:Connect(function()
            Tween(Dim, { BackgroundTransparency = 1 }, Library.TweenInfo)
            task.delay(0.15, function() Dim:Destroy() end)
        end)

        PopulateGrid()
    end

    ModalBtn.MouseButton1Click:Connect(function()
        if not DD.Disabled then DD:OpenModalGrid() end
    end)
    Button.MouseButton1Click:Connect(function()
        if not DD.Disabled then Popup:Toggle() end
    end)

    function DD:OnChanged(F) DD.Changed = F end
    function DD:RunChanged()
        if DD.Disabled then return end
        Library:SafeCallback(DD.Callback, DD.Value)
        Library:SafeCallback(DD.Changed, DD.Value)
    end

    function DD:SetValue(V)
        if DD.Multi then
            local T = {}
            if typeof(V) == "table" then
                for _, Item in DD.Values do
                    if V[Item.Value] or table.find(V, Item.Value) then T[Item.Value] = true end
                end
            end
            DD.Value = T
        else
            DD.Value = V
        end
        DD:Display()
        DD:RunChanged()
    end

    function DD:SetValues(NewList)
        DD.Values = ParseEntries(NewList)
        DD:Display()
        if Popup.Active then DD:BuildList() end
    end

    DD:Display()
    Finalize(Group, DD, Holder, Options, Idx, Info)
    return DD
end

--// Search Remake: Style 1 (Inline Expand) & Style 2 (Spotlight Modal) \\--
local function JumpToElement(Element)
    local Group = Element.Parent
    local Tab = Group and Group.Tab
    if Tab and Tab.Show then
        Tab:Show()
        if Group.Collapsed then Group:SetCollapsed(false) end
        local Holder = Element.Holder
        if Holder and Tab.Sides then
            local Side = Holder:FindFirstAncestorWhichIsA("ScrollingFrame")
            if Side then
                Side.CanvasPosition = Vector2.new(0, math.max(0, Holder.AbsolutePosition.Y - Side.AbsolutePosition.Y + Side.CanvasPosition.Y - 40))
            end
        end
        -- Visual pulse animation on element
        local Stroke_ = Stroke(Holder, "Accent", 2, 0)
        Tween(Stroke_, { Transparency = 1 }, TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
        task.delay(1.2, function() Stroke_:Destroy() end)
    end
end

function Library:OpenSpotlightSearch()
    if Library.SpotlightOpen then return end
    Library.SpotlightOpen = true

    local Dim = New("TextButton", { BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 70, Parent = ScreenGui })
    Tween(Dim, { BackgroundTransparency = 0.5 }, Library.SlowTween)

    local Spot = New("Frame", {
        BackgroundColor3 = "Popup", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0.2, 0),
        Size = UDim2.fromOffset(500, 340), ZIndex = 71, ClipsDescendants = true, Parent = Dim,
    })
    Corner(Spot, 12)
    Stroke(Spot, "Outline", 1, 0.3)
    Grad(Spot, Two("Popup", 0.04, -0.02), 90)

    local Top = New("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 44), ZIndex = 72, Parent = Spot })
    Pad(Top, 0, 14, 0, 14)
    List(Top, 10, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
    Glyph(Top, "search", "⌕", { Size = UDim2.fromOffset(18, 18), Color = "Accent", ZIndex = 73 })

    local Input = New("TextBox", {
        BackgroundTransparency = 1, Size = UDim2.new(1, -60, 1, 0), PlaceholderText = "Search elements, toggles, features...",
        TextSize = 14, ClearTextOnFocus = false, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 73, Parent = Top,
    })

    local ResultsScroll = New("ScrollingFrame", {
        Position = UDim2.fromOffset(0, 46), Size = UDim2.new(1, 0, 1, -46),
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, ZIndex = 72, Parent = Spot,
    })
    List(ResultsScroll, 4)
    Pad(ResultsScroll, 6, 12, 10, 12)

    local function PopulateResults()
        for _, C in ResultsScroll:GetChildren() do
            if C:IsA("TextButton") then C:Destroy() end
        end
        local Q = NormalizeSearch(Input.Text)
        if Q == "" then return end

        for _, Tab in Library.TabList do
            for _, G in Tab.Groupboxes do
                for _, El in G.Elements do
                    if El.Text and Fuzzy(El.Text, Q) then
                        local Breadcrumb = string.format("%s > %s > %s: %s", Tab.Name, G.Name, El.Text, El.Type)
                        local Item = New("TextButton", {
                            BackgroundColor3 = "Control", Size = UDim2.new(1, 0, 0, 32),
                            Text = "", ZIndex = 73, Parent = ResultsScroll,
                        })
                        Corner(Item, 8)
                        Pad(Item, 0, 10, 0, 10)

                        local Lbl = New("TextLabel", {
                            Size = UDim2.fromScale(1, 1), Text = Breadcrumb, TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                            TextColor3 = "Text", ZIndex = 74, Parent = Item,
                        })

                        Item.MouseEnter:Connect(function() Tween(Item, { BackgroundColor3 = Library.Scheme.ControlHover }) end)
                        Item.MouseLeave:Connect(function() Tween(Item, { BackgroundColor3 = Library.Scheme.Control }) end)
                        Item.MouseButton1Click:Connect(function()
                            Library.SpotlightOpen = false
                            Dim:Destroy()
                            JumpToElement(El)
                        end)
                    end
                end
            end
        end
    end

    Input:GetPropertyChangedSignal("Text"):Connect(PopulateResults)
    Dim.MouseButton1Click:Connect(function()
        Library.SpotlightOpen = false
        Dim:Destroy()
    end)
    task.defer(function() Input:CaptureFocus() end)
end

--// Window Creation \\--
function Library:CreateWindow(WindowInfo)
    WindowInfo = Library:Validate(WindowInfo, Templates.Window)
    if Library.Window then warn("[Evergreen] Window exists.") return Library.Window end

    local Camera = workspace.CurrentCamera
    local View = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
    WindowInfo.Size = UDim2.fromOffset(
        math.clamp(WindowInfo.Size.X.Offset, WindowInfo.MinSize.X, math.max(WindowInfo.MinSize.X, View.X - 40)),
        math.clamp(WindowInfo.Size.Y.Offset, WindowInfo.MinSize.Y, math.max(WindowInfo.MinSize.Y, View.Y - 40))
    )

    Library:SetTheme(WindowInfo.Theme)
    if WindowInfo.Accent then Library:SetAccent(WindowInfo.Accent) end
    Library:SetDPIScale(WindowInfo.DPIScale)
    Library.ToggleKeybind = WindowInfo.ToggleKeybind

    local Window = { Info = WindowInfo }
    local SidebarWidth = WindowInfo.SidebarWidth
    local TitleH = 40

    local Root = New("Frame", {
        BackgroundTransparency = 1, Size = WindowInfo.Size, Visible = false, Parent = ScreenGui,
        Position = WindowInfo.Center and UDim2.new(0.5, -WindowInfo.Size.X.Offset / 2, 0.5, -WindowInfo.Size.Y.Offset / 2) or WindowInfo.Position,
    })
    Library.DPIScales[New("UIScale", { Scale = Library.DPIScale, Parent = Root })] = true

    local Main = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.fromScale(1, 1), ClipsDescendants = true, Parent = Root })
    Corner(Main, WindowInfo.CornerRadius)
    Stroke(Main, "Outline", 1, 0.25)
    Grad(Main, Two("Window", 0.05, -0.015), 125)
    local MainScale = New("UIScale", { Parent = Main })
    Window.Root, Window.MainFrame = Root, Main

    -- Titlebar
    local TitleBar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 0, TitleH), ZIndex = 3, Parent = Main })
    New("Frame", { BackgroundColor3 = "Outline", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 1), BackgroundTransparency = 0.3, Parent = TitleBar })
    Corner(TitleBar, WindowInfo.CornerRadius)
    Grad(TitleBar, Two("Titlebar", 0.07, -0.025), 90)
    Library:MakeDraggable(Root, TitleBar, true)

    if WindowInfo.ShowTrafficLights then
        local Lights = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Size = UDim2.fromOffset(64, 16), Parent = TitleBar })
        List(Lights, 8, Enum.FillDirection.Horizontal, nil, Enum.VerticalAlignment.Center)
        local function MakeLight(Color, Func)
            local B = New("TextButton", { BackgroundColor3 = Color, Size = UDim2.fromOffset(13, 13), Parent = Lights })
            Corner(B, 99)
            B.MouseButton1Click:Connect(Func)
        end
        MakeLight(Color3.fromRGB(255, 95, 87), function() Window:Toggle(false) end)
        MakeLight(Color3.fromRGB(254, 188, 46), function() Window:SetMinimized(not Window.Minimized) end)
        MakeLight(Color3.fromRGB(40, 200, 64), function() Window:SetMaximized(not Window.Maximized) end)
    end

    local TitleHolder = New("Frame", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -380, 1, 0), Parent = TitleBar })
    List(TitleHolder, 0, nil, Enum.HorizontalAlignment.Center, Enum.VerticalAlignment.Center)
    local TitleLabel = New("TextLabel", { Size = UDim2.new(1, 0, 0, 16), FontFace = "FontBold", Parent = TitleHolder })
    Library:ApplyCustomText(TitleLabel, WindowInfo.Title)

    -- Top Edge Search Implementation (Style 1 vs Style 2)
    if not WindowInfo.DisableSearch then
        if WindowInfo.SearchStyle == 2 then
            -- Style 2: Search Icon that opens Central Spotlight
            local SIconBtn = New("TextButton", {
                BackgroundColor3 = "Control", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.fromOffset(28, 28), Parent = TitleBar,
            })
            Corner(SIconBtn, 8)
            Glyph(SIconBtn, "search", "⌕", { AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(14, 14), Color = "Text" })
            SIconBtn.MouseButton1Click:Connect(function() Library:OpenSpotlightSearch() end)
        else
            -- Style 1: Expandable Search Bar on Top Edge
            local SearchPill = New("TextBox", {
                BackgroundColor3 = "Control", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.fromOffset(30, 26), PlaceholderText = "Search...", Text = "", ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left, ClipsDescendants = true, Parent = TitleBar,
            })
            Corner(SearchPill, 99)
            Pad(SearchPill, 0, 10, 0, 26)
            local SIcon = Glyph(SearchPill, "search", "⌕", { AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -18, 0.5, 0), Size = UDim2.fromOffset(14, 14) })

            SearchPill.Focused:Connect(function()
                Tween(SearchPill, { Size = UDim2.fromOffset(190, 26) })
            end)
            SearchPill.FocusLost:Connect(function()
                if SearchPill.Text == "" then Tween(SearchPill, { Size = UDim2.fromOffset(30, 26) }) end
            end)
            SearchPill:GetPropertyChangedSignal("Text"):Connect(function()
                Library:UpdateSearch(SearchPill.Text)
            end)
        end
    end

    -- Sidebar
    local Sidebar = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.fromOffset(0, TitleH), Size = UDim2.new(0, SidebarWidth, 1, -TitleH), Parent = Main })
    Corner(Sidebar, WindowInfo.CornerRadius)
    Grad(Sidebar, Two("Sidebar", 0.04, -0.02), 90)
    local TabsList = New("ScrollingFrame", { Size = UDim2.fromScale(1, 1), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, Parent = Sidebar })
    List(TabsList, 2)
    Pad(TabsList, 10, 8, 8, 8)

    -- Content
    local Content = New("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(SidebarWidth, TitleH), Size = UDim2.new(1, -SidebarWidth, 1, -TitleH), ClipsDescendants = true, Parent = Main })
    local Pages = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = Content })

    function Window:Toggle(Value)
        if Library.Unloaded then return end
        Library.Toggled = (Value ~= nil) and Value or not Library.Toggled
        Root.Visible = Library.Toggled
    end

    -- Tab Construction
    function Window:AddTab(...)
        local Name = ...
        if typeof(Name) == "table" then Name = Name.Name end
        Name = Name or "Tab"

        local Btn = New("TextButton", { BackgroundColor3 = "ControlHover", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 30), Parent = TabsList })
        Corner(Btn, 7)
        local BtnLabel = New("TextLabel", { Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -16, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, Parent = Btn })
        Library:ApplyCustomText(BtnLabel, Name)

        local Container = New("Frame", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = Pages })

        -- 2 Column Sides
        local SideLeft = New("ScrollingFrame", {
            Position = UDim2.fromScale(0, 0), Size = UDim2.fromScale(0.5, 1),
            AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, Parent = Container,
        })
        List(SideLeft, 12); Pad(SideLeft, 10, 8, 10, 12)

        local SideRight = New("ScrollingFrame", {
            Position = UDim2.fromScale(0.5, 0), Size = UDim2.fromScale(0.5, 1),
            AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, Parent = Container,
        })
        List(SideRight, 12); Pad(SideRight, 10, 12, 10, 8)

        -- Unified Single Scroll Container
        local SingleScroll = New("ScrollingFrame", {
            Position = UDim2.fromScale(0, 0), Size = UDim2.fromScale(1, 1),
            AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, Visible = false, Parent = Container,
        })
        List(SingleScroll, 12); Pad(SingleScroll, 10, 14, 10, 14)

        local Tab = {
            Name = Name, Button = Btn, Container = Container,
            Sides = { SideLeft, SideRight }, SingleScroll = SingleScroll,
            HasSingleBox = false, Groupboxes = {}, Tabboxes = {}, Pages = {},
        }

        function Tab:Show()
            if Library.ActiveTab then Library.ActiveTab:Hide() end
            Library.ActiveTab = Tab
            Container.Visible = true
            Tween(Btn, { BackgroundTransparency = 0 })
        end

        function Tab:Hide()
            Container.Visible = false
            Tween(Btn, { BackgroundTransparency = 1 })
        end

        function Tab:RefreshStyle()
            if Library.ActiveTab == Tab then
                Btn.BackgroundColor3 = Library.Scheme.Accent
                BtnLabel.TextColor3 = Library.Scheme.AccentText
            else
                Btn.BackgroundColor3 = Library.Scheme.ControlHover
                BtnLabel.TextColor3 = Library.Scheme.Text
            end
        end

        Btn.MouseButton1Click:Connect(function() Tab:Show() end)

        -- Add Single Groupbox (Full Width & Unified Scrolling)
        function Tab:AddSingleGroupbox(Info)
            if typeof(Info) == "string" then Info = { Name = Info } end
            Info.Side = "Single"

            -- Enable Unified Scroll Mode
            Tab.HasSingleBox = true
            SideLeft.Visible = false
            SideRight.Visible = false
            SingleScroll.Visible = true

            return Tab:AddGroupbox(Info)
        end

        -- Add Groupbox
        function Tab:AddGroupbox(Info)
            Info = Library:Validate(Info, Templates.Groupbox)

            local TargetParent
            if Info.Side == "Single" or Info.Side == 0 or Info.Side == "Full" then
                TargetParent = SingleScroll
            else
                TargetParent = (Info.Side == 2) and SideRight or SideLeft
            end

            local Card = New("Frame", { BackgroundColor3 = Color3.new(1, 1, 1), AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), Parent = TargetParent })
            Corner(Card, 10)
            Stroke(Card, "Outline", 1, 0.5)
            Grad(Card, Two("Card", 0.035, -0.015), 90)
            List(Card, 0)

            local Head = New("TextButton", { Size = UDim2.new(1, 0, 0, 36), Parent = Card })
            local HeadLabel = New("TextLabel", { Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -40, 1, 0), FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, Parent = Head })
            Library:ApplyCustomText(HeadLabel, Info.Name)

            local Arrow = Glyph(Head, "chevron-down", "▾", { AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.fromOffset(14, 14) })
            local Line = New("Frame", { BackgroundColor3 = "Outline", Size = UDim2.new(1, 0, 0, 1), LayoutOrder = 2, Parent = Card })
            local Body = New("Frame", { BackgroundTransparency = 1, AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = 3, Parent = Card })
            List(Body, 10)
            Pad(Body, 12, 12, 12, 12)

            local Groupbox = {
                Name = Info.Name, Collapsed = false, BoxHolder = Card, Holder = Card,
                Container = Body, Tab = Tab, Elements = {}, DependencyBoxes = {},
            }

            function Groupbox:SetCollapsed(C)
                Groupbox.Collapsed = C
                Body.Visible, Line.Visible = not C, not C
                Tween(Arrow, { Rotation = C and -90 or 0 }, Library.SlowTween)
            end

            Head.MouseButton1Click:Connect(function() Groupbox:SetCollapsed(not Groupbox.Collapsed) end)
            setmetatable(Groupbox, BaseGroupbox)
            table.insert(Tab.Groupboxes, Groupbox)
            return Groupbox
        end

        function Tab:AddLeftGroupbox(Name) return Tab:AddGroupbox({ Side = 1, Name = Name }) end
        function Tab:AddRightGroupbox(Name) return Tab:AddGroupbox({ Side = 2, Name = Name }) end

        table.insert(Library.TabList, Tab)
        if not Library.ActiveTab then Tab:Show() end
        return Tab
    end

    Window:Toggle(WindowInfo.AutoShow)
    Library.Window = Window
    return Window
end

--// Notification System \\--
local NotifyArea = New("Frame", {
    BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 12),
    Size = UDim2.new(0, 320, 1, -24), ZIndex = 80, Parent = ScreenGui,
})
List(NotifyArea, 8, Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Right)

function Library:Notify(Data)
    if typeof(Data) == "string" then Data = { Description = Data } end
    local Card = New("Frame", {
        BackgroundColor3 = "Popup", AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0), Parent = NotifyArea,
    })
    Corner(Card, 10)
    Stroke(Card, "Outline", 1, 0.4)
    Pad(Card, 8, 10, 8, 10)
    List(Card, 3)

    local Title = New("TextLabel", { Size = UDim2.new(1, 0, 0, 16), FontFace = "FontBold", TextXAlignment = Enum.TextXAlignment.Left, Parent = Card })
    Library:ApplyCustomText(Title, Data.Title or Library.AppName)

    local Desc = New("TextLabel", { AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(1, 0, 0, 0), TextSize = 12, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, Parent = Card })
    Library:ApplyCustomText(Desc, Data.Description or "")

    task.delay(Data.Time or 3.5, function()
        Tween(Card, { BackgroundTransparency = 1 }, Library.TweenInfo)
        task.delay(0.2, function() Card:Destroy() end)
    end)
end

getgenv().Library = Library
return Library
