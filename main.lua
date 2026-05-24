-- Paint's improved forked modification
-- ArrayField Interface Suite by Meta | Original by Sirius
-- Credits to rightful owners | https://docs.sirius.menu/community/arrayfield

-- THIS IS STILL NSUI, JUST RENAMED!

local Version = string.gsub("BUILD_V78", "^%s*(.-)%s*$", "%1")
local Release = "Build 78"
local NotificationDuration = 6.5
local plr_name = game:GetService("Players").LocalPlayer.Name
local NSUIFolder = "NSUI"
local ConfigurationFolder = NSUIFolder.."/Configurations"
local ConfigurationExtension = ".NSUI"
local NSUIQuality = {}
local latest = string.gsub(game:HttpGet("https://raw.githubusercontent.com/rrAsus/NSUI/refs/heads/main/version.txt"), "^%s*(.-)%s*$", "%1")
local NSUILib = {
    Flags = {},
    Theme = {
        Default = {
            TextFont = "Default", -- Default will use the various font faces used across NSUI
            TextColor = Color3.fromRGB(240, 240, 240),

            Background = Color3.fromRGB(25, 25, 25),
            Topbar = Color3.fromRGB(34, 34, 34),
            Shadow = Color3.fromRGB(20, 20, 20),

            NotificationBackground = Color3.fromRGB(20, 20, 20),
            NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

            TabBackground = Color3.fromRGB(80, 80, 80),
            TabStroke = Color3.fromRGB(85, 85, 85),
            TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
            TabTextColor = Color3.fromRGB(240, 240, 240),
            SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

            ElementBackground = Color3.fromRGB(35, 35, 35),
            ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
            SecondaryElementBackground = Color3.fromRGB(25, 25, 25), -- For labels and paragraphs
            ElementStroke = Color3.fromRGB(50, 50, 50),
            SecondaryElementStroke = Color3.fromRGB(40, 40, 40), -- For labels and paragraphs

            SliderBackground = Color3.fromRGB(43, 105, 159),
            SliderProgress = Color3.fromRGB(43, 105, 159),
            SliderStroke = Color3.fromRGB(48, 119, 177),

            ToggleBackground = Color3.fromRGB(30, 30, 30),
            ToggleEnabled = Color3.fromRGB(0, 146, 214),
            ToggleDisabled = Color3.fromRGB(100, 100, 100),
            ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
            ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
            ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
            ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),

            InputBackground = Color3.fromRGB(30, 30, 30),
            InputStroke = Color3.fromRGB(65, 65, 65),
            PlaceholderColor = Color3.fromRGB(178, 178, 178)
        },
        Light = {
            TextFont = "Gotham",  -- Default will use the various font faces used across NSUI
            TextColor = Color3.fromRGB(50, 50, 50), -- i need to make all text 240, 240, 240 and base gray on transparency not color to do this

            Background = Color3.fromRGB(255, 255, 255),
            Topbar = Color3.fromRGB(217, 217, 217),
            Shadow = Color3.fromRGB(223, 223, 223),

            NotificationBackground = Color3.fromRGB(20, 20, 20),
            NotificationActionsBackground = Color3.fromRGB(230, 230, 230),

            TabBackground = Color3.fromRGB(220, 220, 220),
            TabStroke = Color3.fromRGB(112, 112, 112),
            TabBackgroundSelected = Color3.fromRGB(0, 142, 208),
            TabTextColor = Color3.fromRGB(240, 240, 240),
            SelectedTabTextColor = Color3.fromRGB(50, 50, 50),

            ElementBackground = Color3.fromRGB(198, 198, 198),
            ElementBackgroundHover = Color3.fromRGB(230, 230, 230),
            SecondaryElementBackground = Color3.fromRGB(136, 136, 136), -- For labels and paragraphs
            ElementStroke = Color3.fromRGB(180, 199, 97),
            SecondaryElementStroke = Color3.fromRGB(40, 40, 40),  --For labels and paragraphs

            SliderBackground = Color3.fromRGB(31, 159, 71),
            SliderProgress = Color3.fromRGB(31, 159, 71),
            SliderStroke = Color3.fromRGB(42, 216, 94),

            ToggleBackground = Color3.fromRGB(170, 203, 60),
            ToggleEnabled = Color3.fromRGB(32, 214, 29),
            ToggleDisabled = Color3.fromRGB(100, 22, 23),
            ToggleEnabledStroke = Color3.fromRGB(17, 255, 0),
            ToggleDisabledStroke = Color3.fromRGB(65, 8, 8),
            ToggleEnabledOuterStroke = Color3.fromRGB(0, 170, 0),
            ToggleDisabledOuterStroke = Color3.fromRGB(170, 0, 0),

            InputBackground = Color3.fromRGB(31, 159, 71),
            InputStroke = Color3.fromRGB(19, 65, 31),
            PlaceholderColor = Color3.fromRGB(178, 178, 178)
        },

    }
}

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = game:GetService("Players").LocalPlayer

-- Interface Management
local NSUI = game:GetObjects("rbxassetid://13067385695")[1]
NSUI.Enabled = false

local spawn = task.spawn
local delay = task.delay

--Studio
if RunService:IsStudio() then
    local http_request, http = nil , nil
    
    local syn = { protect_gui = false, request = false }
    
    function writefile(tt,t,ttt) end
    function isfolder(t) end
    function makefolder(t) end
    function isfile(r) end
    function readfile(t) end
    function gethui() return NSUI end
end

pcall(function()
    _G.LastNSUI.Name = "Old NSUI"
    _G.LastNSUI.Enabled = false
end)

local ParentObject = function(Gui)
    local success, failure = pcall(function()
        if get_hidden_gui or gethui then
            local hiddenUI = get_hidden_gui or gethui
            Gui.Parent = hiddenUI()
        elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
            syn.protect_gui(Gui)
            Gui.Parent = CoreGui
        elseif CoreGui then
            Gui.Parent = CoreGui
        end
    end)
    if not success and failure then
        Gui.Parent = LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
    end
    _G.LastNSUI = NSUI
end
ParentObject(NSUI)

--Object Variables

local Camera = workspace.CurrentCamera
local Main = NSUI.Main
local Topbar = Main.Topbar
local Elements = Main.Elements
local LoadingFrame = Main.LoadingFrame
local TopList = Main.TabList
local SideList = Main.SideTabList.Holder
local TabsList = TopList and SideList
local SearchBar = Main.Searchbar
local Filler = SearchBar.CanvasGroup.Filler
local Prompt = Main.Prompt
local NotePrompt = Main.NotePrompt

NSUI.DisplayOrder = 100
LoadingFrame.Version.Text = Release


--Variables
local request = (syn and syn.request) or (http and http.request) or http_request
local CFileName = nil
local CEnabled = false
local Minimised = false
local Hidden = false
local Debounce = false
local clicked = false
local SearchHided = true
local SideBarClosed = true
local InfoPromptOpen = false
local BarType = "Side"
local HoverTime = 0.3
local Notifications = NSUI.Notifications

-- ── NSUI Global Search & Pin System ──────────────────────────────────────────
local LastActivePage       = nil
local NSUIPinnedFile       = NSUIFolder .. "/Pinned.NSUI"
local TabNavRegistry       = {}   -- [tabName] = { page, navigate }
local GlobalSearchActive   = false
local SearchResultsPage    = nil

-- Active pinned windows: key = "tabName|sectionName" → Frame
local ActivePinnedWindows  = {}

-- Save all open pinned windows to file
local function SavePinnedFile()
    pcall(function()
        if not isfolder then return end
        if not isfolder(NSUIFolder) then makefolder(NSUIFolder) end
        local tbl = {}
        for key, win in pairs(ActivePinnedWindows) do
            if win and win.Parent then
                tbl[#tbl + 1] = {
                    key     = key,
                    tab     = win:GetAttribute("_PinTab"),
                    section = win:GetAttribute("_PinSection"),
                    x       = win.Position.X.Offset,
                    y       = win.Position.Y.Offset,
                }
            end
        end
        writefile(NSUIPinnedFile, HttpService:JSONEncode(tbl))
    end)
end

-- Build a row inside a pinned window for one element from the section holder
local function BuildPinnedRow(element, winContent, zBase)
    if not element:IsA("Frame") then return end
    if element.Name == "Placeholder" or element.Name == "SectionSpacing" then return end

    -- Detect element type from its children structure
    local isToggle      = element:FindFirstChild("Switch") ~= nil
    local isSlider      = element:FindFirstChild("Main") ~= nil and element:FindFirstChild("Main"):FindFirstChild("Progress") ~= nil
    local isColorPicker = element:FindFirstChild("CPBackground") ~= nil
    local isDropdown    = element:FindFirstChild("Selected") ~= nil and element:FindFirstChild("List") ~= nil
    local isInput       = element:FindFirstChild("InputFrame") ~= nil and not isDropdown
    local isKeybind     = element:FindFirstChild("KeybindFrame") ~= nil
    local isButton      = element:FindFirstChild("ElementIndicator") ~= nil and not isToggle and not isSlider and not isDropdown and not isColorPicker
    local isParagraph   = element:FindFirstChild("Content") ~= nil
    local isLabel       = not isToggle and not isSlider and not isButton and not isInput and not isKeybind and not isDropdown and not isColorPicker and not isParagraph

    -- Row height by type
    local rowH = 38
    if isSlider       then rowH = 54 end
    if isInput        then rowH = 46 end
    if isKeybind      then rowH = 46 end
    if isDropdown     then rowH = 42 end
    if isColorPicker  then rowH = 42 end
    if isParagraph    then rowH = 50 end

    -- Get label text
    local labelText = element.Name
    pcall(function()
        if element:FindFirstChild("Title") and element.Title.Text ~= "" then
            labelText = element.Title.Text
        end
    end)

    -- ── Row container ────────────────────────────────────────────────────
    local Row = Instance.new("Frame")
    Row.Name                    = element.Name
    Row.Size                    = UDim2.new(1, -2, 0, rowH)
    Row.BackgroundColor3        = Color3.fromRGB(32, 32, 32)
    Row.BackgroundTransparency  = 0
    Row.BorderSizePixel         = 0
    Row.ZIndex                  = zBase + 1
    Row.ClipsDescendants        = true
    Row.Parent                  = winContent

    local rc = Instance.new("UICorner")
    rc.CornerRadius = UDim.new(0, 6)
    rc.Parent = Row

    local rs = Instance.new("UIStroke")
    rs.Color     = Color3.fromRGB(50, 50, 50)
    rs.Thickness = 1
    rs.Parent    = Row

    -- Label
    local Lbl = Instance.new("TextLabel")
    Lbl.Size               = UDim2.new(0.54, -4, 0, 18)
    Lbl.Position           = UDim2.new(0, 9, 0, if isSlider then 4 else 0)
    Lbl.AnchorPoint        = Vector2.new(0, if isSlider then 0 else 0.5)
    if not isSlider then Lbl.Position = UDim2.new(0, 9, 0.5, 0) end
    Lbl.BackgroundTransparency = 1
    Lbl.Text               = labelText
    Lbl.TextColor3         = Color3.fromRGB(210, 210, 210)
    Lbl.Font               = Enum.Font.GothamBold
    Lbl.TextSize           = 11
    Lbl.TextXAlignment     = Enum.TextXAlignment.Left
    Lbl.TextTruncate       = Enum.TextTruncate.AtEnd
    Lbl.ZIndex             = zBase + 2
    Lbl.Parent             = Row

    -- ── TOGGLE ──────────────────────────────────────────────────────────
    if isToggle then
        -- Mini switch housing
        local SwBg = Instance.new("Frame")
        SwBg.Size            = UDim2.new(0, 44, 0, 22)
        SwBg.AnchorPoint     = Vector2.new(1, 0.5)
        SwBg.Position        = UDim2.new(1, -8, 0.5, 0)
        SwBg.BorderSizePixel = 0
        SwBg.ZIndex          = zBase + 2
        SwBg.Parent          = Row
        local swCorner = Instance.new("UICorner")
        swCorner.CornerRadius = UDim.new(1, 0)
        swCorner.Parent = SwBg
        local swStroke = Instance.new("UIStroke")
        swStroke.Thickness = 1
        swStroke.Parent = SwBg

        local Dot = Instance.new("Frame")
        Dot.Size             = UDim2.new(0, 14, 0, 14)
        Dot.AnchorPoint      = Vector2.new(0.5, 0.5)
        Dot.Position         = UDim2.new(0, 13, 0.5, 0)
        Dot.BorderSizePixel  = 0
        Dot.ZIndex           = zBase + 3
        Dot.Parent           = SwBg
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = Dot

        local function SyncSwitch()
            pcall(function()
                local orig = element.Switch
                local origInd = orig.Indicator
                SwBg.BackgroundColor3 = orig.BackgroundColor3
                swStroke.Color        = orig.UIStroke.Color
                Dot.BackgroundColor3  = origInd.BackgroundColor3
                -- on = indicator offset -20 from right; off = -40
                local offX = origInd.Position.X.Offset
                if offX > -32 then -- ON state
                    TweenService:Create(Dot, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 31, 0.5, 0)}):Play()
                else -- OFF state
                    TweenService:Create(Dot, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0, 13, 0.5, 0)}):Play()
                end
            end)
        end
        SyncSwitch()
        pcall(function()
            element.Switch.Indicator:GetPropertyChangedSignal("BackgroundColor3"):Connect(SyncSwitch)
            element.Switch.Indicator:GetPropertyChangedSignal("Position"):Connect(SyncSwitch)
            element.Switch.UIStroke:GetPropertyChangedSignal("Color"):Connect(swStroke and function()
                swStroke.Color = element.Switch.UIStroke.Color
            end or function() end)
        end)

        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(1,0,1,0); Btn.BackgroundTransparency=1; Btn.Text=""; Btn.ZIndex=zBase+5; Btn.Parent=Row
        Btn.MouseButton1Click:Connect(function() pcall(function() element.Interact:Activate() end) end)
        Btn.MouseEnter:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(42,42,42)}):Play() end)
        Btn.MouseLeave:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play() end)

    -- ── SLIDER ──────────────────────────────────────────────────────────
    elseif isSlider then
        Lbl.AnchorPoint = Vector2.new(0, 0)
        Lbl.Position    = UDim2.new(0, 9, 0, 5)

        local ValLbl = Instance.new("TextLabel")
        ValLbl.Size = UDim2.new(0.45, 0, 0, 14)
        ValLbl.AnchorPoint = Vector2.new(1, 0)
        ValLbl.Position = UDim2.new(1, -8, 0, 5)
        ValLbl.BackgroundTransparency = 1
        ValLbl.TextColor3 = Color3.fromRGB(100, 160, 220)
        ValLbl.Font = Enum.Font.GothamBold
        ValLbl.TextSize = 11
        ValLbl.TextXAlignment = Enum.TextXAlignment.Right
        ValLbl.ZIndex = zBase + 2
        ValLbl.Parent = Row
        pcall(function()
            ValLbl.Text = element.Main.Information.Text
            element.Main.Information:GetPropertyChangedSignal("Text"):Connect(function()
                ValLbl.Text = element.Main.Information.Text
            end)
        end)

        -- Mini slider track
        local Track = Instance.new("Frame")
        Track.Size = UDim2.new(1, -18, 0, 7)
        Track.Position = UDim2.new(0, 9, 0, 32)
        Track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Track.BorderSizePixel = 0
        Track.ZIndex = zBase + 2
        Track.Parent = Row
        local tkCorner = Instance.new("UICorner"); tkCorner.CornerRadius = UDim.new(1,0); tkCorner.Parent = Track

        local Fill = Instance.new("Frame")
        Fill.Size = UDim2.new(0, 0, 1, 0)
        Fill.BackgroundColor3 = Color3.fromRGB(43, 105, 159)
        Fill.BorderSizePixel = 0
        Fill.ZIndex = zBase + 3
        Fill.Parent = Track
        local fillCorner = Instance.new("UICorner"); fillCorner.CornerRadius = UDim.new(1,0); fillCorner.Parent = Fill

        local function SyncSlider()
            pcall(function()
                local origProg = element.Main.Progress
                local origMain = element.Main
                if origMain.AbsoluteSize.X > 0 then
                    local pct = math.clamp(origProg.AbsoluteSize.X / origMain.AbsoluteSize.X, 0, 1)
                    Fill.Size = UDim2.new(pct, 0, 1, 0)
                end
                Fill.BackgroundColor3 = origProg.BackgroundColor3
            end)
        end
        task.delay(0.5, SyncSlider)
        pcall(function() element.Main.Progress:GetPropertyChangedSignal("AbsoluteSize"):Connect(SyncSlider) end)

        local Btn = Instance.new("TextButton")
        Btn.Size=UDim2.new(1,0,1,0); Btn.BackgroundTransparency=1; Btn.Text=""; Btn.ZIndex=zBase+5; Btn.Parent=Row
        Btn.MouseEnter:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(42,42,42)}):Play() end)
        Btn.MouseLeave:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play() end)

    -- ── INPUT ────────────────────────────────────────────────────────────
    elseif isInput then
        Lbl.Size = UDim2.new(0.42, -4, 1, 0)

        local MiniBox = Instance.new("TextBox")
        MiniBox.Size = UDim2.new(0.54, -4, 0, 26)
        MiniBox.AnchorPoint = Vector2.new(1, 0.5)
        MiniBox.Position = UDim2.new(1, -8, 0.5, 0)
        MiniBox.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        MiniBox.BorderSizePixel = 0
        MiniBox.Font = Enum.Font.Gotham
        MiniBox.TextSize = 11
        MiniBox.TextColor3 = Color3.fromRGB(200, 200, 200)
        MiniBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
        MiniBox.ClearTextOnFocus = false
        MiniBox.ZIndex = zBase + 2
        MiniBox.Parent = Row
        local mbCorner = Instance.new("UICorner"); mbCorner.CornerRadius = UDim.new(0,5); mbCorner.Parent = MiniBox
        local mbStroke = Instance.new("UIStroke"); mbStroke.Color=Color3.fromRGB(60,60,60); mbStroke.Thickness=1; mbStroke.Parent=MiniBox

        pcall(function()
            local origBox = element.InputFrame.InputBox
            MiniBox.PlaceholderText = origBox.PlaceholderText or ""
            MiniBox.Text = origBox.Text
            origBox:GetPropertyChangedSignal("Text"):Connect(function()
                if not MiniBox:IsFocused() then MiniBox.Text = origBox.Text end
            end)
            MiniBox.FocusLost:Connect(function(enter)
                origBox.Text = MiniBox.Text
                if enter then origBox:CaptureFocus() task.wait() origBox:ReleaseFocus(true) end
            end)
            MiniBox.Focused:Connect(function()
                TweenService:Create(mbStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(80,130,200)}):Play()
            end)
            MiniBox.FocusLost:Connect(function()
                TweenService:Create(mbStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(60,60,60)}):Play()
            end)
        end)

    -- ── KEYBIND ──────────────────────────────────────────────────────────
    elseif isKeybind then
        Lbl.Size = UDim2.new(0.42, -4, 1, 0)

        local KbBox = Instance.new("TextBox")
        KbBox.Size = UDim2.new(0.54, -4, 0, 26)
        KbBox.AnchorPoint = Vector2.new(1, 0.5)
        KbBox.Position = UDim2.new(1, -8, 0.5, 0)
        KbBox.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        KbBox.BorderSizePixel = 0
        KbBox.Font = Enum.Font.GothamBold
        KbBox.TextSize = 10
        KbBox.TextColor3 = Color3.fromRGB(180, 180, 180)
        KbBox.PlaceholderText = "Set Keybind"
        KbBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
        KbBox.ClearTextOnFocus = false
        KbBox.ZIndex = zBase + 2
        KbBox.Parent = Row
        local kbCorner = Instance.new("UICorner"); kbCorner.CornerRadius = UDim.new(0,5); kbCorner.Parent = KbBox
        local kbStroke = Instance.new("UIStroke"); kbStroke.Color=Color3.fromRGB(60,60,60); kbStroke.Thickness=1; kbStroke.Parent=KbBox

        pcall(function()
            local origBox = element.KeybindFrame.KeybindBox
            KbBox.Text = origBox.Text
            origBox:GetPropertyChangedSignal("Text"):Connect(function()
                if not KbBox:IsFocused() then KbBox.Text = origBox.Text end
            end)
            KbBox.FocusLost:Connect(function(enter)
                if enter then
                    origBox.Text = KbBox.Text
                    origBox:CaptureFocus() task.wait() origBox:ReleaseFocus(true)
                else
                    KbBox.Text = origBox.Text
                end
            end)
        end)

    -- ── DROPDOWN ────────────────────────────────────────────────────────
    elseif isDropdown then
        Lbl.Size = UDim2.new(0.42, -4, 1, 0)

        local SelLbl = Instance.new("TextLabel")
        SelLbl.Size = UDim2.new(0.54, -4, 0, 22)
        SelLbl.AnchorPoint = Vector2.new(1, 0.5)
        SelLbl.Position = UDim2.new(1, -8, 0.5, 0)
        SelLbl.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
        SelLbl.BorderSizePixel = 0
        SelLbl.Font = Enum.Font.Gotham
        SelLbl.TextSize = 10
        SelLbl.TextColor3 = Color3.fromRGB(180, 180, 180)
        SelLbl.ZIndex = zBase + 2
        SelLbl.Parent = Row
        local selCorner = Instance.new("UICorner"); selCorner.CornerRadius = UDim.new(0,5); selCorner.Parent = SelLbl
        local selStroke = Instance.new("UIStroke"); selStroke.Color=Color3.fromRGB(55,55,55); selStroke.Thickness=1; selStroke.Parent=SelLbl
        pcall(function()
            SelLbl.Text = element.Selected.Text
            element.Selected:GetPropertyChangedSignal("Text"):Connect(function()
                SelLbl.Text = element.Selected.Text
            end)
        end)

        local Btn = Instance.new("TextButton")
        Btn.Size=UDim2.new(1,0,1,0); Btn.BackgroundTransparency=1; Btn.Text=""; Btn.ZIndex=zBase+5; Btn.Parent=Row
        Btn.MouseButton1Click:Connect(function() pcall(function() element.Interact:Activate() end) end)
        Btn.MouseEnter:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(42,42,42)}):Play() end)
        Btn.MouseLeave:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play() end)

    -- ── COLOR PICKER ─────────────────────────────────────────────────────
    elseif isColorPicker then
        Lbl.Size = UDim2.new(0.54, -4, 1, 0)

        local ColorDot = Instance.new("Frame")
        ColorDot.Size = UDim2.new(0, 30, 0, 20)
        ColorDot.AnchorPoint = Vector2.new(1, 0.5)
        ColorDot.Position = UDim2.new(1, -8, 0.5, 0)
        ColorDot.BorderSizePixel = 0
        ColorDot.ZIndex = zBase + 2
        ColorDot.Parent = Row
        local cdCorner = Instance.new("UICorner"); cdCorner.CornerRadius = UDim.new(0,5); cdCorner.Parent = ColorDot
        local cdStroke = Instance.new("UIStroke"); cdStroke.Color=Color3.fromRGB(65,65,65); cdStroke.Thickness=1; cdStroke.Parent=ColorDot
        pcall(function()
            ColorDot.BackgroundColor3 = element.CPBackground.Display.BackgroundColor3
            element.CPBackground.Display:GetPropertyChangedSignal("BackgroundColor3"):Connect(function()
                ColorDot.BackgroundColor3 = element.CPBackground.Display.BackgroundColor3
            end)
        end)

        local Btn = Instance.new("TextButton")
        Btn.Size=UDim2.new(1,0,1,0); Btn.BackgroundTransparency=1; Btn.Text=""; Btn.ZIndex=zBase+5; Btn.Parent=Row
        Btn.MouseButton1Click:Connect(function() pcall(function() element.Interact:Activate() end) end)
        Btn.MouseEnter:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(42,42,42)}):Play() end)
        Btn.MouseLeave:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play() end)

    -- ── BUTTON / GENERIC ─────────────────────────────────────────────────
    else
        Lbl.Size = UDim2.new(0.55, -4, 1, 0)

        local IndLbl = Instance.new("TextLabel")
        IndLbl.Size = UDim2.new(0.42, 0, 1, 0)
        IndLbl.AnchorPoint = Vector2.new(1, 0.5)
        IndLbl.Position = UDim2.new(1, -8, 0.5, 0)
        IndLbl.BackgroundTransparency = 1
        IndLbl.TextColor3 = Color3.fromRGB(85, 85, 85)
        IndLbl.Font = Enum.Font.Gotham
        IndLbl.TextSize = 10
        IndLbl.TextXAlignment = Enum.TextXAlignment.Right
        IndLbl.TextTruncate = Enum.TextTruncate.AtEnd
        IndLbl.ZIndex = zBase + 2
        IndLbl.Parent = Row
        pcall(function()
            if element:FindFirstChild("ElementIndicator") then
                IndLbl.Text = element.ElementIndicator.Text
                element.ElementIndicator:GetPropertyChangedSignal("Text"):Connect(function()
                    IndLbl.Text = element.ElementIndicator.Text
                end)
            end
            if isParagraph and element:FindFirstChild("Content") then
                Lbl.Size = UDim2.new(1, -16, 0, 16)
                Lbl.Position = UDim2.new(0, 9, 0, 4)
                Lbl.AnchorPoint = Vector2.new(0, 0)
                local CntLbl = Instance.new("TextLabel")
                CntLbl.Size = UDim2.new(1, -16, 0, 28)
                CntLbl.Position = UDim2.new(0, 9, 0, 20)
                CntLbl.BackgroundTransparency = 1
                CntLbl.TextColor3 = Color3.fromRGB(100, 100, 100)
                CntLbl.Font = Enum.Font.Gotham
                CntLbl.TextSize = 10
                CntLbl.TextXAlignment = Enum.TextXAlignment.Left
                CntLbl.TextWrapped = true
                CntLbl.TextTruncate = Enum.TextTruncate.AtEnd
                CntLbl.Text = element.Content.Text
                CntLbl.ZIndex = zBase + 2
                CntLbl.Parent = Row
                IndLbl.Text = ""
            end
        end)

        if not isParagraph then
            local Btn = Instance.new("TextButton")
            Btn.Size=UDim2.new(1,0,1,0); Btn.BackgroundTransparency=1; Btn.Text=""; Btn.ZIndex=zBase+5; Btn.Parent=Row
            Btn.MouseButton1Click:Connect(function()
                pcall(function() if element:FindFirstChild("Interact") then element.Interact:Activate() end end)
                TweenService:Create(Row,TweenInfo.new(0.1,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(24,24,24)}):Play()
                task.wait(0.12)
                TweenService:Create(Row,TweenInfo.new(0.25,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play()
            end)
            Btn.MouseEnter:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(42,42,42)}):Play() end)
            Btn.MouseLeave:Connect(function() TweenService:Create(Row,TweenInfo.new(0.2,Enum.EasingStyle.Quint),{BackgroundColor3=Color3.fromRGB(32,32,32)}):Play() end)
        end
    end
