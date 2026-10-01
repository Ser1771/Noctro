# Noctro API Reference

**Version:** 1.2.2  
**File:** `Files/Library.lua`

```lua
local Library = loadstring(game:HttpGet("…/Library.lua"))()
```

---

## Library

### Properties

| Name | Type | Default |
|------|------|---------|
| `Flags` | `{ [string]: { Value, Set, … } }` | `{}` |
| `Theme` | theme table | see Theme |
| `DefaultTheme` | theme table | defaults |
| `SectionDragEnabled` | `boolean` | `true` |
| `MenuKey` | `Enum.KeyCode` | `LeftAlt` |
| `MenuOpen` | `boolean` | `true` |
| `UIScale` | `number` | `1` |
| `Folder` | `string` | `"Noctro"` |
| `ConfigExtension` | `string` | `".json"` |
| `Autoload` | `string?` | `nil` |
| `NotifyPosition` | `string` | `"Top Right"` |
| `MaxNotifications` | `number` | `4` |
| `NotifyToggles` | `boolean` | `true` |
| `NotifyHistory` | `{ … }` | `{}` |
| `MaxNotifyHistory` | `number` | `40` |
| `Windows` | `{ Window }` | `{}` |

### Methods

```lua
Library:Window(props) -> Window
Library:KeySystem(props)
Library:LoadingScreen(props)
Library:BuildConfigPage(Window)
Library:UiButton(props) -> UiButton

Library.Notify(props) -> { Dismiss }
Library.ClearNotifications()
Library.SetWatermark(text?, enabled?)
Library.SetKeybindList(enabled?)
Library.UpdateKeybindList(name, keyText, active?, mode?)
Library.ToggleMenu(state?)
Library.Unload()
Library.SetScale(scale)
Library.SetConfigFolder(path)
Library.SaveConfig(name)
Library.LoadConfig(name)
Library.DeleteConfig(name)
Library.ListConfigs() -> { string }
Library.SetAutoload(name?)
Library.GetAutoload() -> string?
Library.GetConfig() -> table
Library.LoadConfigData(data)
Library.SetFlag(flag, value, transparency?)
Library.RegisterFlag(flag, entry)
Library.GetLayout()
Library.SaveLayout()
Library.ApplyLayout(layout)
Library.ApplyTheme()
Library.ThemeLink(object, property, key, key2?)
Library.SignOut()
Library.FormatExpiry(expiresAt) -> string
Library.GetKeyExpiryText() -> string
Library.Track(connection) -> connection?
Library.Connect(signal, fn) -> connection
Library.DisconnectAll()
```

---

## Library:Window

```lua
Library:Window({
	Title = "",
	Footer = "",
	Logo = nil,
	Icon = nil,
	TabStyle = "Icon" -- "Icon" | "IconText"
})
```

| Member | |
|--------|--|
| `Window:Page(props) -> Page` | |
| `Window.SetLogo(icon)` | |
| `Window.Canvas` | Frame |
| `Window.Pages` | `{ Page }` |
| `Window.TabStyle` | |
| `Window.TabEditMode` | |
| `Window.SidebarWidth` | |
| `Window.OpenNotifyHistory(state?)` | |
| `Window.RefreshNotifyHistory()` | |

---

## Page

```lua
Window:Page({ Icon = "box", Name = "" })
```

| Member | |
|--------|--|
| `Page:SubPage(props) -> SubPage` | |
| `Page.Open()` / `Page.Close()` | |
| `Page.SubPages` | |
| `Page.ActiveSubPage` | |
| `Page.Button` / `Page.IconLabel` / `Page.Label` | |

---

## SubPage

```lua
Page:SubPage({ Name = "" })
```

| Member | |
|--------|--|
| `SubPage:Section(props) -> Section` | |
| `SubPage.Open()` / `SubPage.Close()` | |

---

## Section

```lua
SubPage:Section({
	Name = "",
	Icon = "box",
	Side = "Left",
	Collapsible = false,
	Collapsed = false,
	Drag = true
})
```

| Member | |
|--------|--|
| `Section:Label` `Slider` `Dropdown` `Input` `Button` `Paragraph` `Divider` `Spacer` `Card` | |
| `Section.SetCollapsed(state?)` | |
| `Section.Content` `Section.Frame` `Section.Side` | |

`Library.SectionDragEnabled = false` — lock all section drag.

---

## Elements

### Label

```lua
Section:Label({ Text = "", RichText = true })
```

`Label:Toggle` · `Label:Keybind` · `Label:Colorpicker` · `Label.SetText(text)` · `LeftContent` · `RightContent`

### Toggle

```lua
Label:Toggle({
	State = false,
	Flag = nil,
	Disabled = false,
	Callback = function(state) end
})
```

`Toggle.Set(state?, silent?)` · `Toggle.SetDisabled(state)`

### Keybind

```lua
Label:Keybind({
	Title = "",
	Key = Enum.KeyCode.E,
	Type = "Toggle", -- "Toggle" | "Hold"
	Flag = nil,
	Callback = function() end
})
```

`Keybind.Set(key)` · `Keybind.SetType(type)` · `Keybind.Open(state?)` · `Keybind.Close()`

### Colorpicker

```lua
Label:Colorpicker({
	Title = "",
	Color = Color3.new(1, 1, 1),
	Transparency = 0,
	Flag = nil,
	Callback = function(color, transparency) end
})
```

`Colorpicker.Set(color?, transparency?)` · `Colorpicker.Toggle(state?)` · `Colorpicker.Close()`

### Slider

```lua
Section:Slider({
	Name = "",
	Value = 0,
	Min = 0,
	Max = 1,
	Increment = 0.1,
	Suffix = "",
	Flag = nil,
	Disabled = false,
	Callback = function(value) end
})
```

