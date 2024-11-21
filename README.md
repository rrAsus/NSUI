# NSUI
### Info :
- This is a modified version of Arrayfield which is a modified version of Rayfield
---
### Features : 
- Fixes
- Improvements
- Some New Features
---
### Used by :
- [Hexen Universal](https://github.com/Teremanphius/HexUni.Dev)
---
### How to use : 
#### Main Loadstring : 
```lua
local NSUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/rrAsus/NSUI/main/main.lua"))()
```
Refer to most things in [Arrayfield](https://arraydocumentation.vercel.app/en/windows), to boot up the window and such, but replace Rayfield with NSUI.

---
##### `SectionName = Tab:CreateSection("Name", Boolean1, Boolean2, data)`
**Creates a section with optional features.**
- **Parameters:**
  - `data` *(number)*: Specifies an image to display in the section's corner. If not provided, no image is shown.
  - `Boolean1` *(boolean)*: If `true`, the section is static (non-collapsible) and acts as a label with no image.
  - `Boolean2` *(boolean)*: Applies when `Boolean1` is `false`.  
    - If `true`, the section is collapsible (folded).  
    - If `false`, the section displays its contents.
---
##### `Spacing = Tab:CreateSpacing(section, number)`
**Creates spacing between elements in a section.**
- **Parameters:**
  - `section` *(Section)*: The section where the spacing will be applied.
  - `number` *(number)*: The amount of spacing, in pixels, between elements in the section.
- **Notes:**  
  This function only works when a valid `section` is provided (If I'm not wrong).
---
##### About `CanBeToggled`
The `CanBeToggled` parameter controls whether the keybind can enable or disable a feature when pressed.
- **Type:** *(boolean)*  
- **Functionality:**
  - If `true`, pressing the keybind toggles the associated feature on or off.
  - If `false`, the keybind does not toggle functionality—it only triggers the action once when pressed.
This parameter is part of the following function:
```lua
Keybind = Tab:CreateKeybind({
    Name = "Keybind",
    CurrentKeybind = "Set Keybind",
    CanBeToggled = true,
    HoldToInteract = false,
    SectionParent = SectionName,
    Callback = function(KeyBind)
        -- Your code here
    end
})
```
---
##### About `Set` Function for Keybinds
The `Set` function allows you to programmatically change or reset a keybind.
- **Usage:**  
  You can call `Keybind:Set("Set Keybind")` to reset the keybind. If the string is `"Set Keybind"`, it will unbind the key, making the keybind inactive.
- **Example:**  
  Here's how you can create a button to reset a keybind:
```lua
Button = Tab:CreateButton({
      SectionParent = Section,
      Name = "Reset Keybind Button",
      Callback = function()
          Keybind:Set("Set Keybind")
      end
  })
```
---
#### Functions :

##### `HDXLib:IsNumeric(data)`
**Checks if the input data is numeric.**  
- **Parameters:**  
  `data` *(any)* – The data to validate.  
- **Returns:**  
  `true` if `data` is numeric, `false` otherwise.
---
##### `HDXLib:IsAlpha(data)`
**Checks if the input data contains only alphabetic characters.**  
- **Parameters:**  
  `data` *(any)* – The data to validate.  
- **Returns:**  
  `true` if `data` is alphabetic, `false` otherwise.
---
##### `HDXLib:IsAlphaAndOrNumeric(data)`
**Checks if the input data contains only alphanumeric characters.**  
- **Parameters:**  
  `data` *(string)* – The data to validate.  
- **Returns:**  
  `true` if `data` is alphanumeric, `false` otherwise.
---
##### `HDXLib:GetPlayerThumbnail(data, thumbnailtype)`
**Generates a player's thumbnail.**  
- **Parameters:**  
  `data` *(string/number/Player)* – The player's name, UserId, or Player object.  
  `thumbnailtype` *(string)* – The type of thumbnail. Options: `"AvatarBust"`, `"AvatarThumbnail"`, `"HeadShot"`.  
- **Returns:**  
  A URL to the thumbnail image. Defaults to `rbxassetid://284402785` if invalid.
---
##### `HDXLib:IsR15(plr)`
**Checks if a player's character uses the R15 rig.**  
- **Parameters:**  
  `plr` *(Player)* – The player to check.  
- **Returns:**  
  `true` if the character is R15, `false` otherwise.
---
##### `HDXLib:FFC(instance, name)`
**Finds a child of the given instance by name.**  
- **Parameters:**  
  `instance` *(Instance)* – The parent instance.  
  `name` *(string)* – The name of the child.  
- **Returns:**  
  The child if found, `nil` otherwise.
---
##### `HDXLib:FFCOC(instance, class)`
**Finds a child of the given instance by class.**  
- **Parameters:**  
  `instance` *(Instance)* – The parent instance.  
  `class` *(string)* – The class name to search for.  
- **Returns:**  
  The child of the specified class if found, `nil` otherwise.
---
##### `HDXLib:AllTrue(conditions)`
**Checks if all conditions in the list are `true`.**  
- **Parameters:**  
  `conditions` *(table)* – A list of boolean values.  
- **Returns:**  
  `true` if all values are `true`, `false` otherwise.