end

-- Create a draggable floating window for a pinned section
local function CreatePinnedWindow(tabName, sectionName, sectionFrameRef, tabPageRef, startX, startY)
    local key = tabName .. "|" .. sectionName
    -- Deduplicate
    if ActivePinnedWindows[key] and ActivePinnedWindows[key].Parent then return end

    local WIN_W = 220
    local WIN_TITLE_H = 32

    -- Count holder children to size window height
    local childCount = 0
    if sectionFrameRef and sectionFrameRef:FindFirstChild("Holder") then
        for _, c in ipairs(sectionFrameRef.Holder:GetChildren()) do
            if c:IsA("Frame") and c.Name ~= "Placeholder" and c.Name ~= "SectionSpacing" then
                childCount = childCount + 1
            end
        end
    end
    local WIN_H = WIN_TITLE_H + math.clamp(childCount * 38 + 6, 38, 300)

    local posX = startX or 30
    local posY = startY or 120

    local Win = Instance.new("Frame")
    Win.Name                  = "NSUIPinWin_" .. key
    Win.Size                  = UDim2.new(0, WIN_W, 0, WIN_H)
    Win.Position              = UDim2.new(0, posX, 0, posY)
    Win.BackgroundColor3      = Color3.fromRGB(22, 22, 22)
    Win.BackgroundTransparency = 0.04
    Win.BorderSizePixel       = 0
    Win.ZIndex                = 300
    Win.Active                = true
    Win.Parent                = NSUI

    Win:SetAttribute("_PinTab",     tabName)
    Win:SetAttribute("_PinSection", sectionName)

    local WinCorner = Instance.new("UICorner")
    WinCorner.CornerRadius = UDim.new(0, 8)
    WinCorner.Parent = Win

    local WinStroke = Instance.new("UIStroke")
    WinStroke.Color        = Color3.fromRGB(58, 58, 58)
    WinStroke.Thickness    = 1
    WinStroke.Parent       = Win

    local WinShadow = Instance.new("ImageLabel")
    WinShadow.Name          = "Shadow"
    WinShadow.AnchorPoint   = Vector2.new(0.5, 0.5)
    WinShadow.Position      = UDim2.new(0.5, 0, 0.5, 4)
    WinShadow.Size          = UDim2.new(1, 24, 1, 24)
    WinShadow.BackgroundTransparency = 1
    WinShadow.Image         = "rbxassetid://5554236805"
    WinShadow.ImageColor3   = Color3.fromRGB(0, 0, 0)
    WinShadow.ImageTransparency = 0.5
    WinShadow.ScaleType     = Enum.ScaleType.Slice
    WinShadow.SliceCenter   = Rect.new(23, 23, 277, 277)
    WinShadow.ZIndex        = 299
    WinShadow.Parent        = Win

    -- ── Titlebar ──────────────────────────────────────────────────────
    local Titlebar = Instance.new("Frame")
    Titlebar.Name             = "Titlebar"
    Titlebar.Size             = UDim2.new(1, 0, 0, WIN_TITLE_H)
    Titlebar.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    Titlebar.BackgroundTransparency = 0
    Titlebar.BorderSizePixel  = 0
    Titlebar.ZIndex           = 301
    Titlebar.Parent           = Win

    local TitlebarCorner = Instance.new("UICorner")
    TitlebarCorner.CornerRadius = UDim.new(0, 8)
    TitlebarCorner.Parent = Titlebar

    -- Cover bottom corners of titlebar so it merges with content
    local TitlebarRepair = Instance.new("Frame")
    TitlebarRepair.Size             = UDim2.new(1, 0, 0, 8)
    TitlebarRepair.AnchorPoint      = Vector2.new(0, 1)
    TitlebarRepair.Position         = UDim2.new(0, 0, 1, 0)
    TitlebarRepair.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    TitlebarRepair.BorderSizePixel  = 0
    TitlebarRepair.ZIndex           = 302
    TitlebarRepair.Parent           = Titlebar

    -- Pin icon in titlebar
    local PinIcon = Instance.new("ImageLabel")
    PinIcon.Size             = UDim2.new(0, 14, 0, 14)
    PinIcon.AnchorPoint      = Vector2.new(0, 0.5)
    PinIcon.Position         = UDim2.new(0, 8, 0.5, 0)
    PinIcon.BackgroundTransparency = 1
    PinIcon.Image            = "rbxassetid://10734886004"
    PinIcon.ImageColor3      = Color3.fromRGB(160, 160, 160)
    PinIcon.ZIndex           = 303
    PinIcon.Parent           = Titlebar

    -- Section title
    local WinTitle = Instance.new("TextLabel")
    WinTitle.Size             = UDim2.new(1, -56, 1, 0)
    WinTitle.Position         = UDim2.new(0, 26, 0, 0)
    WinTitle.BackgroundTransparency = 1
    WinTitle.Text             = sectionName
    WinTitle.TextColor3       = Color3.fromRGB(210, 210, 210)
    WinTitle.Font             = Enum.Font.GothamBold
    WinTitle.TextSize         = 12
    WinTitle.TextXAlignment   = Enum.TextXAlignment.Left
    WinTitle.TextTruncate     = Enum.TextTruncate.AtEnd
    WinTitle.ZIndex           = 303
    WinTitle.Parent           = Titlebar

    -- Tab breadcrumb under title
    local TabCrumb = Instance.new("TextLabel")
    TabCrumb.Size             = UDim2.new(1, -56, 0, 10)
    TabCrumb.Position         = UDim2.new(0, 26, 0.5, 2)
    TabCrumb.BackgroundTransparency = 1
    TabCrumb.Text             = tabName
    TabCrumb.TextColor3       = Color3.fromRGB(100, 100, 100)
    TabCrumb.Font             = Enum.Font.Gotham
    TabCrumb.TextSize         = 9
    TabCrumb.TextXAlignment   = Enum.TextXAlignment.Left
    TabCrumb.TextTruncate     = Enum.TextTruncate.AtEnd
    TabCrumb.ZIndex           = 303
    TabCrumb.Parent           = Titlebar

    -- Close/unpin button (X)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size             = UDim2.new(0, 22, 0, 22)
    CloseBtn.AnchorPoint      = Vector2.new(1, 0.5)
    CloseBtn.Position         = UDim2.new(1, -5, 0.5, 0)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text             = "×"
    CloseBtn.TextColor3       = Color3.fromRGB(130, 130, 130)
    CloseBtn.Font             = Enum.Font.GothamBold
    CloseBtn.TextSize         = 16
    CloseBtn.ZIndex           = 304
    CloseBtn.Parent           = Titlebar

    CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
    end)
    CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(130, 130, 130)}):Play()
    end)

    -- Drag handle on titlebar
    local DragArea = Instance.new("TextButton")
    DragArea.Size              = UDim2.new(1, -28, 1, 0)
    DragArea.BackgroundTransparency = 1
    DragArea.Text              = ""
    DragArea.ZIndex            = 303
    DragArea.Parent            = Titlebar

    -- Drag logic (same pattern as main window)
    do
        local dragging, dragStart, startPos = false, nil, nil
        DragArea.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging  = true
                dragStart = input.Position
                startPos  = Win.Position
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input.Position - dragStart
                Win.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if dragging then
                    dragging = false
                    SavePinnedFile()
                end
            end
        end)
    end

    -- ── Content scroll area ───────────────────────────────────────────
    local Content = Instance.new("ScrollingFrame")
    Content.Name                    = "PinWinContent"
    Content.Size                    = UDim2.new(1, -6, 1, -(WIN_TITLE_H + 4))
    Content.Position                = UDim2.new(0, 3, 0, WIN_TITLE_H + 2)
    Content.BackgroundTransparency  = 1
    Content.BorderSizePixel         = 0
    Content.ScrollBarThickness      = 2
    Content.ScrollBarImageColor3    = Color3.fromRGB(70, 70, 70)
    Content.CanvasSize              = UDim2.new(0, 0, 0, 0)
    Content.AutomaticCanvasSize     = Enum.AutomaticSize.Y
    Content.ZIndex                  = 81
    Content.Parent                  = Win

    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Padding       = UDim.new(0, 3)
    ContentLayout.FillDirection = Enum.FillDirection.Vertical
    ContentLayout.SortOrder     = Enum.SortOrder.LayoutOrder
    ContentLayout.Parent        = Content

    -- Populate rows from section holder
    if sectionFrameRef and sectionFrameRef:FindFirstChild("Holder") then
        for _, elem in ipairs(sectionFrameRef.Holder:GetChildren()) do
            BuildPinnedRow(elem, Content, 81)
        end
        -- Watch for new elements added to holder later
        sectionFrameRef.Holder.ChildAdded:Connect(function(child)
            task.wait() -- let element finish setup
            BuildPinnedRow(child, Content, 81)
        end)
    end

    -- Close / unpin
    CloseBtn.MouseButton1Click:Connect(function()
        -- Reset pin button on the original section
        pcall(function()
            if sectionFrameRef and sectionFrameRef:FindFirstChild("NSUIPinButton") then
                sectionFrameRef.NSUIPinButton.ImageColor3 = Color3.fromRGB(110, 110, 110)
                sectionFrameRef.NSUIPinButton:SetAttribute("_Pinned", false)
            end
        end)
        ActivePinnedWindows[key] = nil
        Win:Destroy()
        SavePinnedFile()
    end)

    ActivePinnedWindows[key] = Win
    SavePinnedFile()
end

-- Pending pins loaded from file (applied after sections are created)
local PendingPins = {}
pcall(function()
    if isfile and isfile(NSUIPinnedFile) then
        local decoded = HttpService:JSONDecode(readfile(NSUIPinnedFile))
        for _, entry in ipairs(decoded) do
            table.insert(PendingPins, entry)
        end
    end
end)
-- ─────────────────────────────────────────────────────────────────────────────

local SelectedTheme = NSUILib.Theme.Default

function ChangeTheme(ThemeName)
    SelectedTheme = NSUI.Theme[ThemeName]
    for _, obj in ipairs(NSUI:GetDescendants()) do
        if obj.ClassName == "TextLabel" or obj.ClassName == "TextBox" or obj.ClassName == "TextButton" then
            if SelectedTheme.TextFont ~= "Default" then 
                obj.TextColor3 = SelectedTheme.TextColor
                obj.Font = SelectedTheme.TextFont
            end
        end
    end

    NSUI.Main.BackgroundColor3 = SelectedTheme.Background
    NSUI.Main.Topbar.BackgroundColor3 = SelectedTheme.Topbar
    NSUI.Main.Topbar.CornerRepair.BackgroundColor3 = SelectedTheme.Topbar
    NSUI.Main.Shadow.Image.ImageColor3 = SelectedTheme.Shadow

    NSUI.Main.Topbar.ChangeSize.ImageColor3 = SelectedTheme.TextColor
    NSUI.Main.Topbar.Hide.ImageColor3 = SelectedTheme.TextColor
    NSUI.Main.Topbar.Theme.ImageColor3 = SelectedTheme.TextColor

    for _, TabPage in ipairs(Elements:GetChildren()) do
        for _, Element in ipairs(TabPage:GetChildren()) do
            if Element.ClassName == "Frame" and Element.Name ~= "Placeholder" and Element.Name ~= "SectionSpacing" and Element.Name ~= ""  then
                Element.BackgroundColor3 = SelectedTheme.ElementBackground
                Element.UIStroke.Color = SelectedTheme.ElementStroke
            end
        end
    end

end
local function AddDraggingFunctionality(DragPoint, Main)
    pcall(function()
        local Dragging, DragInput, MousePos, FramePos = false,false,false,false
        DragPoint.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Dragging = true
                MousePos = Input.Position
                FramePos = Main.Position

                Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
        DragPoint.InputChanged:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement then
                DragInput = Input
            end
        end)
        UserInputService.InputChanged:Connect(function(Input)
            if Input == DragInput and Dragging then
                local Delta = Input.Position - MousePos
                TweenService:Create(Main, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
            end
        end)
    end)
end

function BoolToText(Bool)
    if Bool == true then
        return "ENABLED",Color3.fromRGB(44, 186, 44)
    else
        return "DISABLED",Color3.fromRGB(186, 44, 44)
    end
end
local function PackColor(Color)
    return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end    

local function UnpackColor(Color)
    return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadConfiguration(Configuration)
    local Data = HttpService:JSONDecode(Configuration)
    for FlagName, FlagValue in next, Data do
        if NSUILib.Flags[FlagName] then
            spawn(function() 
                if NSUILib.Flags[FlagName].Type == "ColorPicker" then
                    NSUILib.Flags[FlagName]:Set(UnpackColor(FlagValue))
                else
                    if NSUILib.Flags[FlagName].CurrentValue or NSUILib.Flags[FlagName].CurrentKeybind or NSUILib.Flags[FlagName].CurrentOption or NSUILib.Flags[FlagName].Color ~= FlagValue then NSUILib.Flags[FlagName]:Set(FlagValue) end
                end    
            end)
        else
            NSUILib:Notify({Title = "Flag Error", Content = "NSUI was unable to find "..FlagName.. " in the current script"})
        end
    end
end

local function SaveConfiguration()
    if not CEnabled then return end
    local Data = {}
    for i,v in pairs(NSUILib.Flags) do
        if v.Type == "ColorPicker" then
            Data[i] = PackColor(v.Color)
        else
            Data[i] = v.CurrentValue or v.CurrentKeybind or v.Color or v.CurrentOption
        end
    end	
    writefile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
end

