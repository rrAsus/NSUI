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
