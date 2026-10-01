# Noctro

Roblox Luau UI library for executor scripts — windows, pages, sections, flags, themes, configs, and overlays.

**Current version:** `1.2.2`

```
Ui/Noctro/
  Files/Library.lua    ← main library
  Files/Example.lua    ← full demo
  Backups/             ← versioned snapshots
  README.md
```

---

## Quick start

```lua
local Noctro = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ser1771/Noctro/refs/heads/main/Library.lua"))()

Noctro.SetConfigFolder("MyScript")

-- Optional key system — omit entirely if you don't need it
-- Noctro:KeySystem({ ... })

Noctro:LoadingScreen({ Title = "MyScript"; Subtitle = "Loading…"; Duration = 1 })

Noctro.SetWatermark("MyScript", true)
Noctro.SetKeybindList(true)

-- Floating show/hide button (optional)
Noctro:UiButton({ Icon = "menu"; Draggable = true })

local Window = Noctro:Window({
	Title = "MyScript";
	Footer = ".gg/example";
	TabStyle = "IconText"; -- or "Icon"
})

local Combat = Window:Page({ Icon = "swords"; Name = "Combat" })
local Aimbot = Combat:SubPage({ Name = "Aimbot" })
local Main = Aimbot:Section({ Name = "Main"; Side = "Left"; Icon = "crosshair" })

local Enable = Main:Label({ Text = "Enable" })
Enable:Toggle({ State = false; Flag = "AimbotEnabled"; Callback = function(On) end })
Enable:Keybind({ Key = Enum.KeyCode.E; Type = "Toggle"; Flag = "AimbotKey"; Callback = function() end })

Main:Slider({ Name = "FOV"; Value = 90; Min = 1; Max = 180; Flag = "AimbotFOV"; Callback = function() end })

Noctro:BuildConfigPage(Window)
Noctro.Notify({ Title = "Ready"; Text = "Loaded"; Type = "Success"; Duration = 3 })
```

---

## Structure

```
Library
 └─ Window
     └─ Page          (sidebar tab)
         └─ SubPage   (header tabs)
             └─ Section (Left / Right column)
                 └─ elements…
```

| Level | API |
|-------|-----|
| Window | `Library:Window({ Title, Footer, TabStyle, Icon })` |
| Page | `Window:Page({ Icon, Name })` |
| SubPage | `Page:SubPage({ Name })` |
| Section | `SubPage:Section({ Name, Side, Icon, Collapsible, Collapsed, Drag })` |

**TabStyle**

- `"Icon"` — compact icon-only sidebar (default)
- `"IconText"` — wider sidebar; uses `Page.Name` as label

---

## Elements

Created on a **Section** (or Label for sub-elements):