local neon = (function()  --Open sourced neon module
    local module = {}

    do
        local function IsNotNaN(x)
            return x == x
        end
        local continued = IsNotNaN(Camera:ScreenPointToRay(0,0).Origin.x)
        while not continued do
            RunService.RenderStepped:wait()
            continued = IsNotNaN(Camera:ScreenPointToRay(0,0).Origin.x)
        end
    end
	local RootParent = Camera
	if getgenv().SecureMode == nil then
		RootParent = Camera
	else
		if not getgenv().SecureMode then
			RootParent = Camera
		else 
			RootParent = nil
		end
	end


    local binds = {}
    local root = Instance.new("Folder", RootParent)
    root.Name = "neon"


    local GenUid; do
        local id = 0
        function GenUid()
            id = id + 1
            return "neon::"..tostring(id)
        end
    end

    local DrawQuad; do
        local acos, max, pi, sqrt = math.acos, math.max, math.pi, math.sqrt
        local sz = 0.2

        local function DrawTriangle(v1, v2, v3, p0, p1)
            local s1 = (v1 - v2).magnitude
            local s2 = (v2 - v3).magnitude
            local s3 = (v3 - v1).magnitude
            local smax = max(s1, s2, s3)
            local A, B, C
            if s1 == smax then
                A, B, C = v1, v2, v3
            elseif s2 == smax then
                A, B, C = v2, v3, v1
            elseif s3 == smax then
                A, B, C = v3, v1, v2
            end

            local para = ( (B-A).x*(C-A).x + (B-A).y*(C-A).y + (B-A).z*(C-A).z ) / (A-B).magnitude
            local perp = sqrt((C-A).magnitude^2 - para*para)
            local dif_para = (A - B).magnitude - para

            local st = CFrame.new(B, A)
            local za = CFrame.Angles(pi/2,0,0)

            local cf0 = st

            local Top_Look = (cf0 * za).lookVector
            local Mid_Point = A + CFrame.new(A, B).LookVector * para
            local Needed_Look = CFrame.new(Mid_Point, C).LookVector
            local dot = Top_Look.x*Needed_Look.x + Top_Look.y*Needed_Look.y + Top_Look.z*Needed_Look.z

            local ac = CFrame.Angles(0, 0, acos(dot))

            cf0 = cf0 * ac
            if ((cf0 * za).lookVector - Needed_Look).magnitude > 0.01 then
                cf0 = cf0 * CFrame.Angles(0, 0, -2*acos(dot))
            end
            cf0 = cf0 * CFrame.new(0, perp/2, -(dif_para + para/2))

            local cf1 = st * ac * CFrame.Angles(0, pi, 0)
            if ((cf1 * za).lookVector - Needed_Look).magnitude > 0.01 then
                cf1 = cf1 * CFrame.Angles(0, 0, 2*acos(dot))
            end
            cf1 = cf1 * CFrame.new(0, perp/2, dif_para/2)

            if not p0 then
                p0 = Instance.new("Part")
                p0.FormFactor = "Custom"
                p0.TopSurface = 0
                p0.BottomSurface = 0
                p0.Anchored = true
                p0.CanCollide = false
                p0.Material = "Glass"
                p0.Size = Vector3.new(sz, sz, sz)
                local mesh = Instance.new("SpecialMesh", p0)
                mesh.MeshType = 2
                mesh.Name = "WedgeMesh"
            end
            p0.WedgeMesh.Scale = Vector3.new(0, perp/sz, para/sz)
            p0.CFrame = cf0

            if not p1 then
                p1 = p0:clone()
            end
            p1.WedgeMesh.Scale = Vector3.new(0, perp/sz, dif_para/sz)
            p1.CFrame = cf1

            return p0, p1
        end

        function DrawQuad(v1, v2, v3, v4, parts)
            parts[1], parts[2] = DrawTriangle(v1, v2, v3, parts[1], parts[2])
            parts[3], parts[4] = DrawTriangle(v3, v2, v4, parts[3], parts[4])
        end
    end

    function module:BindFrame(frame, properties)
        if RootParent == nil then return end
        if binds[frame] then
            return binds[frame].parts
        end

        local uid = GenUid()
        local parts = {}
        local f = Instance.new("Folder", root)
        f.Name = frame.Name

        local parents = {}
        do
            local function add(child)
                if child:IsA"GuiObject" then
                    parents[#parents + 1] = child
                    add(child.Parent)
                end
            end
            add(frame)
        end

        local function UpdateOrientation(fetchProps)
            local zIndex = 1 - 0.05*frame.ZIndex
            local tl, br = frame.AbsolutePosition, frame.AbsolutePosition + frame.AbsoluteSize
            local tr, bl = Vector2.new(br.x, tl.y), Vector2.new(tl.x, br.y)
            do
                local rot = 0;
                for _, v in ipairs(parents) do
                    rot = rot + v.Rotation
                end
                if rot ~= 0 and rot%180 ~= 0 then
                    local mid = tl:lerp(br, 0.5)
                    local s, c = math.sin(math.rad(rot)), math.cos(math.rad(rot))
                    local vec = tl
                    tl = Vector2.new(c*(tl.x - mid.x) - s*(tl.y - mid.y), s*(tl.x - mid.x) + c*(tl.y - mid.y)) + mid
                    tr = Vector2.new(c*(tr.x - mid.x) - s*(tr.y - mid.y), s*(tr.x - mid.x) + c*(tr.y - mid.y)) + mid
                    bl = Vector2.new(c*(bl.x - mid.x) - s*(bl.y - mid.y), s*(bl.x - mid.x) + c*(bl.y - mid.y)) + mid
                    br = Vector2.new(c*(br.x - mid.x) - s*(br.y - mid.y), s*(br.x - mid.x) + c*(br.y - mid.y)) + mid
                end
            end
            DrawQuad(
                Camera:ScreenPointToRay(tl.x, tl.y, zIndex).Origin, 
                Camera:ScreenPointToRay(tr.x, tr.y, zIndex).Origin, 
                Camera:ScreenPointToRay(bl.x, bl.y, zIndex).Origin, 
                Camera:ScreenPointToRay(br.x, br.y, zIndex).Origin, 
                parts
            )
            if fetchProps then
                for _, pt in pairs(parts) do
                    pt.Parent = f
                end
                for propName, propValue in pairs(properties) do
                    for _, pt in pairs(parts) do
                        pt[propName] = propValue
                    end
                end
            end
        end

        UpdateOrientation(true)
        RunService:BindToRenderStep(uid, 2000, UpdateOrientation)

        binds[frame] = {
            uid = uid;
            parts = parts;
        }
        return binds[frame].parts
    end

    function module:Modify(frame, properties)
        local parts = module:GetBoundParts(frame)
        if parts then
            for propName, propValue in pairs(properties) do
                for _, pt in pairs(parts) do
                    pt[propName] = propValue
                end
            end
        end
    end

    function module:UnbindFrame(frame)
        if RootParent == nil then return end
        local cb = binds[frame]
        if cb then
            RunService:UnbindFromRenderStep(cb.uid)
            for _, v in pairs(cb.parts) do
                v:Destroy()
            end
            binds[frame] = nil
        end
    end

    function module:HasBinding(frame)
        return binds[frame] ~= nil
    end

    function module:GetBoundParts(frame)
        return binds[frame] and binds[frame].parts
    end


    return module

end)()
function CloseNPrompt()
    local Infos= TweenInfo.new(.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    TweenService:Create(NotePrompt,Infos,{BackgroundTransparency = 1,Size = UDim2.fromOffset(436,92),Position = UDim2.fromScale(0.5,0.19)}):Play()
    TweenService:Create(NotePrompt.UIStroke,Infos,{Transparency = 1}):Play()
    TweenService:Create(NotePrompt.Shadow.Image,Infos,{ImageTransparency = 1}):Play()

    TweenService:Create(NotePrompt.Close,Infos,{ImageTransparency = .1}):Play()
    TweenService:Create(NotePrompt.Icon,Infos,{ImageTransparency = 1}):Play()
    TweenService:Create(NotePrompt.Title,Infos,{TextTransparency = 1}):Play()

    TweenService:Create(NotePrompt.Description,Infos,{TextTransparency = 1}):Play()
    TweenService:Create(NotePrompt.Load,Infos,{TextTransparency = 1,BackgroundTransparency = 1}):Play()
    TweenService:Create(NotePrompt.Load.UIStroke,Infos,{Transparency = 1}):Play()
    TweenService:Create(NotePrompt.Load.Shadow,Infos,{ImageTransparency = 1}):Play()
    task.wait(0.21)
    NotePrompt.Visible = false
end
function qNotePrompt(PromptSettings)
    local Infos= TweenInfo.new(.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)
    NotePrompt.Visible = false
    --Setup
    NotePrompt.Size = UDim2.fromOffset(436,92)
    NotePrompt.Position = UDim2.fromScale(0.5,0.19)
    NotePrompt.BackgroundTransparency = 1
    NotePrompt.UIStroke.Transparency = 1

    NotePrompt.Icon.ImageTransparency = 1
    NotePrompt.Close.ImageTransparency = 1

    NotePrompt.Shadow.Image.ImageTransparency = 1

    NotePrompt.Title.TextTransparency = 1
    NotePrompt.Description.TextTransparency = 1

    NotePrompt.Load.BackgroundTransparency = 1
    NotePrompt.Load.UIStroke.Transparency = 1
    NotePrompt.Load.TextTransparency = 1
    NotePrompt.Load.Shadow.ImageTransparency = 1
    --Settings
    NotePrompt.Title.Text = PromptSettings.Title or ""
    NotePrompt.Description.Text = PromptSettings.Description or ""
    NotePrompt.Icon.Image = PromptSettings.Icon or 'rbxassetid://'..4483362748
    NotePrompt.Load.BackgroundColor3 = PromptSettings.Color or Color3.fromRGB(90, 90, 90)
    NotePrompt.Load.MouseButton1Down:Once(function(x,y)
        CloseNPrompt()
        if PromptSettings.Callback then
            PromptSettings.Callback()
        end
    end)

    NotePrompt.Close.MouseButton1Down:Once(function()
        CloseNPrompt()
    end)
    NotePrompt.Visible = true
    --Opening
    TweenService:Create(NotePrompt,Infos,{BackgroundTransparency = .1,Size = UDim2.fromOffset(474,100),Position = UDim2.fromScale(0.5,0.21)}):Play()
    TweenService:Create(NotePrompt.UIStroke,Infos,{Transparency = 0}):Play()
    TweenService:Create(NotePrompt.Shadow.Image,Infos,{ImageTransparency = .2}):Play()
    task.wait(.3)
    TweenService:Create(NotePrompt.Close,Infos,{ImageTransparency = .8}):Play()
    TweenService:Create(NotePrompt.Icon,Infos,{ImageTransparency = 0}):Play()
    TweenService:Create(NotePrompt.Title,Infos,{TextTransparency = 0}):Play()
    task.wait(.1)
    TweenService:Create(NotePrompt.Description,Infos,{TextTransparency = 0}):Play()
    task.wait(.2)
    TweenService:Create(NotePrompt.Load,Infos,{TextTransparency = 0,BackgroundTransparency = .2}):Play()
    TweenService:Create(NotePrompt.Load.UIStroke,Infos,{Transparency = 0}):Play()
    TweenService:Create(NotePrompt.Load.Shadow,Infos,{ImageTransparency = .8}):Play()
end
function ClosePrompt()
    local PromptUI = Prompt.Prompt
    clicked = false
    TweenService:Create(Prompt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
    TweenService:Create(PromptUI, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1,Size = UDim2.new(0,340,0,140)}):Play()
    TweenService:Create(PromptUI.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
    TweenService:Create(PromptUI.Title, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
    TweenService:Create(PromptUI.Content, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
    TweenService:Create(PromptUI.Sub, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
    for _,button in pairs(PromptUI.Buttons:GetChildren()) do
        if button.Name ~= "Template" and button:IsA("Frame") then
            TweenService:Create(button.UIStroke,TweenInfo.new(0.2, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
            TweenService:Create(button.TextLabel,TweenInfo.new(0.2, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
            delay(.2,function()
                button:Destroy()
            end)
        end
    end
    task.wait(.5)
    Prompt.Visible = false
end
function NSUILib:Notify(NotificationSettings)
    spawn(function()
        local ActionCompleted = true
        local Notification = Notifications.Template:Clone()
        Notification.Parent = Notifications
        Notification.Name = NotificationSettings.Title or "Unknown Title"
        Notification.Visible = true

        local blurlight = nil
        if not getgenv().SecureMode then
            blurlight = Instance.new("DepthOfFieldEffect",game:GetService("Lighting"))
            blurlight.Enabled = true
            blurlight.FarIntensity = 0
            blurlight.FocusDistance = 51.6
            blurlight.InFocusRadius = 50
            blurlight.NearIntensity = 1
            game:GetService("Debris"):AddItem(script,0)
        end

        Notification.Actions.Template.Visible = false

        if NotificationSettings.Actions then
			for _, Action in pairs(NotificationSettings.Actions) do
				ActionCompleted = false
				local NewAction = Notification.Actions.Template:Clone()
				NewAction.BackgroundColor3 = SelectedTheme.NotificationActionsBackground
				if SelectedTheme ~= NSUILib.Theme.Default then
					NewAction.TextColor3 = SelectedTheme.TextColor
				end
				NewAction.Name = Action.Name
				NewAction.Visible = true
				NewAction.Parent = Notification.Actions
				NewAction.Text = Action.Name
				NewAction.BackgroundTransparency = 1
				NewAction.TextTransparency = 1
				NewAction.Size = UDim2.new(0, NewAction.TextBounds.X + 27, 0, 36)

                NewAction.MouseButton1Click:Connect(function()
                    local Success, Response = pcall(Action.Callback)
                    if not Success then
                        print("NSUI | Action: "..Action.Name.." Callback Error " ..tostring(Response))
                    end
                    ActionCompleted = true
                end)
            end
        end
		Notification.BackgroundColor3 = SelectedTheme.Background
		Notification.Title.Text = NotificationSettings.Title or "Unknown"
		Notification.Title.TextTransparency = 1
		Notification.Title.TextColor3 = SelectedTheme.TextColor
		Notification.Description.Text = NotificationSettings.Content or "Unknown"
		Notification.Description.TextTransparency = 1
		Notification.Description.TextColor3 = SelectedTheme.TextColor
		Notification.Icon.ImageColor3 = SelectedTheme.TextColor
		if NotificationSettings.Image then
			if tonumber(NotificationSettings.Image) then
				Notification.Icon.Image = "rbxassetid://"..tostring(NotificationSettings.Image)
			else
				Notification.Icon.Image = NotificationSettings.Image
			end
		else
			Notification.Icon.Image = "rbxassetid://3944680095"
		end

        Notification.Icon.ImageTransparency = 1

        Notification.Parent = Notifications
        Notification.Size = UDim2.new(0, 260, 0, 80)
        Notification.BackgroundTransparency = 1

        TweenService:Create(Notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 295, 0, 91)}):Play()
        TweenService:Create(Notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.1}):Play()
        Notification:TweenPosition(UDim2.new(0.5,0,0.915,0),"Out","Quint",0.8,true)

        task.wait(0.3)
        TweenService:Create(Notification.Icon, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
        TweenService:Create(Notification.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        TweenService:Create(Notification.Description, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
        task.wait(0.2)



        -- Requires Graphics Level 8-10
        if getgenv().SecureMode == nil then
            TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.4}):Play()
        else
            if not getgenv().SecureMode then
                TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.4}):Play()
            else 
                TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            end
        end

        if NSUI.Name == "NSUI" then
            neon:BindFrame(Notification.BlurModule, {
                Transparency = 0.98;
                BrickColor = BrickColor.new("Institutional white");
            })
        end

        if not NotificationSettings.Actions then
            task.wait(NotificationSettings.Duration or NotificationDuration - 0.5)
        else
            task.wait(0.8)
            TweenService:Create(Notification, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 295, 0, 132)}):Play()
            task.wait(0.3)
            for _, Action in ipairs(Notification.Actions:GetChildren()) do
                if Action.ClassName == "TextButton" and Action.Name ~= "Template" then
                    TweenService:Create(Action, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.2}):Play()
                    TweenService:Create(Action, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                    task.wait(0.05)
                end
            end
        end

        repeat task.wait(0.001) until ActionCompleted

        for _, Action in ipairs(Notification.Actions:GetChildren()) do
            if Action.ClassName == "TextButton" and Action.Name ~= "Template" then
                TweenService:Create(Action, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                TweenService:Create(Action, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
            end
        end

        TweenService:Create(Notification.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.47, 0,0.234, 0)}):Play()
        TweenService:Create(Notification.Description, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {Position = UDim2.new(0.528, 0,0.637, 0)}):Play()
        TweenService:Create(Notification, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 280, 0, 83)}):Play()
        TweenService:Create(Notification.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
        TweenService:Create(Notification, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()

        task.wait(0.3)
        TweenService:Create(Notification.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
        TweenService:Create(Notification.Description, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
        task.wait(0.4)
        TweenService:Create(Notification, TweenInfo.new(0.9, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 260, 0, 0)}):Play()
        TweenService:Create(Notification, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Notification.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
        TweenService:Create(Notification.Description, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
        task.wait(0.2)
        if not getgenv().SecureMode then
            neon:UnbindFrame(Notification.BlurModule)
            blurlight:Destroy()
        end
        task.wait(0.9)
        Notification:Destroy()
    end)
end

function CloseSideBar()
    Debounce = true
	for _, child in pairs(Main:GetChildren()) do
    SideBarClosed = true
  for _,tabbtn in pairs(SideList:GetChildren()) do
    if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "Placeholder" and tabbtn.Name ~= "SpacerTab" then
        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),{TextTransparency = 1}):Play()
        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint),{ImageTransparency = 1}):Play()
    end
end
for _, child in pairs(Main:GetChildren()) do
    if child.Name == "SpacerLine" then
        TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
    end
end
end
    TweenService:Create(Main.SideTabList, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 1,Size = UDim2.new(0,150,0,390),Position = UDim2.new(0,10,0.5,22)}):Play()
    TweenService:Create(Main.SideTabList.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint),{Transparency = 1}):Play()
    TweenService:Create(Main.SideTabList.RDMT, TweenInfo.new(0.4, Enum.EasingStyle.Quint),{TextTransparency = 1}):Play()
    task.wait(.4)
    Main.SideTabList.Visible = false
    task.wait(0.2)
    Debounce = false
end
function Hide()
    if not SideBarClosed then
        task.spawn(CloseSideBar)
    end
    Debounce = true
    NSUILib:Notify({
        Title = "Interface Hidden",
        Content = "The interface has been hidden, you can unhide the interface by pressing Quote (')",
        Duration = 7
    })
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 470, 0, 400) }):Play()
    TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 470, 0, 45) })
        :Play()
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Main.Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 1 })
        :Play()
    TweenService:Create(Main.Topbar.CornerRepair, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
        { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Main.Topbar.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { ImageTransparency = 1 }):Play()
    TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Transparency = 1 }):Play()
    for _, TopbarButton in ipairs(Topbar:GetChildren()) do
        if TopbarButton.ClassName == "ImageButton" then
            TweenService:Create(TopbarButton, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { ImageTransparency = 1 })
                :Play()
        end
    end
    for _, tabbtn in ipairs(TabsList:GetChildren()) do
        if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "Placeholder" then
            TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { BackgroundTransparency = 1 }):Play()
            TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { TextTransparency = 1 }):Play()
            TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { ImageTransparency = 1 })
                :Play()
            TweenService:Create(tabbtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { ImageTransparency = 1 })
                :Play()
            TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), { Transparency = 1 }):Play()
        end
    end
    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab.ClassName == "ScrollingFrame" and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element.ClassName == "Frame" then
                    if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" then
                        if element:FindFirstChild('Holder') then
                            TweenService:Create(element, TweenInfo.new(0.2, Enum.EasingStyle.Quint),
                                { BackgroundTransparency = 1 }):Play()
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { TextTransparency = 1 }):Play()
                        else
                            TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { BackgroundTransparency = 1 }):Play()
                            pcall(function()
                                TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { Transparency = 1 }):Play()
                            end)
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { TextTransparency = 1 }):Play()
                        end
                        for _, child in ipairs(element:GetChildren()) do
                            if child.ClassName == "Frame" or child.ClassName == "TextLabel" or child.ClassName == "TextBox" or child.ClassName == "ImageButton" or child.ClassName == "ImageLabel" then
                                child.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end
    wait(0.5)
    Main.Visible = false
    Debounce = false
end
function Unhide()
    Debounce = true
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Visible = true
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 500, 0, 475) }):Play()
    TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 500, 0, 45) })
        :Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.4 }):Play()
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(Main.Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { BackgroundTransparency = 0 })
        :Play()
    TweenService:Create(Main.Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
        { BackgroundTransparency = 0 }):Play()
    TweenService:Create(Main.Topbar.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { TextTransparency = 0 }):Play()
    if Minimised then
        spawn(Maximise)
    end
    for _, TopbarButton in ipairs(Topbar:GetChildren()) do
        if TopbarButton.ClassName == "ImageButton" then
            TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { ImageTransparency = 0.8 })
                :Play()
        end
    end
    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab.ClassName == "ScrollingFrame" and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element.ClassName == "Frame" then
                    if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" and not element:FindFirstChild('ColorPickerIs') then
                        if element:FindFirstChild('_UIPadding_') then
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { TextTransparency = 0 }):Play()
                            TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { BackgroundTransparency = .25 }):Play()
                        else
                            if element.Name ~= 'SectionTitle' then
                                TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { BackgroundTransparency = 0 }):Play()
                                TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { Transparency = 0 }):Play()
                            end
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                { TextTransparency = 0 }):Play()
                        end
                        for _, child in ipairs(element:GetChildren()) do
                            if (child.ClassName == "Frame" or child.ClassName == "TextLabel" or child.ClassName == "TextBox" or child.ClassName == "ImageButton" or child.ClassName == "ImageLabel") then
                                child.Visible = true
                            end
                        end
                    elseif element:FindFirstChild('ColorPickerIs') then
                        TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { BackgroundTransparency = 0 }):Play()
                        TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { Transparency = 0 }):Play()
                        TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                            { TextTransparency = 0 }):Play()

                        if element.ColorPickerIs.Value then
                            element.ColorSlider.Visible = true
                            element.HexInput.Visible = true
                            element.RGB.Visible = true
                        end
                        element.CPBackground.Visible = true
                        element.Lock.Visible = true
                        element.Interact.Visible = true
                        element.Title.Visible = true
                    end
                end
            end
        end
    end
    wait(0.5)
    Minimised = false
    Debounce = false
end

local _SB_Built = false

local function _SB_Build()
    if _SB_Built then return end
    _SB_Built = true

    local iconId, filterId, clearId = "", "", ""
    pcall(function() iconId   = SearchBar.Icon.Image   end)
    pcall(function() filterId = SearchBar.Filter.Image end)
    pcall(function() clearId  = SearchBar.Clear.Image  end)

    for _, ch in ipairs(SearchBar:GetChildren()) do
        if ch.Name ~= "Input" and ch.ClassName ~= "UICorner" and ch.ClassName ~= "UIStroke" then
            pcall(function() ch.Visible = false end)
        end
    end

    local SIcon = Instance.new("ImageLabel")
    SIcon.Name                   = "_SB_Icon"
    SIcon.Size                   = UDim2.new(0, 20, 0, 20)
    SIcon.AnchorPoint            = Vector2.new(0, 0.5)
    SIcon.Position               = UDim2.new(0, 10, 0.5, 0)
    SIcon.BackgroundTransparency = 1
    SIcon.Image                  = iconId
    SIcon.ImageColor3            = Color3.fromRGB(130, 130, 130)
    SIcon.ZIndex                 = 502
    SIcon.Parent                 = SearchBar

    local SFilter = Instance.new("ImageLabel")
    SFilter.Name                   = "_SB_Filter"
    SFilter.Size                   = UDim2.new(0, 20, 0, 20)
    SFilter.AnchorPoint            = Vector2.new(1, 0.5)
    SFilter.Position               = UDim2.new(1, -34, 0.5, 0)
    SFilter.BackgroundTransparency = 1
    SFilter.Image                  = filterId
    SFilter.ImageColor3            = Color3.fromRGB(130, 130, 130)
    SFilter.ZIndex                 = 502
    SFilter.Parent                 = SearchBar

    local SClear = Instance.new("ImageButton")
    SClear.Name                   = "_SB_Clear"
    SClear.Size                   = UDim2.new(0, 20, 0, 20)
    SClear.AnchorPoint            = Vector2.new(1, 0.5)
    SClear.Position               = UDim2.new(1, -10, 0.5, 0)
    SClear.BackgroundTransparency = 1
    SClear.Image                  = clearId
    SClear.ImageColor3            = Color3.fromRGB(130, 130, 130)
    SClear.ZIndex                 = 502
    SClear.Parent                 = SearchBar
    SClear.MouseButton1Down:Connect(function()
        SearchBar.Input.Text = ""
        if not SearchHided then
            SearchHided = true
            task.spawn(CloseSearch)
        end
    end)

    SearchBar.Input.AnchorPoint = Vector2.new(0, 0.5)
    SearchBar.Input.Position    = UDim2.new(0, 34, 0.51, 0)
    SearchBar.Input.Size        = UDim2.new(1, -72, 0, 28)
    SearchBar.Input.ZIndex      = 502
end

function CloseSearch()
    pcall(function()
        if _G._NSUISearchPosConn then
            _G._NSUISearchPosConn:Disconnect()
            _G._NSUISearchPosConn = nil
        end
    end)
    Topbar.Title.TextTransparency = 0
    local t = TweenInfo.new(0.25, Enum.EasingStyle.Quint)
    TweenService:Create(SearchBar, t, {BackgroundTransparency = 1}):Play()
    TweenService:Create(SearchBar.Input, t, {TextTransparency = 1}):Play()
    pcall(function() TweenService:Create(SearchBar.UIStroke, t, {Transparency = 1}):Play() end)
    pcall(function() TweenService:Create(SearchBar:FindFirstChild("_SB_Icon"),   t, {ImageTransparency = 1}):Play() end)
    pcall(function() TweenService:Create(SearchBar:FindFirstChild("_SB_Filter"), t, {ImageTransparency = 1}):Play() end)
    pcall(function() TweenService:Create(SearchBar:FindFirstChild("_SB_Clear"),  t, {ImageTransparency = 1}):Play() end)
    task.wait(0.3)
    SearchBar.Input.Text             = ""
    SearchBar.Input.Visible          = false
    SearchBar.Visible                = false
    SearchBar.Parent                 = Main
    SearchBar.BackgroundTransparency = 1
end

function OpenSearch()
    Debounce = true
    SearchBar.BackgroundColor3       = SelectedTheme.InputBackground
    SearchBar.BackgroundTransparency = 1
    SearchBar.Parent                 = NSUI
    SearchBar.ZIndex                 = 500
    SearchBar.AnchorPoint            = Vector2.new(0, 1)
    SearchBar.ClipsDescendants       = false

    local function UpdateSearchPos()
        pcall(function()
            local ap = Main.AbsolutePosition
            local as = Main.AbsoluteSize
            SearchBar.Position = UDim2.new(0, ap.X + 5, 0, ap.Y - 6)
            SearchBar.Size     = UDim2.new(0, as.X - 10, 0, 40)
        end)
    end
    UpdateSearchPos()
    _G._NSUISearchPosConn = Main:GetPropertyChangedSignal("AbsolutePosition"):Connect(UpdateSearchPos)

    _SB_Build()

    SearchBar.Input.TextTransparency = 1
    pcall(function() SearchBar.UIStroke.Transparency = 1 end)
    pcall(function() local i = SearchBar:FindFirstChild("_SB_Icon");   if i then i.ImageTransparency = 1 end end)
    pcall(function() local i = SearchBar:FindFirstChild("_SB_Filter"); if i then i.ImageTransparency = 1 end end)
    pcall(function() local i = SearchBar:FindFirstChild("_SB_Clear");  if i then i.ImageTransparency = 1 end end)

    SearchBar.Input.TextColor3        = Color3.fromRGB(180, 180, 180)
    SearchBar.Input.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
    SearchBar.Input.PlaceholderText   = "Search elements..."
    SearchBar.Input.Visible           = true
    SearchBar.Visible                 = true

    task.wait()

    local t = TweenInfo.new(0.4, Enum.EasingStyle.Quint)
    TweenService:Create(SearchBar, t, {BackgroundTransparency = 0}):Play()
    TweenService:Create(SearchBar.Input, t, {TextTransparency = 0}):Play()
    pcall(function() TweenService:Create(SearchBar.UIStroke, t, {Transparency = 0}):Play() end)
    pcall(function() TweenService:Create(SearchBar:FindFirstChild("_SB_Icon"),   t, {ImageTransparency = 0.3}):Play() end)
    pcall(function() TweenService:Create(SearchBar:FindFirstChild("_SB_Filter"), t, {ImageTransparency = 0.4}):Play() end)
    pcall(function() TweenService:Create(SearchBar:FindFirstChild("_SB_Clear"),  t, {ImageTransparency = 0.4}):Play() end)

    task.wait(0.45)
    Debounce = false
end

-- ── NSUI Global Search ───────────────────────────────────────────────────────

local function EnsureSearchPage()
    if SearchResultsPage then return end
    SearchResultsPage = Instance.new("ScrollingFrame")
    SearchResultsPage.Name                  = "___SearchResults___"
    SearchResultsPage.Size                  = UDim2.new(1, 0, 1, 0)
    SearchResultsPage.BackgroundTransparency = 1
    SearchResultsPage.BorderSizePixel       = 0
    SearchResultsPage.ScrollBarThickness    = 3
    SearchResultsPage.ScrollBarImageColor3  = Color3.fromRGB(80, 80, 80)
    SearchResultsPage.CanvasSize            = UDim2.new(0, 0, 0, 0)
    SearchResultsPage.AutomaticCanvasSize   = Enum.AutomaticSize.Y
    SearchResultsPage.Visible               = true
    SearchResultsPage.LayoutOrder           = 999999
    SearchResultsPage.Parent                = Elements

    local lyt = Instance.new("UIListLayout")
    lyt.Padding        = UDim.new(0, 4)
    lyt.FillDirection  = Enum.FillDirection.Vertical
    lyt.SortOrder      = Enum.SortOrder.LayoutOrder
    lyt.Parent         = SearchResultsPage

    local pad = Instance.new("UIPadding")
    pad.PaddingLeft   = UDim.new(0, 6)
    pad.PaddingRight  = UDim.new(0, 6)
    pad.PaddingTop    = UDim.new(0, 8)
    pad.PaddingBottom = UDim.new(0, 6)
    pad.Parent        = SearchResultsPage