`Slider.Set(value)` · `Slider.SetDisabled(state)`

### Dropdown

```lua
Section:Dropdown({
	Name = "",
	Options = {},
	Value = "" , -- or {} if Multi
	Multi = false,
	Search = false,
	MaxHeight = 180,
	Flag = nil,
	Disabled = false,
	Callback = function(value) end
})
```

`Dropdown.Set(value)` · `Dropdown.UpdateOptions(options)` · `Dropdown.Open(state?)` · `Dropdown.OpenExpand(state?)` · `Dropdown.Close()` · `Dropdown.SetDisabled(state)`

### Input

```lua
Section:Input({
	Name = "",
	Value = "",
	Placeholder = "",
	Flag = nil,
	Callback = function(text) end
})
```

`Input.Set(value)`

### Button

```lua
Section:Button({
	Name = "Button",
	Callback = function() end,
	Height = 30,
	Width = 1,
	Disabled = false,
	RichText = false
})
```

`Button.SetText(text)` · `Button.SetDisabled(state)`

### Paragraph

```lua
Section:Paragraph({ Title = "", Body = "", RichText = true })
```

`Paragraph.SetTitle(text)` · `Paragraph.SetBody(text)`

### Divider

```lua
Section:Divider({ Text = "", Height = 12 })
```

### Spacer

```lua
Section:Spacer({ Height = 10 })
```

### Card

```lua
Section:Card({
	Title = "",
	Subtitle = "",
	Icon = nil,
	Body = "",
	Image = nil,
	ImageHeight = 80,
	Background = nil,
	BackgroundTransparency = 0,
	Stroke = true,
	StrokeColor = nil,
	Corner = 8,
	Padding = 12,
	Width = 1,
	OnClick = nil,
	Buttons = {
		{ Name = "", Style = "Surface", Callback = function() end }
	},
	Badge = nil,
	Gradient = nil,
	RichText = true
})
```

Button `Style`: `"Accent"` | `"Surface"` | `"Ghost"` | `"Danger"`

`SetTitle` · `SetSubtitle` · `SetBody` · `SetBackground(bg, transparency?)` · `SetImage(image, height?)` · `AddButton(def)` · `ClearButtons()` · `SetBadge(text?)` · `SetVisible(bool)` · `Content` · `Frame` · `Inner`

---

## Flags

```lua
Library.Flags["AimbotEnabled"].Value
Library.SetFlag("AimbotEnabled", true)
```

| Control | `.Value` |
|---------|----------|
| Toggle | `boolean` |
| Slider | `number` |
| Dropdown | `string` |
| Multi | `{ string }` |
| Input | `string` |

---

## Config

```lua
Library.SetConfigFolder("MyScript")
Library.SaveConfig("default")
Library.LoadConfig("default")
Library.DeleteConfig("default")
Library.ListConfigs()
Library.SetAutoload("default")
Library.GetAutoload()
Library.GetConfig()
Library.LoadConfigData(data)
Library:BuildConfigPage(Window)
```

---

## Notify

```lua
Library.Notify({
	Title = "Notification",
	Text = "",
	Type = "Info",
	Duration = 4,
	Icon = nil,
	RichText = true,
	Action = { Text = "OK", Callback = function() end }
})

Library.ClearNotifications()
Library.NotifyPosition = "Top Right"
Library.MaxNotifications = 4
Library.NotifyToggles = true
```

`Window.OpenNotifyHistory(state?)` · `Library.NotifyHistory`

---

## Overlays / menu

```lua
Library.SetWatermark(text?, enabled?)
Library.SetKeybindList(enabled?)
Library.UpdateKeybindList(name, keyText, active?, mode?)
Library.MenuKey = Enum.KeyCode.LeftAlt
Library.ToggleMenu(state?)
Library.SetScale(1)
Library.Unload()
```

### UiButton

```lua
Library:UiButton({
	Icon = "menu",
	Text = nil,
	Size = 44,
	Position = nil,
	Draggable = true,
	Callback = function(open) end
})
```

`SetVisible` · `SetIcon` · `SetText` · `Sync` · `Destroy`

---

## Theme

```lua
Library.Theme = {
	Accent = Color3.fromRGB(138, 156, 229),
	AccentDark = Color3.fromRGB(78, 88, 129),
	Background = Color3.fromRGB(9, 8, 8),
	Surface = Color3.fromRGB(15, 14, 15),
	SurfaceAlt = Color3.fromRGB(20, 20, 21),
	Border = Color3.fromRGB(36, 37, 37),
	SectionBorder = Color3.fromRGB(32, 33, 36),
	Text = Color3.fromRGB(255, 255, 255),
	TextDim = Color3.fromRGB(180, 184, 200),
}
Library.ApplyTheme()
Library.ThemeLink(instance, property, key, key2?)
```

---

## KeySystem

```lua
Library:KeySystem({
	Title = "Login",
	Placeholder = "License key",
	ButtonText = "Sign in",
	Remember = true,
	ShowExpiry = true,
	WatermarkExpiry = true,
	GetKey = "",
	Validate = function(key, finish)
		return true, os.time() + 86400, nil
		-- or finish(success, expiresAt?, error?)
	end
})

Library.SignOut()
Library.FormatExpiry(expiresAt)
Library.GetKeyExpiryText()
Library.Auth
```

---

## LoadingScreen

```lua
Library:LoadingScreen({
	Title = "",
	Subtitle = "",
	Duration = 1.25
})
```

---

## Hierarchy

```
Library:Window
  → Window:Page
    → Page:SubPage
      → SubPage:Section
        → :Label → :Toggle | :Keybind | :Colorpicker
        → :Slider | :Dropdown | :Input | :Button
        → :Paragraph | :Divider | :Spacer | :Card
```