| Method | Main props |
|--------|------------|
| `:Label` | `Text`, `RichText` → then `:Toggle` / `:Keybind` / `:Colorpicker` |
| `:Toggle` | `State`, `Flag`, `Disabled`, `Callback` |
| `:Slider` | `Name`, `Value`, `Min`, `Max`, `Increment`, `Suffix`, `Flag`, `Disabled` |
| `:Dropdown` | `Name`, `Options`, `Value`, `Multi`, `Search`, `MaxHeight`, `Flag`, `Disabled` |
| `:Input` | `Name`, `Value`, `Placeholder`, `Flag` |
| `:Button` | `Name`, `Callback`, `Width` (0.2–1), `Height`, `Disabled` |
| `:Paragraph` | `Title`, `Body`, `RichText` |
| `:Divider` | `Text?`, `Height` |
| `:Spacer` | `Height` |
| `:Card` | see [Card](#card) below |

### Label sub-elements

```lua
local Row = Section:Label({ Text = "Aimbot" })
Row:Toggle({ State = false; Flag = "AimbotEnabled"; Callback = function(On) end })
Row:Keybind({ Key = Enum.KeyCode.E; Type = "Hold"; Flag = "AimbotKey"; Callback = function() end })
Row:Colorpicker({ Color = Color3.fromRGB(255, 80, 80); Flag = "AimbotColor"; Callback = function() end })
```

### Dropdown extras

- Compact list scrolls with `MaxHeight` (default `180`)
- **Maximize** button → centered modal; Multi gets **Select all / Deselect all**
- Empty list shows “No options”

```lua
Section:Dropdown({
	Name = "ESP";
	Multi = true;
	Options = { "Box", "Name", "Health" };
	Value = { "Box" };
	Search = true;
	Flag = "ESPModes";
	Callback = function(V) end;
})
```

### Card

```lua
Section:Card({
	Title = "Premium";
	Subtitle = "Optional";
	Icon = "star";
	Badge = "NEW";
	Body = "Supports <b>RichText</b>";
	Background = "SurfaceAlt"; -- or Color3
	Buttons = {
		{ Name = "Get key"; Style = "Accent"; Callback = function() end },
		{ Name = "Later"; Style = "Ghost"; Callback = function() end },
	};
})

-- Styles: Accent | Surface | Ghost | Danger
-- Runtime: SetTitle, SetBody, SetBackground, AddButton, SetBadge, Content (Frame)
```

### Sections

```lua
Section({
	Name = "Main";
	Side = "Left"; -- or "Right"
	Icon = "crosshair";
	Collapsible = true;
	Collapsed = false;
	Drag = true; -- false = never reorder this section
})

Section:SetCollapsed(true)
```

```lua
Library.SectionDragEnabled = false -- lock all section reordering
```

---

## Flags

Flags store values and drive **config save/load**.

```lua
-- Attach
Toggle({ Flag = "AimbotEnabled"; State = false; Callback = function(On) end })

-- Read
local On = Library.Flags["AimbotEnabled"].Value

-- Safe read
local Entry = Library.Flags["AimbotEnabled"]
if Entry and Entry.Value then
	-- ...
end

-- Write (updates UI when Set is registered)
Library.SetFlag("AimbotEnabled", true)
Library.SetFlag("AimbotFOV", 120)
```

| Control | `.Value` type |
|---------|----------------|
| Toggle | `boolean` |
| Slider | `number` |
| Dropdown | `string` |
| Multi dropdown | `{ string }` |
| Input | `string` |
| Keybind / Colorpicker | see flag entry |

Use **unique, stable** flag names. Renaming a flag drops old config data for that key.

---

## Configs

```lua
Library.SetConfigFolder("MyScript")

Library.SaveConfig("default")
Library.LoadConfig("default")
Library.DeleteConfig("default")
Library.ListConfigs()           -- { "default", ... }
Library.SetAutoload("default")
Library.GetAutoload()

Library.GetConfig()             -- snapshot table
Library.LoadConfigData(data)

Library:BuildConfigPage(Window) -- built-in Configs / Theme / Menu UI
```

Requires executor FS (`writefile` / `readfile` / `isfolder` / `makefolder`).

---

## Notifications

```lua
Library.Notify({
	Title = "Saved";
	Text = "Config <b>default</b> written";
	Type = "Success"; -- Info | Success | Warning | Error
	Duration = 3;
	RichText = true;
	Action = { Text = "OK"; Callback = function() end };
})

Library.ClearNotifications()
Library.NotifyPosition = "Top Right" -- Top/Bottom × Left/Right
Library.MaxNotifications = 4
Library.NotifyToggles = true         -- toast when toggles flip
```

**History:** bell button next to the window search bar opens a history panel (Clear all included).

---

## Overlays & menu

```lua
Library.SetWatermark("MyScript", true)
Library.SetKeybindList(true)
Library.MenuKey = Enum.KeyCode.LeftAlt
Library.ToggleMenu()           -- or ToggleMenu(true/false)
Library.SetScale(1.0)          -- 0.75–1.25

Library:UiButton({
	Icon = "menu";
	Text = nil;
	Size = 44;
	Draggable = true;
	Callback = function(open) end;
})

Library.Unload()               -- destroy UI + disconnect tracked connections
```

---

## Theme

```lua
Library.Theme.Accent = Color3.fromRGB(138, 156, 229)
Library.Theme.AccentDark = Color3.fromRGB(78, 88, 129)
Library.Theme.Background = Color3.fromRGB(9, 8, 8)
Library.Theme.Surface = Color3.fromRGB(15, 14, 15)
Library.Theme.SurfaceAlt = Color3.fromRGB(20, 20, 21)
Library.Theme.Border = Color3.fromRGB(36, 37, 37)
Library.Theme.Text = Color3.fromRGB(255, 255, 255)
Library.ApplyTheme()
```

Live links use `Library.ThemeLink(instance, property, key)`.

---

## Optional key system

```lua
Library:KeySystem({
	Title = "Login";
	Placeholder = "License key";
	ButtonText = "Sign in";
	Remember = true;
	ShowExpiry = true;
	GetKey = "discord.gg/example";
	Validate = function(key, finish)
		if key == "secret" then
			return true, os.time() + 7 * 86400 -- success + expiry
		end
		return false, nil, "Invalid key"
	end;
})
```

Omit the whole block if you don’t need a lock screen.

---

## Library API summary

| API | Purpose |
|-----|---------|
| `:Window` | Main window |
| `:KeySystem` | Optional login |
| `:LoadingScreen` | Splash |
| `:BuildConfigPage` | Config / theme / menu page |
| `:UiButton` | Floating menu toggle |
| `Notify` | Toast |
| `ClearNotifications` | Dismiss toasts |
| `SetWatermark` / `SetKeybindList` | Overlays |
| `SetScale` | UI scale |
| `ToggleMenu` / `Unload` | Visibility / cleanup |
| `SaveConfig` / `LoadConfig` / … | Persistence |
| `SetFlag` / `Flags` | State |
| `SectionDragEnabled` | Global section reorder lock |
| `Track` / `Connect` / `DisconnectAll` | Connection hygiene |

---

## Example

See `Files/Example.lua` for a full Lumen-style layout, including:

- IconText tabs  
- Multi dropdown + modal expand  
- Settings → **Library** (section drag lock, scale, overlays, notify options)  
- Settings → **General** (control showcase)  
- Cards, dividers, collapsible sections  

---

## Notes

- Designed for **executor** environments (filesystem + `CoreGui` / `PlayerGui` fallback).
- Icons resolve via built-in Lucide-style name map (`"swords"`, `"settings"`, …) or `rbxassetid://…`.
- Public API is additive across 1.x versions; prefer new flags/props over breaking renames.