end

local function ClearSearchPage()
    if not SearchResultsPage then return end
    for _, c in ipairs(SearchResultsPage:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
end

local function AddSearchCard(elementName, tabName, sectionName, tabPageRef, elementFrameRef, order, elementType)
    -- ── Type appearance map ──────────────────────────────────────────────
    local typeColor = {
        TOGGLE   = Color3.fromRGB(0,  146, 214),
        BUTTON   = Color3.fromRGB(90, 180, 100),
        DROPDOWN = Color3.fromRGB(200, 140, 60),
        KEYBIND  = Color3.fromRGB(170, 100, 220),
    }
    local typeBg = {
        TOGGLE   = Color3.fromRGB(0,  30,  55),
        BUTTON   = Color3.fromRGB(18, 42,  22),
        DROPDOWN = Color3.fromRGB(48, 30,  10),
        KEYBIND  = Color3.fromRGB(40, 18,  58),
    }
    local typeLabel = elementType or "ELEMENT"
    local tColor    = typeColor[typeLabel]  or Color3.fromRGB(130, 130, 130)
    local tBgColor  = typeBg[typeLabel]     or Color3.fromRGB(28, 28, 28)

    local Card = Instance.new("Frame")
    Card.Name               = "SRCard"
    Card.Size               = UDim2.new(1, -4, 0, 48)
    Card.BackgroundColor3   = Color3.fromRGB(35, 35, 35)
    Card.BackgroundTransparency = 0
    Card.BorderSizePixel    = 0
    Card.LayoutOrder        = order
    Card.ZIndex             = 5
    Card.Parent             = SearchResultsPage

    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 7)
    cc.Parent = Card

    local cs = Instance.new("UIStroke")
    cs.Color        = Color3.fromRGB(50, 50, 55)
    cs.Thickness    = 1
    cs.Parent       = Card

    -- ── Left accent bar ───────────────────────────────────────────────────
    local Accent = Instance.new("Frame")
    Accent.Size             = UDim2.new(0, 3, 1, -14)
    Accent.Position         = UDim2.new(0, 0, 0.5, 0)
    Accent.AnchorPoint      = Vector2.new(0, 0.5)
    Accent.BackgroundColor3 = tColor
    Accent.BorderSizePixel  = 0
    Accent.ZIndex           = 6
    Accent.Parent           = Card
    local acCorner = Instance.new("UICorner")
    acCorner.CornerRadius = UDim.new(1, 0)
    acCorner.Parent = Accent

    -- ── Element name ──────────────────────────────────────────────────────
    local NameLbl = Instance.new("TextLabel")
    NameLbl.Size               = UDim2.new(1, -110, 0, 18)
    NameLbl.Position           = UDim2.new(0, 12, 0, 8)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Text               = elementName
    NameLbl.TextColor3         = Color3.fromRGB(230, 230, 230)
    NameLbl.Font               = Enum.Font.GothamBold
    NameLbl.TextSize           = 13
    NameLbl.TextXAlignment     = Enum.TextXAlignment.Left
    NameLbl.TextTruncate       = Enum.TextTruncate.AtEnd
    NameLbl.ZIndex             = 6
    NameLbl.Parent             = Card

    -- ── Type badge — right side of name row ───────────────────────────────
    local BadgeBg = Instance.new("Frame")
    BadgeBg.Size             = UDim2.new(0, 68, 0, 16)
    BadgeBg.AnchorPoint      = Vector2.new(1, 0.5)   -- vertically centred like the arrow
    BadgeBg.Position         = UDim2.new(1, -40, 0.5, 0)  -- 6 px gap left of the arrow
    BadgeBg.BackgroundColor3 = tBgColor
    BadgeBg.BorderSizePixel  = 0
    BadgeBg.ZIndex           = 6
    BadgeBg.Parent           = Card
    local badgeCorner = Instance.new("UICorner")
    badgeCorner.CornerRadius = UDim.new(1, 0)
    badgeCorner.Parent = BadgeBg
    local badgeStroke = Instance.new("UIStroke")
    badgeStroke.Color        = tColor
    badgeStroke.Thickness    = 1
    badgeStroke.Transparency = 0.4
    badgeStroke.Parent       = BadgeBg

    local BadgeLbl = Instance.new("TextLabel")
    BadgeLbl.Size               = UDim2.new(1, 0, 1, 0)
    BadgeLbl.BackgroundTransparency = 1
    BadgeLbl.Text               = typeLabel
    BadgeLbl.TextColor3         = tColor
    BadgeLbl.Font               = Enum.Font.GothamBold
    BadgeLbl.TextSize           = 8
    BadgeLbl.TextXAlignment     = Enum.TextXAlignment.Center
    BadgeLbl.ZIndex             = 7
    BadgeLbl.Parent             = BadgeBg

    -- ── Path: Tab  ›  Section ─────────────────────────────────────────────
    local pathStr = tabName .. (sectionName ~= "" and ("  ›  " .. sectionName) or "")
    local PathLbl = Instance.new("TextLabel")
    PathLbl.Size               = UDim2.new(1, -42, 0, 13)
    PathLbl.Position           = UDim2.new(0, 12, 0, 30)
    PathLbl.BackgroundTransparency = 1
    PathLbl.Text               = pathStr
    PathLbl.TextColor3         = Color3.fromRGB(100, 100, 110)
    PathLbl.Font               = Enum.Font.Gotham
    PathLbl.TextSize           = 10
    PathLbl.TextXAlignment     = Enum.TextXAlignment.Left
    PathLbl.TextTruncate       = Enum.TextTruncate.AtEnd
    PathLbl.ZIndex             = 6
    PathLbl.Parent             = Card

    -- ── Go arrow ──────────────────────────────────────────────────────────
    local GoLbl = Instance.new("TextLabel")
    GoLbl.Size               = UDim2.new(0, 30, 1, 0)
    GoLbl.AnchorPoint        = Vector2.new(1, 0.5)
    GoLbl.Position           = UDim2.new(1, -4, 0.5, 0)
    GoLbl.BackgroundTransparency = 1
    GoLbl.Text               = "›"
    GoLbl.TextColor3         = tColor
    GoLbl.Font               = Enum.Font.GothamBold
    GoLbl.TextSize           = 20
    GoLbl.ZIndex             = 6
    GoLbl.Parent             = Card

    -- Invisible click button over whole card
    local Btn = Instance.new("TextButton")
    Btn.Size                = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundTransparency = 1
    Btn.Text                = ""
    Btn.ZIndex              = 7
    Btn.Parent              = Card

    -- Hover effect
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(45, 45, 50)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
    end)

    -- Navigate on click
    Btn.MouseButton1Click:Connect(function()
        -- Clear search
        SearchBar.Input.Text = ""
        task.wait(0.05)
        -- Navigate to the right tab
        pcall(function()
            if TabNavRegistry[tabName] then
                TabNavRegistry[tabName].navigate()
            end
            -- Scroll element into view in its tab page
            if tabPageRef and elementFrameRef then
                task.wait(0.25)
                pcall(function()
                    local elemY = elementFrameRef.AbsolutePosition.Y - tabPageRef.AbsolutePosition.Y + tabPageRef.CanvasPosition.Y
                    TweenService:Create(tabPageRef, TweenInfo.new(0.4, Enum.EasingStyle.Quint),
                        {CanvasPosition = Vector2.new(0, math.max(0, elemY - 20))}):Play()
                    -- Brief highlight flash
                    local origColor = elementFrameRef.BackgroundColor3
                    TweenService:Create(elementFrameRef, TweenInfo.new(0.25, Enum.EasingStyle.Quint),
                        {BackgroundColor3 = Color3.fromRGB(50, 80, 110)}):Play()
                    task.wait(0.5)
                    TweenService:Create(elementFrameRef, TweenInfo.new(0.5, Enum.EasingStyle.Quint),
                        {BackgroundColor3 = origColor}):Play()
                end)
            end
        end)
    end)
end

SearchBar.Input:GetPropertyChangedSignal("Text"):Connect(function()
    local InputText = string.upper(SearchBar.Input.Text)

    if InputText == "" then
        TweenService:Create(Topbar.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        if GlobalSearchActive then
            GlobalSearchActive = false
            ClearSearchPage()
            if LastActivePage then
                pcall(function()
                    Elements.UIPageLayout.Animated = false
                    Elements.UIPageLayout:JumpTo(LastActivePage)
                    Elements.UIPageLayout.Animated = true
                end)
            end
        end
        for _, page in ipairs(Elements:GetChildren()) do
            if page:IsA("ScrollingFrame") and page.Name ~= "___SearchResults___" and page.Name ~= "Template" then
                for _, Element in pairs(page:GetChildren()) do
                    if Element:IsA("Frame") and Element.Name ~= "Placeholder" then
                        Element.Visible = true
                        if Element:FindFirstChild("Holder") then
                            local sectionIsOpen = true
                            pcall(function()
                                if Element:FindFirstChild("Title") and Element.Title:FindFirstChild("ImageButton") then
                                    sectionIsOpen = Element.Title.ImageButton.Rotation ~= 180
                                end
                            end)
                            if sectionIsOpen then
                                for _, child in pairs(Element.Holder:GetChildren()) do
                                    if child:IsA("Frame") and child.Name ~= "Placeholder" then
                                        child.Visible = true
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
        return
    end

    -- ── Global search across all tabs ────────────────────────────────────
    if not GlobalSearchActive then
        -- Remember current page before jumping away
        pcall(function() LastActivePage = Elements.UIPageLayout.CurrentPage end)
        GlobalSearchActive = true
    end

    EnsureSearchPage()
    ClearSearchPage()

    local resultOrder = 0
    local seenKeys = {}  -- dedup: "tabName|sectionTitle|elementTitle"

    -- ── Detect element type; returns nil for excluded types ────────────────
    local function DetectElementType(elem)
        if not elem:IsA("Frame") then return nil end
        -- Exclude non-interactive / paragraph / label types
        if elem:FindFirstChild("Content")    then return nil end  -- paragraph
        if elem:FindFirstChild("CPBackground") then return nil end  -- color picker
        local hasMain = elem:FindFirstChild("Main")
        if hasMain and hasMain:FindFirstChild("Progress") then return nil end  -- slider
        if elem:FindFirstChild("InputFrame")
            and not (elem:FindFirstChild("Selected") and elem:FindFirstChild("List"))
        then return nil end  -- text input

        -- Interactive types we DO show
        if elem:FindFirstChild("Switch")   then return "TOGGLE"   end
        if elem:FindFirstChild("KeybindFrame") then return "KEYBIND" end
        if elem:FindFirstChild("Selected") and elem:FindFirstChild("List") then return "DROPDOWN" end
        if elem:FindFirstChild("ElementIndicator") then return "BUTTON" end
        return nil  -- label or unrecognised – skip
    end

    local function SafeAddCard(elemTitle, tName, sectTitle, pageRef, frameRef, elemType)
        local key = tName .. "|" .. sectTitle .. "|" .. elemTitle
        if seenKeys[key] then return end
        seenKeys[key] = true
        resultOrder = resultOrder + 1
        AddSearchCard(elemTitle, tName, sectTitle, pageRef, frameRef, resultOrder, elemType)
    end

    for _, page in ipairs(Elements:GetChildren()) do
        if page:IsA("ScrollingFrame") and page.Name ~= "___SearchResults___" and page.Name ~= "Template" and page.Name ~= "Placeholder" then
            local tabName = page.Name
            for _, Element in pairs(page:GetChildren()) do
                if Element:IsA("Frame") and Element.Name ~= "Placeholder" and Element.Name ~= "SectionSpacing" then

                    if Element:FindFirstChild("Holder") then
                        -- Section frame – read its real title from the Title label
                        local sectionTitle = Element.Name
                        pcall(function()
                            if Element:FindFirstChild("Title") and Element.Title.Text ~= "" then
                                sectionTitle = Element.Title.Text
                            end
                        end)
                        local sectionMatches = string.find(string.upper(sectionTitle), InputText) ~= nil

                        for _, child in pairs(Element.Holder:GetChildren()) do
                            if child:IsA("Frame") and child.Name ~= "Placeholder" and child.Name ~= "SectionSpacing" then
                                local elemType = DetectElementType(child)
                                if elemType then  -- nil = filtered out (paragraph, label, slider, etc.)
                                    local childTitle = child.Name
                                    pcall(function()
                                        if child:FindFirstChild("Title") and child.Title.Text ~= "" then
                                            childTitle = child.Title.Text
                                        end
                                    end)
                                    local childMatches = string.find(string.upper(childTitle), InputText) ~= nil
                                    -- Show child if the section or the element itself matches
                                    if sectionMatches or childMatches then
                                        SafeAddCard(childTitle, tabName, sectionTitle, page, child, elemType)
                                    end
                                end
                            end
                        end
                        -- (section header is NOT added as a separate card)

                    else
                        -- Top-level element (not inside a section)
                        local elemType = DetectElementType(Element)
                        if elemType then
                            local elemTitle = Element.Name
                            pcall(function()
                                if Element:FindFirstChild("Title") and Element.Title.Text ~= "" then
                                    elemTitle = Element.Title.Text
                                end
                            end)
                            if string.find(string.upper(elemTitle), InputText) ~= nil then
                                SafeAddCard(elemTitle, tabName, "", page, Element, elemType)
                            end
                        end
                    end

                end
            end
        end
    end

    -- Jump to results page
    pcall(function()
        Elements.UIPageLayout.Animated = false
        Elements.UIPageLayout:JumpTo(SearchResultsPage)
        Elements.UIPageLayout.Animated = true
    end)
end)
-- ─────────────────────────────────────────────────────────────────────────────
SearchBar.Clear.MouseButton1Down:Connect(function()
    -- Clear text first (triggers the Input Changed handler which restores tab)
    SearchBar.Input.Text = ""
    -- Then close the bar
    if not SearchHided then
        SearchHided = true
        task.spawn(CloseSearch)
    end
end)

function Maximise()
    Debounce = true
    Topbar.ChangeSize.Image = "rbxassetid://"..10137941941

	TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
	TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 0.4}):Play()
	TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 475)}):Play()
	TweenService:Create(Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 45)}):Play()
	TabsList.Visible = true
	wait(0.2)

	Elements.Visible = true

    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab.ClassName == "ScrollingFrame" and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element.ClassName == "Frame" then
                    if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" and not element:FindFirstChild("ColorPickerIs") then
                        if element:FindFirstChild("_UIPadding_") then
                            TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = .25}):Play()
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                        else
                            if element.Name ~= "SectionTitle" then
                                TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                                TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                            end
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                        end
                        for _, child in ipairs(element:GetChildren()) do
                            if (child.ClassName == "Frame" or child.ClassName == "TextLabel" or child.ClassName == "TextBox" or child.ClassName == "ImageButton" or child.ClassName == "ImageLabel") then
                                child.Visible = true
                            end
                        end
                    elseif element:FindFirstChild("ColorPickerIs") then
                        TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                        TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

                        if element.ColorPickerIs.Value then
                            element.ColorSlider.Visible = true
                            element.HexInput.Visible = true
                            element.RGB.Visible = true
                        end
                        element.CPBackground.Visible = true
                        element.Lock.Visible = true
                        element.Interact.Visible = true
                        element.Title.Visible = true
                    end
                end
            end
        end
    end


    task.wait(0.1)

    for _, tabbtn in ipairs(TopList:GetChildren()) do
        if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "Placeholder" then
            if tostring(Elements.UIPageLayout.CurrentPage) == tabbtn.Title.Text then
                TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
                TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                TweenService:Create(tabbtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.9}):Play()
            else
                TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.7}):Play()
                TweenService:Create(tabbtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.7}):Play()
                TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.2}):Play()
                TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
                TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            end

        end
    end


    task.wait(0.5)
    Debounce = false
end
function OpenSideBar()
    Debounce = true
    Main.SideTabList.Visible = true 
    TweenService:Create(Main.SideTabList, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = .03,Size = UDim2.new(0,160,0,405),Position = UDim2.new(0,14,0.5,22)}):Play()
    TweenService:Create(Main.SideTabList.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint),{Transparency = 0}):Play()
    TweenService:Create(Main.SideTabList.RDMT, TweenInfo.new(0.4, Enum.EasingStyle.Quint),{TextTransparency = 0}):Play()
    -- Defer by one frame so Roblox computes SideSpacer.AbsolutePosition first,
    -- which triggers UpdateLinePos and places every SpacerLine correctly before
    -- it becomes visible (fixes wrong position on first open).
    task.defer(function()
        for _, child in pairs(Main:GetChildren()) do
            if child.Name == "SpacerLine" then
                TweenService:Create(child, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.75}):Play()
            end
        end
    end)
    for _,tabbtn in pairs(SideList:GetChildren()) do
        if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "Placeholder" and tabbtn.Name ~= "SpacerTab" then
            if tabbtn.Title.TextColor3 ~= Color3.fromRGB(255,255,255) then
                TweenService:Create(tabbtn.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint),{TextTransparency = .2}):Play()
            else
                TweenService:Create(tabbtn.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint),{TextTransparency = 0}):Play()
            end
            TweenService:Create(tabbtn.Image, TweenInfo.new(0.25, Enum.EasingStyle.Quint),{ImageTransparency = 0}):Play()
        end
        task.wait(0.12)
    end
    SideBarClosed = false
    task.wait(0.2)
    Debounce = false
end
function Minimise()
    Debounce = true
    Topbar.ChangeSize.Image = "rbxassetid://"..11036884234
    if not SearchHided then
        spawn(CloseSearch)
    end
    if not SideBarClosed then
        spawn(CloseSideBar)
    end
    for _, tabbtn in ipairs(TopList:GetChildren()) do
        if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "Placeholder" then
            TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
            TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
            TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
            TweenService:Create(tabbtn.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
            TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
        end
    end

    for _, tab in ipairs(Elements:GetChildren()) do
        if tab.Name ~= "Template" and tab.ClassName == "ScrollingFrame" and tab.Name ~= "Placeholder" then
            for _, element in ipairs(tab:GetChildren()) do
                if element.ClassName == "Frame" then
                    if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" then
                        if element:FindFirstChild("_UIPadding_") then
                            TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        else
                            TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                            pcall(function()
                                TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                            end)
                            TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        end
                        for _, child in ipairs(element:GetChildren()) do
                            if child.ClassName == "Frame" or child.ClassName == "TextLabel" or child.ClassName == "TextBox" or child.ClassName == "ImageButton" or child.ClassName == "ImageLabel" then
                                child.Visible = false
                            end
                        end
                    end
                end
            end
        end
    end

    TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
    TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 400, 0, 35)}):Play()
    TweenService:Create(Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 400, 0, 45)}):Play()

    task.wait(0.3)

    Elements.Visible = false
    TabsList.Visible = false

    task.wait(0.2)
    Debounce = false
end

function NSUILib:CreateWindow(Settings)
    NSUI.Enabled = false
    local Passthrough = false
    Topbar.Title.Text = Settings.Name
    Main.Size = UDim2.new(0, 420, 0, 100)
    Main.Visible = true
    Main.BackgroundTransparency = 1
    LoadingFrame.Title.TextTransparency = 1
    LoadingFrame.Subtitle.TextTransparency = 1
LoadingFrame.Title.Position = UDim2.new(0, 20, 0, 35)
LoadingFrame.Title.TextSize = 18 
LoadingFrame.Subtitle.Position = UDim2.new(0, 20, 0, 50)
LoadingFrame.Subtitle.TextSize = 14

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.Parent = LoadingFrame
LoadingFrame.Title.TextXAlignment = Enum.TextXAlignment.Left
LoadingFrame.Title.TextYAlignment = Enum.TextYAlignment.Center
LoadingFrame.Subtitle.TextXAlignment = Enum.TextXAlignment.Left
LoadingFrame.Subtitle.TextYAlignment = Enum.TextYAlignment.Center
LoadingFrame.Title.TextScaled = true
LoadingFrame.Subtitle.TextScaled = true
LoadingFrame.Version.TextScaled = true
    Main.Shadow.Image.ImageTransparency = 1
    LoadingFrame.Version.TextTransparency = 1
LoadingFrame.Version.Position = UDim2.new(1, -5, 1, -10)
LoadingFrame.Version.AnchorPoint = Vector2.new(1, 1)
LoadingFrame.Version.TextSize = 11
LoadingFrame.Version.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingFrame.Title.Text = Settings.LoadingTitle or "NSUI Interface Suite"
    LoadingFrame.Subtitle.Text = Settings.LoadingSubtitle or "by Sirius | Meta"
    if Settings.LoadingTitle ~= "NSUI Interface Suite" then
        LoadingFrame.Version.Text = Release
    end
    Topbar.Visible = false
    Elements.Visible = false
    LoadingFrame.Visible = true

NSUILib:ToggleOldTabStyle(Settings.OldTabLayout)

    pcall(function()
        if not Settings.ConfigurationSaving.FileName then
            Settings.ConfigurationSaving.FileName = tostring(game.PlaceId)
        end
        if not isfolder(NSUIFolder.."/Configuration Folders") then

        end
        if Settings.ConfigurationSaving.Enabled == nil then
            Settings.ConfigurationSaving.Enabled = false
        end
        CFileName = Settings.ConfigurationSaving.FileName
        ConfigurationFolder = Settings.ConfigurationSaving.FolderName or ConfigurationFolder
        CEnabled = Settings.ConfigurationSaving.Enabled

        if Settings.ConfigurationSaving.Enabled then
            if not isfolder(ConfigurationFolder) then
                makefolder(ConfigurationFolder)
            end	
        end
    end)

    AddDraggingFunctionality(Topbar,Main)
	
    Settings = Settings or {}

    Settings.KeySystem = Settings.KeySystem or false

    if type(Settings.KeySystem) == "table" then
        Settings.KeySettings = Settings.KeySystem
        Settings.KeySystem = true
    else
        Settings.KeySystem = false
    end

    if Settings.KeySettings and typeof(Settings.KeySettings.Key) == "string" then
        Settings.KeySettings.Key = {Settings.KeySettings.Key}
    end

    for _, TabButton in ipairs(TabsList:GetChildren()) do
        if TabButton.ClassName == "Frame" and TabButton.Name ~= "Placeholder" then
            TabButton.BackgroundTransparency = 1
            TabButton.Title.TextTransparency = 1
            TabButton.Shadow.ImageTransparency = 1
            TabButton.Image.ImageTransparency = 1
            TabButton.UIStroke.Transparency = 1
        end
    end

    if Settings.Discord then
        if not isfolder(NSUIFolder.."/Discord Invites") then
            makefolder(NSUIFolder.."/Discord Invites")
        end
        if not isfile(NSUIFolder.."/Discord Invites".."/"..Settings.Discord.Invite..ConfigurationExtension) then
            if request then
                request({
                    Url = "http://127.0.0.1:6463/rpc?v=1",
                    Method = "POST",
                    Headers = {
                        ["Content-Type"] = "application/json",
                        Origin = "https://discord.com"
                    },
                    Body = HttpService:JSONEncode({
                        cmd = "INVITE_BROWSER",
                        nonce = HttpService:GenerateGUID(false),
                        args = {code = Settings.Discord.Invite}
                    })
                })
            end

            if Settings.Discord.RememberJoins then -- We do logic this way so if the developer changes this setting, the user still won"t be prompted, only new users
                writefile(NSUIFolder.."/Discord Invites".."/"..Settings.Discord.Invite..ConfigurationExtension,"NSUI RememberJoins is true for this invite, this invite will not ask you to join again")
            end
        else

        end
    end

    if Settings.KeySystem then
        if not Settings.KeySettings then
            Passthrough = true
            return
        end

        if not isfolder(NSUIFolder.."/Key System") then
            makefolder(NSUIFolder.."/Key System")
        end

        if Settings.KeySettings.GrabKeyFromSite then
            for i, Key in ipairs(Settings.KeySettings.Key) do
                local Success, Response = pcall(function()
                    Settings.KeySettings.Key[i] = tostring(game:HttpGet(Key):gsub("[\n\r]", " "))
                    Settings.KeySettings.Key[i] = string.gsub(Settings.KeySettings.Key[i], " ", "")
                end)
                if not Success then
                    print("NSUI | "..Key.." Error " ..tostring(Response))
                end
            end
        end

        if not Settings.KeySettings.FileName then
            Settings.KeySettings.FileName = "No file name specified"
        end

        if isfile(NSUIFolder.."/Key System".."/"..Settings.KeySettings.FileName..ConfigurationExtension) then
        for _, MKey in ipairs(Settings.KeySettings.Key) do
            if string.find(readfile(NSUIFolder.."/Key System".."/"..Settings.KeySettings.FileName..ConfigurationExtension), MKey) then
                Passthrough = true
                end
            end
        end

        if not Passthrough then
            local AttemptsRemaining = math.random(2,6)
            NSUI.Enabled = false
            local KeyUI = game:GetObjects("rbxassetid://11695805160")[1]
            KeyUI.Enabled = true
            pcall(function()
                _G.KeyUI:Destroy()
            end)
            _G.KeyUI = KeyUI

            ParentObject(KeyUI)

            local KeyMain = KeyUI.Main
            KeyMain.Title.Text = Settings.KeySettings.Title or Settings.Name
            KeyMain.Subtitle.Text = Settings.KeySettings.Subtitle or "Key System"
            KeyMain.NoteMessage.Text = Settings.KeySettings.Note or "No instructions"

            KeyMain.Size = UDim2.new(0, 467, 0, 175)
            KeyMain.BackgroundTransparency = 1
            KeyMain.EShadow.ImageTransparency = 1
            KeyMain.Title.TextTransparency = 1
            KeyMain.Subtitle.TextTransparency = 1
            KeyMain.KeyNote.TextTransparency = 1
            KeyMain.Input.BackgroundTransparency = 1
            KeyMain.Input.UIStroke.Transparency = 1
            KeyMain.Input.InputBox.TextTransparency = 1
            KeyMain.NoteTitle.TextTransparency = 1
            KeyMain.NoteMessage.TextTransparency = 1
            KeyMain.Hide.ImageTransparency = 1
            KeyMain.HideP.ImageTransparency = 1
            KeyMain.Actions.Template.TextTransparency = 1

            if Settings.KeySettings.Actions then
                for _,ActionInfo in ipairs(Settings.KeySettings.Actions) do
                    local Action = KeyMain.Actions.Template:Clone()
                    Action.Text = ActionInfo.Text
                    Action.MouseButton1Down:Connect(ActionInfo.OnPress)
                    Action.MouseEnter:Connect(function()
                        TweenService:Create(Action,TweenInfo.new(.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
                    end)
                    Action.MouseLeave:Connect(function()
                        TweenService:Create(Action,TweenInfo.new(.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{TextColor3 = Color3.fromRGB(105, 105, 105)}):Play()
                    end)
                    Action.Parent = KeyMain.Actions
                    delay(.2,function()
                        Action.Visible = true
                        TweenService:Create(Action, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                    end)
                end
            end

            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 187)}):Play()
            TweenService:Create(KeyMain.EShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 0.5}):Play()
            task.wait(0.05)
            TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            task.wait(0.05)
            TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            task.wait(0.05)
            TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            task.wait(0.15)
            TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.3}):Play()
            TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 0.3}):Play()
            KeyUI.Main.Input.InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                KeyUI.Main.Input.HidenInput.Text = string.rep("•", #KeyUI.Main.Input.InputBox.Text)
            end)
            KeyUI.Main.Input.InputBox.FocusLost:Connect(function(EnterPressed)
                if not EnterPressed then return end
                if #KeyUI.Main.Input.InputBox.Text == 0 then return end
                local KeyFound = false
                local FoundKey = ""
                for _, MKey in ipairs(Settings.KeySettings.Key) do
                    if KeyMain.Input.InputBox.Text== MKey then
                        KeyFound = true
                        FoundKey = MKey
                    end
                end
                if KeyFound then
                    for _,Action in ipairs(KeyMain.Actions:GetChildren()) do
                        if Action:IsA("TextButton") then
                            TweenService:Create(Action, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        end
                    end
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
                    TweenService:Create(KeyMain.EShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    TweenService:Create(KeyMain.Input.InputBox,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                    TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                    delay(.4,function()
                        KeyMain.Hide.Visible = false
                        KeyUI:Destroy()
                    end)
                    task.wait(0.51)
                    Passthrough = true
                    if Settings.KeySettings.SaveKey then
                        if writefile then
                            local keyToSave = Settings.KeySettings.Key[1]
                            writefile(NSUIFolder.."/Key System".."/"..Settings.KeySettings.FileName..ConfigurationExtension, FoundKey)
                        end
                        NSUILib:Notify({Title = "Key System", Content = "The key for this script has been saved successfully"})
                    end
                else
                    if AttemptsRemaining == 0 then
                        TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                        TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
                        TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                        TweenService:Create(KeyMain.Input.InputBox,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Input.HidenInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                        TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                        task.wait(0.45)
                        game.Players.LocalPlayer:Kick("No Attempts Remaining")
                        game:Shutdown()
                    end
                    KeyMain.Input.InputBox.Text = ""
                    AttemptsRemaining = AttemptsRemaining - 1
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Position = UDim2.new(0.495,0,0.5,0)}):Play()
                    task.wait(0.1)
                    TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {Position = UDim2.new(0.505,0,0.5,0)}):Play()
                    task.wait(0.1)
                    TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5,0,0.5,0)}):Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 187)}):Play()
                end
            end)
            local Hidden = true
            KeyMain.HideP.MouseButton1Click:Connect(function()
                if Hidden then
                    TweenService:Create(KeyMain.Input.HidenInput,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(KeyMain.Input.InputBox,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                    Hidden = false
                else
                    TweenService:Create(KeyMain.Input.HidenInput,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                    TweenService:Create(KeyMain.Input.InputBox,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    Hidden = true
                end
            end)

            KeyMain.Hide.MouseButton1Click:Connect(function()
                TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 467, 0, 175)}):Play()
                TweenService:Create(KeyMain.EShadow, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.Input.HidenInput,TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                TweenService:Create(KeyMain.HideP, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                task.wait(0.51)
                NSUILib:Destroy()
                KeyUI:Destroy()
            end)
        else
            Passthrough = true
        end
    end
    if Settings.KeySystem then
        repeat task.wait() until Passthrough
    end
    NSUI.Enabled = true
    for _,tabbtn in pairs(SideList:GetChildren()) do
        if tabbtn.ClassName == "Frame" and tabbtn.Name ~= "Placeholder" then
            TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),{TextTransparency = 1}):Play()
            TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Quint),{ImageTransparency = 1}):Play()

			if tabbtn.Name == "SpacerTab" and tabbtn:FindFirstChild("SpacerLine") then
    			TweenService:Create(tabbtn.SpacerLine, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
			end
        end
    end
    TweenService:Create(Main.SideTabList, TweenInfo.new(0, Enum.EasingStyle.Quint), {BackgroundTransparency = 1,Size = UDim2.new(0,150,0,390),Position = UDim2.new(0,10,0.5,22)}):Play()
    TweenService:Create(Main.SideTabList.UIStroke, TweenInfo.new(0, Enum.EasingStyle.Quint),{Transparency = 1}):Play()
    TweenService:Create(Main.SideTabList.RDMT, TweenInfo.new(0, Enum.EasingStyle.Quint),{TextTransparency = 1}):Play()
    --delay(4,function()
    --	qNotePrompt({
    --		Title = "Preview",
    --		Description = "This is a preview for the official NSUI forum post. Remember that things are subject to change.",

    --	})
    --end)

    TopList.Template.Visible = false
    SideList.SideTemplate.Visible = false
    Notifications.Template.Visible = false
    Notifications.Visible = true
    task.wait(0.5)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.55}):Play()
    task.wait(0.1)
    TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
    task.wait(0.05)
    TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
    task.wait(0.05)
    TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

    Elements.Template.LayoutOrder = 100000
    Elements.Template.Visible = false

    Elements.UIPageLayout.FillDirection = Enum.FillDirection.Horizontal

    -- Tab
    local FirstTab = false
    NSUIQuality.Window = {Tabs = {}}
    local Window = NSUIQuality.Window
    
    function Window:SetTopbarTitle(text)
        Topbar.Title.Text = text
    end


function Window:CreateSpacerTab(px)
    px = px or 2

    local function MakeDummies(parent)
        local t = Instance.new("TextLabel")
        t.Name = "Title" t.Text = "" t.BackgroundTransparency = 1
        t.TextTransparency = 1 t.Size = UDim2.new(1,0,1,0) t.Parent = parent

        local i = Instance.new("ImageLabel")
        i.Name = "Image" i.BackgroundTransparency = 1
        i.ImageTransparency = 1 i.Size = UDim2.new(1,0,1,0) i.Parent = parent

        local s = Instance.new("ImageLabel")
        s.Name = "Shadow" s.BackgroundTransparency = 1
        s.ImageTransparency = 1 s.Size = UDim2.new(1,0,1,0) s.Parent = parent

        local st = Instance.new("UIStroke")
        st.Name = "UIStroke" st.Transparency = 1 st.Parent = parent

        local b = Instance.new("TextButton")
        b.Name = "Interact" b.Text = "" b.BackgroundTransparency = 1
        b.Size = UDim2.new(1,0,1,0) b.Parent = parent
    end

    local SideSpacer = Instance.new("Frame")
    SideSpacer.Name = "SpacerTab"
    SideSpacer.BackgroundTransparency = 1
    SideSpacer.BorderSizePixel = 0
    SideSpacer.Size = UDim2.new(1, 0, 0, px + 8)
    MakeDummies(SideSpacer)
    SideSpacer.Parent = SideList

    local SideLine = Instance.new("Frame")
    SideLine.Name = "SpacerLine"
    SideLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SideLine.BackgroundTransparency = 1
    SideLine.BorderSizePixel = 0
    SideLine.ZIndex = 15
    SideLine.AnchorPoint = Vector2.new(0.5, 0.5)
    SideLine.Size = UDim2.new(0, 108, 0, math.max(px, 2))
    Instance.new("UICorner", SideLine).CornerRadius = UDim.new(1, 0)
    SideLine.Parent = Main

    local function UpdateLinePos()
        local abs = SideSpacer.AbsolutePosition
        local mainAbs = Main.AbsolutePosition
        SideLine.Position = UDim2.new(
            0, (abs.X - mainAbs.X) + SideSpacer.AbsoluteSize.X * 0.5,
            0, (abs.Y - mainAbs.Y) + SideSpacer.AbsoluteSize.Y * 0.5
        )
    end
    SideSpacer:GetPropertyChangedSignal("AbsolutePosition"):Connect(UpdateLinePos)
    -- Also update when the sidebar panel itself moves or resizes (covers the first-open case
    -- where SideSpacer.AbsolutePosition was 0,0 while SideTabList was hidden).
    Main.SideTabList:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
        task.defer(UpdateLinePos)
    end)
    Main.SideTabList:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        task.defer(UpdateLinePos)
    end)
    task.defer(UpdateLinePos)

    local TopSpacer = Instance.new("Frame")
    TopSpacer.Name = "SpacerTab"
    TopSpacer.BackgroundTransparency = 1
    TopSpacer.BorderSizePixel = 0
    TopSpacer.Size = UDim2.new(0, 16, 0, 30)
    MakeDummies(TopSpacer)

    local TopLine = Instance.new("Frame")
    TopLine.Name = "SpacerLine"
    TopLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopLine.BackgroundTransparency = 0.75
    TopLine.BorderSizePixel = 0
    TopLine.AnchorPoint = Vector2.new(0.5, 0)
    TopLine.Size = UDim2.new(0, math.max(px, 2), 0.55, 0)
    TopLine.Position = UDim2.new(0.5, 0, 0.225, 0)
    Instance.new("UICorner", TopLine).CornerRadius = UDim.new(1, 0)
    TopLine.Parent = TopSpacer
    TopSpacer.Parent = TopList

	task.defer(function()
    	TweenService:Create(TopLine, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.75}):Play()
	end)

    return {
        Destroy = function()
            SideSpacer:Destroy()
            SideLine:Destroy()
            TopSpacer:Destroy()
        end
    }
end
    
    function Window:CreateTab(Name,Image)
        Window.Tabs[Name]={Elements = {}}
        local Tab = Window.Tabs[Name]
        local SDone = false
        local TopTabButton,SideTabButton = TopList.Template:Clone(), SideList.SideTemplate:Clone()

        SideTabButton.Parent = SideList
        TopTabButton.Parent = TopList

        TopTabButton.Name=Name SideTabButton.Name=Name

        TopTabButton.Title.Text = Name SideTabButton.Title.Text = Name
        SideTabButton.Title.TextWrapped = false TopTabButton.Title.TextWrapped = false 

        TopTabButton.Size = UDim2.new(0, TopTabButton.Title.TextBounds.X + 30, 0, 30)
		if Image then
			TopTabButton.Image.Image = "rbxassetid://"..Image
			SideTabButton.Image.Image = "rbxassetid://"..Image

			TopTabButton.Title.AnchorPoint = Vector2.new(0, 0.5)
			TopTabButton.Title.Position = UDim2.new(0, 37, 0.5, 0)
			TopTabButton.Image.Visible = true
			TopTabButton.Title.TextXAlignment = Enum.TextXAlignment.Left
			TopTabButton.Size = UDim2.new(0, TopTabButton.Title.TextBounds.X + 46, 0, 30)
		end
        TopTabButton.BackgroundTransparency = 1
        TopTabButton.Title.TextTransparency = 1
        TopTabButton.Shadow.ImageTransparency = 1
        TopTabButton.Image.ImageTransparency = 1
        TopTabButton.UIStroke.Transparency = 1

        SideTabButton.BackgroundTransparency = 1
        SideTabButton.Title.TextTransparency = 1
        SideTabButton.Shadow.ImageTransparency = 1
        SideTabButton.Image.ImageTransparency = 1
        SideTabButton.UIStroke.Transparency = 1

        TopTabButton.Visible = true
        SideTabButton.Visible = true

        --Create Elements Page
        local TabPage = Elements.Template:Clone()
        TabPage.Name = Name
        TabPage.Visible = true

        TabPage.LayoutOrder = #Elements:GetChildren()

        for _, TemplateElement in ipairs(TabPage:GetChildren()) do
            if TemplateElement.ClassName == "Frame" and TemplateElement.Name ~= "Placeholder" then
                TemplateElement:Destroy()
            end
        end

        TabPage.Parent = Elements
        if not FirstTab then
            Elements.UIPageLayout.Animated = false
            Elements.UIPageLayout:JumpTo(TabPage)
            Elements.UIPageLayout.Animated = true
        end

        if SelectedTheme ~= NSUILib.Theme.Default then
            TopTabButton.Shadow.Visible = false
        end
        TopTabButton.UIStroke.Color = SelectedTheme.TabStroke
        --Animate
        task.wait(0.1)
        if FirstTab then
            TopTabButton.BackgroundColor3 = SelectedTheme.TabBackground
            TopTabButton.Image.ImageColor3 = SelectedTheme.TabTextColor
            TopTabButton.Title.TextColor3 = SelectedTheme.TabTextColor
            TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.7}):Play()
            TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0.2}):Play()
            TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.2}):Play()
            TweenService:Create(TopTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(TopTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.7}):Play()

            TweenService:Create(SideTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0,ImageColor3 = Color3.fromRGB(205, 205, 205)}):Play()
            TweenService:Create(SideTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = .2,TextColor3 = Color3.fromRGB(205, 205, 205)}):Play()	
        else
            FirstTab = Name

            TopTabButton.BackgroundColor3 = SelectedTheme.TabBackgroundSelected
            TopTabButton.Image.ImageColor3 = SelectedTheme.SelectedTabTextColor
            TopTabButton.Title.TextColor3 = SelectedTheme.SelectedTabTextColor
            TweenService:Create(TopTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.9}):Play()
            TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
            TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

            SideTabButton.Image.ImageColor3 = Color3.fromRGB(255, 255, 255)
            SideTabButton.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            TweenService:Create(SideTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
            TweenService:Create(SideTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

        end

        local function Pick()
            if Minimised then return end
            TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(TopTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
            TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
            TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
            TweenService:Create(TopTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.TabBackgroundSelected}):Play()
            TweenService:Create(TopTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextColor3 = SelectedTheme.SelectedTabTextColor}):Play()
            TweenService:Create(TopTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageColor3 = SelectedTheme.SelectedTabTextColor}):Play()
            TweenService:Create(TopTabButton.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ImageTransparency = 0.9}):Play()

            TweenService:Create(SideTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0,ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            TweenService:Create(SideTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0,TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
            Elements.UIPageLayout:JumpTo(TabPage)
            for _, OtherTabButton in ipairs(TopList:GetChildren()) do
                spawn(function()
                    if OtherTabButton.Name ~= "Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= TopTabButton and OtherTabButton.Name ~= "Placeholder" then
                        TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.TabBackground,BackgroundTransparency = .7}):Play()
                        TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageColor3 = Color3.fromRGB(240, 240, 240)}):Play()
                        TweenService:Create(OtherTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0,Color = Color3.fromRGB(85,85,85)}):Play()
                        TweenService:Create(OtherTabButton.Shadow, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = .85,ImageColor3 = Color3.fromRGB(20,20,20)}):Play()
                        TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextColor3 = Color3.fromRGB(240, 240, 240),TextTransparency = .2}):Play()
                    end
                end)
            end
            for _,OtherTabButton in ipairs(SideList:GetChildren()) do
                spawn(function()
                    if OtherTabButton.Name ~= "Template" and OtherTabButton.ClassName == "Frame" and OtherTabButton ~= SideTabButton and OtherTabButton.Name ~= "Placeholder" then
                        TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0,ImageColor3 = Color3.fromRGB(205, 205, 205)}):Play()
                        TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = .2,TextColor3 = Color3.fromRGB(205, 205, 205)}):Play()	
                    end
                end)
            end

        end

        TopTabButton.Interact.MouseButton1Click:Connect(Pick)
        SideTabButton.Interact.MouseButton1Click:Connect(Pick)

        -- Register this tab so search results and pinned-panel entries can navigate here
        TabNavRegistry[Name] = {
            page     = TabPage,
            navigate = Pick
        }

        -- Button
        function Tab:CreateButton(ButtonSettings)
            local ButtonValue = {Locked = false}

            local Button = Elements.Template.Button:Clone()
            ButtonValue.Button = Button
            Tab.Elements[Button.Name] = {
                type = "button",
                section = ButtonSettings.SectionParent,
                element = Button
            }

            Button.Name = ButtonSettings.Name
            Button.Title.Text = ButtonSettings.Name
            Button.ElementIndicator.Text = ButtonSettings.Interact or "button"
            Button.Visible = true

            Button.BackgroundTransparency = 1
            Button.UIStroke.Transparency = 1
            Button.Title.TextTransparency = 1
            if ButtonSettings.SectionParent then
                Button.Parent = ButtonSettings.SectionParent.Holder
            else
                Button.Parent = TabPage
            end
            TweenService:Create(Button, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Button.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Button.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

            Button.Interact.MouseButton1Click:Connect(function()
                if ButtonValue.Locked then return end
                local Success, Response = pcall(ButtonSettings.Callback)
                if not Success then
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    Button.Title.Text = "Callback Error"
                    print("NSUI | "..ButtonSettings.Name.." Callback Error " ..tostring(Response))
                    task.wait(0.5)
                    Button.Title.Text = ButtonSettings.Name
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.9}):Play()
                else
                    SaveConfiguration()
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    task.wait(0.2)
                    TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                    TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.9}):Play()
                end
            end)

            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.7}):Play()
            end)

            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.9}):Play()
            end)

            function ButtonValue:Set(NewButton,Interaction)
                Button.Title.Text = NewButton or Button.Title.Text
                Button.Name = NewButton or Button.Name
                Button.ElementIndicator.Text = Interaction or Button.ElementIndicator.Text
            end
            function ButtonValue:Destroy()
                Button:Destroy()
            end
            function ButtonValue:Lock(Reason)
                if ButtonValue.Locked then return end
                ButtonValue.Locked = true
                Button.Lock.Reason.Text = Reason or "Locked"
                TweenService:Create(Button.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
                TweenService:Create(Button.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                task.wait(0.2)
                if not ButtonValue.Locked then return end --no icon bug
                TweenService:Create(Button.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
            end
            function ButtonValue:Unlock()
                if not ButtonValue.Locked then return end
                ButtonValue.Locked = false
                task.wait(0.2)
                TweenService:Create(Button.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                if ButtonValue.Locked then return end --no icon bug
                TweenService:Create(Button.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(Button.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
            end
            function ButtonValue:Visible(bool)
                Button.Visible = bool
            end

            return ButtonValue
        end

        -- Section
        function Tab:CreateSection(SectionName, Display, DefaultHide, Icon)
            local SectionValue = {
                Holder = NSUILib.Holding,
                Open = true
            }
            local Debounce = false
            local Section = Elements.Template.SectionTitle:Clone()
            SectionValue.Holder = Section.Holder
            Section.Name = SectionName   -- fix: use real name so search path shows correctly
            Section.Title.Text = SectionName
            Section.Visible = true
            Section.Parent = TabPage

            Tab.Elements[SectionName] = {
                type = 'section',
                display = Display,
                sectionholder = Section.Holder,
                element = Section
            }

            Section.Icon.Visible = false
            if not Icon or Icon == nil then
                Section.Icon.Visible = false
                Section.Title.Position = UDim2.new(0, 10, 0, 8)
            else
                Section.Icon.Image = "rbxassetid://" .. tostring(Icon)
                Section.Icon.Visible = true
                Section.Title.Position = UDim2.new(0, 35, 0, 8)
            end

            Section.Title.TextTransparency = 1
            TweenService:Create(Section.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { TextTransparency = 0 })
                :Play()

            -- ─────────────────────────────────────────────────────────────────

            function SectionValue:Set(NewSection)
                Section.Title.Text = NewSection
            end

            if Display then
                Section._UIPadding_.PaddingBottom = UDim.new(0, 4)
                Section.Holder.Visible = false
                Section.BackgroundTransparency = 1
                SectionValue.Holder.Parent = NSUILib.Holding
                Section.Title.ImageButton.Visible = false
            end

            if DefaultHide and not Display then
                coroutine.wrap(function()
                    wait()
                    Section._UIPadding_.PaddingBottom = UDim.new(0, 4)
                    for _, element in ipairs(Section.Holder:GetChildren()) do
                        if element.ClassName == "Frame" then
                            if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" and element.Name ~= 'Topholder' then
                                if element.Name == "SectionTitle" then
                                    element.Title.TextTransparency = 1
                                else
                                    element.BackgroundTransparency = 1
                                    element.UIStroke.Transparency = 1
                                    element.Title.TextTransparency = 1
                                end

                                for _, child in ipairs(element:GetChildren()) do
                                    if child.ClassName == "Frame" then
                                        child.Visible = false
                                    end
                                end
                            end
                            element.Visible = false
                        end
                    end
                    Section.Title.ImageButton.Rotation = 180
                    SectionValue.Open = false
                end)()
            elseif not DefaultHide and not Display then
                Section._UIPadding_.PaddingBottom = UDim.new(0, 8)
            end

            Section.Clickable.MouseButton1Down:Connect(function()
                if Debounce then return end
                if SectionValue.Open then
                    --Section.Holder.Visible = true
                    Debounce = true
                    TweenService:Create(Section._UIPadding_, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        { PaddingBottom = UDim.new(0, 4) }):Play()
                    for _, element in ipairs(Section.Holder:GetChildren()) do
                        if element.ClassName == "Frame" then
                            if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" and element.Name ~= 'Topholder' then
                                if element.Name == "SectionTitle" then
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { TextTransparency = 1 }):Play()
                                else
                                    TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { BackgroundTransparency = 1 }):Play()
                                    TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { Transparency = 1 }):Play()
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { TextTransparency = 1 }):Play()
                                end
                                for _, child in ipairs(element:GetChildren()) do
                                    if child.ClassName == "Frame" then --or child.ClassName == "TextLabel" or child.ClassName == "TextBox" or child.ClassName == "ImageButton" or child.ClassName == "ImageLabel" then
                                        child.Visible = false
                                    end
                                end
                            end
                            element.Visible = false
                        end
                    end
                    TweenService:Create(Section.Title.ImageButton,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 }):Play()
                    SectionValue.Open = false
                    Debounce = false
                else
                    Debounce = true
                    TweenService:Create(Section._UIPadding_, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                        { PaddingBottom = UDim.new(0, 8) }):Play()
                    for _, element in ipairs(Section.Holder:GetChildren()) do
                        if element.ClassName == "Frame" then
                            if element.Name ~= "SectionSpacing" and element.Name ~= "Placeholder" and element.Name ~= 'Topholder' and not element:FindFirstChild('ColorPickerIs') then
                                if element.Name == "SectionTitle" then
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { TextTransparency = 0 }):Play()
                                else
                                    TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { BackgroundTransparency = 0 }):Play()
                                    TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { Transparency = 0 }):Play()
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                        { TextTransparency = 0 }):Play()
                                end
                                for _, child in ipairs(element:GetChildren()) do
                                    if (child.ClassName == "Frame" or child.ClassName == "TextLabel" or child.ClassName == "TextBox" or child.ClassName == "ImageButton" or child.ClassName == "ImageLabel") then
                                        child.Visible = true
                                    end
                                end
                            elseif element:FindFirstChild('ColorPickerIs') then
                                TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { BackgroundTransparency = 0 }):Play()
                                TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { Transparency = 0 }):Play()
                                TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint),
                                    { TextTransparency = 0 }):Play()
                                if element.ColorPickerIs.Value then
                                    element.ColorSlider.Visible = true
                                    element.HexInput.Visible = true
                                    element.RGB.Visible = true
                                end
                                element.CPBackground.Visible = true
                                element.Lock.Visible = true
                                element.Interact.Visible = true
                                element.Title.Visible = true
                            end
                            element.Visible = true
                        end
                    end
                    TweenService:Create(Section.Title.ImageButton,
                        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 }):Play()
                    SectionValue.Open = true
                    wait(.3)
                    Debounce = false
                end
            end)
            SDone = true
            function SectionValue:Lock(Reason)

            end

            function SectionValue:Unlock(Reason)

            end

            return SectionValue
        end
        -- Spacing
        function Tab:CreateSpacing(SectionParent, Size)
    local Spacing = Elements.Template.SectionSpacing:Clone()
    Spacing.Visible = true
    Spacing.Size = UDim2.new(0, 390, 0, Size or 6)
    Spacing.BackgroundColor3 = Color3.fromRGB(59, 59, 59)
    Spacing.BackgroundTransparency = 0
    Spacing.BorderSizePixel = 0

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 4)
    Corner.Parent = Spacing

    local Parent = SectionParent and SectionParent.Holder or TabPage
    if #Parent:GetChildren() > 0 then
        local LastChild = Parent:GetChildren()[#Parent:GetChildren()]
        if LastChild and LastChild:IsA("GuiObject") then
            Spacing.Position = UDim2.new(0, 0, 0, LastChild.Position.Y.Offset + LastChild.Size.Y.Offset + 10)
        end
    else
        Spacing.Position = UDim2.new(0, 0, 0, 10)
    end

    Spacing.Parent = Parent
end

        -- Label
        function Tab:CreateLabel(LabelText,SectionParent)
            local LabelValue = {}

            local Label = Elements.Template.Label:Clone()
            Label.Title.Text = LabelText
            Label.Visible = true
            Tab.Elements[LabelText] = {
                type = "label",
                section = SectionParent,
                element = Label
            }
            if SectionParent then
                Label.Parent = SectionParent.Holder
            else
                Label.Parent = TabPage
            end

            Label.BackgroundTransparency = 1
            Label.UIStroke.Transparency = 1
            Label.Title.TextTransparency = 1

            Label.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
            Label.UIStroke.Color = SelectedTheme.SecondaryElementStroke

            TweenService:Create(Label, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Label.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Label.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

            function LabelValue:Set(NewLabel)
                Label.Title.Text = NewLabel
            end

            return LabelValue
        end

        -- Paragraph
        function Tab:CreateParagraph(ParagraphSettings, SectionParent)
            local ParagraphValue = {}

            local Paragraph = Elements.Template.Paragraph:Clone()
            Paragraph.Title.Text = ParagraphSettings.Title
		Paragraph.Title.RichText = true
            Paragraph.Content.Text = ParagraphSettings.Content
            Paragraph.Content.RichText = true
            if ParagraphSettings.Icon then
                local PIcon = Instance.new("ImageLabel")
                PIcon.Name                   = "ParagraphIcon"
                PIcon.Size                   = UDim2.new(0, 18, 0, 18)
                PIcon.AnchorPoint            = Vector2.new(0, 0.5)
                PIcon.Position               = UDim2.new(0, 10, 0, 27)
                PIcon.BackgroundTransparency = 1
                PIcon.Image                  = "rbxassetid://" .. tostring(ParagraphSettings.Icon)
                PIcon.ImageColor3            = Color3.fromRGB(210, 210, 210)
                PIcon.ImageTransparency      = 1
                PIcon.ZIndex                 = Paragraph.Title.ZIndex
                PIcon.Parent                 = Paragraph

                Paragraph.Title.Position = UDim2.new(0, 34, Paragraph.Title.Position.Y.Scale, Paragraph.Title.Position.Y.Offset)
                Paragraph.Title.Size     = UDim2.new(Paragraph.Title.Size.X.Scale, Paragraph.Title.Size.X.Offset - 24, Paragraph.Title.Size.Y.Scale, Paragraph.Title.Size.Y.Offset)

                TweenService:Create(PIcon, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
            end
            Paragraph.Visible = true
            Tab.Elements[ParagraphSettings.Title] = {
                type = "paragraph",
                section = ParagraphSettings.SectionParent,
                element = Paragraph
            }
            if SectionParent or (ParagraphSettings.SectionParent and ParagraphSettings.SectionParent.Holder) then
                Paragraph.Parent = SectionParent.Holder or ParagraphSettings.SectionParent.Holder
            else
                Paragraph.Parent = TabPage
            end

            -- local textSize = TextService:GetTextSize(Paragraph.Content.Text, Paragraph.Content.TextSize, Paragraph.Content.Font, Vector2.new(math.huge, math.huge))
            -- Paragraph.Content.Size = UDim2.new(0, 438, 0, textSize.Y)
            -- --Paragraph.Content.Position = UDim2.new(0,465, 0,76)
            -- Paragraph.Size = UDim2.new(0,465, 0, textSize.Y + 40)

            Paragraph.BackgroundTransparency = 1
            Paragraph.UIStroke.Transparency = 1
            Paragraph.Title.TextTransparency = 1
            Paragraph.Content.TextTransparency = 1
            
            Paragraph.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
            Paragraph.UIStroke.Color = SelectedTheme.SecondaryElementStroke

            TweenService:Create(Paragraph, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Paragraph.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Paragraph.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	
            TweenService:Create(Paragraph.Content, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

            function ParagraphValue:Set(NewParagraphSettings)
                Paragraph.Title.Text   = NewParagraphSettings.Title
                Paragraph.Content.Text = NewParagraphSettings.Content
                if NewParagraphSettings.Icon then
                    local existing = Paragraph:FindFirstChild("ParagraphIcon")
                    if existing then
                        existing.Image = "rbxassetid://" .. tostring(NewParagraphSettings.Icon)
                    end
                end
            end

            return ParagraphValue
        end

        -- Input
        function Tab:CreateInput(InputSettings)
            local Input = Elements.Template.Input:Clone()
            Input.Name = InputSettings.Name
            Input.Title.Text = InputSettings.Name
            Input.Visible = true
            InputSettings.Locked = false
            Tab.Elements[InputSettings.Name] = {
                type = "input",
                section = InputSettings.SectionParent,
                element = Input
            }
            if InputSettings.SectionParent then
                Input.Parent = InputSettings.SectionParent.Holder
            else
                Input.Parent = TabPage
            end
            Input.BackgroundTransparency = 1
            Input.UIStroke.Transparency = 1
            Input.Title.TextTransparency = 1

            Input.InputFrame.BackgroundColor3 = SelectedTheme.InputBackground
            Input.InputFrame.UIStroke.Color = SelectedTheme.InputStroke

            TweenService:Create(Input, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Input.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Input.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

            Input.InputFrame.InputBox.PlaceholderText = InputSettings.PlaceholderText
            Input.InputFrame.Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)

            if InputSettings.NumbersOnly or InputSettings.CharacterLimit then
                Input.InputFrame.InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                    if Input.InputFrame.InputBox.Text == "" then return end 
                    if InputSettings.CharacterLimit then Input.InputFrame.InputBox.Text = Input.InputFrame.InputBox.Text:sub(1,InputSettings.CharacterLimit) end
                    if InputSettings.NumbersOnly then
    			Input.InputFrame.InputBox.Text = Input.InputFrame.InputBox.Text:gsub("[^%d%.]", "")
    			local dotCount = select(2, Input.InputFrame.InputBox.Text:gsub("%.", ""))
    			if dotCount > 1 then
        			Input.InputFrame.InputBox.Text = Input.InputFrame.InputBox.Text:sub(1, #Input.InputFrame.InputBox.Text - 1)
    			end
		end
                end)
            end

            Input.InputFrame.InputBox.FocusLost:Connect(function(enter)
                if InputSettings.OnEnter and not enter then if InputSettings.RemoveTextAfterFocusLost then Input.InputFrame.InputBox.Text = "" end return end
                local Success, Response = pcall(function()
                    InputSettings.Callback(Input.InputFrame.InputBox.Text)
                end)
                if not Success then
                    TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                    TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    Input.Title.Text = "Callback Error"
                    print("NSUI | "..InputSettings.Name.." Callback Error " ..tostring(Response))
                    task.wait(0.5)
                    Input.Title.Text = InputSettings.Name
                    TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                end

                if InputSettings.RemoveTextAfterFocusLost then Input.InputFrame.InputBox.Text = "" end
                SaveConfiguration()
            end)

            Input.MouseEnter:Connect(function()
                TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
            end)

            Input.MouseLeave:Connect(function()
                TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
            end)

            Input.InputFrame.InputBox:GetPropertyChangedSignal("Text"):Connect(function()
                TweenService:Create(Input.InputFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)}):Play()
            end)

            Input.InputFrame.InputBox.Focused:Connect(function()
                if InputSettings.Locked then
                    Input.InputFrame.InputBox:ReleaseFocus() return
                end
            end)

            function InputSettings:Destroy()
                Input:Destroy()
            end
            function InputSettings:Lock(Reason)
                if InputSettings.Locked then return end
                InputSettings.Locked = true
                Input.Lock.Reason.Text = Reason or "Locked"
                TweenService:Create(Input.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
                TweenService:Create(Input.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                task.wait(0.2)
                if not InputSettings.Locked then return end --no icon bug
                TweenService:Create(Input.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
            end
            function InputSettings:Unlock()
                if not InputSettings.Locked then return end
                InputSettings.Locked = false
                task.wait(0.2)
                TweenService:Create(Input.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                if InputSettings.Locked then return end --no icon bug
                TweenService:Create(Input.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(Input.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
            end
            function InputSettings:Visible(bool)
                Input.Visible = bool
            end
            return InputSettings
        end

        -- Dropdown
        function Tab:CreateDropdown(DropdownSettings)
            local Dropdown = Elements.Template.Dropdown:Clone()
            local SearchBar = Dropdown.List["-SearchBar"]
            local Required = 0
            --local Debounce = false
            DropdownSettings.Items = DropdownSettings.Items or {}
	        DropdownSettings.Items.Selected = DropdownSettings.Items.Selected or {}
            DropdownSettings.Locked = false
            local Multi = DropdownSettings.MultiSelection or false
            if string.find(DropdownSettings.Name,"closed") then
                Dropdown.Name = "Dropdown"
            else
                Dropdown.Name = DropdownSettings.Name
            end
            Dropdown.Title.Text = DropdownSettings.Name
            pcall(function() Dropdown.ElementIndicator.Text = "" end)
            Dropdown.Visible = true
            Tab.Elements[DropdownSettings.Name] = {
                type = "dropdown",
                section = DropdownSettings.SectionParent,
                element = Dropdown
            }
            if DropdownSettings.SectionParent then
                Dropdown.Parent = DropdownSettings.SectionParent.Holder
            else
                Dropdown.Parent = TabPage
            end

            Dropdown.List.Visible = false
            Dropdown.BackgroundTransparency = 1
            Dropdown.UIStroke.Transparency = 1
            Dropdown.Title.TextTransparency = 1

            Dropdown.Size = UDim2.new(0,465, 0, 44)

            TweenService:Create(Dropdown, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Dropdown.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	


            for _, child in ipairs(Dropdown.List:GetChildren()) do
    		if child.ClassName == "Frame" and child.Name ~= "PlaceHolder" and child.Name ~= "-SearchBar" then
        		if not DropdownSettings.Items[child.Name] then
            			child:Destroy()
        		end
    		end
	end

            Dropdown.Toggle.Rotation = 180

            local function RefreshSelected()
                if #DropdownSettings.Items.Selected > 1 then
                    local NT = {}
                    for _,kj in ipairs(DropdownSettings.Items.Selected) do
                        NT[#NT+1] = kj.Option.Name
                    end
                    Dropdown.Selected.Text = table.concat(NT, ", ")
                elseif DropdownSettings.Items.Selected[1] then
                    Dropdown.Selected.Text = DropdownSettings.Items.Selected[1].Option.Name
                else
                    Dropdown.Selected.Text = DropdownSettings.PlaceholderText or "Choose an option"
                end
                pcall(function() Dropdown.ElementIndicator.Text = Dropdown.Selected.Text end)
            end

            Dropdown.Interact.MouseButton1Click:Connect(function()
                if DropdownSettings.Locked then return end
                TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                task.wait(0.1)
                TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()

                if Debounce then return end

                if Dropdown.List.Visible then
                    Debounce = true
                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, 44)}):Play()
                    for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                        if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "PlaceHolder" and DropdownOpt ~= SearchBar then
                            TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                            TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                            TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        end
                    end
                    TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 1}):Play()
                    TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()	
                    task.wait(0.35)
                    Dropdown.List.Visible = false
                    Debounce = false
                else
                local fixedDropdownHeight = 278
                Dropdown.List.Size = UDim2.new(1, 0, 0, fixedDropdownHeight)
                Dropdown.List.Visible = true
                Dropdown.List.ScrollingEnabled = true
                Dropdown.List.CanvasSize = UDim2.new(0, 0, 0, Dropdown.List.UIListLayout.AbsoluteContentSize.Y)
                Dropdown.List.ScrollBarThickness = 6
                TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 465, 0, fixedDropdownHeight + 44)}):Play()
                for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                    if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "PlaceHolder" and DropdownOpt ~= SearchBar then
                        DropdownOpt.Visible = true
                        TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                        TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                    end
                end
                TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 0.7}):Play()
                TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 0}):Play()
            end
            end)

            Dropdown.List["-SearchBar"].Input:GetPropertyChangedSignal("Text"):Connect(function()
                local InputText=string.upper(Dropdown.List["-SearchBar"].Input.Text)
                for _,item in ipairs(Dropdown.List:GetChildren()) do
                    if item:IsA("Frame") and item.Name ~= "Template" and item ~= SearchBar and item.Name ~= "PlaceHolder" then
                        if InputText=="" or InputText==" "or string.find(string.upper(item.Name),InputText)~=nil then
                            TweenService:Create(item, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                            TweenService:Create(item.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                            TweenService:Create(item.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                        else
                            TweenService:Create(item, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                            TweenService:Create(item.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                            TweenService:Create(item.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                        end
                    end
                end
            end)

            Dropdown.MouseEnter:Connect(function()
                if not Dropdown.List.Visible then
                    TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                end
            end)

            Dropdown.MouseLeave:Connect(function()
                TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
            end)

            local function Error(text)
                TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                Dropdown.Title.Text = text
                task.wait(0.5)
                Dropdown.Title.Text = DropdownSettings.Name
                TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            end

            local function AddOption(Option,Selecteds)
                local DropdownOption = Elements.Template.Dropdown.List.Template:Clone()
                DropdownOption:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
                    if DropdownOption.BackgroundTransparency == 1 then
                        DropdownOption.Visible = false
                    else
                        DropdownOption.Visible = true
                    end
                end)
                DropdownSettings.Items[Option] = {
                    Option = DropdownOption,
                    Selected = false
                }
                local OptionInTable = DropdownSettings.Items[Option]
                DropdownOption.Name = Option.Name or Option
                DropdownOption.Title.Text = Option.Name or Option
                DropdownOption.Parent = Dropdown.List
                DropdownOption.Visible = true
                local IsSelected = OptionInTable.Selected
                if Selecteds and #Selecteds > 0 then
                    if typeof(Selecteds) == "string" then
                        Selecteds = {Selecteds}
                    end
                    for index,Selected in pairs(Selecteds) do
                        if Selected == Option then
                            IsSelected = true
                            OptionInTable.Selected = true
                            table.insert(DropdownSettings.Items.Selected,OptionInTable)
                            DropdownSettings.Items.Selected[table.find(DropdownSettings.Items.Selected,OptionInTable)].Selected = true
                        end
                    end
                    RefreshSelected()
                end

                if IsSelected then
                    DropdownOption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                end

                if Dropdown.Visible then
                    DropdownOption.BackgroundTransparency = 0
                    DropdownOption.UIStroke.Transparency = 0
                    DropdownOption.Title.TextTransparency = 0
                else
                    DropdownOption.BackgroundTransparency = 1
                    DropdownOption.UIStroke.Transparency = 1
                    DropdownOption.Title.TextTransparency = 1
                end

                DropdownOption.Interact.ZIndex = 50
                DropdownOption.Interact.MouseButton1Click:Connect(function()
                    if DropdownSettings.Locked then return end
                    if OptionInTable.Selected then
                        OptionInTable.Selected = false
                        table.remove(DropdownSettings.Items.Selected,table.find(DropdownSettings.Items.Selected,OptionInTable))
                        RefreshSelected()
                        TweenService:Create(DropdownOption, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                        SaveConfiguration()
                        return
                    end
                    if not Multi and DropdownSettings.Items.Selected[1] then
                        DropdownSettings.Items.Selected[1].Selected = false
                        TweenService:Create(DropdownSettings.Items.Selected[1].Option, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                    end
                    if not (Multi) then
                        DropdownSettings.Items.Selected = {OptionInTable}
                        Dropdown.Selected.Text = Option.Name or Option
                    else
                        table.insert(DropdownSettings.Items.Selected,OptionInTable)
                        RefreshSelected()
                    end

                    local Success, Response = pcall(function()
                        DropdownSettings.Callback(Option)
                    end)
                    if not Success then
                        Error("Callback Error")
                        print("NSUI | "..DropdownSettings.Name.." Callback Error " ..tostring(Response))
                    end

                    OptionInTable.Selected = true

                    if not (Multi) then
                        for _,op in ipairs(DropdownSettings.Items.Selected) do
                            TweenService:Create(op.Option, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                        end
                    end
                    TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    TweenService:Create(DropdownOption, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                    Debounce = true
                    task.wait(0.2)
                    TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                    task.wait(0.1)
                    if not Multi then
                        TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0,465, 0, 45)}):Play()
                        for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                            if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "PlaceHolder" and DropdownOpt ~= SearchBar then
                                TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                                TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                                TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                            end
                        end
                        TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 1}):Play()
                        TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()	
                        task.wait(0.35)
                        Dropdown.List.Visible = false

                    end
                    Debounce = false
                    SaveConfiguration()
                end)
            end
            local function AddOptions(Options,Selected)
                if typeof(Options) == "table" then
                    for _, Option in ipairs(Options) do
                        AddOption(Option,Selected)
                    end
                else
                    AddOption(Options,Selected)
                end
                if Settings.ConfigurationSaving then
                    if Settings.ConfigurationSaving.Enabled and DropdownSettings.Flag then
                        NSUILib.Flags[DropdownSettings.Flag] = DropdownSettings
                    end
                end
            end
            function DropdownSettings:Add(Items,Selected)
                AddOptions(Items,Selected)
            end

            AddOptions(DropdownSettings.Options, DropdownSettings.CurrentOption)
            RefreshSelected()

            --fix
            function DropdownSettings:Set(NewOption)

                for _,o in pairs(NewOption) do

                    if typeof(NewOption) == "table" then

                        DropdownSettings.Items.Selected = NewOption
                    else
                        DropdownSettings.Items.Selected = {NewOption}
                    end
                    local Success, Response = pcall(function()
                        DropdownSettings.Callback(NewOption)
                    end)
                    if not Success then
                        TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                        TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                        Dropdown.Title.Text = "Callback Error"
                        print("NSUI | "..DropdownSettings.Name.." Callback Error " ..tostring(Response))
                        task.wait(0.5)
                        Dropdown.Title.Text = DropdownSettings.Name
                        TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                        TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                    end
                    if DropdownSettings.Items[NewOption] then
                        local DropdownOption =  DropdownSettings.Items[NewOption]
                        DropdownOption.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

                        if Dropdown.Visible then
                            DropdownOption.BackgroundTransparency = 0
                            DropdownOption.UIStroke.Transparency = 0
                            DropdownOption.Title.TextTransparency = 0
                        else
                            DropdownOption.BackgroundTransparency = 1
                            DropdownOption.UIStroke.Transparency = 1
                            DropdownOption.Title.TextTransparency = 1
                        end

                    end
                end
                --Dropdown.Selected.Text = NewText
            end
            function DropdownSettings:Error(text)
                Error(text)
            end
            function DropdownSettings:Refresh(NewOptions, Selecteds)
                DropdownSettings.Items = {}
                DropdownSettings.Items.Selected = {}
                for _, option in ipairs(Dropdown.List:GetChildren()) do
                    if option.ClassName == "Frame" and option ~= SearchBar and option.Name ~= "Placeholder" then
                        option:Destroy()
                    end
                end
                if typeof(Selecteds) == "string" then
                    local isRealOption = false
                    if typeof(NewOptions) == "table" then
                        for _, opt in ipairs(NewOptions) do
                            if opt == Selecteds then isRealOption = true break end
                        end
                    end
                    if not isRealOption then
                        DropdownSettings.PlaceholderText = Selecteds
                        Dropdown.Selected.Text = Selecteds
                        AddOptions(NewOptions, nil)
                        return
                    end
                end
                AddOptions(NewOptions, Selecteds)
                RefreshSelected()
            end
            function DropdownSettings:Remove(Item)
                if Item.Name ~= "Placeholder" and Item ~= SearchBar then
                    if DropdownSettings.Items[Item] then
                        DropdownSettings.Items[Item].Option:Destroy()
                        table.remove(DropdownSettings.Items,table.find(DropdownSettings.Items,Item))
                    else
                        Error("Option not found.")
                    end
                else
                    SearchBar:Destroy()
                    Error("why you trynna remove the searchbar? FINE")
                end
                if Dropdown.Selected.Text == Item then
                    DropdownSettings.Items.Selected = {}
                    RefreshSelected()
                end
            end

            function DropdownSettings:Destroy()
                Dropdown:Destroy()
            end
            function DropdownSettings:Lock(Reason)
                if DropdownSettings.Locked then return end
                DropdownSettings.Locked = true
                Debounce = true
                TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Size = UDim2.new(0,465, 0, 44)}):Play()
                for _, DropdownOpt in ipairs(Dropdown.List:GetChildren()) do
                    if DropdownOpt.ClassName == "Frame" and DropdownOpt.Name ~= "PlaceHolder" and DropdownOpt.Name ~= "-SearchBar" then
                        TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                        TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                        TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
                    end
                end
                TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {ScrollBarImageTransparency = 1}):Play()
                TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Rotation = 180}):Play()	
                task.wait(0.35)
                Dropdown.List.Visible = false
                Debounce = false
                Dropdown.Lock.Reason.Text = Reason or "Locked"
                TweenService:Create(Dropdown.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
                TweenService:Create(Dropdown.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                task.wait(0.2)
                if not DropdownSettings.Locked then return end --no icon bug
                TweenService:Create(Dropdown.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
            end
            function DropdownSettings:Unlock()
                if not DropdownSettings.Locked then return end
                DropdownSettings.Locked = false
                task.wait(0.2)
                TweenService:Create(Dropdown.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                if DropdownSettings.Locked then return end --no icon bug
                TweenService:Create(Dropdown.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(Dropdown.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
            end
            function DropdownSettings:Visible(bool)
                Dropdown.Visible = bool
            end
            return DropdownSettings
        end

        -- Keybind
       function Tab:CreateKeybind(KeybindSettings)
    local CheckingForKey = false
    local Keybind = Elements.Template.Keybind:Clone()
    Keybind.Name = KeybindSettings.Name
    Keybind.Title.Text = KeybindSettings.Name
    Keybind.Visible = true
    local BlockedKeybinds = KeybindSettings.BlockedKeybinds or {}

    Tab.Elements[KeybindSettings.Name] = {
        type = "keybind",
        section = KeybindSettings.SectionParent,
        element = Keybind
    }

    if KeybindSettings.SectionParent then
        Keybind.Parent = KeybindSettings.SectionParent.Holder
    else
        Keybind.Parent = TabPage
    end

    Keybind.BackgroundTransparency = 1
    Keybind.UIStroke.Transparency = 1
    Keybind.Title.TextTransparency = 1

    Keybind.KeybindFrame.BackgroundColor3 = SelectedTheme.InputBackground
    Keybind.KeybindFrame.UIStroke.Color = SelectedTheme.InputStroke

    TweenService:Create(Keybind, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
    TweenService:Create(Keybind.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()

    local function GetKeyCodeName(str)
        if not str or str == "" then return nil end
        for _, kc in ipairs(Enum.KeyCode:GetEnumItems()) do
            if kc.Name:upper() == str:upper() then
                return kc.Name
            end
        end
        return nil
    end

    local displayText = (KeybindSettings.CurrentKeybind and KeybindSettings.CurrentKeybind ~= "Unknown")
        and KeybindSettings.CurrentKeybind
        or "Set Keybind"

    Keybind.KeybindFrame.KeybindBox.Text = displayText
    Keybind.KeybindFrame.Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30)

    Keybind.KeybindFrame.KeybindBox.Focused:Connect(function()
        if KeybindSettings.Locked then
            Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
            return
        end
        CheckingForKey = true
        Keybind.KeybindFrame.KeybindBox.Text = ""
    end)

    Keybind.KeybindFrame.KeybindBox.FocusLost:Connect(function()
        CheckingForKey = false
        local box = Keybind.KeybindFrame.KeybindBox
        local txt = box.Text

        if txt == "" then
            local current = KeybindSettings.CurrentKeybind
            if not current or current == "Unknown" then
                box.Text = "Set Keybind"
            else
                box.Text = current
            end
            return
        end

        local matchedName = GetKeyCodeName(txt)

        if matchedName then
            KeybindSettings.CurrentKeybind = matchedName
            box.Text = matchedName
        else
            local current = KeybindSettings.CurrentKeybind
            if not current or current == "Unknown" then
                box.Text = "Set Keybind"
            else
                box.Text = current
            end
        end

        SaveConfiguration()
    end)

    Keybind.MouseEnter:Connect(function()
        TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
    end)

    Keybind.MouseLeave:Connect(function()
        TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
    end)

    local function CanBeToggled()
        KeybindSettings.Toggled = not KeybindSettings.Toggled
        local Success, Response = pcall(KeybindSettings.Callback, KeybindSettings.Toggled)
        if not Success then
            TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
            TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
            Keybind.Title.Text = "Callback Error"
            print("NSUI | "..KeybindSettings.Name.." Callback Error " ..tostring(Response))
            task.wait(0.5)
            Keybind.Title.Text = KeybindSettings.Name
            TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
            TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
        end
    end

    UserInputService.InputBegan:Connect(function(input, processed)
        if CheckingForKey then
            if input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode ~= Enum.KeyCode.Quote then
                local SplitMessage = string.split(tostring(input.KeyCode), ".")
                local NewKeyNoEnum = SplitMessage[3]

                if table.find(BlockedKeybinds, NewKeyNoEnum) then
                    NSUILib:Notify({
                        Title = "Blocked Key",
                        Content = "You can't use that key as a keybind!",
                        Duration = 2.5
                    })
                    task.wait(0.5)
                    local current = KeybindSettings.CurrentKeybind
                    Keybind.KeybindFrame.KeybindBox.Text = (not current or current == "Unknown") and "Set Keybind" or current
                    return
                end

                Keybind.KeybindFrame.KeybindBox.Text = NewKeyNoEnum
                KeybindSettings.CurrentKeybind = NewKeyNoEnum
                Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
                SaveConfiguration()
            end
        else
            local current = KeybindSettings.CurrentKeybind
            if not current or current == "Unknown" or current == "Set Keybind" then return end

            local ok, keyCode = pcall(function() return Enum.KeyCode[current] end)
            if not ok or not keyCode or input.KeyCode ~= keyCode then return end

            local Held = true
            local Connection
            Connection = input.Changed:Connect(function(prop)
                if prop == "UserInputState" then
                    Connection:Disconnect()
                    Held = false
                end
            end)

            if KeybindSettings.CanBeToggled then
                CanBeToggled()
            elseif not KeybindSettings.HoldToInteract then
                local Success, Response = pcall(KeybindSettings.Callback, true)
                if not Success then
                    TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                    TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    Keybind.Title.Text = "Callback Error"
                    print("NSUI | "..KeybindSettings.Name.." Callback Error " ..tostring(Response))
                    task.wait(0.5)
                    Keybind.Title.Text = KeybindSettings.Name
                    TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                end
            else
                task.wait(0.25)
                if Held then
                    local Loop; Loop = RunService.Stepped:Connect(function()
                        if not Held then
                            KeybindSettings.Callback(false)
                            Loop:Disconnect()
                        else
                            KeybindSettings.Callback(true)
                        end
                    end)
                end
            end
        end
    end)

    Keybind.KeybindFrame.KeybindBox:GetPropertyChangedSignal("Text"):Connect(function()
        TweenService:Create(Keybind.KeybindFrame, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30)}):Play()
    end)

    function KeybindSettings:Set(NewKeybind)
        local matchedName = GetKeyCodeName(tostring(NewKeybind))
        local display = matchedName or tostring(NewKeybind)
        Keybind.KeybindFrame.KeybindBox.Text = display
        KeybindSettings.CurrentKeybind = display
        Keybind.KeybindFrame.KeybindBox:ReleaseFocus()
        SaveConfiguration()
    end

    function KeybindSettings:Destroy()
        Keybind:Destroy()
    end

    function KeybindSettings:Lock(Reason)
        if KeybindSettings.Locked then return end
        KeybindSettings.Locked = true
        Keybind.Lock.Reason.Text = Reason or "Locked"
        TweenService:Create(Keybind.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
        TweenService:Create(Keybind.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        task.wait(0.2)
        if not KeybindSettings.Locked then return end
        TweenService:Create(Keybind.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
    end

    function KeybindSettings:Unlock()
        if not KeybindSettings.Locked then return end
        KeybindSettings.Locked = false
        task.wait(0.2)
        TweenService:Create(Keybind.Lock.Reason.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
        if KeybindSettings.Locked then return end
        TweenService:Create(Keybind.Lock, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        TweenService:Create(Keybind.Lock.Reason, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
    end

    function KeybindSettings:Visible(bool)
        Keybind.Visible = bool
    end

    function KeybindSettings:Clear()
        CheckingForKey = false
        Keybind.KeybindFrame.KeybindBox.Text = "Set Keybind"
        KeybindSettings.CurrentKeybind = "Unknown"
        SaveConfiguration()
    end

    if Settings.ConfigurationSaving then
        if Settings.ConfigurationSaving.Enabled and KeybindSettings.Flag then
            NSUILib.Flags[KeybindSettings.Flag] = KeybindSettings
        end
    end

    return KeybindSettings
end


-- Toggle
        function Tab:CreateToggle(ToggleSettings)

            local Toggle = Elements.Template.Toggle:Clone()
            Toggle.Name = ToggleSettings.Name
            Toggle.Title.Text = ToggleSettings.Name
            Toggle.Visible = true

            Toggle.BackgroundTransparency = 1
            Toggle.UIStroke.Transparency = 1
            Toggle.Title.TextTransparency = 1
            Toggle.Switch.BackgroundColor3 = SelectedTheme.ToggleBackground
            Tab.Elements[Toggle.Name] = {
                type = "toggle",
                section = ToggleSettings.SectionParent,
                element = Toggle
            }
			if ToggleSettings.CurrentValue == true then
				local Success, Response = pcall(function()
					ToggleSettings.Callback(ToggleSettings.CurrentValue)
				end)
			end
            if ToggleSettings.SectionParent then
                Toggle.Parent = ToggleSettings.SectionParent.Holder
            else
                Toggle.Parent = TabPage
            end
            if SelectedTheme ~= NSUILib.Theme.Default then
                Toggle.Switch.Shadow.Visible = false
            end
            ToggleSettings.Locked = false
            TweenService:Create(Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Toggle.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	


            if not ToggleSettings.CurrentValue then
                Toggle.Switch.Indicator.Position = UDim2.new(1, -40, 0.5, 0)
                Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleDisabledStroke
                Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleDisabled
                Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleDisabledOuterStroke
            else
                Toggle.Switch.Indicator.Position = UDim2.new(1, -20, 0.5, 0)
                Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleEnabledStroke
                Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleEnabled
                Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleEnabledOuterStroke
            end

            Toggle.MouseEnter:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
            end)

            Toggle.MouseLeave:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
            end)
            Toggle.Interact.MouseButton1Click:Connect(function()
                if ToggleSettings.Locked then return end
                if ToggleSettings.CurrentValue then
                    ToggleSettings.CurrentValue = false
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -40, 0.5, 0)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,12,0,12)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleDisabledStroke}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleDisabled}):Play()
                    TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleDisabledOuterStroke}):Play()
                    task.wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,17,0,17)}):Play()
                    task.wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()	
                else
                    ToggleSettings.CurrentValue = true
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.5, 0)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,12,0,12)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleEnabledStroke}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleEnabled}):Play()
                    TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleEnabledOuterStroke}):Play()
                    task.wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,17,0,17)}):Play()	
                    task.wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()		
                end

                local Success, Response = pcall(function()
                    ToggleSettings.Callback(ToggleSettings.CurrentValue)
                end)
                if not Success then
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    Toggle.Title.Text = "Callback Error"
                    print("NSUI | "..ToggleSettings.Name.." Callback Error " ..tostring(Response))
                    task.wait(0.5)
                    Toggle.Title.Text = ToggleSettings.Name
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                end

                SaveConfiguration()
            end)
            function ToggleSettings:Set(NewToggleValue)
                if NewToggleValue then
                    ToggleSettings.CurrentValue = true
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -20, 0.5, 0)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,12,0,12)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleEnabledStroke}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleEnabled}):Play()
                    TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Color3.fromRGB(100,100,100)}):Play()
                    task.wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,17,0,17)}):Play()	
                    task.wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()	
                else
                    ToggleSettings.CurrentValue = false
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(1, -40, 0.5, 0)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,12,0,12)}):Play()
                    TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = SelectedTheme.ToggleDisabledStroke}):Play()
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = SelectedTheme.ToggleDisabled}):Play()
                    TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color = Color3.fromRGB(65,65,65)}):Play()
                    task.wait(0.05)
                    TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0,17,0,17)}):Play()
                    task.wait(0.15)
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()	
                end
                local Success, Response = pcall(function()
                    ToggleSettings.Callback(ToggleSettings.CurrentValue)
                end)
                if not Success then
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    Toggle.Title.Text = "Callback Error"
                    print("NSUI | "..ToggleSettings.Name.." Callback Error " ..tostring(Response))
                    task.wait(0.5)
                    Toggle.Title.Text = ToggleSettings.Name
                    TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                end
                SaveConfiguration()
            end
            function ToggleSettings:Destroy()
                Toggle:Destroy()
            end
            function ToggleSettings:Lock(Reason)
                if ToggleSettings.Locked then return end
                ToggleSettings.Locked = true
                Toggle.Lock.Reason.Text = Reason or "Locked"
                TweenService:Create(Toggle.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
                TweenService:Create(Toggle.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                task.wait(0.2)
                if not ToggleSettings.Locked then return end --no icon bug
                TweenService:Create(Toggle.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
            end
            function ToggleSettings:Unlock()
                if not ToggleSettings.Locked then return end
                ToggleSettings.Locked = false
                task.wait(0.2)
                TweenService:Create(Toggle.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                if ToggleSettings.Locked then return end --no icon bug
                TweenService:Create(Toggle.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(Toggle.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
            end
            function ToggleSettings:Visible(bool)
                Toggle.Visible = bool
            end

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and ToggleSettings.Flag then
                    NSUILib.Flags[ToggleSettings.Flag] = ToggleSettings
                end
            end

            return ToggleSettings
        end

        -- ColorPicker
        function Tab:CreateColorPicker(ColorPickerSettings) -- by Throit
            local ColorPicker = Elements.Template.ColorPicker:Clone()
            Tab.Elements[ColorPickerSettings.Name] = {
                type = "colorpicker",
                section = ColorPickerSettings.SectionParent,
                element = ColorPicker
            }
            local Background = ColorPicker.CPBackground
            local Display = Background.Display
            local Main = Background.MainCP
            local Slider = ColorPicker.ColorSlider
            ColorPicker.ColorPickerIs.Value = false
            ColorPicker.ClipsDescendants = true
            ColorPicker.Name = ColorPickerSettings.Name
            ColorPicker.Title.Text = ColorPickerSettings.Name
            ColorPickerSettings.Locked = false
            ColorPicker.Visible = true
            if ColorPickerSettings.SectionParent then
                ColorPicker.Parent = ColorPickerSettings.SectionParent.Holder
            else
                ColorPicker.Parent = TabPage
            end
            ColorPicker.Size = UDim2.new(0,465,0,40)
            ColorPicker.ColorSlider.Visible = false
            ColorPicker.HexInput.Visible = false
            ColorPicker.RGB.Visible = false
            Background.Size = UDim2.new(0, 39, 0, 22)
            Display.BackgroundTransparency = 0
            Main.MainPoint.ImageTransparency = 1
            ColorPicker.Interact.Size = UDim2.new(1, 0, 1, 0)
            ColorPicker.Interact.Position = UDim2.new(0.5, 0, 0.5, 0)
            ColorPicker.RGB.Position = UDim2.new(0, 17, 0, 70)
            ColorPicker.HexInput.Position = UDim2.new(0, 17, 0, 90)
            Main.ImageTransparency = 1
            Background.BackgroundTransparency = 1
            local opened  = false 
            local mouse = game.Players.LocalPlayer:GetMouse()
            Main.Image = "http://www.roblox.com/asset/?id=11415645739"
            local mainDragging = false 
            local sliderDragging = false 
            ColorPicker.Interact.MouseButton1Down:Connect(function()
                if ColorPickerSettings.Locked then return end
                if not opened then
                    ColorPicker.ColorPickerIs.Value = true
                    opened = true 
                    ColorPicker.ColorSlider.Visible = true
                    ColorPicker.HexInput.Visible = true
                    ColorPicker.RGB.Visible = true
                    TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0,465, 0, 120)}):Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 173, 0, 86)}):Play()
                    TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.289, 0, 0.5, 0)}):Play()
                    TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 40)}):Play()
                    TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 73)}):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0.574, 0, 1, 0)}):Play()
                    TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
                    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 0.1}):Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                else
                    ColorPicker.ColorPickerIs.Value = false
                    opened = false
                    ColorPicker.ColorSlider.Visible = false
                    ColorPicker.HexInput.Visible = false
                    ColorPicker.RGB.Visible = false
                    TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0,465, 0,40)}):Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 39, 0, 22)}):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                    TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
                    TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 70)}):Play()
                    TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 90)}):Play()
                    TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                    TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                end
            end)

            game:GetService("UserInputService").InputEnded:Connect(function(input, gameProcessed) if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    mainDragging = false
                    sliderDragging = false
                end end)
            Main.MouseButton1Down:Connect(function()
                if opened and not ColorPickerSettings.Locked then
                    mainDragging = true 
                end
            end)
            Main.MainPoint.MouseButton1Down:Connect(function()
                if opened and not ColorPickerSettings.Locked then
                    mainDragging = true 
                end
            end)
            Slider.MouseButton1Down:Connect(function()
                if ColorPickerSettings.Locked then return end
                sliderDragging = true 
            end)
            Slider.SliderPoint.MouseButton1Down:Connect(function()
                if ColorPickerSettings.Locked then return end
                sliderDragging = true 
            end)

            local h,s,v = ColorPickerSettings.Color:ToHSV()
            local color = Color3.fromHSV(h,s,v) 
            local hex = string.format("#%02X%02X%02X",color.R*0xFF,color.G*0xFF,color.B*0xFF)
            ColorPicker.HexInput.InputBox.Text = hex
            local function setDisplay()
                --Main
                Main.MainPoint.Position = UDim2.new(s,-Main.MainPoint.AbsoluteSize.X/2,1-v,-Main.MainPoint.AbsoluteSize.Y/2)
                Main.MainPoint.ImageColor3 = Color3.fromHSV(h,s,v)
                Background.BackgroundColor3 = Color3.fromHSV(h,1,1)
                Display.BackgroundColor3 = Color3.fromHSV(h,s,v)
                --Slider 
                local x = h * Slider.AbsoluteSize.X
                Slider.SliderPoint.Position = UDim2.new(0,x-Slider.SliderPoint.AbsoluteSize.X/2,0.5,0)
                Slider.SliderPoint.ImageColor3 = Color3.fromHSV(h,1,1)
                local color = Color3.fromHSV(h,s,v) 
                local r,g,b = math.floor((color.R*255)+0.5),math.floor((color.G*255)+0.5),math.floor((color.B*255)+0.5)
                ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                hex = string.format("#%02X%02X%02X",color.R*0xFF,color.G*0xFF,color.B*0xFF)
                ColorPicker.HexInput.InputBox.Text = hex
            end
            setDisplay()
            ColorPicker.HexInput.InputBox.FocusLost:Connect(function()
                if not pcall(function()
                        local r, g, b = string.match(ColorPicker.HexInput.InputBox.Text, "^#?(%w%w)(%w%w)(%w%w)$")
                        local rgbColor = Color3.fromRGB(tonumber(r, 16),tonumber(g, 16), tonumber(b, 16))
                        h,s,v = rgbColor:ToHSV()
                        hex = ColorPicker.HexInput.InputBox.Text
                        setDisplay()
                        ColorPickerSettings.Color = rgbColor
                    end) 
                then 
                    ColorPicker.HexInput.InputBox.Text = hex 
                end
                pcall(function()ColorPickerSettings.Callback(Color3.fromHSV(h,s,v))end)
                local r,g,b = math.floor((h*255)+0.5),math.floor((s*255)+0.5),math.floor((v*255)+0.5)
                ColorPickerSettings.Color = Color3.fromRGB(r,g,b)
                SaveConfiguration()
            end)
            --RGB
            local function rgbBoxes(box,toChange)
                local value = tonumber(box.Text) 
                local color = Color3.fromHSV(h,s,v) 
                local oldR,oldG,oldB = math.floor((color.R*255)+0.5),math.floor((color.G*255)+0.5),math.floor((color.B*255)+0.5)
                local save 
                if toChange == "R" then save = oldR;oldR = value elseif toChange == "G" then save = oldG;oldG = value else save = oldB;oldB = value end
                if value then 
                    value = math.clamp(value,0,255)
                    h,s,v = Color3.fromRGB(oldR,oldG,oldB):ToHSV()

                    setDisplay()
                else 
                    box.Text = tostring(save)
                end
                local r,g,b = math.floor((h*255)+0.5),math.floor((s*255)+0.5),math.floor((v*255)+0.5)
                ColorPickerSettings.Color = Color3.fromRGB(r,g,b)
                SaveConfiguration()
            end

            ColorPicker.RGB.RInput.InputBox.FocusLost:connect(function()
                rgbBoxes(ColorPicker.RGB.RInput.InputBox,"R")
                pcall(function()ColorPickerSettings.Callback(Color3.fromHSV(h,s,v))end)
            end)
            ColorPicker.RGB.GInput.InputBox.FocusLost:connect(function()
                rgbBoxes(ColorPicker.RGB.GInput.InputBox,"G")
                pcall(function()ColorPickerSettings.Callback(Color3.fromHSV(h,s,v))end)
            end)
            ColorPicker.RGB.BInput.InputBox.FocusLost:connect(function()
                rgbBoxes(ColorPicker.RGB.BInput.InputBox,"B")
                pcall(function()ColorPickerSettings.Callback(Color3.fromHSV(h,s,v))end)
            end)

            ColorPicker.HexInput.InputBox.Focused:Connect(function()
                if ColorPickerSettings.Locked then ColorPicker.HexInput.InputBox:ReleaseFocus() return end
            end)
            ColorPicker.RGB.RInput.InputBox.Focused:connect(function()
                if ColorPickerSettings.Locked then ColorPicker.RGB.RInput.InputBox:ReleaseFocus() return end
            end)
            ColorPicker.RGB.GInput.InputBox.Focused:connect(function()
                if ColorPickerSettings.Locked then ColorPicker.RGB.GInput.InputBox:ReleaseFocus() return end
            end)
            ColorPicker.RGB.BInput.InputBox.Focused:connect(function()
                if ColorPickerSettings.Locked then ColorPicker.RGB.BInput.InputBox:ReleaseFocus() return end
            end)

            game:GetService("RunService").RenderStepped:connect(function()
                if mainDragging then 
                    local localX = math.clamp(mouse.X-Main.AbsolutePosition.X,0,Main.AbsoluteSize.X)
                    local localY = math.clamp(mouse.Y-Main.AbsolutePosition.Y,0,Main.AbsoluteSize.Y)
                    Main.MainPoint.Position = UDim2.new(0,localX-Main.MainPoint.AbsoluteSize.X/2,0,localY-Main.MainPoint.AbsoluteSize.Y/2)
                    s = localX / Main.AbsoluteSize.X
                    v = 1 - (localY / Main.AbsoluteSize.Y)
                    Display.BackgroundColor3 = Color3.fromHSV(h,s,v)
                    Main.MainPoint.ImageColor3 = Color3.fromHSV(h,s,v)
                    Background.BackgroundColor3 = Color3.fromHSV(h,1,1)
                    local color = Color3.fromHSV(h,s,v) 
                    local r,g,b = math.floor((color.R*255)+0.5),math.floor((color.G*255)+0.5),math.floor((color.B*255)+0.5)
                    ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                    ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                    ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                    ColorPicker.HexInput.InputBox.Text = string.format("#%02X%02X%02X",color.R*0xFF,color.G*0xFF,color.B*0xFF)
                    pcall(function()ColorPickerSettings.Callback(Color3.fromHSV(h,s,v))end)
                    ColorPickerSettings.Color = Color3.fromRGB(r,g,b)
                    SaveConfiguration()
                end
                if sliderDragging then 
                    local localX = math.clamp(mouse.X-Slider.AbsolutePosition.X,0,Slider.AbsoluteSize.X)
                    h = localX / Slider.AbsoluteSize.X
                    Display.BackgroundColor3 = Color3.fromHSV(h,s,v)
                    Slider.SliderPoint.Position = UDim2.new(0,localX-Slider.SliderPoint.AbsoluteSize.X/2,0.5,0)
                    Slider.SliderPoint.ImageColor3 = Color3.fromHSV(h,1,1)
                    Background.BackgroundColor3 = Color3.fromHSV(h,1,1)
                    Main.MainPoint.ImageColor3 = Color3.fromHSV(h,s,v)
                    local color = Color3.fromHSV(h,s,v) 
                    local r,g,b = math.floor((color.R*255)+0.5),math.floor((color.G*255)+0.5),math.floor((color.B*255)+0.5)
                    ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                    ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                    ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                    ColorPicker.HexInput.InputBox.Text = string.format("#%02X%02X%02X",color.R*0xFF,color.G*0xFF,color.B*0xFF)
                    pcall(function()ColorPickerSettings.Callback(Color3.fromHSV(h,s,v))end)
                    ColorPickerSettings.Color = Color3.fromRGB(r,g,b)
                    SaveConfiguration()
                end
            end)

            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and ColorPickerSettings.Flag then
                    NSUILib.Flags[ColorPickerSettings.Flag] = ColorPickerSettings
                end
            end

            function ColorPickerSettings:Set(RGBColor)
                ColorPickerSettings.Color = RGBColor
                h,s,v = ColorPickerSettings.Color:ToHSV()
                color = Color3.fromHSV(h,s,v)
                setDisplay()
            end
            function ColorPickerSettings:Destroy()
                ColorPicker:Destroy()
            end
            function ColorPickerSettings:Lock(Reason)
                if ColorPickerSettings.Locked then return end
                ColorPicker.ColorPickerIs.Value = false
                opened = false
                ColorPicker.ColorSlider.Visible = false
                ColorPicker.HexInput.Visible = false
                ColorPicker.RGB.Visible = false
                TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0,465, 0,40)}):Play()
                TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 39, 0, 22)}):Play()
                TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
                TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 70)}):Play()
                TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 17, 0, 90)}):Play()
                TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
                TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundTransparency = 1}):Play()
                ColorPicker.Lock.Reason.Text = Reason or "Locked"
                ColorPickerSettings.Locked = true
                TweenService:Create(ColorPicker.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
                TweenService:Create(ColorPicker.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                task.wait(0.2)
                if not ColorPickerSettings.Locked then return end --no icon bug
                TweenService:Create(ColorPicker.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
            end
            function ColorPickerSettings:Unlock()
                if not ColorPickerSettings.Locked then return end
                ColorPickerSettings.Locked = false
                task.wait(0.2)
                TweenService:Create(ColorPicker.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                if ColorPickerSettings.Locked then return end --no icon bug
                TweenService:Create(ColorPicker.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(ColorPicker.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
            end
            function ColorPickerSettings:Visible(bool)
                ColorPicker.Visible = bool
            end
            return ColorPickerSettings
        end

        function Tab:CreateSlider(SliderSettings)
            local Dragging = false
            local Slider = Elements.Template.Slider:Clone()
            Slider.Name = SliderSettings.Name
            Slider.Title.Text = SliderSettings.Name
            Slider.Visible = true
            Tab.Elements[SliderSettings.Name] = {
                type = "slider",
                section = SliderSettings.SectionParent,
                element = Slider
            }
            if SliderSettings.SectionParent then
                Slider.Parent = SliderSettings.SectionParent.Holder
            else
                Slider.Parent = TabPage
            end

            Slider.BackgroundTransparency = 1
            Slider.UIStroke.Transparency = 1
            Slider.Title.TextTransparency = 1

            if SelectedTheme ~= NSUILib.Theme.Default then
                Slider.Main.Shadow.Visible = false
            end

            Slider.Main.BackgroundColor3 = SelectedTheme.SliderBackground
            Slider.Main.UIStroke.Color = SelectedTheme.SliderStroke
            Slider.Main.Progress.BackgroundColor3 = SelectedTheme.SliderProgress

            TweenService:Create(Slider, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Slider.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            TweenService:Create(Slider.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()	

            Slider.Main.Progress.Size =	UDim2.new(0, Slider.Main.AbsoluteSize.X * ((SliderSettings.CurrentValue + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) > 5 and Slider.Main.AbsoluteSize.X * (SliderSettings.CurrentValue / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0)

            if not SliderSettings.Suffix then
                Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue)
            else
                Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue) .. " " .. SliderSettings.Suffix
            end


            Slider.MouseEnter:Connect(function()
                TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackgroundHover}):Play()
            end)
            Slider.Main.Interact.MouseLeave:Connect(function()
                Dragging = false
            end)
            Slider.MouseLeave:Connect(function()
                TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
            end)
            local function UpdateSlider(X)
                local Current = Slider.Main.Progress.AbsolutePosition.X + Slider.Main.Progress.AbsoluteSize.X
                local Start = Current
                local Location = X

                Location = UserInputService:GetMouseLocation().X
                Current = Current + 0.025 * (Location - Start)

                if Location < Slider.Main.AbsolutePosition.X then
                    Location = Slider.Main.AbsolutePosition.X
                elseif Location > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
                    Location = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
                end

                if Current < Slider.Main.AbsolutePosition.X + 5 then
                    Current = Slider.Main.AbsolutePosition.X + 5
                elseif Current > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
                    Current = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
                end

                if Current <= Location and (Location - Start) < 0 then
                    Start = Location
                elseif Current >= Location and (Location - Start) > 0 then
                    Start = Location
                end
                TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, Location - Slider.Main.AbsolutePosition.X > 5 and Location - Slider.Main.AbsolutePosition.X or 5, 1, 0)}):Play()
                local NewValue = SliderSettings.Range[1] + (Location - Slider.Main.AbsolutePosition.X) / Slider.Main.AbsoluteSize.X * (SliderSettings.Range[2] - SliderSettings.Range[1])

                NewValue = math.floor(NewValue / SliderSettings.Increment + 0.5) * (SliderSettings.Increment * 10000000) / 10000000
                if not SliderSettings.Suffix then
                    Slider.Main.Information.Text = tostring(NewValue)
                else
                    Slider.Main.Information.Text = tostring(NewValue) .. " " .. SliderSettings.Suffix
                end

                if SliderSettings.CurrentValue ~= NewValue then
                    local Success, Response = pcall(function()
                        SliderSettings.Callback(NewValue)
                    end)
                    if not Success then
                        TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                        TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                        Slider.Title.Text = "Callback Error"
                        print("NSUI | "..SliderSettings.Name.." Callback Error " ..tostring(Response))
                        task.wait(0.5)
                        Slider.Title.Text = SliderSettings.Name
                        TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                        TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                    end

                    SliderSettings.CurrentValue = NewValue
                    SaveConfiguration()
                end
            end
            Slider.Main.Interact.MouseButton1Down:Connect(function(X)
                if not SliderSettings.Locked then 
                    UpdateSlider(X)
                    Dragging = true 
                end 
            end)
            Slider.Main.Interact.MouseButton1Up:Connect(function(X) 
                Dragging = false 
            end)
            Slider.Main.Interact.MouseMoved:Connect(function(X)
                if SliderSettings.Locked then return end
                if Dragging then
                    UpdateSlider(X)
                end
            end)

            function SliderSettings:Set(NewVal)
                TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, Slider.Main.AbsoluteSize.X * ((NewVal + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) > 5 and Slider.Main.AbsoluteSize.X * (NewVal / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0)}):Play()
                Slider.Main.Information.Text = tostring(NewVal) .. " " .. SliderSettings.Suffix
                local Success, Response = pcall(function()
                    SliderSettings.Callback(NewVal)
                end)
                if not Success then
                    TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = Color3.fromRGB(85, 0, 0)}):Play()
                    TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
                    Slider.Title.Text = "Callback Error"
                    print("NSUI | "..SliderSettings.Name.." Callback Error " ..tostring(Response))
                    task.wait(0.5)
                    Slider.Title.Text = SliderSettings.Name
                    TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {BackgroundColor3 = SelectedTheme.ElementBackground}):Play()
                    TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                end
                SliderSettings.CurrentValue = NewVal
                SaveConfiguration()
            end
            function SliderSettings:Destroy()
                Slider:Destroy()
            end
            function SliderSettings:Lock(Reason)
                if SliderSettings.Locked then return end
                SliderSettings.Locked = true
                Slider.Lock.Reason.Text = Reason or "Locked"
                TweenService:Create(Slider.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0}):Play()
                TweenService:Create(Slider.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                task.wait(0.2)
                if not SliderSettings.Locked then return end --no icon bug
                TweenService:Create(Slider.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
            end
            function SliderSettings:Unlock()
                if not SliderSettings.Locked then return end
                SliderSettings.Locked = false
                task.wait(0.2)
                TweenService:Create(Slider.Lock.Reason.Icon,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                if SliderSettings.Locked then return end --no icon bug
                TweenService:Create(Slider.Lock,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(Slider.Lock.Reason,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency = 1}):Play()
            end
            function SliderSettings:Visible(bool)
                Slider.Visible = bool
            end
            if Settings.ConfigurationSaving then
                if Settings.ConfigurationSaving.Enabled and SliderSettings.Flag then
                    NSUILib.Flags[SliderSettings.Flag] = SliderSettings
                end
            end
            return SliderSettings
        end


        return Tab
    end

    Elements.Visible = true

    task.wait(1.2)
    TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
    TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()
    task.wait(0.2)
    TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 500, 0, 475)}):Play()
    TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.4}):Play()

    Topbar.BackgroundTransparency = 1
    Topbar.Divider.Size = UDim2.new(0, 0, 0, 1)
    Topbar.CornerRepair.BackgroundTransparency = 1
    Topbar.Title.TextTransparency = 1
    Topbar.Theme.ImageTransparency = 1
    Topbar.ChangeSize.ImageTransparency = 1
    Topbar.Hide.ImageTransparency = 1

    task.wait(0.8)
    Topbar.Visible = true
    TweenService:Create(Topbar, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
    TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {BackgroundTransparency = 0}):Play()
    task.wait(0.1)
    TweenService:Create(Topbar.Divider, TweenInfo.new(1, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 1)}):Play()
    task.wait(0.1)
    TweenService:Create(Topbar.Title, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
    task.wait(0.1)
    TweenService:Create(Topbar.Theme, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
    task.wait(0.1)
    TweenService:Create(Topbar.ChangeSize, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
    task.wait(0.1)
    TweenService:Create(Topbar.Hide, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
    task.wait(0.3)

    function Window:Prompt(PromptSettings)
        local PromptUI = Prompt.Prompt
        Prompt.Visible = true
        Prompt.BackgroundTransparency = 1
        PromptUI.BackgroundTransparency = 1
        PromptUI.UIStroke.Transparency = 1
        PromptUI.Content.TextTransparency = 1
        PromptUI.Title.TextTransparency = 1
        PromptUI.Sub.TextTransparency = 1
        PromptUI.Size = UDim2.new(0,340,0,140)
        PromptUI.Buttons.Template.Visible = false
        PromptUI.Buttons.Template.TextLabel.TextTransparency = 1
        PromptUI.Buttons.Template.UIStroke.Transparency = 1
        --PromptUI.Buttons.Middle.Visible = false
        --PromptUI.Buttons.Middle.TextLabel.TextTransparency = 1
        --PromptUI.Buttons.Middle.UIStroke.Transparency = 1

        PromptUI.Content.Text = PromptSettings.Content
        PromptUI.Sub.Text = PromptSettings.SubTitle or ""
        PromptUI.Title.Text = PromptSettings.Title or ""

        if PromptSettings.Actions then
            for name,info in pairs(PromptSettings.Actions) do
                local Button = PromptUI.Buttons.Template:Clone()
                Button.TextLabel.Text = info.Name
                Button.Interact.MouseButton1Up:Connect(function()
                    if not clicked then
                        local Success, Response = pcall(info.Callback)
                        clicked = true
                        if not Success then
                            ClosePrompt()
                            print("NSUI | "..info.Name.." Callback Error " ..tostring(Response))
                        else
                            ClosePrompt()
                        end
                    end
                end)
                Button.Name = name
                Button.Parent = PromptUI.Buttons -- saving memory
                Button.Size = UDim2.fromOffset(Button.TextLabel.TextBounds.X + 24, 30)
            end
        end

        TweenService:Create(Prompt, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {BackgroundTransparency = .5}):Play()
        task.wait(.2)
        TweenService:Create(PromptUI, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {BackgroundTransparency = 0,Size = UDim2.new(0,350,0,150)}):Play()
        task.wait(0.2)
        TweenService:Create(PromptUI.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
        TweenService:Create(PromptUI.Title, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        TweenService:Create(PromptUI.Content, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        TweenService:Create(PromptUI.Sub, TweenInfo.new(0.45, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        task.wait(1)
        if PromptSettings.Actions then
            for _,button in pairs(PromptUI.Buttons:GetChildren()) do
                if button.Name ~= "Template" and button.Name ~= "Middle" and button:IsA("Frame") then
                    button.Visible = true
                    TweenService:Create(button.UIStroke,TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
                    TweenService:Create(button.TextLabel,TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
                    task.wait(.8)
                end
            end
        else
            --TweenService:Create(PromptUI.Buttons.Middle.UIStroke,TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Transparency = 0}):Play()
            --TweenService:Create(PromptUI.Buttons.Middle.TextLabel,TweenInfo.new(0.3, Enum.EasingStyle.Quint), {TextTransparency = 0}):Play()
        end
    end
    return Window
end

function NSUILib:ToggleOldTabStyle(oldTabStyle)
    if oldTabStyle == nil then oldTabStyle = true end

    if not oldTabStyle then
        TopList.Visible = true
        Elements.Size = UDim2.new(1, 0, 0, 364)
        Elements.Position = UDim2.new(0.5, 0, 0.5, 45)

        Topbar.Type.Visible = false
        Topbar.Title.Position = UDim2.new(0, 15, 0.5, 0)
    else
        TopList.Visible = false
        Elements.Size = UDim2.new(1, 0, 0, 409)
        Elements.Position = UDim2.new(0.5, 0, 0.555, 0)

        Topbar.Type.Visible = true
        Topbar.Title.Position = UDim2.new(0, 45, 0.5, 0)
    end
end

function NSUILib:Destroy()
    NSUI:Destroy()
end

Topbar.ChangeSize.MouseButton1Click:Connect(function()
    if Debounce then return end
    if Minimised then
        Minimised = false
        Maximise()
    else
        if not SearchHided then SearchHided = true spawn(CloseSearch)  end
        Minimised = true
        Minimise()
    end
end)

Topbar.Search.MouseButton1Click:Connect(function()
    if Debounce or Minimised then return end
    if SearchHided then
        OpenSearch()
        SearchHided = false
    else
        SearchHided = true
        CloseSearch()
    end
end)

Topbar.Type.MouseButton1Click:Connect(function()
    if Debounce or Minimised then return end
    if SideBarClosed then
          -- Topbar.Type.Image = "rbxassetid://".. 10709759610
        OpenSideBar()
    else
         -- Topbar.Type.Image = "rbxassetid://".. 10709759610
        CloseSideBar()
    end
end)

Topbar.Hide.MouseButton1Click:Connect(function()
    if Debounce then return end
    if Hidden then
        Hidden = false
        Minimised = false
        Unhide()
    else
        if not SearchHided then SearchHided = true spawn(CloseSearch)  end
        Hidden = true
        Hide()
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if (input.KeyCode == Enum.KeyCode.Quote and not processed) then
        if Debounce then return end
        if Hidden then
            Hidden = false
            Unhide()
        else
            if not SearchHided then spawn(CloseSearch) end
            Hidden = true
            Hide()
        end
    end
end)

for _, TopbarButton in ipairs(Topbar:GetChildren()) do
    if TopbarButton.ClassName == "ImageButton" then
        TopbarButton.MouseEnter:Connect(function()
            if TopbarButton.Name ~= "Type" then
                TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
            else
                TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.2}):Play()
            end
        end)
        TopbarButton.MouseLeave:Connect(function()
            if TopbarButton.Name ~= "Type" then
                TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
            else
                TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0}):Play()
            end
        end)

        TopbarButton.MouseButton1Click:Connect(function()
            TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Quint), {ImageTransparency = 0.8}):Play()
        end)
    end
end


function NSUILib:LoadConfiguration()
    if CEnabled then
        pcall(function()
            if isfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension) then
                LoadConfiguration(readfile(ConfigurationFolder .. "/" .. CFileName .. ConfigurationExtension))
                NSUILib:Notify({Title = "Configuration Loaded", Content = "The configuration file for this script has been loaded from a previous session"})
            end
        end)
    end
end

-- own

function NSUILib:FindPlayerByPartial(playername)
    if playername == "me" then 
        return LocalPlayer
    else 
        for index, player in Players:GetPlayers() do
            if player.Name:lower():find(playername:lower()) then
                return player
            end
        end
    end
end

Player = Players.LocalPlayer

VirtualUser = game:GetService("VirtualUser")

function NSUILib:IsNumeric(data)
    return tonumber(data)
end

function NSUILib:IsAlpha(data)
    return not tonumber(data)
end

function NSUILib:IsAlphaAndOrNumeric(data)
    return data:match("[^%w]") == nil
end

function NSUILib:GetPlayerThumbnail(data, thumbnailtype)
	local UserId = nil
	if NSUILib:IsNumeric(data) then
		UserId = data
	elseif NSUILib:IsAlpha(data) then
		UserId = NSUILib:FindPlayer(data).UserId
	elseif data.Parent and data.Parent == Players then
		UserId = data.UserId
	end
	if Enum.ThumbnailType[thumbnailtype] then
		return Players:GetUserThumbnailAsync(UserId, Enum.ThumbnailType[thumbnailtype], Enum.ThumbnailSize.Size420x420)
	else
		return "rbxassetid://284402785"
	end
end

if latest ~= Version then
    NSUILib:Notify({Title = "Outdated Version Detected",Content = string.format("Hello, %s. You're currently using an outdated version of NSUI and we recommend you use the latest version.", plr_name),Duration = 13.5,Image = 10709753149})
setclipboard("https://raw.githubusercontent.com/rrAsus/NSUI/refs/heads/main/main.lua")
NSUILib:Notify({Title = "Copied RAW UI Link",Content = "The RAW version has been copied into your clipboard.",Duration = 13.5,Image = 10709753149})
end

-- NSUILib:GetPlayerThumbnail(userid, "AvatarBust")
-- NSUILib:GetPlayerThumbnail(userid, "AvatarThumbnail")
-- NSUILib:GetPlayerThumbnail(userid, "HeadShot")

NSUILib.Player = {}
NSUILib.Player.HeadShot = NSUILib:GetPlayerThumbnail(Player.UserId, "HeadShot")

function NSUILib:FFC(instance, name)
    return instance:FindFirstChild(tostring(name))
end

function NSUILib:FFCOC(instance, class)
    return instance:FindFirstChildOfClass(tostring(class))
end

function NSUILib:AllTrue(conditions)
    local count = 0
    for _, condition in ipairs(conditions) do
        if condition == true then
            count = count + 1
        end
    end
    return count == #conditions
end

task.delay(9, NSUILib.LoadConfiguration, NSUILib)

-- NSUI Search Bar Diagnostic Logger
-- Paste and run this AFTER the main NSUI script loads
-- Then open the search bar and start typing

-- Diagnostic (uses variables already in scope)
task.delay(14, function()
    warn("[DIAG] === SNAPSHOT ===")
    warn("[DIAG] SearchBar.BackgroundColor3 = " .. tostring(SearchBar.BackgroundColor3))
    warn("[DIAG] SearchBar.BackgroundTransparency = " .. tostring(SearchBar.BackgroundTransparency))
    warn("[DIAG] SearchBar.Visible = " .. tostring(SearchBar.Visible))
    for _, desc in ipairs(SearchBar:GetDescendants()) do
        if desc:IsA("GuiObject") then
            local info = string.format("  %s | Vis=%s | BgTrans=%.2f | ZIndex=%d", desc.Name, tostring(desc.Visible), desc.BackgroundTransparency, desc.ZIndex)
            if desc:IsA("TextBox") or desc:IsA("TextLabel") then
                info = info .. string.format(" | TextTrans=%.2f", desc.TextTransparency)
            end
            if desc.ClassName == "CanvasGroup" then
                info = info .. string.format(" | GroupTrans=%.2f", desc.GroupTransparency)
            end
            warn("[DIAG]" .. info)
        end
    end
    warn("[DIAG] === Now open search bar, then type. Monitors active. ===")

    local function monitor(obj, path)
        if obj:IsA("GuiObject") then
            obj:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
                if obj.BackgroundTransparency > 0.5 then
                    warn(string.format("[DIAG] BgTrans=%.2f → %s", obj.BackgroundTransparency, path))
                end
            end)
            obj:GetPropertyChangedSignal("Visible"):Connect(function()
                warn(string.format("[DIAG] Visible=%s → %s", tostring(obj.Visible), path))
            end)
        end
        if obj:IsA("TextBox") or obj:IsA("TextLabel") then
            obj:GetPropertyChangedSignal("TextTransparency"):Connect(function()
                warn(string.format("[DIAG] TextTrans=%.2f → %s", obj.TextTransparency, path))
            end)
        end
        if obj.ClassName == "CanvasGroup" then
            obj:GetPropertyChangedSignal("GroupTransparency"):Connect(function()
                warn(string.format("[DIAG] GroupTrans=%.2f → %s", obj.GroupTransparency, path))
            end)
        end
        obj:GetPropertyChangedSignal("ZIndex"):Connect(function()
            warn(string.format("[DIAG] ZIndex=%d → %s", obj.ZIndex, path))
        end)
    end

    monitor(SearchBar, "SearchBar")
    for _, desc in ipairs(SearchBar:GetDescendants()) do
        if desc:IsA("GuiObject") then
            monitor(desc, "SearchBar." .. desc.Name)
        end
    end
end)

return NSUILib
