-- =========================================================
-- RESET HUB BY SSAGGAJH (v5.0 Ultimate Edition - v53 Combat/Emotes Repair)
-- Combat Focused | EN & TR Language | Black & White Themes
-- =========================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

-- Session guard prevents duplicated injections from fighting over the camera/character.
if type(_G.ResetHubCleanup) == "function" then
    pcall(_G.ResetHubCleanup)
end
_G.ResetHubSession = (_G.ResetHubSession or 0) + 1
local ResetHubSession = _G.ResetHubSession

-- Remove the previous Reset Hub UI before creating a new one.
do
    pcall(function()
        local containers = {}
        if gethui then table.insert(containers, gethui()) end
        table.insert(containers, LocalPlayer:FindFirstChildOfClass("PlayerGui"))
        pcall(function() table.insert(containers, CoreGui) end)
        for _, container in ipairs(containers) do
            if container then
                local oldGui = container:FindFirstChild("ResetHub_ssaggajh")
                if oldGui then oldGui:Destroy() end
            end
        end
    end)
end

-- Clean up leftover Reset Hub motion controllers from older injections.
do
    local char = LocalPlayer and LocalPlayer.Character
    if char then
        for _, obj in ipairs(char:GetDescendants()) do
            if obj.Name:sub(1, 8) == "ResetHub_" or obj.Name == "QFlyVel" or obj.Name == "QFlyGyro" then
                pcall(function() obj:Destroy() end)
            end
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            for _, obj in ipairs(root:GetChildren()) do
                local class = obj.ClassName
                if class == "BodyAngularVelocity" or class == "BodyVelocity" or class == "BodyGyro"
                    or class == "BodyPosition" or class == "BodyForce" or class == "VectorForce"
                    or class == "LinearVelocity" or class == "AngularVelocity" or class == "AlignOrientation" then
                    pcall(function() obj:Destroy() end)
                end
            end
            pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function() hum.CameraOffset = Vector3.zero end)
            pcall(function() hum.AutoRotate = true end)
            if Camera and Camera.CameraSubject == nil then
                pcall(function() Camera.CameraSubject = hum end)
            end
        end
    end
end

-- GUI Container & Protection
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ResetHub_ssaggajh"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

do
    local parentGui = nil
    if type(gethui) == "function" then
        local ok, hui = pcall(gethui)
        if ok and hui then parentGui = hui end
    end
    if not parentGui and syn and type(syn.protect_gui) == "function" then
        pcall(function() syn.protect_gui(ScreenGui) end)
        parentGui = CoreGui
    end
    if not parentGui then
        parentGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
    end
    ScreenGui.Parent = parentGui
end

-- =========================================================
-- LANGUAGE DICTIONARY (TR / EN)
-- =========================================================
local CurrentLang = "TR"
local TranslatableObjects = {}

local Dict = {
    EN = {
        Title = "Reset hub by ssaggajh",
        TabCombat = "Combat & Aimbot",
        TabMove = "Movement & Physics",
        TabPlayer = "Local Player",
        TabVisuals = "Visuals & ESP",
        TabTeleport = "Teleportation",
        TabAuto = "Automation & Farm",
        TabHubs = "Script Hubs",
        TabFun = "Fun & Exploits",
        TabSettings = "Settings & Themes",
        Home = "Home",
        World = "World",
        TabChat = "Chat",
        TabTools = "Tools & Items",
        TabOther = "Other...",
        TabEmotes = "Emotes",
        BTools = "BTools",
        ToolF3X = "F3X Building Tools",
        ToolPart = "Part Placer",
        ToolCopy = "Copy",
        ToolDelete = "Delete",
        ToolClear = "Clear Placed Parts",
        ChatTitle = "Script Chat",
        ChatPlaceholder = "Type a message...",
        ChatSend = "SEND",
        ChatInfo = "Uses the current Roblox text chat channel",
        ChatUnavailable = "Text chat is unavailable in this game",
        ChatEmpty = "Write a message first",
        
        -- Combat
        Aimbot = "Toggle Aimbot",
        SilentAim = "Toggle Silent Aim",
        Triggerbot = "Toggle Triggerbot",
        KillAura = "Toggle Kill Aura",
        HitboxSize = "Hitbox Expander Size",
        Reach = "Melee Reach Expander",
        AntiKnockback = "Anti-Knockback (Velocity Zero)",
        TargetStrafe = "Target Strafe (Orbit Target)",
        ShowFOV = "Toggle FOV Circle",
        AimbotFOV = "Aimbot FOV Radius",
        AimbotSmooth = "Aimbot Smoothness",
        
        -- Movement
        Speed = "WalkSpeed Multiplier",
        Jump = "JumpPower Multiplier",
        FlySpeed = "Fly Speed",
        QFly = "Toggle Q-Key Fly Mode",
        InfJump = "Infinite Air Jump",
        Noclip = "Toggle Noclip",
        MoonGravity = "Moon Gravity (Low)",
        UnderMap = "Teleport Under Map",
        
        -- Player
        Godmode = "God Mode / Anti-Damage",
        NoFall = "No Fall Damage",
        Headless = "Become Headless",
        TinyMorph = "Tiny Character Morph",
        BigMorph = "Big Character Morph",
        AntiAFK = "Anti-AFK Auto Kick Bypass",
        
        -- Visuals
        ESP = "Player Highlight ESP",
        Fullbright = "Fullbright (No Shadows)",
        XRay = "X-Ray Walls",
        FOVAngle = "Camera FOV Angle",
        Crosshair = "Screen Center Crosshair",
        
        -- Settings
        SwitchLang = "Switch Language (TR / EN)",
        ThemeDark = "Theme: Dark Midnight",
        ThemeBWDark = "Theme: Black & White (Dark)",
        ThemeBWLight = "Theme: Black & White (Light)",
        Rejoin = "Rejoin Current Server"
    },
    TR = {
        Title = "Reset hub by ssaggajh",
        TabCombat = "Savaş & Aimbot",
        TabMove = "Hareket & Fizik",
        TabPlayer = "Yerel Oyuncu",
        TabVisuals = "Görsel & ESP",
        TabTeleport = "Işınlanma (Teleport)",
        TabAuto = "Otomasyon & Farm",
        TabHubs = "Script Merkezleri",
        TabFun = "Eğlence & Hileler",
        TabSettings = "Ayarlar & Temalar",
        Home = "Ana Sayfa",
        World = "Dünya",
        TabChat = "Sohbet",
        TabTools = "Araçlar & Eşyalar",
        TabOther = "Diğer...",
        TabEmotes = "Emotes",
        BTools = "BTools",
        ToolF3X = "F3X Yapım Araçları",
        ToolPart = "Part Yerleştirici",
        ToolCopy = "Copy",
        ToolDelete = "Delete",
        ToolClear = "Yerleştirilen Partları Temizle",
        ChatTitle = "Script Sohbeti",
        ChatPlaceholder = "Mesaj yaz...",
        ChatSend = "GÖNDER",
        ChatInfo = "Mevcut Roblox metin sohbet kanalini kullanir",
        ChatUnavailable = "Bu oyunda metin sohbeti kullanilamiyor",
        ChatEmpty = "Once bir mesaj yaz",
        
        -- Combat
        Aimbot = "Aimbot Kilidi",
        SilentAim = "Sessiz Aimbot (Silent)",
        Triggerbot = "Otomatik Ateş (Triggerbot)",
        KillAura = "Kill Aura / Otomatik Vuruş",
        HitboxSize = "Hitbox Büyütücü Yarıçapı",
        Reach = "Menzil Artırıcı (Reach)",
        AntiKnockback = "Geri Tepme Engelleyici",
        TargetStrafe = "Hedef Etrafında Yüksek Hızda Dönme",
        ShowFOV = "Aimbot FOV Dairesini Göster",
        AimbotFOV = "Aimbot Görüş Yarıçapı",
        AimbotSmooth = "Aimbot Yumuşaklığı",
        
        -- Movement
        Speed = "Yürüme Hızı (WalkSpeed)",
        Jump = "Zıplama Gücü (JumpPower)",
        FlySpeed = "Uçuş Hızı (Fly Speed)",
        QFly = "Q Tuşu ile Uçma Modu",
        InfJump = "Sınırsız Hava Zıplaması",
        Noclip = "Duvarlardan Geçme (Noclip)",
        MoonGravity = "Ay Çekimi (Düşük Yerçekimi)",
        UnderMap = "Harita Altına Işınlan",
        
        -- Player
        Godmode = "Ölümsüzlük / Hasar Almama",
        NoFall = "Düşme Hasarını Engelle",
        Headless = "Kafasız Karakter (Headless)",
        TinyMorph = "Küçük Karakter Modu",
        BigMorph = "Büyük Karakter Modu",
        AntiAFK = "Anti-AFK Oyundan Düşme Engelleyici",
        
        -- Visuals
        ESP = "Oyuncu Görünürlük ESP",
        Fullbright = "Gece Görüşü / Tam Aydınlatma",
        XRay = "Röntgen (Duvar Arkası Görme)",
        FOVAngle = "Kamera Görüş Açısı (FOV)",
        Crosshair = "Ekran Ortası Nişangah",
        
        -- Settings
        SwitchLang = "Dil Değiştir (TR / EN)",
        ThemeDark = "Tema: Gece Siyahı (Dark)",
        ThemeBWDark = "Tema: Siyah & Beyaz (Koyu)",
        ThemeBWLight = "Tema: Siyah & Beyaz (Açık)",
        Rejoin = "Sunucuya Yeniden Bağlan"
    }
}

local function GetText(key)
    return Dict[CurrentLang][key] or key
end

local function RegisterTranslation(instance, textKey)
    table.insert(TranslatableObjects, {Instance = instance, Key = textKey})
    instance.Text = GetText(textKey)
end

local function SwitchLanguage()
    CurrentLang = CurrentLang == "TR" and "EN" or "TR"
    for _, item in pairs(TranslatableObjects) do
        if item.Instance and item.Instance.Parent then
            item.Instance.Text = GetText(item.Key)
            if item.Instance.SetAttribute then
                item.Instance:SetAttribute("SearchText", GetText(item.Key))
            end
        end
    end
end

-- =========================================================
-- GLOBAL VARIABLES
-- =========================================================
_G.WalkSpeedValue = 16
_G.JumpPowerValue = 50
_G.FlySpeedValue = 50
_G.FovValue = 70

_G.AimbotEnabled = false
_G.AimbotFOV = 150
_G.AimbotSmoothness = 0.2
_G.ShowFOVCircle = false
_G.SilentAimEnabled = false
_G.TriggerbotEnabled = false
_G.KillAuraEnabled = false
_G.TargetStrafe = false
_G.AimbotEnabled = false
_G.ShowFOVCircle = false
_G.SilentAimEnabled = false
_G.TriggerbotEnabled = false

_G.QFlyEnabled = false
_G.IsFlying = false
_G.NoclipEnabled = false
_G.HitboxSize = 2
_G.DashPower = 120
_G.NoDamageEnabled = false
_G.VelocityMultiplier = 0.15
_G.VelocityVertical = 0.85
_G.VelocityThreshold = 24
_G.FlingPower = 180


-- =========================================================
-- THEMES (DARK, MONOCHROME BLACK & WHITE)
-- =========================================================
local Themes = {
    Dark = {
        Main = Color3.fromRGB(16, 18, 24),
        TopBar = Color3.fromRGB(24, 26, 36),
        Sidebar = Color3.fromRGB(12, 14, 18),
        Content = Color3.fromRGB(20, 22, 30),
        Card = Color3.fromRGB(28, 31, 42),
        CardHover = Color3.fromRGB(40, 44, 60),
        Accent = Color3.fromRGB(80, 100, 235),
        Text = Color3.fromRGB(245, 245, 250),
        SubText = Color3.fromRGB(140, 145, 165),
        Stroke = Color3.fromRGB(38, 42, 58)
    },
    BlackAndWhiteDark = {
        Main = Color3.fromRGB(8, 8, 8),
        TopBar = Color3.fromRGB(16, 16, 16),
        Sidebar = Color3.fromRGB(4, 4, 4),
        Content = Color3.fromRGB(12, 12, 12),
        Card = Color3.fromRGB(22, 22, 22),
        CardHover = Color3.fromRGB(38, 38, 38),
        Accent = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(150, 150, 150),
        Stroke = Color3.fromRGB(45, 45, 45)
    },
    BlackAndWhiteLight = {
        Main = Color3.fromRGB(235, 235, 238),
        TopBar = Color3.fromRGB(220, 220, 225),
        Sidebar = Color3.fromRGB(210, 210, 215),
        Content = Color3.fromRGB(245, 245, 248),
        Card = Color3.fromRGB(255, 255, 255),
        CardHover = Color3.fromRGB(225, 225, 230),
        Accent = Color3.fromRGB(15, 15, 15),
        Text = Color3.fromRGB(10, 10, 10),
        SubText = Color3.fromRGB(90, 90, 90),
        Stroke = Color3.fromRGB(195, 195, 200)
    }
}

local CurrentTheme = Themes.Dark
local CurrentThemeName = "Dark"
local ThemeObjects = {}

local function RegisterThemeObject(instance, colorProperty, themeKey)
    table.insert(ThemeObjects, {Instance = instance, Property = colorProperty, Key = themeKey})
    instance[colorProperty] = CurrentTheme[themeKey]
end

local function ApplyTheme(themeName)
    if Themes[themeName] then
        CurrentThemeName = themeName
        CurrentTheme = Themes[themeName]
        for _, obj in pairs(ThemeObjects) do
            if obj.Instance and obj.Instance.Parent then
                TweenService:Create(obj.Instance, TweenInfo.new(0.3), {[obj.Property] = CurrentTheme[obj.Key]}):Play()
            end
        end
    end
end

-- =========================================================
-- MAIN FRAME WORKSPACE
-- =========================================================
-- Rich UI layer. Existing feature callbacks below are intentionally kept
-- separate so the core scripts remain unchanged.
ScreenGui.IgnoreGuiInset = true

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 820, 0, 570)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = false
MainFrame.Parent = ScreenGui
RegisterThemeObject(MainFrame, "BackgroundColor3", "Main")

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainScale = Instance.new("UIScale")
MainScale.Scale = 0.90
MainScale.Parent = MainFrame

local function UpdateResponsiveScale()
    local viewport = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
    MainScale.Scale = math.clamp(math.min(viewport.X / 1040, viewport.Y / 720), 0.68, 1)
end

UpdateResponsiveScale()
if Camera then
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateResponsiveScale)
end

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.3
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame
RegisterThemeObject(MainStroke, "Color", "Stroke")

local Shadow = Instance.new("Frame")
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 16, 1, 16)
Shadow.Position = UDim2.new(0, -8, 0, 8)
Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Shadow.BackgroundTransparency = 0.78
Shadow.BorderSizePixel = 0
Shadow.ZIndex = 0
Shadow.Parent = MainFrame
local ShadowCorner = Instance.new("UICorner")
ShadowCorner.CornerRadius = UDim.new(0, 20)
ShadowCorner.Parent = Shadow

-- Smooth dragging: header is the drag surface so feature clicks do not move the UI.
local dragging, dragInput, dragStart, startPos
local function BeginDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = MainFrame.Position
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 62)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 3
TopBar.ClipsDescendants = true
TopBar.Parent = MainFrame
RegisterThemeObject(TopBar, "BackgroundColor3", "TopBar")

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 16)
TopCorner.Parent = TopBar

local TopGradient = Instance.new("UIGradient")
TopGradient.Rotation = 90
TopGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.02),
    NumberSequenceKeypoint.new(1, 0.12)
})
TopGradient.Parent = TopBar

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        BeginDrag(input)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        local targetPos = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        MainFrame.Position = targetPos
    end
end)

local BrandMark = Instance.new("Frame")
BrandMark.Size = UDim2.new(0, 54, 0, 34)
BrandMark.Position = UDim2.new(0, 14, 0.5, -17)
BrandMark.BorderSizePixel = 0
BrandMark.Parent = TopBar
RegisterThemeObject(BrandMark, "BackgroundColor3", "Accent")
local BrandCorner = Instance.new("UICorner")
BrandCorner.CornerRadius = UDim.new(0, 10)
BrandCorner.Parent = BrandMark

-- Wikimedia logo requested by the user.
local LogoOuter = Instance.new("Frame")
LogoOuter.Size = UDim2.new(0, 34, 0, 34)
LogoOuter.Position = UDim2.new(0.5, -17, 0.5, -17)
LogoOuter.BackgroundTransparency = 1
LogoOuter.BorderSizePixel = 0
LogoOuter.ClipsDescendants = true
LogoOuter.Parent = BrandMark

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 8)
LogoCorner.Parent = LogoOuter

local LogoImage = Instance.new("ImageLabel")
LogoImage.Name = "WikimediaLogo"
LogoImage.Size = UDim2.fromScale(1, 1)
LogoImage.BackgroundTransparency = 1
LogoImage.ScaleType = Enum.ScaleType.Fit
LogoImage.Image = ""
LogoImage.Parent = LogoOuter

local LogoSourceURL = "https://upload.wikimedia.org/wikipedia/commons/0/04/Red-John-Smiley-Face.png"
local function LoadWikimediaLogo()
    local assetLoader = getcustomasset or getsynasset
    if type(assetLoader) ~= "function" or type(writefile) ~= "function" then return nil end
    local ok, data = pcall(function() return game:HttpGet(LogoSourceURL) end)
    if not ok or type(data) ~= "string" or #data < 100 then return nil end
    local path = "ResetHub_RedJohn_Smiley.png"
    if not pcall(function() writefile(path, data) end) then return nil end
    local assetOk, asset = pcall(function() return assetLoader(path) end)
    if assetOk and type(asset) == "string" then return asset end
    return nil
end

task.spawn(function()
    local asset = LoadWikimediaLogo()
    if asset and LogoImage.Parent then LogoImage.Image = asset end
end)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 170, 0, 22)
Title.TextTruncate = Enum.TextTruncate.AtEnd
Title.Position = UDim2.new(0, 78, 0, 10)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar
RegisterTranslation(Title, "Title")
RegisterThemeObject(Title, "TextColor3", "Text")

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 165, 0, 16)
Subtitle.TextTruncate = Enum.TextTruncate.AtEnd
Subtitle.Position = UDim2.new(0, 79, 0, 31)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Ultimate Edition - Ready"
Subtitle.Font = Enum.Font.GothamMedium
Subtitle.TextSize = 9
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar
RegisterThemeObject(Subtitle, "TextColor3", "SubText")

local ReadyDot = Instance.new("Frame")
ReadyDot.Size = UDim2.new(0, 7, 0, 7)
ReadyDot.Position = UDim2.new(0, 236, 0, 27)
ReadyDot.BorderSizePixel = 0
ReadyDot.Parent = TopBar
ReadyDot.BackgroundColor3 = Color3.fromRGB(90, 220, 120)
local ReadyCorner = Instance.new("UICorner")
ReadyCorner.CornerRadius = UDim.new(1, 0)
ReadyCorner.Parent = ReadyDot

local PageTitle = Instance.new("TextLabel")
PageTitle.Size = UDim2.new(0, 120, 0, 30)
PageTitle.Position = UDim2.new(0, 250, 0.5, -15)
PageTitle.TextTruncate = Enum.TextTruncate.AtEnd
PageTitle.BackgroundTransparency = 1
PageTitle.Font = Enum.Font.GothamBold
PageTitle.Text = GetText("TabCombat")
PageTitle.TextSize = 13
PageTitle.TextXAlignment = Enum.TextXAlignment.Center
PageTitle.Parent = TopBar
RegisterThemeObject(PageTitle, "TextColor3", "Text")

local function MakeTopButton(text, xOffset, width)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, width, 0, 15)
    btn.Position = UDim2.new(1, xOffset, 0.5, -7.5)
    btn.AutoButtonColor = false
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 8
    btn.TextTruncate = Enum.TextTruncate.AtEnd
    btn.ZIndex = 5
    btn.Parent = TopBar
    RegisterThemeObject(btn, "BackgroundColor3", "Card")
    RegisterThemeObject(btn, "TextColor3", "Text")

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 4)
    c.Parent = btn

    local st = Instance.new("UIStroke")
    st.Thickness = 1
    st.Transparency = 0.65
    st.Parent = btn
    RegisterThemeObject(st, "Color", "Stroke")

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = CurrentTheme.CardHover}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundColor3 = CurrentTheme.Card}):Play()
    end)
    return btn
end

local CloseButton = MakeTopButton("CLOSE", -44, 34)
local DarkThemeButton = MakeTopButton("DARK", -87, 31)
local LightThemeButton = MakeTopButton("LIGHT", -131, 34)
local MinimizeButton = MakeTopButton("MINIMIZE", -188, 47)
MinimizeButton.TextSize = 7
local FavOnlyButton = MakeTopButton("FAVORITES", -245, 50)
FavOnlyButton.TextSize = 7
local LangTRButton = MakeTopButton("TR", -280, 27)
local LangENButton = MakeTopButton("EN", -315, 27)
CloseButton.TextSize = 7

LangENButton.MouseButton1Click:Connect(function()
    if CurrentLang ~= "EN" then SwitchLanguage() end
end)
LangTRButton.MouseButton1Click:Connect(function()
    if CurrentLang ~= "TR" then SwitchLanguage() end
end)
LightThemeButton.MouseButton1Click:Connect(function() ApplyTheme("BlackAndWhiteLight") end)
DarkThemeButton.MouseButton1Click:Connect(function() ApplyTheme("Dark") end)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 174, 1, -62)
Sidebar.Position = UDim2.new(0, 0, 0, 62)
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 0
Sidebar.BackgroundTransparency = 0
Sidebar.Parent = MainFrame
RegisterThemeObject(Sidebar, "BackgroundColor3", "Sidebar")

local SideLayout = Instance.new("UIListLayout")
SideLayout.Padding = UDim.new(0, 6)
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.Parent = Sidebar
local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.PaddingBottom = UDim.new(0, 8)
SidePadding.Parent = Sidebar
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -188, 1, -76)
ContentArea.Position = UDim2.new(0, 184, 0, 72)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

local ContentCard = Instance.new("Frame")
ContentCard.Size = UDim2.fromScale(1, 1)
ContentCard.BorderSizePixel = 0
ContentCard.Parent = ContentArea
RegisterThemeObject(ContentCard, "BackgroundColor3", "Content")
local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 13)
ContentCorner.Parent = ContentCard
local ContentStroke = Instance.new("UIStroke")
ContentStroke.Thickness = 1
ContentStroke.Transparency = 0.5
ContentStroke.Parent = ContentCard
RegisterThemeObject(ContentStroke, "Color", "Stroke")

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, -12, 1, -12)
PageContainer.Position = UDim2.new(0, 6, 0, 6)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = ContentCard

-- Keep the original ContentArea reference usable by the existing builders.
ContentArea = PageContainer

local tabs = {}
local TabByKey = {}
local CurrentPage = nil
local CurrentTabData = nil
local Favorites = {}
local FavoritesOnly = false

local TabIcons = {
    Home = "Home",
    TabCombat = "Combat & Aimbot",
    TabMove = "Movement & Physics",
    TabPlayer = "Local Player",
    TabVisuals = "Visuals & ESP",
    TabTeleport = "Teleportation",
    TabAuto = "Automation & Farm",
    TabHubs = "Script Hubs",
    TabFun = "Fun & Exploits",
    TabSettings = "Settings & Themes",
    World = "World",
    TabChat = "Chat",
    TabTools = "Tools & Items",
    TabOther = "Other...",
    TabEmotes = "Emotes"
}

local function UpdateFavoritesFilter()
    if not CurrentPage then return end
    for _, child in ipairs(CurrentPage:GetChildren()) do
        if child:IsA("GuiButton") or child:GetAttribute("Searchable") then
            child.Visible = (not FavoritesOnly) or Favorites[child] == true
        end
    end
end

local UpdateSearch = UpdateFavoritesFilter

FavOnlyButton.MouseButton1Click:Connect(function()
    FavoritesOnly = not FavoritesOnly
    FavOnlyButton.TextColor3 = FavoritesOnly and Color3.fromRGB(255, 210, 70) or CurrentTheme.Text
    UpdateFavoritesFilter()
end)

local function MakeSidebarButton(nameKey, order)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = nameKey .. "Button"
    TabButton.Size = UDim2.new(0, 150, 0, 32)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 11
    TabButton.Text = GetText(nameKey)
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    TabButton.LayoutOrder = order
    TabButton.Parent = Sidebar
    RegisterTranslation(TabButton, nameKey)
    RegisterThemeObject(TabButton, "BackgroundColor3", "Card")
    RegisterThemeObject(TabButton, "TextColor3", "SubText")

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 11)
    corner.Parent = TabButton

    local textPad = Instance.new("UIPadding")
    textPad.PaddingLeft = UDim.new(0, 14)
    textPad.PaddingRight = UDim.new(0, 10)
    textPad.Parent = TabButton

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Transparency = 0.55
    stroke.Parent = TabButton
    RegisterThemeObject(stroke, "Color", "Stroke")

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 3, 0, 26)
    indicator.Position = UDim2.new(0, 0, 0.5, -13)
    indicator.BorderSizePixel = 0
    indicator.BackgroundTransparency = 1
    indicator.Parent = TabButton
    RegisterThemeObject(indicator, "BackgroundColor3", "Accent")

    local tip = Instance.new("TextLabel")
    tip.Name = "Tooltip"
    tip.Size = UDim2.new(0, 155, 0, 28)
    tip.Position = UDim2.new(1, 9, 0.5, -14)
    tip.BackgroundTransparency = 0
    tip.Text = GetText(nameKey)
    tip.TextSize = 10
    tip.Font = Enum.Font.GothamSemibold
    tip.TextXAlignment = Enum.TextXAlignment.Left
    tip.Visible = false
    tip.ZIndex = 30
    tip.Parent = TabButton
    RegisterThemeObject(tip, "BackgroundColor3", "TopBar")
    RegisterThemeObject(tip, "TextColor3", "Text")
    local tc = Instance.new("UICorner")
    tc.CornerRadius = UDim.new(0, 7)
    tc.Parent = tip
    local tp = Instance.new("UIPadding")
    tp.PaddingLeft = UDim.new(0, 9)
    tp.Parent = tip

    TabButton.MouseEnter:Connect(function()
        tip.Visible = false
        TweenService:Create(TabButton, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 153, 0, 33)}):Play()
    end)
    TabButton.MouseLeave:Connect(function()
        tip.Visible = false
        TweenService:Create(TabButton, TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 150, 0, 32)}):Play()
    end)

    return TabButton, indicator
end

local function UpdateTabSelection(activeTab)
    for _, t in ipairs(tabs) do
        local selected = t == activeTab
        t.Page.Visible = selected
        TweenService:Create(t.Btn, TweenInfo.new(0.16), {
            BackgroundColor3 = selected and CurrentTheme.CardHover or CurrentTheme.Card,
            TextColor3 = selected and CurrentTheme.Text or CurrentTheme.SubText
        }):Play()
        if t.Indicator then
            TweenService:Create(t.Indicator, TweenInfo.new(0.16), {
                BackgroundTransparency = selected and 0 or 1
            }):Play()
        end
    end
    CurrentPage = activeTab and activeTab.Page or nil
    CurrentTabData = activeTab
    if activeTab then
        local title = GetText(activeTab.Key)
        PageTitle.Text = title
    end
    FavoritesOnly = false
    FavOnlyButton.TextColor3 = CurrentTheme.Text
end

local function CreateTab(nameKey, isHome)
    local TabButton, Indicator = MakeSidebarButton(nameKey, #tabs + 1)

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = nameKey .. "Page"
    TabPage.Size = UDim2.fromScale(1, 1)
    TabPage.BackgroundTransparency = 1
    TabPage.BorderSizePixel = 0
    TabPage.ScrollBarThickness = 4
    TabPage.ScrollBarImageTransparency = 0.15
    TabPage.Visible = false
    TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabPage.Parent = ContentArea
    RegisterThemeObject(TabPage, "ScrollBarImageColor3", "Accent")

    local Layout
    if isHome then
        Layout = Instance.new("UIGridLayout")
        Layout.CellSize = UDim2.new(0.5, -8, 0, 112)
        Layout.CellPadding = UDim2.new(0, 10, 0, 10)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Parent = TabPage
        local pad = Instance.new("UIPadding")
        pad.PaddingTop = UDim.new(0, 8)
        pad.PaddingLeft = UDim.new(0, 8)
        pad.PaddingRight = UDim.new(0, 8)
        pad.PaddingBottom = UDim.new(0, 12)
        pad.Parent = TabPage
    else
        Layout = Instance.new("UIGridLayout")
        Layout.CellSize = UDim2.new(0.5, -10, 0, 34)
        Layout.CellPadding = UDim2.new(0, 10, 0, 8)
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Parent = TabPage
        local pad = Instance.new("UIPadding")
        pad.PaddingTop = UDim.new(0, 8)
        pad.PaddingLeft = UDim.new(0, 8)
        pad.PaddingRight = UDim.new(0, 8)
        pad.PaddingBottom = UDim.new(0, 12)
        pad.Parent = TabPage

    end

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabPage.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
    end)

    local tabData = {Btn = TabButton, Page = TabPage, Indicator = Indicator, Key = nameKey}
    tabData.Switch = function() UpdateTabSelection(tabData) end
    table.insert(tabs, tabData)
    TabByKey[nameKey] = tabData
    TabButton.MouseButton1Click:Connect(tabData.Switch)
    if #tabs == 1 then tabData.Switch() end
    return TabPage
end

-- Notification Helper
local function Notify(msg)
    local Notif = Instance.new("Frame")
    Notif.Name = "ResetHub_Notification"
    Notif.Size = UDim2.new(0, 330, 0, 52)
    Notif.Position = UDim2.new(1, 25, 1, -72)
    Notif.AnchorPoint = Vector2.new(1, 1)
    Notif.ZIndex = 100
    Notif.Parent = ScreenGui
    RegisterThemeObject(Notif, "BackgroundColor3", "TopBar")

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 11)
    Corner.Parent = Notif
    local Stroke = Instance.new("UIStroke")
    Stroke.Thickness = 1
    Stroke.Transparency = 0.25
    Stroke.Parent = Notif
    RegisterThemeObject(Stroke, "Color", "Accent")

    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 4, 1, -16)
    AccentBar.Position = UDim2.new(0, 7, 0, 8)
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Notif
    RegisterThemeObject(AccentBar, "BackgroundColor3", "Accent")
    local Ac = Instance.new("UICorner")
    Ac.CornerRadius = UDim.new(1, 0)
    Ac.Parent = AccentBar

    local NText = Instance.new("TextLabel")
    NText.Size = UDim2.new(1, -28, 1, 0)
    NText.Position = UDim2.new(0, 20, 0, 0)
    NText.BackgroundTransparency = 1
    NText.Text = tostring(msg)
    NText.Font = Enum.Font.GothamMedium
    NText.TextSize = 11
    NText.TextXAlignment = Enum.TextXAlignment.Left
    NText.TextTruncate = Enum.TextTruncate.AtEnd
    NText.ZIndex = 101
    NText.Parent = Notif
    RegisterThemeObject(NText, "TextColor3", "Text")

    TweenService:Create(Notif, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -20, 1, -72)
    }):Play()
    task.delay(2.6, function()
        if not Notif.Parent then return end
        local tween = TweenService:Create(Notif, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 25, 1, -72)
        })
        tween:Play()
        tween.Completed:Connect(function()
            if Notif then Notif:Destroy() end
        end)
    end)
end

local function AddFavoriteButton(parent, owner)
    local Star = Instance.new("TextButton")
    Star.Name = "Favorite"
    Star.Size = UDim2.new(0, 34, 0, 26)
    Star.Position = UDim2.new(1, -38, 0.5, -13)
    Star.BackgroundTransparency = 1
    Star.Text = Favorites[owner] and "FAVORITE" or "NORMAL"
    Star.TextSize = 9
    Star.Font = Enum.Font.GothamBold
    Star.AutoButtonColor = false
    Star.ZIndex = 4
    Star.Parent = owner
    RegisterThemeObject(Star, "TextColor3", "SubText")
    Star.MouseButton1Click:Connect(function()
        Favorites[owner] = not Favorites[owner]
        Star.Text = Favorites[owner] and "FAVORITE" or "NORMAL"
        Star.TextColor3 = Favorites[owner] and Color3.fromRGB(255, 210, 70) or CurrentTheme.SubText
        UpdateSearch()
    end)
end

-- =========================================================
-- UI BUILDERS (Button & Slider)
-- =========================================================
local GetToggleState
local Keybinds = {}
local KeybindTargets = {}
local KeybindButtons = {}
local CapturingKeybind = nil
local RequestKeybind

local function RefreshKeybindBadge(feature)
    for _, btn in ipairs(KeybindButtons[feature] or {}) do
        if btn and btn.Parent then
            local badge = btn:FindFirstChild('KeybindBadge')
            if badge then badge.Text = Keybinds[feature] and ('⌨ ' .. Keybinds[feature]) or '⌨ NONE' end
        end
    end
end

local function ClearKeybind(keyName)
    for feature, key in pairs(Keybinds) do
        if key == keyName then
            Keybinds[feature] = nil
            RefreshKeybindBadge(feature)
        end
    end
end

local function RefreshToggleIndicator(btn, key)
    if not btn or not btn.Parent or type(GetToggleState) ~= "function" then return end
    local indicator = btn:FindFirstChild("ToggleStateLabel")
    if not indicator then return end
    local state = GetToggleState(key)
    if state == nil then
        indicator.Visible = false
        return
    end
    indicator.Visible = true
    indicator.Text = state and "ON" or "OFF"
    indicator.TextColor3 = state and Color3.fromRGB(95, 220, 120) or CurrentTheme.SubText
end

local function BuildButtonText(parent, key, text)
    local label = Instance.new("TextLabel")
    label.Name = "ButtonText"
    label.Size = UDim2.new(1, -90, 1, 0)
    label.Position = UDim2.new(0, 28, 0, 0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.Text = text
    label.Parent = parent
    if key then RegisterTranslation(label, key) end
    RegisterThemeObject(label, "TextColor3", "Text")
    return label
end

local function AddButton(page, textKey, callback)
    KeybindTargets[textKey] = KeybindTargets[textKey] or {}
    if type(callback) == 'function' then table.insert(KeybindTargets[textKey], callback) end
    local Btn = Instance.new("TextButton")
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 9
    Btn.Text = ""
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.AutoButtonColor = false
    Btn.Parent = page
    Btn:SetAttribute("Searchable", true)
    Btn:SetAttribute("SearchText", GetText(textKey))
    RegisterThemeObject(Btn, "BackgroundColor3", "Card")

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 9)
    BCorner.Parent = Btn
    local BStroke = Instance.new("UIStroke")
    BStroke.Thickness = 1
    BStroke.Transparency = 0.45
    BStroke.Parent = Btn
    RegisterThemeObject(BStroke, "Color", "Stroke")

    local Accent = Instance.new("Frame")
    Accent.Name = "AccentBar"
    Accent.Size = UDim2.new(0, 3, 0, 20)
    Accent.Position = UDim2.new(0, 7, 0.5, -10)
    Accent.BorderSizePixel = 0
    Accent.BackgroundTransparency = 0.6
    Accent.ZIndex = 2
    Accent.Parent = Btn
    RegisterThemeObject(Accent, "BackgroundColor3", "Accent")
    local AC = Instance.new("UICorner")
    AC.CornerRadius = UDim.new(1, 0)
    AC.Parent = Accent

    BuildButtonText(Btn, textKey, GetText(textKey))
    AddFavoriteButton(Btn, Btn)

    KeybindButtons[textKey] = KeybindButtons[textKey] or {}
    table.insert(KeybindButtons[textKey], Btn)
    local KeybindBadge = Instance.new("TextLabel")
    KeybindBadge.Name = "KeybindBadge"
    KeybindBadge.Size = UDim2.new(0, 52, 0, 18)
    KeybindBadge.Position = UDim2.new(1, -122, 0.5, -9)
    KeybindBadge.BackgroundTransparency = 1
    KeybindBadge.Font = Enum.Font.GothamBold
    KeybindBadge.TextSize = 7
    KeybindBadge.Text = Keybinds[textKey] and ("⌨ " .. Keybinds[textKey]) or "⌨ NONE"
    KeybindBadge.TextXAlignment = Enum.TextXAlignment.Center
    KeybindBadge.Parent = Btn
    RegisterThemeObject(KeybindBadge, "TextColor3", "SubText")
    Btn.MouseButton2Click:Connect(function() if RequestKeybind then RequestKeybind(textKey) end end)

    local ToggleStateLabel = Instance.new("TextLabel")
    ToggleStateLabel.Name = "ToggleStateLabel"
    ToggleStateLabel.Size = UDim2.new(0, 30, 0, 18)
    ToggleStateLabel.Position = UDim2.new(1, -68, 0.5, -9)
    ToggleStateLabel.BackgroundTransparency = 1
    ToggleStateLabel.Font = Enum.Font.GothamBold
    ToggleStateLabel.TextSize = 8
    ToggleStateLabel.TextXAlignment = Enum.TextXAlignment.Center
    ToggleStateLabel.Parent = Btn
    RegisterThemeObject(ToggleStateLabel, "TextColor3", "SubText")

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.12), {BackgroundColor3 = CurrentTheme.CardHover}):Play()
        TweenService:Create(BStroke, TweenInfo.new(0.12), {Transparency = 0.08}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.12), {BackgroundColor3 = CurrentTheme.Card}):Play()
        TweenService:Create(BStroke, TweenInfo.new(0.12), {Transparency = 0.45}):Play()
    end)
    Btn.MouseButton1Click:Connect(function()
        local ok, err = pcall(callback)
        if ok then
            Notify(GetText(textKey) .. " Active!")
        else
            Notify(GetText(textKey) .. " Error: " .. tostring(err))
        end
        RefreshToggleIndicator(Btn, textKey)
        TweenService:Create(Accent, TweenInfo.new(0.08), {BackgroundTransparency = 0}):Play()
        task.delay(0.16, function()
            if Accent and Accent.Parent then
                TweenService:Create(Accent, TweenInfo.new(0.15), {BackgroundTransparency = 0.6}):Play()
            end
        end)
    end)
    task.defer(function() RefreshToggleIndicator(Btn, textKey) end)
    return Btn
end

local function AddSlider(page, textKey, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(0.5, -8, 0, 52)
    SliderFrame.Parent = page
    SliderFrame:SetAttribute("Searchable", true)
    SliderFrame:SetAttribute("SearchText", GetText(textKey))
    RegisterThemeObject(SliderFrame, "BackgroundColor3", "Card")
    local SCorner = Instance.new("UICorner")
    SCorner.CornerRadius = UDim.new(0, 9)
    SCorner.Parent = SliderFrame
    local SStroke = Instance.new("UIStroke")
    SStroke.Thickness = 1
    SStroke.Transparency = 0.45
    SStroke.Parent = SliderFrame
    RegisterThemeObject(SStroke, "Color", "Stroke")

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -62, 0, 18)
    TitleLabel.Position = UDim2.new(0, 12, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.TextSize = 9
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = SliderFrame
    RegisterTranslation(TitleLabel, textKey)
    RegisterThemeObject(TitleLabel, "TextColor3", "Text")

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 42, 0, 18)
    ValueLabel.Position = UDim2.new(1, -50, 0, 5)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 9
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    RegisterThemeObject(ValueLabel, "TextColor3", "Accent")

    local Track = Instance.new("Frame")
    Track.Size = UDim2.new(1, -24, 0, 6)
    Track.Position = UDim2.new(0, 12, 1, -14)
    Track.BorderSizePixel = 0
    Track.Parent = SliderFrame
    RegisterThemeObject(Track, "BackgroundColor3", "Sidebar")
    local TC = Instance.new("UICorner")
    TC.CornerRadius = UDim.new(1, 0)
    TC.Parent = Track

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new(math.clamp((default - min) / math.max(max - min, 1), 0, 1), 0, 1, 0)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    RegisterThemeObject(Fill, "BackgroundColor3", "Accent")
    local FC = Instance.new("UICorner")
    FC.CornerRadius = UDim.new(1, 0)
    FC.Parent = Fill

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 10, 0, 10)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new(math.clamp((default - min) / math.max(max - min, 1), 0, 1), 0, 0.5, 0)
    Knob.BorderSizePixel = 0
    Knob.Parent = Track
    RegisterThemeObject(Knob, "BackgroundColor3", "Text")
    local KC = Instance.new("UICorner")
    KC.CornerRadius = UDim.new(1, 0)
    KC.Parent = Knob

    local sliding = false
    local function Update(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / math.max(Track.AbsoluteSize.X, 1), 0, 1)
        local val = math.floor(min + ((max - min) * pos) + 0.5)
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, 0, 0.5, 0)
        ValueLabel.Text = tostring(val)
        if callback then pcall(callback, val) end
    end
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            Update(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            Update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    return SliderFrame
end

-- =========================================================
-- EXTENDED FEATURE ENGINE (v6)
-- Keeps the original UI/API and adds safer toggle/loop helpers.
-- =========================================================
local FeatureState = {}
local FeatureConnections = {}
local OriginalGravity = workspace.Gravity
local OriginalFOV = Camera.FieldOfView
local OriginalLighting = {
    Ambient = Lighting.Ambient,
    Brightness = Lighting.Brightness,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    ClockTime = Lighting.ClockTime,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows
}
local SavedPosition = nil
local SavedCameraType = Camera.CameraType
local SavedCameraSubject = Camera.CameraSubject
local NotificationsEnabled = true
local AutoCollectEnabled = false
local AutoEquipEnabled = false
local AutoPromptEnabled = false
local ActiveFlingConnection = nil
local ActiveFlingCanCollide = nil

-- Shared cleanup hook so re-injecting Reset Hub cannot leave old physics/camera loops behind.
_G.ResetHubCleanup = function()
    _G.TargetStrafe = false
    _G.IsFlying = false
    pcall(function() RunService:UnbindFromRenderStep("ResetHub_CombatLoop") end)
    if FeatureConnections then
        for name, connection in pairs(FeatureConnections) do
            pcall(function() connection:Disconnect() end)
            FeatureConnections[name] = nil
        end
    end
    if ActiveFlingConnection then
        pcall(function() ActiveFlingConnection:Disconnect() end)
        ActiveFlingConnection = nil
    end
    local char = LocalPlayer.Character
    if char then
        for _, name in ipairs({"QFlyVel", "QFlyGyro", "ResetHub_SpinBot", "ResetHub_SpinMovement"}) do
            local obj = char:FindFirstChild(name)
            if obj then pcall(function() obj:Destroy() end) end
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            for _, obj in ipairs(root:GetChildren()) do
                local class = obj.ClassName
                if class == "BodyAngularVelocity" or class == "BodyVelocity" or class == "BodyGyro"
                    or class == "BodyPosition" or class == "BodyForce" or class == "VectorForce"
                    or class == "LinearVelocity" or class == "AngularVelocity" or class == "AlignOrientation" then
                    pcall(function() obj:Destroy() end)
                end
            end
            pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
        end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function() hum.CameraOffset = Vector3.zero end)
        end
    end
end

local function CleanResetHubMotionArtifacts(char)
    char = char or LocalPlayer.Character
    if not char then return end

    local removeNames = {
        QFlyVel = true,
        QFlyGyro = true,
        ResetHub_SpinBot = true,
        ResetHub_SpinMovement = true,
        ResetHub_Fling = true,
        ResetHub_FlingGyro = true,
        ResetHub_FlingVelocity = true,
        ResetHub_Camera = true
    }

    for _, obj in ipairs(char:GetDescendants()) do
        if removeNames[obj.Name] then
            pcall(function() obj:Destroy() end)
        end
    end

    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
        pcall(function() root.AssemblyLinearVelocity = Vector3.new(0, root.AssemblyLinearVelocity.Y, 0) end)
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        pcall(function() hum.CameraOffset = Vector3.zero end)
    end
end

local function SetFeatureConnection(name, enabled, signal, callback)
    if FeatureConnections[name] then
        FeatureConnections[name]:Disconnect()
        FeatureConnections[name] = nil
    end
    if enabled and signal then
        FeatureConnections[name] = signal:Connect(callback)
    end
end

local function ToggleFeature(name, state)
    FeatureState[name] = state
    return state
end

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local char = GetCharacter()
    return char and char:FindFirstChildOfClass('Humanoid')
end

local function GetRoot()
    local char = GetCharacter()
    return char and char:FindFirstChild('HumanoidRootPart')
end

local function GetHead()
    local char = GetCharacter()
    return char and char:FindFirstChild('Head')
end

local function IsEnemyPlayer(player)
    if not player or player == LocalPlayer or not player.Character then return false end
    local hum = player.Character:FindFirstChildOfClass('Humanoid')
    return hum ~= nil and hum.Health > 0
end

local function SetButtonState(btn, enabled)
    if not btn or not btn.Parent then return end
    local target = enabled and CurrentTheme.Accent or CurrentTheme.Card
    TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = target}):Play()
end

local function AddFeatureButton(page, label, callback)
    KeybindTargets[label] = KeybindTargets[label] or {}
    if type(callback) == 'function' then table.insert(KeybindTargets[label], callback) end
    local Btn = Instance.new('TextButton')
    Btn.Font = Enum.Font.GothamMedium
    Btn.TextSize = 9
    Btn.Text = ""
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Btn.TextTruncate = Enum.TextTruncate.AtEnd
    Btn.AutoButtonColor = false
    Btn.Parent = page
    Btn:SetAttribute("Searchable", true)
    Btn:SetAttribute("SearchText", label)
    RegisterThemeObject(Btn, 'BackgroundColor3', 'Card')

    local Corner = Instance.new('UICorner')
    Corner.CornerRadius = UDim.new(0, 9)
    Corner.Parent = Btn

    local Stroke = Instance.new('UIStroke')
    Stroke.Thickness = 1
    Stroke.Transparency = 0.45
    Stroke.Parent = Btn
    RegisterThemeObject(Stroke, 'Color', 'Stroke')

    local Accent = Instance.new('Frame')
    Accent.Name = 'AccentBar'
    Accent.Size = UDim2.new(0, 3, 0, 20)
    Accent.Position = UDim2.new(0, 7, 0.5, -10)
    Accent.BorderSizePixel = 0
    Accent.BackgroundTransparency = 0.6
    Accent.ZIndex = 2
    Accent.Parent = Btn
    RegisterThemeObject(Accent, 'BackgroundColor3', 'Accent')
    local AC = Instance.new('UICorner')
    AC.CornerRadius = UDim.new(1, 0)
    AC.Parent = Accent

    BuildButtonText(Btn, nil, label)
    AddFavoriteButton(Btn, Btn)

    KeybindButtons[label] = KeybindButtons[label] or {}
    table.insert(KeybindButtons[label], Btn)
    local KeybindBadge = Instance.new('TextLabel')
    KeybindBadge.Name = 'KeybindBadge'
    KeybindBadge.Size = UDim2.new(0, 52, 0, 18)
    KeybindBadge.Position = UDim2.new(1, -122, 0.5, -9)
    KeybindBadge.BackgroundTransparency = 1
    KeybindBadge.Font = Enum.Font.GothamBold
    KeybindBadge.TextSize = 7
    KeybindBadge.Text = Keybinds[label] and ('⌨ ' .. Keybinds[label]) or '⌨ NONE'
    KeybindBadge.TextXAlignment = Enum.TextXAlignment.Center
    KeybindBadge.Parent = Btn
    RegisterThemeObject(KeybindBadge, 'TextColor3', 'SubText')
    Btn.MouseButton2Click:Connect(function() if RequestKeybind then RequestKeybind(label) end end)

    local ToggleStateLabel = Instance.new('TextLabel')
    ToggleStateLabel.Name = 'ToggleStateLabel'
    ToggleStateLabel.Size = UDim2.new(0, 30, 0, 18)
    ToggleStateLabel.Position = UDim2.new(1, -68, 0.5, -9)
    ToggleStateLabel.BackgroundTransparency = 1
    ToggleStateLabel.Font = Enum.Font.GothamBold
    ToggleStateLabel.TextSize = 8
    ToggleStateLabel.TextXAlignment = Enum.TextXAlignment.Center
    ToggleStateLabel.Parent = Btn
    RegisterThemeObject(ToggleStateLabel, 'TextColor3', 'SubText')

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.12), {BackgroundColor3 = CurrentTheme.CardHover}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.12), {Transparency = 0.08}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.12), {BackgroundColor3 = CurrentTheme.Card}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.12), {Transparency = 0.45}):Play()
    end)
    Btn.MouseButton1Click:Connect(function()
        local ok, err = pcall(callback)
        if NotificationsEnabled then
            Notify(label .. (ok and ' Active!' or (' Error: ' .. tostring(err))))
        end
        RefreshToggleIndicator(Btn, label)
        TweenService:Create(Accent, TweenInfo.new(0.08), {BackgroundTransparency = 0}):Play()
        task.delay(0.16, function()
            if Accent and Accent.Parent then
                TweenService:Create(Accent, TweenInfo.new(0.15), {BackgroundTransparency = 0.6}):Play()
            end
        end)
    end)
    task.defer(function() RefreshToggleIndicator(Btn, label) end)
    return Btn
end

local function AddFeatureSlider(page, label, min, max, default, callback)
    local SliderFrame = Instance.new('Frame')
    SliderFrame.Size = UDim2.new(0, 255, 0, 40)
    SliderFrame.Parent = page
    SliderFrame:SetAttribute('Searchable', true)
    SliderFrame:SetAttribute('SearchText', label)
    RegisterThemeObject(SliderFrame, 'BackgroundColor3', 'Card')

    local Corner = Instance.new('UICorner')
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = SliderFrame

    local Stroke = Instance.new('UIStroke')
    Stroke.Thickness = 1
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = SliderFrame
    RegisterThemeObject(Stroke, 'Color', 'Stroke')

    local TitleLabel = Instance.new('TextLabel')
    TitleLabel.Size = UDim2.new(1, -50, 0, 20)
    TitleLabel.Position = UDim2.new(0, 10, 0, 2)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamMedium
    TitleLabel.TextSize = 10
    TitleLabel.Text = label
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = SliderFrame
    RegisterThemeObject(TitleLabel, 'TextColor3', 'Text')

    if AddFavoriteButton then AddFavoriteButton(SliderFrame, SliderFrame) end

    local ValueLabel = Instance.new('TextLabel')
    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
    ValueLabel.Position = UDim2.new(1, -45, 0, 2)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 10
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    RegisterThemeObject(ValueLabel, 'TextColor3', 'Accent')

    local Track = Instance.new('Frame')
    Track.Size = UDim2.new(1, -20, 0, 5)
    Track.Position = UDim2.new(0, 10, 1, -10)
    Track.BorderSizePixel = 0
    Track.Parent = SliderFrame
    RegisterThemeObject(Track, 'BackgroundColor3', 'Sidebar')

    local TCorner = Instance.new('UICorner')
    TCorner.CornerRadius = UDim.new(0, 4)
    TCorner.Parent = Track

    local Fill = Instance.new('Frame')
    Fill.Size = UDim2.new(math.clamp((default - min) / (max - min), 0, 1), 0, 1, 0)
    Fill.BorderSizePixel = 0
    Fill.Parent = Track
    RegisterThemeObject(Fill, 'BackgroundColor3', 'Accent')

    local FCorner = Instance.new('UICorner')
    FCorner.CornerRadius = UDim.new(0, 4)
    FCorner.Parent = Fill

    local sliding = false
    local function update(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / math.max(Track.AbsoluteSize.X, 1), 0, 1)
        local val = min + ((max - min) * pos)
        if math.floor(max) == max and math.floor(min) == min then
            val = math.floor(val + 0.5)
        end
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        ValueLabel.Text = tostring(val)
        callback(val)
    end
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = true
            update(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    return SliderFrame
end

local function SafeSetClipboard(text)
    local fn = setclipboard or toclipboard or (syn and syn.write_clipboard)
    if type(fn) == 'function' then
        pcall(fn, tostring(text))
        return true
    end
    return false
end

local function GetOtherPlayers()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild('HumanoidRootPart') then
            table.insert(list, p)
        end
    end
    return list
end

local function SetCharacterCollision(enabled)
    local char = GetCharacter()
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA('BasePart') then
            part.CanCollide = enabled
        end
    end
end

GetToggleState = function(key)
    local f = FeatureState
    local m = {
        Aimbot=function() return _G.AimbotEnabled end, SilentAim=function() return _G.SilentAimEnabled end,
        Triggerbot=function() return _G.TriggerbotEnabled end, KillAura=function() return _G.KillAuraEnabled end,
        AntiKnockback=function() return f.AntiKnockback end, TargetStrafe=function() return _G.TargetStrafe end,
        ShowFOV=function() return _G.ShowFOVCircle end, QFly=function() return _G.QFlyEnabled end,
        Noclip=function() return _G.NoclipEnabled end, Godmode=function() return f.Godmode end,
        NoFall=function() return f.NoFall end, AntiAFK=function() return f.AntiAFK end,
        Headless=function() local h=GetHead(); return h and h.Transparency==1 or false end,
        ESP=function() return _G.ESPEnabled end, Fullbright=function() return _G.FullbrightEnabled end,
        XRay=function() return _G.XRayEnabled end, Crosshair=function() return ScreenGui:FindFirstChild("CenterCrosshair")~=nil end,
        CriticalHit=function() return f.CriticalHit end, AutoBlock=function() return f.AutoBlock end,
        ['Speed Lock']=function() return f.SpeedLock end, ['Jump Lock']=function() return f.JumpLock end,
        ['Bunny Hop']=function() return f.BunnyHop end,
        ['CFrame Speed']=function() return f.CFrameSpeed end, ['Air Walk']=function() return f.AirWalk end,
        ['No Slow']=function() return f.NoSlow end, ['Spin Movement']=function() return f.SpinMovement end,
        ['Anti Void']=function() return f.AntiVoid end, ['Freeze In Place']=function() return f.Freeze end,
        ['Velocity Guard']=function() return f.VelocityGuard end, ['Horizontal Velocity Lock']=function() return f.HorizontalVelocity end,
        ['Vertical Velocity Lock']=function() return f.VerticalVelocity end, ['Advanced ESP']=function() return f.ESP2 end,
        ['Name ESP']=function() return f.NameESP end, ['Distance ESP']=function() return f.DistanceESP end,
        ['Player Chams']=function() return f.Chams end, ['Night Vision']=function() return f.NightVision end,
        ['World Fullbright']=function() return f.WorldFullbright end,
        ['Orbit Nearest Player']=function() return f.OrbitNearest end, ['Back To Saved On Void']=function() return f.BackSavedVoid end,
        ['Auto Jump']=function() return f.AutoJump end, ['Auto Equip Tool']=function() return AutoEquipEnabled end, ['Prompt Duration 0']=function() return f.PromptDuration0 end,
        ['Auto Prompt Fire']=function() return AutoPromptEnabled end, ['Auto Collect Touch Items']=function() return AutoCollectEnabled end,
        ['Tool Spam']=function() return f.ToolSpam end, ['Auto Sit']=function() return f.AutoSit end,
        ['Auto Respawn']=function() return f.AutoRespawn end, ['Auto Sprint']=function() return f.AutoSprint end,
        ['Auto Rotate']=function() return f.AutoRotate end, ['Auto Heal']=function() return f.AutoHeal end,
        ['Auto Jump + Speed']=function() return f.JumpSpeed end, ['Auto Face Mouse']=function() return f.FaceMouse end,
        ['Spin Bot']=function() return f.SpinBot end, ['Spin Toggle']=function() return f.Spin end,
        ['Third Person Camera']=function() return f.ThirdPerson end, ['Camera Zoom Max']=function() return f.CameraZoomMax end,
        ['Float']=function() return f.Float end, ['Invisible Local']=function() return f.Invisible end,
        ['Walk Backwards']=function() return f.Backward end, ['Face Mouse']=function() return f.FunFaceMouse end,
        ['Respawn Protection']=function() return f.RespawnProtection end, ['No Damage']=function() return f.NoDamage end, ['No Sit']=function() return f.NoSit end,
        ['Freeze Character']=function() local r=GetRoot(); return r and r.Anchored or false end,
        ['Platform Stand']=function() local h=GetHumanoid(); return h and h.PlatformStand or false end,
    }
    local g=m[key]
    if g then local ok,v=pcall(g); if ok then return v end end
    return nil
end

local function ApplyVelocityModifier(mult, verticalMult, threshold)
    local root = GetRoot()
    if not root then return end
    local vel = root.AssemblyLinearVelocity
    local horizontal = Vector3.new(vel.X, 0, vel.Z)
    if horizontal.Magnitude >= threshold then
        horizontal = horizontal * mult
    end
    root.AssemblyLinearVelocity = Vector3.new(horizontal.X, vel.Y * verticalMult, horizontal.Z)
end

-- Keep movement values after respawn.
LocalPlayer.CharacterAdded:Connect(function(char)
    task.defer(function()
        local hum = char:WaitForChild('Humanoid', 5)
        if hum then
            hum.WalkSpeed = _G.WalkSpeedValue
            hum.UseJumpPower = true
            hum.JumpPower = _G.JumpPowerValue
            if FeatureState.NoFall then
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            end
            if FeatureState.RespawnProtection then
                hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            end
        end
    end)
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.defer(function()
        CleanResetHubMotionArtifacts(char)
        for _, name in ipairs({"QFlyVel", "QFlyGyro", "ResetHub_SpinBot", "ResetHub_SpinMovement"}) do
            local old = char:FindFirstChild(name)
            if old then pcall(function() old:Destroy() end) end
        end
        local root = char:WaitForChild('HumanoidRootPart', 5)
        if not root then return end
        pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
        if FeatureState.AntiKnockback then
            root.CustomPhysicalProperties = PhysicalProperties.new(100, 0.3, 0.5)
        end
        if FeatureState.SpinBot then
            SetFeatureConnection('SpinBot', true, RunService.Heartbeat, function()
                local currentRoot = GetRoot()
                if currentRoot then currentRoot.AssemblyAngularVelocity = Vector3.new(0, 60, 0) end
            end)
        end
        if FeatureState.SpinMovement then
            SetFeatureConnection('SpinMovement', true, RunService.Heartbeat, function()
                local currentRoot = GetRoot()
                if currentRoot then currentRoot.AssemblyAngularVelocity = Vector3.new(0, 12, 0) end
            end)
        end
    end)
end)

-- =========================================================
-- CATEGORIES & FULL COMBAT INTEGRATION
-- =========================================================

local TabHome = CreateTab("Home", true)
local TabCombat = CreateTab("TabCombat")
local TabMove = CreateTab("TabMove")
local TabPlayer = CreateTab("TabPlayer")
local TabVisuals = CreateTab("TabVisuals")
local TabTeleport = CreateTab("TabTeleport")
local TabAuto = CreateTab("TabAuto")
local TabHubs = CreateTab("TabHubs")
local TabFun = CreateTab("TabFun")
local TabSettings = CreateTab("TabSettings")
local TabWorld = CreateTab("World")
local TabChat = CreateTab("TabChat")
local TabTools = CreateTab("TabTools")
local TabOther = CreateTab("TabOther")
local TabEmotes = CreateTab("TabEmotes")
do
    local chatLayout = TabChat:FindFirstChildOfClass("UIGridLayout")
    if chatLayout then chatLayout:Destroy() end
    local chatPadding = TabChat:FindFirstChildOfClass("UIPadding")
    if chatPadding then chatPadding:Destroy() end
    TabChat.CanvasSize = UDim2.new(0, 0, 0, 0)
end
-- =========================================================
-- HOME DASHBOARD (visual only; existing scripts remain untouched)
-- =========================================================
local function HomeCard(title, desc, icon, targetKey)
    local Card = Instance.new('TextButton')
    Card.Name = 'Home_' .. title:gsub('%W', '')
    Card.Size = UDim2.new(0.5, -8, 0, 112)
    Card.BackgroundTransparency = 0
    Card.Text = ''
    Card.AutoButtonColor = false
    Card.LayoutOrder = #TabHome:GetChildren() + 1
    Card.Parent = TabHome
    RegisterThemeObject(Card, 'BackgroundColor3', 'Card')
    local cc = Instance.new('UICorner')
    cc.CornerRadius = UDim.new(0, 12)
    cc.Parent = Card
    local cs = Instance.new('UIStroke')
    cs.Thickness = 1
    cs.Transparency = 0.5
    cs.Parent = Card
    RegisterThemeObject(cs, 'Color', 'Stroke')

    local Icon = Instance.new('TextLabel')
    Icon.Size = UDim2.new(0, 58, 0, 44)
    Icon.Position = UDim2.new(0, 12, 0, 14)
    Icon.BackgroundTransparency = 0
    Icon.Text = icon
    Icon.Font = Enum.Font.GothamBlack
    Icon.TextSize = 8
    Icon.TextWrapped = true
    Icon.Parent = Card
    RegisterThemeObject(Icon, 'BackgroundColor3', 'Sidebar')
    RegisterThemeObject(Icon, 'TextColor3', 'Accent')
    local ic = Instance.new('UICorner')
    ic.CornerRadius = UDim.new(0, 11)
    ic.Parent = Icon

    local T = Instance.new('TextLabel')
    T.Size = UDim2.new(1, -88, 0, 22)
    T.Position = UDim2.new(0, 82, 0, 13)
    T.BackgroundTransparency = 1
    T.Text = title
    T.Font = Enum.Font.GothamBold
    T.TextSize = 11
    T.TextXAlignment = Enum.TextXAlignment.Left
    T.Parent = Card
    RegisterThemeObject(T, 'TextColor3', 'Text')

    local D = Instance.new('TextLabel')
    D.Size = UDim2.new(1, -88, 0, 40)
    D.Position = UDim2.new(0, 82, 0, 38)
    D.BackgroundTransparency = 1
    D.Text = desc
    D.TextWrapped = true
    D.Font = Enum.Font.Gotham
    D.TextSize = 8
    D.TextXAlignment = Enum.TextXAlignment.Left
    D.TextYAlignment = Enum.TextYAlignment.Top
    D.Parent = Card
    RegisterThemeObject(D, 'TextColor3', 'SubText')

    Card.MouseEnter:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.14), {BackgroundColor3 = CurrentTheme.CardHover}):Play()
        TweenService:Create(cs, TweenInfo.new(0.14), {Transparency = 0.08}):Play()
    end)
    Card.MouseLeave:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.14), {BackgroundColor3 = CurrentTheme.Card}):Play()
        TweenService:Create(cs, TweenInfo.new(0.14), {Transparency = 0.5}):Play()
    end)
    Card.MouseButton1Click:Connect(function()
        local tab = TabByKey[targetKey]
        if tab then tab.Switch() end
    end)
end

HomeCard('Combat', 'Aimbot, attack and velocity tools', 'COMBAT', 'TabCombat')
HomeCard('Movement', 'Speed, fly, jump and physics', 'MOVE', 'TabMove')
HomeCard('Player', 'Character, camera and local tools', 'PLAYER', 'TabPlayer')
HomeCard('Visuals', 'ESP, lighting and camera visuals', 'VISUAL', 'TabVisuals')
HomeCard('Teleport', 'Saved positions and player teleport', 'TELEPORT', 'TabTeleport')
HomeCard('Automation', 'Click, prompt and tool automation', 'AUTO', 'TabAuto')
HomeCard('Utilities', 'Script hubs and server utilities', 'HUBS', 'TabHubs')
HomeCard('Fun', 'Local effects and movement fun', 'FUN', 'TabFun')
HomeCard('Settings', 'Themes, notifications and UI settings', 'SETTINGS', 'TabSettings')
HomeCard('World', 'Lighting, time and world controls', 'WORLD', 'World')
HomeCard('Tools', 'Part placer, hammer and local tools', 'TOOLS', 'TabTools')

local DashInfo = Instance.new('TextLabel')
DashInfo.Size = UDim2.new(1, -16, 0, 26)
DashInfo.BackgroundTransparency = 1
DashInfo.Text = 'Reset Hub - RightControl / Insert - Favorites enabled'
DashInfo.Font = Enum.Font.GothamSemibold
DashInfo.TextSize = 8
DashInfo.TextXAlignment = Enum.TextXAlignment.Left
DashInfo.LayoutOrder = 999
DashInfo.Parent = TabHome
RegisterThemeObject(DashInfo, 'TextColor3', 'SubText')



-----------------------------------------------------------
-- 0. SCRIPT CHAT
-----------------------------------------------------------
do
    local ChatHeader = Instance.new("Frame")
    ChatHeader.Size = UDim2.new(1, -16, 0, 60)
    ChatHeader.Position = UDim2.new(0, 8, 0, 8)
    ChatHeader.BackgroundTransparency = 1
    ChatHeader.Parent = TabChat

    local ChatTitleLabel = Instance.new("TextLabel")
    ChatTitleLabel.Size = UDim2.new(1, 0, 0, 26)
    ChatTitleLabel.BackgroundTransparency = 1
    ChatTitleLabel.Font = Enum.Font.GothamBold
    ChatTitleLabel.TextSize = 15
    ChatTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ChatTitleLabel.Parent = ChatHeader
    RegisterTranslation(ChatTitleLabel, "ChatTitle")
    RegisterThemeObject(ChatTitleLabel, "TextColor3", "Text")

    local ChatInfoLabel = Instance.new("TextLabel")
    ChatInfoLabel.Size = UDim2.new(1, 0, 0, 22)
    ChatInfoLabel.Position = UDim2.new(0, 0, 0, 28)
    ChatInfoLabel.BackgroundTransparency = 1
    ChatInfoLabel.Font = Enum.Font.Gotham
    ChatInfoLabel.TextSize = 9
    ChatInfoLabel.TextXAlignment = Enum.TextXAlignment.Left
    ChatInfoLabel.Parent = ChatHeader
    RegisterTranslation(ChatInfoLabel, "ChatInfo")
    RegisterThemeObject(ChatInfoLabel, "TextColor3", "SubText")

    local ChatLog = Instance.new("ScrollingFrame")
    ChatLog.Name = "ChatLog"
    ChatLog.Size = UDim2.new(1, -16, 1, -125)
    ChatLog.Position = UDim2.new(0, 8, 0, 70)
    ChatLog.BackgroundTransparency = 0
    ChatLog.BorderSizePixel = 0
    ChatLog.ScrollBarThickness = 4
    ChatLog.CanvasSize = UDim2.new(0, 0, 0, 0)
    ChatLog.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ChatLog.Parent = TabChat
    RegisterThemeObject(ChatLog, "BackgroundColor3", "Card")
    RegisterThemeObject(ChatLog, "ScrollBarImageColor3", "Accent")

    local ChatLogCorner = Instance.new("UICorner")
    ChatLogCorner.CornerRadius = UDim.new(0, 10)
    ChatLogCorner.Parent = ChatLog

    local ChatLogPadding = Instance.new("UIPadding")
    ChatLogPadding.PaddingTop = UDim.new(0, 8)
    ChatLogPadding.PaddingLeft = UDim.new(0, 8)
    ChatLogPadding.PaddingRight = UDim.new(0, 8)
    ChatLogPadding.PaddingBottom = UDim.new(0, 8)
    ChatLogPadding.Parent = ChatLog

    local ChatList = Instance.new("UIListLayout")
    ChatList.Padding = UDim.new(0, 6)
    ChatList.SortOrder = Enum.SortOrder.LayoutOrder
    ChatList.Parent = ChatLog

    local ChatInput = Instance.new("TextBox")
    ChatInput.Name = "ChatInput"
    ChatInput.Size = UDim2.new(1, -88, 0, 42)
    ChatInput.Position = UDim2.new(0, 8, 1, -50)
    ChatInput.BackgroundTransparency = 0
    ChatInput.ClearTextOnFocus = false
    ChatInput.Text = ""
    ChatInput.PlaceholderText = GetText("ChatPlaceholder")
    ChatInput.Font = Enum.Font.Gotham
    ChatInput.TextSize = 11
    ChatInput.TextXAlignment = Enum.TextXAlignment.Left
    ChatInput.Parent = TabChat
    RegisterThemeObject(ChatInput, "BackgroundColor3", "Card")
    RegisterThemeObject(ChatInput, "TextColor3", "Text")

    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 10)
    InputCorner.Parent = ChatInput

    local InputPad = Instance.new("UIPadding")
    InputPad.PaddingLeft = UDim.new(0, 12)
    InputPad.PaddingRight = UDim.new(0, 12)
    InputPad.Parent = ChatInput

    local ChatSendButton = Instance.new("TextButton")
    ChatSendButton.Name = "ChatSendButton"
    ChatSendButton.Size = UDim2.new(0, 72, 0, 42)
    ChatSendButton.Position = UDim2.new(1, -80, 1, -50)
    ChatSendButton.AutoButtonColor = false
    ChatSendButton.Font = Enum.Font.GothamBold
    ChatSendButton.TextSize = 10
    ChatSendButton.Parent = TabChat
    RegisterTranslation(ChatSendButton, "ChatSend")
    RegisterThemeObject(ChatSendButton, "BackgroundColor3", "Accent")
    RegisterThemeObject(ChatSendButton, "TextColor3", "Text")

    local SendCorner = Instance.new("UICorner")
    SendCorner.CornerRadius = UDim.new(0, 10)
    SendCorner.Parent = ChatSendButton

    local function AddChatMessage(prefix, text)
        if not text or tostring(text) == "" then return end
        local row = Instance.new("Frame")
        row.Size = UDim2.new(1, 0, 0, 32)
        row.BackgroundTransparency = 1
        row.Parent = ChatLog

        local label = Instance.new("TextLabel")
        label.Size = UDim2.fromScale(1, 1)
        label.BackgroundTransparency = 1
        label.TextWrapped = true
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextYAlignment = Enum.TextYAlignment.Center
        label.Font = Enum.Font.Gotham
        label.TextSize = 10
        label.Text = (prefix and prefix ~= "") and (tostring(prefix) .. ": " .. tostring(text)) or tostring(text)
        label.Parent = row
        RegisterThemeObject(label, "TextColor3", "Text")
    end

    local ChatChannel = nil
    pcall(function()
        local channels = TextChatService:FindFirstChild("TextChannels")
        if channels then
            ChatChannel = channels:FindFirstChild("RBXGeneral") or channels:FindFirstChildWhichIsA("TextChannel")
        end
    end)

    local function SendChatMessage()
        local message = tostring(ChatInput.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
        if message == "" then
            Notify(GetText("ChatEmpty"))
            return
        end
        if message:sub(1,1) == ':' and type(_G.ResetHubChatCommand) == 'function' then
            local handled = false
            pcall(function() handled = _G.ResetHubChatCommand(message) end)
            AddChatMessage('Reset Hub', handled and ('[CMD] ' .. message) or ('[UNKNOWN CMD] ' .. message))
            ChatInput.Text = ''
            return
        end
        ChatChannel = ChatChannel or TextChatService:FindFirstChild("TextChannels") and (TextChatService.TextChannels:FindFirstChild("RBXGeneral") or TextChatService.TextChannels:FindFirstChildWhichIsA("TextChannel"))
        if ChatChannel then
            local ok = pcall(function()
                ChatChannel:SendAsync(message)
            end)
            if ok then
                ChatInput.Text = ""
            else
                Notify(GetText("ChatUnavailable"))
            end
        else
            Notify(GetText("ChatUnavailable"))
        end
    end

    ChatSendButton.MouseEnter:Connect(function()
        TweenService:Create(ChatSendButton, TweenInfo.new(0.12), {BackgroundTransparency = 0.12}):Play()
    end)
    ChatSendButton.MouseLeave:Connect(function()
        TweenService:Create(ChatSendButton, TweenInfo.new(0.12), {BackgroundTransparency = 0}):Play()
    end)
    ChatSendButton.MouseButton1Click:Connect(SendChatMessage)
    ChatInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            SendChatMessage()
        end
    end)

    pcall(function()
        TextChatService.MessageReceived:Connect(function(message)
            local prefix = message.PrefixText or ""
            local textValue = message.Text or ""
            if textValue ~= "" then
                AddChatMessage(prefix, textValue)
                task.defer(function()
                    ChatLog.CanvasPosition = Vector2.new(0, math.max(0, ChatLog.AbsoluteCanvasSize.Y))
                end)
            end
        end)
    end)

    AddChatMessage("Reset Hub", "Chat is ready.")
end

-----------------------------------------------------------
-- 1. COMBAT & AIMBOT (HEAVY FOCUS)
-----------------------------------------------------------
_G.ResetHubSelectedPlayerName = _G.ResetHubSelectedPlayerName or nil

local function ResolveResetHubPlayer(token)
    token = tostring(token or ''):gsub('^%s+', ''):gsub('%s+$', '')
    if token == '' then return nil end
    local lower = string.lower(token)
    local exactName, exactDisplay, partial
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local name = string.lower(player.Name or '')
            local display = string.lower(player.DisplayName or '')
            if name == lower then exactName = player break end
            if display == lower then exactDisplay = player end
            if not partial and (name:find(lower, 1, true) or display:find(lower, 1, true)) then partial = player end
        end
    end
    return exactName or exactDisplay or partial
end

local function GetSelectedResetHubPlayer()
    if not _G.ResetHubSelectedPlayerName then return nil end
    local player = ResolveResetHubPlayer(_G.ResetHubSelectedPlayerName)
    if player then _G.ResetHubSelectedPlayerName = player.Name end
    return player
end

local function GetSelectedResetHubTargetPart()
    local player = GetSelectedResetHubPlayer()
    if not player or not IsEnemyPlayer(player) then return nil, nil end
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass('Humanoid')
    if not hum or hum.Health <= 0 then return nil, player end
    return char:FindFirstChild('Head') or char:FindFirstChild('HumanoidRootPart'), player
end

local function GetNearestCombatTarget(maxDistance)
    local root = GetRoot()
    local bestPart, bestPlayer, bestDistance = nil, nil, math.huge
    local limit = tonumber(maxDistance) or 60
    for _, player in ipairs(Players:GetPlayers()) do
        if IsEnemyPlayer(player) and player.Character then
            local hum = player.Character:FindFirstChildOfClass('Humanoid')
            local part = player.Character:FindFirstChild('HumanoidRootPart') or player.Character:FindFirstChild('Head')
            if hum and hum.Health > 0 and part and root then
                local d = (part.Position - root.Position).Magnitude
                if d <= limit and d < bestDistance then
                    bestDistance, bestPart, bestPlayer = d, part, player
                end
            end
        end
    end
    return bestPart, bestPlayer, bestDistance
end

do
    if type(hookmetamethod) == 'function' and type(newcclosure) == 'function' then
        local oldIndex
        local ok = pcall(function()
            oldIndex = hookmetamethod(Mouse, '__index', newcclosure(function(self, key)
                local caller = false
                if type(checkcaller) == 'function' then pcall(function() caller = checkcaller() end) end
                if self == Mouse and not caller and _G.SilentAimEnabled then
                    local target = _G.ResetHubSilentAimTarget
                    if target and target.Parent then
                        if key == 'Target' then return target end
                        if key == 'Hit' then return target.CFrame end
                        if key == 'UnitRay' then
                            local origin = (workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position) or target.Position
                            local delta = target.Position - origin
                            if delta.Magnitude > 0.001 then
                                return Ray.new(origin, delta.Unit)
                            end
                        end
                    end
                end
                return oldIndex(self, key)
            end))
        end)
        if ok and type(oldIndex) == 'function' then
            _G.ResetHubSilentAimHookInstalled = true
        end
    end
end

local function GetCombatTarget()
    local cam = workspace.CurrentCamera or Camera
    local localChar = GetCharacter()
    local localRoot = GetRoot()
    if not cam or not localChar then return nil, nil end

    local nearestMode = FeatureState.AimNearest == true
    local lockMode = FeatureState.AutoTarget == true
    local selectedPart, selectedPlayer = GetSelectedResetHubTargetPart()
    if selectedPart and selectedPlayer then
        if lockMode then FeatureState.LockedTarget = selectedPart end
        return selectedPart, selectedPlayer
    end
    local mousePos = UserInputService:GetMouseLocation()
    local fov = math.max(25, tonumber(_G.AimbotFOV) or 150)
    local bestScore = math.huge
    local bestPart = nil
    local bestPlayer = nil

    if lockMode and FeatureState.LockedTarget then
        local locked = FeatureState.LockedTarget
        local model = locked and locked:FindFirstAncestorOfClass('Model')
        local player = model and Players:GetPlayerFromCharacter(model)
        local hum = model and model:FindFirstChildOfClass('Humanoid')
        if locked and locked:IsA('BasePart') and player and IsEnemyPlayer(player) and hum and hum.Health > 0 then
            return locked, player
        end
        FeatureState.LockedTarget = nil
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if IsEnemyPlayer(player) and player.Character then
            local hum = player.Character:FindFirstChildOfClass('Humanoid')
            local head = player.Character:FindFirstChild('Head')
            local root = player.Character:FindFirstChild('HumanoidRootPart')
            local part = (FeatureState.AimBody and root) or head or root
            if part and hum and hum.Health > 0 then
                local score
                if nearestMode and localRoot then
                    score = (part.Position - localRoot.Position).Magnitude
                else
                    local viewport, visible = cam:WorldToViewportPoint(part.Position)
                    if visible and viewport.Z > 0 then
                        score = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(viewport.X, viewport.Y)).Magnitude
                        if score > fov then score = nil end
                    end
                end
                if score and score < bestScore then
                    bestScore = score
                    bestPart = part
                    bestPlayer = player
                end
            end
        end
    end

    if lockMode and bestPart then
        FeatureState.LockedTarget = bestPart
    end

    -- When a combat feature is enabled but the target is outside the FOV/on-screen
    -- region, fall back to the nearest live player so the feature does not appear
    -- completely inactive. Explicitly selected targets still have priority above.
    if not bestPart and (_G.SilentAimEnabled or _G.AimbotEnabled or FeatureState.AimNearest or FeatureState.AutoTarget) then
        bestPart, bestPlayer = GetNearestCombatTarget(250)
        if lockMode and bestPart then
            FeatureState.LockedTarget = bestPart
        end
    end
    return bestPart, bestPlayer
end

ResetCombatTargetState = function()
    FeatureState.LockedTarget = nil
    FeatureState.SilentAimTarget = nil
    FeatureState.SilentAimPlayer = nil
    _G.ResetHubSilentAimTarget = nil
    _G.ResetHubSilentAimPlayer = nil
    FeatureState.TriggerbotNextFire = 0
    FeatureState.KillAuraNext = 0
end

AddButton(TabCombat, "Aimbot", function()
    _G.AimbotEnabled = not _G.AimbotEnabled
    if not _G.AimbotEnabled and not FeatureState.AimNearest and not FeatureState.AutoTarget then
        ResetCombatTargetState()
    end
end)

AddButton(TabCombat, "SilentAim", function()
    _G.SilentAimEnabled = not _G.SilentAimEnabled
    if _G.SilentAimEnabled then
        local part, player = GetCombatTarget()
        _G.ResetHubSilentAimTarget = part
        _G.ResetHubSilentAimPlayer = player
        FeatureState.SilentAimTarget = part
        FeatureState.SilentAimPlayer = player
    else
        _G.ResetHubSilentAimTarget = nil
        _G.ResetHubSilentAimPlayer = nil
        FeatureState.SilentAimTarget = nil
        FeatureState.SilentAimPlayer = nil
    end
end)

AddButton(TabCombat, "Triggerbot", function()
    _G.TriggerbotEnabled = not _G.TriggerbotEnabled
    if not _G.TriggerbotEnabled then
        FeatureState.TriggerbotNextFire = 0
    end
end)

AddButton(TabCombat, "KillAura", function()
    _G.KillAuraEnabled = not _G.KillAuraEnabled
    if not _G.KillAuraEnabled then
        FeatureState.KillAuraNext = 0
    end
end)

AddSlider(TabCombat, "HitboxSize", 2, 40, 2, function(val)
    _G.HitboxSize = val
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local root = p.Character:FindFirstChild('HumanoidRootPart')
            if root and IsEnemyPlayer(p) then
                pcall(function()
                    root.Size = Vector3.new(val, val, val)
                    root.Transparency = math.clamp(0.82 - (val / 200), 0, 0.82)
                    root.CanCollide = false
                end)
            end
        end
    end
end)

ReachOriginal = ReachOriginal or setmetatable({}, {__mode = 'k'})
AddButton(TabCombat, "Reach", function()
    local char = GetCharacter()
    local hand = char and (char:FindFirstChild('RightHand') or char:FindFirstChild('Right Arm'))
    if not hand or not hand:IsA('BasePart') then return end
    if ReachOriginal[hand] == nil then
        ReachOriginal[hand] = hand.Size
        hand.Size = Vector3.new(2, 20, 2)
    else
        hand.Size = ReachOriginal[hand]
        ReachOriginal[hand] = nil
    end
end)

AddButton(TabCombat, "AntiKnockback", function()
    FeatureState.AntiKnockback = not FeatureState.AntiKnockback
    SetFeatureConnection('AntiKnockback', false)
    if FeatureState.AntiKnockback then
        SetFeatureConnection('AntiKnockback', true, RunService.Heartbeat, function()
            local root = GetRoot()
            if not root then return end
            local v = root.AssemblyLinearVelocity
            if v.Magnitude > 0 then
                root.AssemblyLinearVelocity = Vector3.new(0, v.Y, 0)
            end
        end)
    end
end)

AddButton(TabCombat, "TargetStrafe", function()
    _G.TargetStrafe = not _G.TargetStrafe
    SetFeatureConnection('TargetStrafe', _G.TargetStrafe, RunService.Heartbeat, function()
        local root = GetRoot()
        if not root then return end
        local nearest, dist = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if IsEnemyPlayer(p) then
                local pr = p.Character and p.Character:FindFirstChild('HumanoidRootPart')
                if pr then
                    local d = (pr.Position - root.Position).Magnitude
                    if d < dist then dist, nearest = d, p end
                end
            end
        end
        if nearest then
            local pr = nearest.Character and nearest.Character:FindFirstChild('HumanoidRootPart')
            if pr then
                local angle = os.clock() * 2.7
                pcall(function()
                    root.CFrame = CFrame.lookAt(pr.Position + Vector3.new(math.cos(angle) * 7, 2, math.sin(angle) * 7), pr.Position)
                end)
            end
        end
    end)
end)

AddButton(TabCombat, "ShowFOV", function()
    _G.ShowFOVCircle = not _G.ShowFOVCircle
end)

AddSlider(TabCombat, "AimbotFOV", 50, 600, 150, function(val)
    _G.AimbotFOV = val
end)

AddSlider(TabCombat, "AimbotSmooth", 1, 10, 2, function(val)
    -- 1 = very smooth, 10 = fastest lock. Convert consistently for the camera loop.
    _G.AimbotSmoothness = math.clamp(val / 10, 0.02, 1)
end)

function ResetHubCombatClick()
    if type(mouse1click) == 'function' then
        local ok = pcall(mouse1click)
        if ok then return true end
    end
    if type(mouse1press) == 'function' and type(mouse1release) == 'function' then
        local ok = pcall(function()
            mouse1press()
            task.wait(0.01)
            mouse1release()
        end)
        if ok then return true end
    end
    local ok, vim = pcall(function() return game:GetService('VirtualInputManager') end)
    if ok and vim then
        local pos = UserInputService:GetMouseLocation()
        local sent = pcall(function()
            vim:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
            vim:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)
        end)
        if sent then return true end
    end
    return false
end

FOVCircleFrame = Instance.new('Frame')
FOVCircleFrame.Name = 'FOVCircle'
FOVCircleFrame.ZIndex = 200
FOVCircleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircleFrame.BackgroundTransparency = 1
FOVCircleFrame.Parent = ScreenGui
FOVCircleFrame.Visible = false

FOVStroke = Instance.new('UIStroke')
FOVStroke.Thickness = 1.5
FOVStroke.Color = Color3.fromRGB(255, 50, 50)
FOVStroke.Parent = FOVCircleFrame

FOVCorner = Instance.new('UICorner')
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircleFrame

pcall(function() RunService:UnbindFromRenderStep('ResetHub_CombatLoop') end)
SetFeatureConnection('CombatCore', false)
SetFeatureConnection('CombatCore', true, RunService.RenderStepped, function(dt)
    local ok = pcall(function()
        Camera = workspace.CurrentCamera or Camera
        if not Camera then return end

        if FOVCircleFrame and FOVCircleFrame.Parent then
            FOVCircleFrame.Visible = _G.ShowFOVCircle == true
            if FOVCircleFrame.Visible then
                local f = math.max(25, tonumber(_G.AimbotFOV) or 150)
                FOVCircleFrame.Size = UDim2.fromOffset(f * 2, f * 2)
                local mousePos = UserInputService:GetMouseLocation()
                FOVCircleFrame.Position = UDim2.fromOffset(mousePos.X, mousePos.Y)
            end
        end

        local localChar = GetCharacter()
        local localRoot = GetRoot()
        local aimingActive = (_G.AimbotEnabled or FeatureState.AimNearest or FeatureState.AutoTarget) == true
        local target, targetPlayer
        if aimingActive then
            target, targetPlayer = GetCombatTarget()
        end

        if not aimingActive then
            FeatureState.LockedTarget = nil
        end

        if aimingActive and target and target.Parent then
            local smooth = math.clamp(tonumber(_G.AimbotSmoothness) or 0.2, 0.02, 1)
            local frameDt = math.clamp(tonumber(dt) or (1/60), 1/240, 1/20)
            local alpha = 1 - math.exp(-smooth * 12 * frameDt)
            local desired = CFrame.lookAt(Camera.CFrame.Position, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(desired, alpha)
        end

        if _G.TriggerbotEnabled and localChar then
            local hitPart = Mouse.Target
            local cam = workspace.CurrentCamera or Camera
            if not hitPart and cam then
                local mousePos = UserInputService:GetMouseLocation()
                local ray = cam:ScreenPointToRay(mousePos.X, mousePos.Y)
                local params = RaycastParams.new()
                params.FilterType = Enum.RaycastFilterType.Exclude
                params.FilterDescendantsInstances = {localChar}
                params.IgnoreWater = true
                local result = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
                if result then hitPart = result.Instance end
            end

            local model = hitPart and hitPart:FindFirstAncestorOfClass('Model')
            local hum = model and model:FindFirstChildOfClass('Humanoid')
            local targetPlayer = model and Players:GetPlayerFromCharacter(model)
            local valid = model and model ~= localChar and hum and hum.Health > 0 and targetPlayer and IsEnemyPlayer(targetPlayer)

            if valid then
                local now = os.clock()
                if now >= (FeatureState.TriggerbotNextFire or 0) then
                    FeatureState.TriggerbotNextFire = now + 0.09
                    local tool = localChar:FindFirstChildOfClass('Tool')
                    local humLocal = localChar:FindFirstChildOfClass('Humanoid')
                    if not tool and humLocal then
                        local backpack = LocalPlayer:FindFirstChildOfClass('Backpack')
                        local candidate = backpack and backpack:FindFirstChildOfClass('Tool')
                        if candidate then
                            pcall(function() humLocal:EquipTool(candidate) end)
                            task.wait()
                            tool = localChar:FindFirstChildOfClass('Tool') or candidate
                        end
                    end
                    local activated = false
                    if tool then activated = pcall(function() tool:Activate() end) end
                    if not activated then pcall(ResetHubCombatClick) end
                end
            end
        end

        if _G.SilentAimEnabled and localChar and localRoot then
            local silentPart, silentPlayer = GetSelectedResetHubTargetPart()
            if not silentPart then
                silentPart, silentPlayer = GetCombatTarget()
            end
            if not silentPart then
                silentPart, silentPlayer = GetNearestCombatTarget(250)
            end
            if silentPart and silentPart.Parent then
                FeatureState.SilentAimTarget = silentPart
                FeatureState.SilentAimPlayer = silentPlayer
                _G.ResetHubSilentAimTarget = silentPart
                _G.ResetHubSilentAimPlayer = silentPlayer
            else
                FeatureState.SilentAimTarget = nil
                FeatureState.SilentAimPlayer = nil
                _G.ResetHubSilentAimTarget = nil
                _G.ResetHubSilentAimPlayer = nil
            end
        else
            FeatureState.SilentAimTarget = nil
            FeatureState.SilentAimPlayer = nil
            _G.ResetHubSilentAimTarget = nil
            _G.ResetHubSilentAimPlayer = nil
        end

        if _G.KillAuraEnabled and localRoot and localChar then
            local tool = localChar:FindFirstChildOfClass('Tool')
            local hum = localChar:FindFirstChildOfClass('Humanoid')
            if not tool and hum then
                local backpack = LocalPlayer:FindFirstChildOfClass('Backpack')
                local candidate = backpack and backpack:FindFirstChildOfClass('Tool')
                if candidate then
                    pcall(function() hum:EquipTool(candidate) end)
                    tool = candidate
                end
            end
            if tool then
                local bestEnemy, bestDistance = nil, math.huge
                local selectedEnemy = GetSelectedResetHubPlayer()
                if selectedEnemy and IsEnemyPlayer(selectedEnemy) then
                    local er = selectedEnemy.Character and selectedEnemy.Character:FindFirstChild('HumanoidRootPart')
                    if er then
                        bestEnemy = selectedEnemy
                        bestDistance = (er.Position - localRoot.Position).Magnitude
                    end
                else
                    for _, player in ipairs(Players:GetPlayers()) do
                        if IsEnemyPlayer(player) then
                            local er = player.Character and player.Character:FindFirstChild('HumanoidRootPart')
                            local eh = player.Character and player.Character:FindFirstChildOfClass('Humanoid')
                            if er and eh and eh.Health > 0 then
                                local d = (er.Position - localRoot.Position).Magnitude
                                if d <= 24 and d < bestDistance then
                                    bestDistance, bestEnemy = d, player
                                end
                            end
                        end
                    end
                end
                if bestEnemy and bestDistance <= 24 then
                    local now = os.clock()
                    if now >= (FeatureState.KillAuraNext or 0) then
                        FeatureState.KillAuraNext = now + 0.12
                        if tool.Parent ~= localChar then
                            pcall(function() hum:EquipTool(tool) end)
                            task.wait()
                        end
                        local activeTool = localChar:FindFirstChildOfClass('Tool') or tool
                        local activated = pcall(function() activeTool:Activate() end)
                        if not activated then pcall(ResetHubCombatClick) end
                    end
                end
            end
        end

    end)
    if not ok then
        -- Keep the shared combat loop alive even if a game-specific callback errors.
    end
end)

AddFeatureButton(TabCombat, 'Aim Nearest', function()
    FeatureState.AimNearest = not FeatureState.AimNearest
    if not FeatureState.AimNearest and not _G.AimbotEnabled and not FeatureState.AutoTarget then
        ResetCombatTargetState()
    end
end)

AddFeatureButton(TabCombat, 'Aim Body', function()
    FeatureState.AimBody = not FeatureState.AimBody
    if FeatureState.LockedTarget then
        local part, player = GetCombatTarget()
        if part and player then
            FeatureState.LockedTarget = part
        end
    end
end)

AddFeatureButton(TabCombat, 'Auto Target Lock', function()
    FeatureState.AutoTarget = not FeatureState.AutoTarget
    FeatureState.LockedTarget = nil
    if not FeatureState.AutoTarget and not _G.AimbotEnabled and not FeatureState.AimNearest then
        ResetCombatTargetState()
    end
end)


AddFeatureButton(TabCombat, 'Velocity Guard', function()
    FeatureState.VelocityGuard = not FeatureState.VelocityGuard
end)

AddFeatureButton(TabCombat, 'Horizontal Velocity Lock', function()
    FeatureState.HorizontalVelocity = not FeatureState.HorizontalVelocity
    SetFeatureConnection('HorizontalVelocity', FeatureState.HorizontalVelocity, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then
            local v = root.AssemblyLinearVelocity
            local h = Vector3.new(v.X, 0, v.Z)
            if h.Magnitude > 18 then root.AssemblyLinearVelocity = Vector3.new(0, v.Y, 0) end
        end
    end)
end)

AddFeatureButton(TabCombat, 'Vertical Velocity Lock', function()
    FeatureState.VerticalVelocity = not FeatureState.VerticalVelocity
    SetFeatureConnection('VerticalVelocity', FeatureState.VerticalVelocity, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then
            local v = root.AssemblyLinearVelocity
            if math.abs(v.Y) > 32 then root.AssemblyLinearVelocity = Vector3.new(v.X, 0, v.Z) end
        end
    end)
end)

AddFeatureButton(TabCombat, 'Zero Velocity Pulse', function()
    local root = GetRoot()
    if root then root.AssemblyLinearVelocity = Vector3.zero end
end)

AddFeatureSlider(TabCombat, 'Velocity Multiplier', 0, 100, 15, function(val) _G.VelocityMultiplier = val / 100 end)
AddFeatureSlider(TabCombat, 'Velocity Vertical %', 0, 100, 85, function(val) _G.VelocityVertical = val / 100 end)
AddFeatureButton(TabCombat, 'Velocity Threshold Reset', function()
    _G.VelocityThreshold = ((_G.VelocityThreshold or 24) == 24) and 10 or 24
end)

-----------------------------------------------------------
-- 2. MOVEMENT & PHYSICS
-----------------------------------------------------------
AddSlider(TabMove, "Speed", 16, 250, 16, function(val)
    _G.WalkSpeedValue = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

AddSlider(TabMove, "Jump", 50, 300, 50, function(val)
    _G.JumpPowerValue = val
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.UseJumpPower = true
        LocalPlayer.Character.Humanoid.JumpPower = val
    end
end)

AddSlider(TabMove, "FlySpeed", 20, 200, 50, function(val)
    _G.FlySpeedValue = val
end)

local function CleanupQFly()
    _G.IsFlying = false
    local hrp = GetRoot()
    if hrp then
        for _, obj in ipairs(hrp:GetChildren()) do
            if obj.Name == "QFlyVel" or obj.Name == "QFlyGyro" or obj.Name == "QFlyAttachment" then
                pcall(function() obj:Destroy() end)
            end
        end
    end
end

local function StartQFly()
    if _G.IsFlying then return true end
    local char = GetCharacter()
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not char or not hrp or not hum or hum.Health <= 0 then return false end

    CleanupQFly()
    _G.IsFlying = true

    local att, lv, ao, bodyVelocity, bodyGyro
    local okModern = pcall(function()
        att = Instance.new("Attachment")
        att.Name = "QFlyAttachment"
        att.Parent = hrp

        lv = Instance.new("LinearVelocity")
        lv.Name = "QFlyVel"
        lv.Attachment0 = att
        lv.RelativeTo = Enum.ActuatorRelativeTo.World
        lv.MaxForce = math.huge
        lv.VectorVelocity = Vector3.zero
        lv.Parent = hrp

        ao = Instance.new("AlignOrientation")
        ao.Name = "QFlyGyro"
        ao.Mode = Enum.OrientationAlignmentMode.OneAttachment
        ao.Attachment0 = att
        ao.MaxTorque = math.huge
        ao.Responsiveness = 200
        ao.RigidityEnabled = false
        ao.Parent = hrp
    end)

    if not okModern then
        if lv and lv.Parent then lv:Destroy() end
        if ao and ao.Parent then ao:Destroy() end
        if att and att.Parent then att:Destroy() end
        att, lv, ao = nil, nil, nil
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Name = "QFlyVel"
        bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = hrp
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.Name = "QFlyGyro"
        bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bodyGyro.P = 25000
        bodyGyro.Parent = hrp
    end

    task.spawn(function()
        while _G.QFlyEnabled and _G.IsFlying and char.Parent and hrp.Parent and _G.ResetHubSession == ResetHubSession do
            Camera = workspace.CurrentCamera or Camera
            local look = Camera.CFrame.LookVector
            local right = Camera.CFrame.RightVector
            local flatLook = Vector3.new(look.X, 0, look.Z)
            local flatRight = Vector3.new(right.X, 0, right.Z)
            if flatLook.Magnitude > 0.001 then flatLook = flatLook.Unit end
            if flatRight.Magnitude > 0.001 then flatRight = flatRight.Unit end

            local moveDir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + flatLook end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - flatLook end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - flatRight end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + flatRight end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end

            local speed = math.clamp(tonumber(_G.FlySpeedValue) or 50, 10, 300)
            local velocity = moveDir.Magnitude > 0.01 and moveDir.Unit * speed or Vector3.zero
            if lv and lv.Parent then lv.VectorVelocity = velocity end
            if bodyVelocity and bodyVelocity.Parent then bodyVelocity.Velocity = velocity end

            local flatCameraLook = Vector3.new(look.X, 0, look.Z)
            if flatCameraLook.Magnitude > 0.001 then
                local facing = CFrame.lookAt(Vector3.zero, flatCameraLook.Unit)
                if ao and ao.Parent then ao.CFrame = facing end
                if bodyGyro and bodyGyro.Parent then bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + flatCameraLook.Unit) end
            end
            RunService.RenderStepped:Wait()
        end
        if lv and lv.Parent then lv:Destroy() end
        if ao and ao.Parent then ao:Destroy() end
        if att and att.Parent then att:Destroy() end
        if bodyVelocity and bodyVelocity.Parent then bodyVelocity:Destroy() end
        if bodyGyro and bodyGyro.Parent then bodyGyro:Destroy() end
        _G.IsFlying = false
    end)
    return true
end

local function ToggleQFly()
    _G.QFlyEnabled = not _G.QFlyEnabled
    if _G.QFlyEnabled then
        StartQFly()
    else
        CleanupQFly()
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.defer(function()
        if _G.QFlyEnabled then
            task.wait(0.2)
            StartQFly()
        end
    end)
    if ActiveFlingConnection then
        pcall(function() ActiveFlingConnection:Disconnect() end)
        ActiveFlingConnection = nil
    end
    ActiveFlingCanCollide = nil
end)

AddButton(TabMove, "QFly", function()
    ToggleQFly()
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe or input.KeyCode ~= Enum.KeyCode.Q then return end

    -- Q is reserved for QFly. Stop any stale auto-click loop first.
    _G.ResetHubAutoClickerActive = false
    if type(AutomationTokens) == "table" then
        AutomationTokens.FastAutoClicker = (AutomationTokens.FastAutoClicker or 0) + 1
    end

    if _G.IsFlying then
        CleanupQFly()
    else
        _G.QFlyEnabled = true
        StartQFly()
    end
end)

AddButton(TabMove, "InfJump", function()
    _G.InfJump = not _G.InfJump
    if not _G.InfJumpConn then
        _G.InfJumpConn = UserInputService.JumpRequest:Connect(function()
            if _G.InfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end)

OriginalCollisionStates = setmetatable({}, {__mode = "k"})
NoclipWasEnabled = false
local function RestoreCharacterCollision()
    local char = GetCharacter()
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local old = OriginalCollisionStates[part]
            if old ~= nil then
                part.CanCollide = old
                OriginalCollisionStates[part] = nil
            end
        end
    end
end

AddButton(TabMove, "Noclip", function()
    _G.NoclipEnabled = not _G.NoclipEnabled
    if not _G.NoclipEnabled then RestoreCharacterCollision() end
end)

RunService.Stepped:Connect(function()
    if _G.ResetHubSession ~= ResetHubSession then return end
    local char = GetCharacter()
    if not char then return end
    if _G.NoclipEnabled then
        NoclipWasEnabled = true
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                if OriginalCollisionStates[part] == nil then OriginalCollisionStates[part] = part.CanCollide end
                part.CanCollide = false
            end
        end
    elseif NoclipWasEnabled then
        NoclipWasEnabled = false
        RestoreCharacterCollision()
    end
end)

AddButton(TabMove, "MoonGravity", function()
    workspace.Gravity = workspace.Gravity == 40 and OriginalGravity or 40
end)

AddButton(TabMove, "UnderMap", function()
    local root = GetRoot()
    if root then
        local destroyY = workspace.FallenPartsDestroyHeight or -500
        local targetY = destroyY + 50
        root.CFrame = CFrame.new(root.Position.X, targetY, root.Position.Z)
        root.AssemblyLinearVelocity = Vector3.zero
    end
end)



-- ---------------------------------------------------------
-- MOVEMENT EXTENSIONS: 15+ total movement controls
-- ---------------------------------------------------------
AddFeatureButton(TabMove, 'Speed Lock', function()
    FeatureState.SpeedLock = not FeatureState.SpeedLock
    SetFeatureConnection('SpeedLockHeartbeat', false)
    SetFeatureConnection('SpeedLockChanged', false)
    if FeatureState.SpeedLock then
        local hum = GetHumanoid()
        FeatureState.LockedSpeed = math.clamp(tonumber(FeatureState.LockedSpeed) or (hum and hum.WalkSpeed) or tonumber(_G.WalkSpeedValue) or 16, 1, 500)
        local function apply()
            if not FeatureState.SpeedLock then return end
            local current = GetHumanoid()
            if not current or current.Health <= 0 then return end
            local value = math.clamp(tonumber(FeatureState.LockedSpeed) or tonumber(_G.WalkSpeedValue) or 16, 1, 500)
            pcall(function() current.WalkSpeed = value end)
        end
        apply()
        SetFeatureConnection('SpeedLockHeartbeat', true, RunService.Heartbeat, apply)
        local current = GetHumanoid()
        if current then
            SetFeatureConnection('SpeedLockChanged', true, current:GetPropertyChangedSignal('WalkSpeed'), apply)
        end
    else
        FeatureState.LockedSpeed = nil
    end
end)

SetFeatureConnection('SpeedLockRespawn', true, LocalPlayer.CharacterAdded, function(char)
    if not FeatureState.SpeedLock then return end
    task.defer(function()
        local hum = char:FindFirstChildOfClass('Humanoid') or char:WaitForChild('Humanoid', 5)
        if not hum or not FeatureState.SpeedLock then return end
        pcall(function() hum.WalkSpeed = math.clamp(tonumber(FeatureState.LockedSpeed) or tonumber(_G.WalkSpeedValue) or 16, 1, 500) end)
        SetFeatureConnection('SpeedLockChanged', true, hum:GetPropertyChangedSignal('WalkSpeed'), function()
            if FeatureState.SpeedLock then
                pcall(function() hum.WalkSpeed = math.clamp(tonumber(FeatureState.LockedSpeed) or tonumber(_G.WalkSpeedValue) or 16, 1, 500) end)
            end
        end)
    end)
end)

AddFeatureButton(TabMove, 'Jump Lock', function()
    FeatureState.JumpLock = not FeatureState.JumpLock
    SetFeatureConnection('JumpLock', false)
    if FeatureState.JumpLock then
        local hum = GetHumanoid()
        FeatureState.LockedJumpPower = math.clamp(tonumber(FeatureState.LockedJumpPower) or (hum and hum.JumpPower) or tonumber(_G.JumpPowerValue) or 50, 1, 500)
        SetFeatureConnection('JumpLock', true, RunService.Heartbeat, function()
            if not FeatureState.JumpLock then return end
            local current = GetHumanoid()
            if current and current.Health > 0 then
                pcall(function()
                    current.UseJumpPower = true
                    current.JumpPower = math.clamp(tonumber(FeatureState.LockedJumpPower) or tonumber(_G.JumpPowerValue) or 50, 1, 500)
                end)
            end
        end)
    else
        FeatureState.LockedJumpPower = nil
    end
end)

SetFeatureConnection('JumpLockRespawn', true, LocalPlayer.CharacterAdded, function(char)
    if not FeatureState.JumpLock then return end
    task.defer(function()
        local hum = char:FindFirstChildOfClass('Humanoid') or char:WaitForChild('Humanoid', 5)
        if hum and FeatureState.JumpLock then
            pcall(function()
                hum.UseJumpPower = true
                hum.JumpPower = math.clamp(tonumber(FeatureState.LockedJumpPower) or tonumber(_G.JumpPowerValue) or 50, 1, 500)
            end)
        end
    end)
end)

AddFeatureButton(TabMove, 'Bunny Hop', function()
    FeatureState.BunnyHop = not FeatureState.BunnyHop
    SetFeatureConnection('BunnyHop', false)
    if FeatureState.BunnyHop then
        FeatureState.BunnyHopNext = 0
        SetFeatureConnection('BunnyHop', true, RunService.RenderStepped, function()
            local hum = GetHumanoid()
            if not hum or hum.Health <= 0 or hum.MoveDirection.Magnitude <= 0.05 then return end
            local state = hum:GetState()
            local grounded = hum.FloorMaterial ~= Enum.Material.Air or state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.RunningNoPhysics or state == Enum.HumanoidStateType.Landed
            if not grounded then return end
            local now = os.clock()
            if now < (FeatureState.BunnyHopNext or 0) then return end
            FeatureState.BunnyHopNext = now + 0.055
            pcall(function() hum.Jump = true end)
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end)
    end
end)

AddFeatureButton(TabMove, 'CFrame Speed', function()
    FeatureState.CFrameSpeed = not FeatureState.CFrameSpeed
    SetFeatureConnection('CFrameSpeed', FeatureState.CFrameSpeed, RunService.Heartbeat, function(dt)
        local root = GetRoot()
        local hum = GetHumanoid()
        if not root or not hum or hum.Health <= 0 then return end
        local dir = hum.MoveDirection
        if dir.Magnitude > 0.01 then
            local speed = math.clamp(tonumber(_G.WalkSpeedValue) or 16, 16, 250)
            root.CFrame = root.CFrame + dir.Unit * speed * math.clamp(dt or 0.016, 0, 0.05)
        end
    end)
end)

AddFeatureButton(TabMove, 'Dash', function()
    local root = GetRoot()
    local hum = GetHumanoid()
    if not root then return end
    Camera = workspace.CurrentCamera or Camera
    local dir = hum and hum.MoveDirection or Vector3.zero
    if dir.Magnitude < 0.01 then dir = Camera.CFrame.LookVector end
    local flat = Vector3.new(dir.X, 0, dir.Z)
    if flat.Magnitude < 0.01 then
        local look = Camera.CFrame.LookVector
        flat = Vector3.new(look.X, 0, look.Z)
    end
    if flat.Magnitude < 0.01 then return end
    flat = flat.Unit
    local power = math.clamp(tonumber(_G.DashPower) or 120, 20, 300)
    local currentY = root.AssemblyLinearVelocity.Y
    root.AssemblyLinearVelocity = Vector3.new(flat.X * power, math.max(currentY, 8), flat.Z * power)
    pcall(function() root:ApplyImpulse(flat * power * root.AssemblyMass * 0.25) end)
end)

AddFeatureButton(TabMove, 'Long Jump', function()
    local root = GetRoot()
    if root then
        local hum = GetHumanoid()
        local dir = hum and hum.MoveDirection or Camera.CFrame.LookVector
        if dir.Magnitude == 0 then dir = Camera.CFrame.LookVector end
        root.AssemblyLinearVelocity = Vector3.new(dir.X * 95, 85, dir.Z * 95)
    end
end)

AddFeatureButton(TabMove, 'Low Gravity Toggle', function()
    workspace.Gravity = workspace.Gravity == 60 and OriginalGravity or 60
end)

AddFeatureButton(TabMove, 'Air Walk', function()
    FeatureState.AirWalk = not FeatureState.AirWalk
    SetFeatureConnection('AirWalk', FeatureState.AirWalk, RunService.Heartbeat, function()
        local hum = GetHumanoid()
        local root = GetRoot()
        if hum and root and hum.FloorMaterial == Enum.Material.Air then
            root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z)
        end
    end)
end)

AddFeatureButton(TabMove, 'No Slow', function()
    FeatureState.NoSlow = not FeatureState.NoSlow
    SetFeatureConnection('NoSlow', false)
    SetFeatureConnection('NoSlowHeartbeat', false)
    SetFeatureConnection('NoSlowStepped', false)
    SetFeatureConnection('NoSlowChanged', false)
    if FeatureState.NoSlow then
        local enforceNoSlow = function()
            local hum = GetHumanoid()
            if hum and hum.Health > 0 then
                local target = math.max(1, tonumber(_G.WalkSpeedValue) or 16)
                if math.abs(hum.WalkSpeed - target) > 0.01 then
                    pcall(function() hum.WalkSpeed = target end)
                end
            end
        end
        SetFeatureConnection('NoSlow', true, RunService.RenderStepped, enforceNoSlow)
        SetFeatureConnection('NoSlowHeartbeat', true, RunService.Heartbeat, enforceNoSlow)
        SetFeatureConnection('NoSlowStepped', true, RunService.Stepped, enforceNoSlow)
        local hum = GetHumanoid()
        if hum then
            SetFeatureConnection('NoSlowChanged', true, hum:GetPropertyChangedSignal('WalkSpeed'), function()
                if FeatureState.NoSlow and hum.Parent and hum.Health > 0 then
                    pcall(function() hum.WalkSpeed = math.max(1, tonumber(_G.WalkSpeedValue) or 16) end)
                end
            end)
        end
    end
end)
SetFeatureConnection('NoSlowRespawn', true, LocalPlayer.CharacterAdded, function(char)
    task.defer(function()
        local hum = char:FindFirstChildOfClass('Humanoid') or char:WaitForChild('Humanoid',5)
        if hum and FeatureState.NoSlow then pcall(function() hum.WalkSpeed = math.max(1, tonumber(_G.WalkSpeedValue) or 16) end) end
    end)
end)

AddFeatureButton(TabMove, 'Spin Movement', function()
    FeatureState.SpinMovement = not FeatureState.SpinMovement
    if FeatureState.SpinMovement then
        FeatureState.SpinBot = false
        FeatureState.Spin = false
        SetFeatureConnection('SpinBot', false)
        SetFeatureConnection('SpinToggle', false)
    end
    SetFeatureConnection('SpinMovement', FeatureState.SpinMovement, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.new(0, 12, 0) end
    end)
    if not FeatureState.SpinMovement then
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.zero end
    end
end)

AddFeatureButton(TabMove, 'Anti Void', function()
    FeatureState.AntiVoid = not FeatureState.AntiVoid
    SetFeatureConnection('AntiVoid', FeatureState.AntiVoid, RunService.Heartbeat, function()
        local root = GetRoot()
        if root and root.Position.Y < -50 then
            if SavedPosition then
                root.CFrame = SavedPosition
            else
                root.CFrame = CFrame.new(root.Position.X, 10, root.Position.Z)
            end
        end
    end)
end)

AddFeatureButton(TabMove, 'Freeze In Place', function()
    FeatureState.Freeze = not FeatureState.Freeze
    SetFeatureConnection('Freeze', FeatureState.Freeze, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then root.AssemblyLinearVelocity = Vector3.zero end
    end)
end)

AddFeatureSlider(TabMove, 'Dash Power', 20, 200, 120, function(val)
    _G.DashPower = val
end)


-----------------------------------------------------------
-- 3. LOCAL PLAYER
-----------------------------------------------------------
AddButton(TabPlayer, "Godmode", function()
    FeatureState.Godmode = not FeatureState.Godmode
    SetFeatureConnection('Godmode', FeatureState.Godmode, RunService.Heartbeat, function()
        local hum = GetHumanoid()
        if hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, not FeatureState.Godmode)
            if FeatureState.Godmode and hum.Health > 0 and hum.Health < hum.MaxHealth then
                hum.Health = hum.MaxHealth
            end
        end
    end)
end)

AddButton(TabPlayer, "NoFall", function()
    FeatureState.NoFall = not FeatureState.NoFall
    SetFeatureConnection('NoFall', FeatureState.NoFall, RunService.Heartbeat, function()
        local hum = GetHumanoid()
        local root = GetRoot()
        if hum and root then
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not FeatureState.NoFall)
            local v = root.AssemblyLinearVelocity
            if FeatureState.NoFall and v.Y < -55 then
                root.AssemblyLinearVelocity = Vector3.new(v.X, -8, v.Z)
            end
        end
    end)
end)

AddButton(TabPlayer, "Headless", function()
    local head = GetHead()
    if head then head.Transparency = head.Transparency == 1 and 0 or 1 end
end)

AddButton(TabPlayer, "TinyMorph", function()
    if LocalPlayer.Character then LocalPlayer.Character:ScaleTo(0.5) end
end)

AddButton(TabPlayer, "BigMorph", function()
    if LocalPlayer.Character then LocalPlayer.Character:ScaleTo(2) end
end)

AddButton(TabPlayer, "AntiAFK", function()
    FeatureState.AntiAFK = not FeatureState.AntiAFK
    if FeatureConnections.AntiAFK then FeatureConnections.AntiAFK:Disconnect(); FeatureConnections.AntiAFK = nil end
    if FeatureState.AntiAFK then
        local vu = game:GetService("VirtualUser")
        FeatureConnections.AntiAFK = LocalPlayer.Idled:Connect(function()
            if FeatureState.AntiAFK then
                pcall(function()
                    vu:CaptureController()
                    vu:ClickButton2(Vector2.new())
                end)
            end
        end)
    end
end)



-- ---------------------------------------------------------
-- PLAYER EXTENSIONS: 15+ total player controls
-- ---------------------------------------------------------
AddFeatureButton(TabPlayer, 'Reset Character', function()
    local hum = GetHumanoid()
    if hum then hum.Health = 0 end
end)

AddFeatureButton(TabPlayer, 'Remove Tools', function()
    local char = GetCharacter()
    if char then
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA('Tool') then obj:Destroy() end
        end
    end
end)

AddFeatureButton(TabPlayer, 'Remove Accessories', function()
    local char = GetCharacter()
    if char then
        for _, obj in ipairs(char:GetChildren()) do
            if obj:IsA('Accessory') then obj:Destroy() end
        end
    end
end)

AddFeatureButton(TabPlayer, 'Hide Name', function()
    local hum = GetHumanoid()
    if hum then
        hum.DisplayDistanceType = (hum.DisplayDistanceType == Enum.HumanoidDisplayDistanceType.None) and Enum.HumanoidDisplayDistanceType.Viewer or Enum.HumanoidDisplayDistanceType.None
    end
end)

AddFeatureButton(TabPlayer, 'Force Sit / Stand', function()
    local hum = GetHumanoid()
    if not hum then return end
    if hum.Sit then
        hum.Sit = false
        hum.PlatformStand = false
        task.defer(function()
            if hum and hum.Parent then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
        end)
    else
        hum.Sit = true
    end
end)

AddFeatureButton(TabPlayer, 'Platform Stand', function()
    local hum = GetHumanoid()
    if hum then hum.PlatformStand = not hum.PlatformStand end
end)

OriginalCameraMode = LocalPlayer.CameraMode
OriginalCameraMinZoom = LocalPlayer.CameraMinZoomDistance
OriginalCameraMaxZoom = LocalPlayer.CameraMaxZoomDistance

AddFeatureButton(TabPlayer, 'Third Person Camera', function()
    FeatureState.ThirdPerson = not FeatureState.ThirdPerson
    SetFeatureConnection('ThirdPerson', false)
    if FeatureState.ThirdPerson then
        pcall(function() LocalPlayer.CameraMode = Enum.CameraMode.Classic end)
        pcall(function() LocalPlayer.CameraMinZoomDistance = math.max(8, OriginalCameraMinZoom) end)
        pcall(function() LocalPlayer.CameraMaxZoomDistance = math.max(80, OriginalCameraMaxZoom) end)
        SetFeatureConnection('ThirdPerson', true, RunService.RenderStepped, function()
            Camera = workspace.CurrentCamera or Camera
            local hum = GetHumanoid()
            if not hum then return end
            pcall(function() LocalPlayer.CameraMode = Enum.CameraMode.Classic end)
            pcall(function() LocalPlayer.CameraMinZoomDistance = math.max(8, OriginalCameraMinZoom) end)
            pcall(function() LocalPlayer.CameraMaxZoomDistance = math.max(80, OriginalCameraMaxZoom) end)
            if Camera.CameraType ~= Enum.CameraType.Custom then Camera.CameraType = Enum.CameraType.Custom end
            if Camera.CameraSubject ~= hum then Camera.CameraSubject = hum end
        end)
        Notify('Third Person: ON')
    else
        pcall(function() LocalPlayer.CameraMode = OriginalCameraMode end)
        pcall(function() LocalPlayer.CameraMinZoomDistance = OriginalCameraMinZoom end)
        pcall(function() LocalPlayer.CameraMaxZoomDistance = OriginalCameraMaxZoom end)
        Camera = workspace.CurrentCamera or Camera
        pcall(function() Camera.CameraType = SavedCameraType or Enum.CameraType.Custom end)
        pcall(function() Camera.CameraSubject = SavedCameraSubject or GetHumanoid() end)
        Notify('Third Person: OFF')
    end
end)

AddFeatureButton(TabPlayer, 'First Person Camera', function()
    LocalPlayer.CameraMode = (LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson) and Enum.CameraMode.Classic or Enum.CameraMode.LockFirstPerson
end)

AddFeatureButton(TabPlayer, 'Freeze Character', function()
    local root = GetRoot()
    if root then root.Anchored = not root.Anchored end
end)

AddFeatureButton(TabPlayer, 'Hide Character Locally', function()
    local char = GetCharacter()
    if not char then return end
    FeatureState.LocalHidden = not FeatureState.LocalHidden
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA('BasePart') then part.LocalTransparencyModifier = FeatureState.LocalHidden and 1 or 0 end
    end
end)

AddFeatureButton(TabPlayer, 'No Sit', function()
    FeatureState.NoSit = not FeatureState.NoSit
    SetFeatureConnection('NoSit', FeatureState.NoSit, RunService.Heartbeat, function()
        local hum = GetHumanoid()
        if hum and hum.Sit then hum.Sit = false end
    end)
end)

local function BindNoDamageToHumanoid(hum)
    SetFeatureConnection('NoDamageHealth', false)
    SetFeatureConnection('NoDamageGuard', false)
    if not hum then return end
    if FeatureState.NoDamage then
        pcall(function() hum.BreakJointsOnDeath = false end)
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)
        pcall(function() hum.Health = hum.MaxHealth end)
        SetFeatureConnection('NoDamageHealth', true, hum.HealthChanged, function()
            if FeatureState.NoDamage and hum.Parent and hum.Health > 0 and hum.Health < hum.MaxHealth then pcall(function() hum.Health = hum.MaxHealth end) end
        end)
        SetFeatureConnection('NoDamageGuard', true, RunService.Heartbeat, function()
            if FeatureState.NoDamage and hum.Parent then
                pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)
                if hum.Health > 0 and hum.Health < hum.MaxHealth then pcall(function() hum.Health = hum.MaxHealth end) end
            end
        end)
    else
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
        pcall(function() hum.BreakJointsOnDeath = true end)
    end
end
SetFeatureConnection('NoDamageRespawn', true, LocalPlayer.CharacterAdded, function(char)
    task.defer(function()
        local hum = char:FindFirstChildOfClass('Humanoid') or char:WaitForChild('Humanoid',5)
        if hum then BindNoDamageToHumanoid(hum) end
    end)
end)
AddFeatureButton(TabPlayer, 'No Damage', function()
    FeatureState.NoDamage = not FeatureState.NoDamage
    _G.NoDamageEnabled = FeatureState.NoDamage
    BindNoDamageToHumanoid(GetHumanoid())
end)

local function UpdateRespawnShield(enabled)
    local char = GetCharacter()
    if not char then return end
    local shield = char:FindFirstChild('ResetHub_RespawnShield')
    local visual = char:FindFirstChild('ResetHub_RespawnShieldVisual')
    if enabled then
        if not shield then
            shield = Instance.new('ForceField')
            shield.Name = 'ResetHub_RespawnShield'
            shield.Visible = true
            shield.Parent = char
        end
        if not visual then
            visual = Instance.new('Highlight')
            visual.Name = 'ResetHub_RespawnShieldVisual'
            visual.Adornee = char
            visual.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            visual.FillColor = Color3.fromRGB(35,135,255)
            visual.FillTransparency = 0.78
            visual.OutlineColor = Color3.fromRGB(100,195,255)
            visual.OutlineTransparency = 0
            visual.Parent = char
        end
    else
        if shield then pcall(function() shield:Destroy() end) end
        if visual then pcall(function() visual:Destroy() end) end
    end
end
local function BindRespawnProtection()
    SetFeatureConnection('RespawnProtectionHealth', false)
    local hum = GetHumanoid()
    if not hum then return end
    if FeatureState.RespawnProtection then
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)
        pcall(function() hum.BreakJointsOnDeath = false end)
        pcall(function() hum.Health = hum.MaxHealth end)
        SetFeatureConnection('RespawnProtectionHealth', true, RunService.Heartbeat, function()
            if FeatureState.RespawnProtection and hum.Parent then
                pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false) end)
                if hum.Health > 0 and hum.Health < hum.MaxHealth then pcall(function() hum.Health = hum.MaxHealth end) end
                UpdateRespawnShield(true)
            end
        end)
        UpdateRespawnShield(true)
    else
        pcall(function() hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end)
        pcall(function() hum.BreakJointsOnDeath = true end)
        UpdateRespawnShield(false)
    end
end
SetFeatureConnection('RespawnProtectionCharacter', true, LocalPlayer.CharacterAdded, function(char)
    task.defer(function()
        char:WaitForChild('Humanoid',5)
        if FeatureState.RespawnProtection then BindRespawnProtection() end
    end)
end)
AddFeatureButton(TabPlayer, 'Respawn Protection', function()
    FeatureState.RespawnProtection = not FeatureState.RespawnProtection
    BindRespawnProtection()
end)

AddFeatureButton(TabPlayer, 'Clear Character Effects', function()
    local char = GetCharacter()
    if not char then return end
    local removeClasses = {
        ParticleEmitter=true, Trail=true, Beam=true, Fire=true, Smoke=true, Sparkles=true,
        Highlight=true, BillboardGui=true, SelectionBox=true, SelectionSphere=true,
        PointLight=true, SpotLight=true, SurfaceLight=true, Explosion=true
    }
    for _, obj in ipairs(char:GetDescendants()) do
        local keepShield = (obj.Name == 'ResetHub_RespawnShield' or obj.Name == 'ResetHub_RespawnShieldVisual')
        if not keepShield and ((removeClasses[obj.ClassName] == true) or obj.Name == 'ResetHub_HeadDot') then
            pcall(function() obj:Destroy() end)
        end
    end
    local hum = GetHumanoid()
    if hum then
        pcall(function() hum.CameraOffset = Vector3.zero end)
        pcall(function() hum.PlatformStand = false end)
        pcall(function() hum.AutoRotate = true end)
    end
    if FeatureState.RespawnProtection then
        pcall(function() UpdateRespawnShield(true) end)
    end
    Notify('Clear Character Effects: temizlendi')
end)


-----------------------------------------------------------
-- 4. VISUALS & ESP
-----------------------------------------------------------
local function EnsureBasicESP(p)
    if p == LocalPlayer then return end
    local char = p.Character
    if not char then return end
    local old = char:FindFirstChild("ESPHighlight")
    if not _G.ESPEnabled then
        if old then old:Destroy() end
        return
    end
    if not old then
        old = Instance.new("Highlight")
        old.Name = "ESPHighlight"
        old.FillColor = Color3.fromRGB(255, 40, 40)
        old.FillTransparency = 0.45
        old.OutlineColor = Color3.fromRGB(255, 255, 255)
        old.OutlineTransparency = 0
        old.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        old.Parent = char
    end
    old.Adornee = char
end

AddButton(TabVisuals, "ESP", function()
    _G.ESPEnabled = not _G.ESPEnabled
    for _, p in ipairs(Players:GetPlayers()) do EnsureBasicESP(p) end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        if _G.ESPEnabled then
            task.defer(function() EnsureBasicESP(p) end)
        end
    end)
end)

AddButton(TabVisuals, "Fullbright", function()
    _G.FullbrightEnabled = not _G.FullbrightEnabled
    if _G.FullbrightEnabled then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    else
        Lighting.Ambient = OriginalLighting.Ambient
        Lighting.Brightness = OriginalLighting.Brightness
        Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
    end
end)

AddButton(TabVisuals, "XRay", function()
    _G.XRayEnabled = not _G.XRayEnabled
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Parent:FindFirstChild("Humanoid") then
            part.LocalTransparencyModifier = _G.XRayEnabled and 0.5 or 0
        end
    end
end)

AddSlider(TabVisuals, "FOVAngle", 60, 120, 70, function(val)
    Camera.FieldOfView = val
end)

AddButton(TabVisuals, "Crosshair", function()
    local old = ScreenGui:FindFirstChild("CenterCrosshair")
    if old then
        old:Destroy()
        return
    end
    local c = Instance.new("Frame", ScreenGui)
    c.Name = "CenterCrosshair"
    c.AnchorPoint = Vector2.new(0.5, 0.5)
    c.Size = UDim2.new(0, 5, 0, 5)
    c.Position = UDim2.new(0.5, 0, 0.5, 0)
    c.BorderSizePixel = 0
    c.ZIndex = 199
    c.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(1, 0)
    cc.Parent = c
end)



-- ---------------------------------------------------------
-- VISUAL EXTENSIONS: 15+ total visual controls
-- ---------------------------------------------------------
local function ApplyESPToPlayer(p)
    if p == LocalPlayer or not p.Character then return end
    local existing = p.Character:FindFirstChild('ResetHub_ESP')
    if not FeatureState.ESP2 then
        if existing then existing:Destroy() end
        return
    end
    if existing then return end
    local hl = Instance.new('Highlight')
    hl.Name = 'ResetHub_ESP'
    hl.FillTransparency = 0.65
    hl.OutlineTransparency = 0
    hl.FillColor = Color3.fromRGB(255, 255, 255)
    hl.Parent = p.Character
end

AddFeatureButton(TabVisuals, 'Advanced ESP', function()
    FeatureState.ESP2 = not FeatureState.ESP2
    for _, p in ipairs(Players:GetPlayers()) do ApplyESPToPlayer(p) end
end)

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(0.25)
        ApplyESPToPlayer(p)
        if FeatureState.NameESP then
            local head = char:FindFirstChild('Head')
            if head and not head:FindFirstChild('ResetHub_Name') then
                local bb = Instance.new('BillboardGui')
                bb.Name = 'ResetHub_Name'
                bb.Size = UDim2.new(0, 180, 0, 32)
                bb.StudsOffset = Vector3.new(0, 2.7, 0)
                bb.AlwaysOnTop = true
                bb.Parent = head
                local t = Instance.new('TextLabel')
                t.Size = UDim2.fromScale(1, 1)
                t.BackgroundTransparency = 1
                t.Text = p.DisplayName .. ' (@' .. p.Name .. ')'
                t.Font = Enum.Font.GothamBold
                t.TextSize = 11
                t.TextColor3 = Color3.fromRGB(255,255,255)
                t.TextStrokeTransparency = 0.25
                t.Parent = bb
            end
        end
        if FeatureState.Chams and not char:FindFirstChild('ResetHub_Chams') then
            local hl = Instance.new('Highlight')
            hl.Name = 'ResetHub_Chams'
            hl.FillTransparency = 0.25
            hl.OutlineTransparency = 1
            hl.FillColor = Color3.fromRGB(255,255,255)
            hl.Parent = char
        end
    end)
end)

AddFeatureButton(TabVisuals, 'Name ESP', function()
    FeatureState.NameESP = not FeatureState.NameESP
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local head = p.Character:FindFirstChild('Head')
            local old = head and head:FindFirstChild('ResetHub_Name')
            if FeatureState.NameESP and head and not old then
                local bb = Instance.new('BillboardGui')
                bb.Name = 'ResetHub_Name'
                bb.Size = UDim2.new(0, 180, 0, 32)
                bb.StudsOffset = Vector3.new(0, 2.7, 0)
                bb.AlwaysOnTop = true
                bb.Parent = head
                local t = Instance.new('TextLabel')
                t.Size = UDim2.fromScale(1, 1)
                t.BackgroundTransparency = 1
                t.Text = p.DisplayName .. ' (@' .. p.Name .. ')'
                t.Font = Enum.Font.GothamBold
                t.TextSize = 11
                t.TextColor3 = Color3.fromRGB(255,255,255)
                t.TextStrokeTransparency = 0.25
                t.Parent = bb
            elseif old then
                old:Destroy()
            end
        end
    end
end)

AddFeatureButton(TabVisuals, 'Distance ESP', function()
    FeatureState.DistanceESP = not FeatureState.DistanceESP
    SetFeatureConnection('DistanceESP', FeatureState.DistanceESP, RunService.Heartbeat, function()
        local root = GetRoot()
        if not root then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local head = p.Character:FindFirstChild('Head')
                if head then
                    local old = head:FindFirstChild('ResetHub_Distance')
                    if FeatureState.DistanceESP then
                        if not old then
                            old = Instance.new('BillboardGui')
                            old.Name = 'ResetHub_Distance'
                            old.Size = UDim2.new(0, 90, 0, 20)
                            old.StudsOffset = Vector3.new(0, 3.5, 0)
                            old.AlwaysOnTop = true
                            old.Parent = head
                            local label = Instance.new('TextLabel')
                            label.Name = 'Distance'
                            label.Size = UDim2.fromScale(1, 1)
                            label.BackgroundTransparency = 1
                            label.Font = Enum.Font.GothamBold
                            label.TextSize = 9
                            label.TextStrokeTransparency = 0.3
                            label.TextColor3 = Color3.fromRGB(255,255,255)
                            label.Parent = old
                        end
                        local label = old:FindFirstChild('Distance')
                        local pr = p.Character:FindFirstChild('HumanoidRootPart')
                        if label and pr then
                            label.Text = string.format('%dm', math.floor((pr.Position - root.Position).Magnitude))
                        end
                    elseif old then
                        old:Destroy()
                    end
                end
            end
        end
    end)
end)

AddFeatureButton(TabVisuals, 'Player Chams', function()
    FeatureState.Chams = not FeatureState.Chams
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hl = p.Character:FindFirstChild('ResetHub_Chams')
            if FeatureState.Chams and not hl then
                hl = Instance.new('Highlight')
                hl.Name = 'ResetHub_Chams'
                hl.FillTransparency = 0.25
                hl.OutlineTransparency = 1
                hl.FillColor = Color3.fromRGB(255,255,255)
                hl.Parent = p.Character
            elseif not FeatureState.Chams and hl then
                hl:Destroy()
            end
        end
    end
end)

task.spawn(function()
    while _G.ResetHubSession == ResetHubSession and ScreenGui.Parent do
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                EnsureBasicESP(p)
                local existing = p.Character:FindFirstChild('ResetHub_ESP')
                if FeatureState.ESP2 and not existing then
                    local hl = Instance.new('Highlight')
                    hl.Name = 'ResetHub_ESP'
                    hl.FillTransparency = 0.65
                    hl.OutlineTransparency = 0
                    hl.FillColor = Color3.fromRGB(255,255,255)
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Adornee = p.Character
                    hl.Parent = p.Character
                end
                local head = p.Character:FindFirstChild('Head')
                if head then
                    local nameGui = head:FindFirstChild('ResetHub_Name')
                    if FeatureState.NameESP and not nameGui then
                        nameGui = Instance.new('BillboardGui')
                        nameGui.Name = 'ResetHub_Name'
                        nameGui.Size = UDim2.new(0, 180, 0, 32)
                        nameGui.StudsOffset = Vector3.new(0, 2.7, 0)
                        nameGui.AlwaysOnTop = true
                        nameGui.Parent = head
                        local t = Instance.new('TextLabel')
                        t.Name = 'Name'
                        t.Size = UDim2.fromScale(1,1)
                        t.BackgroundTransparency = 1
                        t.Text = p.DisplayName .. ' (@' .. p.Name .. ')'
                        t.Font = Enum.Font.GothamBold
                        t.TextSize = 11
                        t.TextColor3 = Color3.fromRGB(255,255,255)
                        t.TextStrokeTransparency = 0.25
                        t.Parent = nameGui
                    elseif nameGui and not FeatureState.NameESP then
                        nameGui:Destroy()
                    end
                end
                local chams = p.Character:FindFirstChild('ResetHub_Chams')
                if FeatureState.Chams and not chams then
                    chams = Instance.new('Highlight')
                    chams.Name = 'ResetHub_Chams'
                    chams.FillTransparency = 0.25
                    chams.OutlineTransparency = 1
                    chams.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    chams.FillColor = Color3.fromRGB(255,255,255)
                    chams.Adornee = p.Character
                    chams.Parent = p.Character
                elseif chams and not FeatureState.Chams then
                    chams:Destroy()
                end
            end
        end
        task.wait(0.2)
    end
end)

AddFeatureButton(TabVisuals, 'Night Vision', function()
    FeatureState.NightVision = not FeatureState.NightVision
    Lighting.ClockTime = FeatureState.NightVision and 12 or OriginalLighting.ClockTime
    Lighting.Brightness = FeatureState.NightVision and 3 or OriginalLighting.Brightness
end)


CameraZoomMaxActive = false
local function SetCameraZoomMax(enabled)
    CameraZoomMaxActive = enabled == true
    FeatureState.CameraZoomMax = CameraZoomMaxActive
    SetFeatureConnection('CameraZoomMaxGuard', false)

    local function apply()
        if not CameraZoomMaxActive then return end
        pcall(function() LocalPlayer.CameraMode = Enum.CameraMode.Classic end)
        pcall(function() LocalPlayer.CameraMinZoomDistance = 0.5 end)
        pcall(function() LocalPlayer.CameraMaxZoomDistance = math.max(1000, OriginalCameraMaxZoom) end)
    end

    if CameraZoomMaxActive then
        apply()
        SetFeatureConnection('CameraZoomMaxGuard', true, RunService.Heartbeat, apply)
    else
        pcall(function() LocalPlayer.CameraMode = Enum.CameraMode.Classic end)
        pcall(function() LocalPlayer.CameraMinZoomDistance = OriginalCameraMinZoom end)
        pcall(function() LocalPlayer.CameraMaxZoomDistance = OriginalCameraMaxZoom end)
    end
end

AddFeatureButton(TabVisuals, 'Camera Zoom Max', function()
    SetCameraZoomMax(not CameraZoomMaxActive)
end)

SetFeatureConnection('CameraZoomRespawn', true, LocalPlayer.CharacterAdded, function()
    task.defer(function()
        if CameraZoomMaxActive then SetCameraZoomMax(true) end
    end)
end)

AddFeatureButton(TabVisuals, 'Head Dot', function()
    local head = GetHead()
    if not head then return end
    local old = head:FindFirstChild('ResetHub_HeadDot')
    if old then old:Destroy(); return end
    local b = Instance.new('BillboardGui')
    b.Name = 'ResetHub_HeadDot'
    b.Size = UDim2.new(0, 8, 0, 8)
    b.AlwaysOnTop = true
    b.Parent = head
    local f = Instance.new('Frame')
    f.Size = UDim2.fromScale(1,1)
    f.BackgroundColor3 = Color3.fromRGB(255,255,255)
    f.BorderSizePixel = 0
    f.Parent = b
    local c = Instance.new('UICorner')
    c.CornerRadius = UDim.new(1,0)
    c.Parent = f
end)

AddFeatureButton(TabVisuals, 'Camera FOV Pulse', function()
    local old = Camera.FieldOfView
    local ti = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(Camera, ti, {FieldOfView = math.clamp(old + 18, 60, 120)}):Play()
    task.delay(0.25, function()
        TweenService:Create(Camera, ti, {FieldOfView = old}):Play()
    end)
end)

AddFeatureButton(TabVisuals, 'Remove Local Shadows', function()
    Lighting.GlobalShadows = not Lighting.GlobalShadows
end)

AddFeatureButton(TabVisuals, 'Reset Visuals', function()
    Camera.FieldOfView = OriginalFOV
    Lighting.Ambient = OriginalLighting.Ambient
    Lighting.Brightness = OriginalLighting.Brightness
    Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
    Lighting.ClockTime = OriginalLighting.ClockTime
    Lighting.FogStart = OriginalLighting.FogStart
    Lighting.FogEnd = OriginalLighting.FogEnd
    Lighting.GlobalShadows = OriginalLighting.GlobalShadows
end)


-----------------------------------------------------------
-- 5. TELEPORTATION
-----------------------------------------------------------
AddButton(TabTeleport, "Teleport to Spawn", function()
    local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
    if spawn and LocalPlayer.Character then
        LocalPlayer.Character.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
    end
end)

AddButton(TabTeleport, "Teleport to Random Player", function()
    local allP = GetOtherPlayers()
    if #allP == 0 then Notify('No other player found'); return end
    local target = allP[math.random(1, #allP)]
    local targetRoot = target.Character and target.Character:FindFirstChild('HumanoidRootPart')
    local char = GetCharacter()
    if targetRoot and char then
        local destination = targetRoot.CFrame + targetRoot.CFrame.UpVector * 3
        pcall(function() char:PivotTo(destination) end)
        local root = GetRoot()
        if root then root.CFrame = destination end
    end
end)



-- ---------------------------------------------------------
-- TELEPORT EXTENSIONS: 15+ total teleport controls
-- ---------------------------------------------------------
AddFeatureButton(TabTeleport, 'Save Position', function()
    local root = GetRoot()
    if root then SavedPosition = root.CFrame end
end)

AddFeatureButton(TabTeleport, 'Load Saved Position', function()
    local root = GetRoot()
    if root and SavedPosition then root.CFrame = SavedPosition end
end)

AddFeatureButton(TabTeleport, 'Teleport To Mouse', function()
    local root = GetRoot()
    if root and Mouse.Hit then root.CFrame = Mouse.Hit + Vector3.new(0, 3, 0) end
end)

AddFeatureButton(TabTeleport, 'Teleport Up 100', function()
    local root = GetRoot()
    if root then root.CFrame = root.CFrame + Vector3.new(0, 100, 0) end
end)

AddFeatureButton(TabTeleport, 'Teleport Down 100', function()
    local root = GetRoot()
    if root then root.CFrame = root.CFrame - Vector3.new(0, 100, 0) end
end)

AddFeatureButton(TabTeleport, 'Nearest Player', function()
    local root = GetRoot()
    if not root then return end
    local best, dist = nil, math.huge
    for _, p in ipairs(GetOtherPlayers()) do
        local pr = p.Character and p.Character:FindFirstChild('HumanoidRootPart')
        if pr then
            local d = (pr.Position - root.Position).Magnitude
            if d < dist then dist, best = d, p end
        end
    end
    if best then root.CFrame = best.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0) end
end)

AddFeatureButton(TabTeleport, 'Farthest Player', function()
    local root = GetRoot()
    if not root then return end
    local best, dist = nil, -1
    for _, p in ipairs(GetOtherPlayers()) do
        local pr = p.Character and p.Character:FindFirstChild('HumanoidRootPart')
        if pr then
            local d = (pr.Position - root.Position).Magnitude
            if d > dist then dist, best = d, p end
        end
    end
    if best then root.CFrame = best.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0) end
end)

AddFeatureButton(TabTeleport, 'Random Safe Point', function()
    local root = GetRoot()
    if not root then return end
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {GetCharacter()}
    local chosen
    for _ = 1, 12 do
        local origin = root.Position + Vector3.new(math.random(-150,150), 150, math.random(-150,150))
        local result = workspace:Raycast(origin, Vector3.new(0,-500,0), params)
        if result and result.Material ~= Enum.Material.Water then
            chosen = result.Position + Vector3.new(0,4,0)
            break
        end
    end
    if not chosen then Notify('Safe point bulunamadı'); return end
    local cf = CFrame.new(chosen)
    local char = GetCharacter()
    if char then pcall(function() char:PivotTo(cf) end) end
    local newRoot = GetRoot()
    if newRoot then newRoot.CFrame = cf end
end)

AddFeatureButton(TabTeleport, 'Orbit Nearest Player', function()
    FeatureState.OrbitNearest = not FeatureState.OrbitNearest
    SetFeatureConnection('OrbitNearest', FeatureState.OrbitNearest, RunService.Heartbeat, function(dt)
        local root = GetRoot()
        if not root then return end
        local nearest, dist = nil, math.huge
        for _, p in ipairs(GetOtherPlayers()) do
            local pr = p.Character and p.Character:FindFirstChild('HumanoidRootPart')
            if pr then
                local d = (pr.Position - root.Position).Magnitude
                if d < dist then dist, nearest = d, p end
            end
        end
        if nearest then
            local pr = nearest.Character.HumanoidRootPart
            local angle = os.clock() * 2.5
            root.CFrame = CFrame.new(pr.Position + Vector3.new(math.cos(angle) * 8, 2, math.sin(angle) * 8), pr.Position)
        end
    end)
end)

AddFeatureButton(TabTeleport, 'Recenter Camera', function()
    Camera = workspace.CurrentCamera or Camera
    local hum = GetHumanoid()
    local root = GetRoot()
    if not Camera or not hum or not root then
        Notify('Recenter Camera: karakter hazır değil')
        return
    end

    pcall(function()
        hum.CameraOffset = Vector3.zero
        hum.AutoRotate = true
    end)
    pcall(function()
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = hum
        Camera.FieldOfView = tonumber(_G.FovValue) or OriginalFOV
        local look = root.CFrame.LookVector
        local focus = root.Position + Vector3.new(0, 2, 0)
        Camera.CFrame = CFrame.lookAt(focus - look * 8 + Vector3.new(0, 2, 0), focus)
    end)
    RunService.RenderStepped:Wait()
    pcall(function()
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = hum
        hum.CameraOffset = Vector3.zero
    end)
    Notify('Kamera yeniden ortalandı')
end)

AddFeatureButton(TabTeleport, 'Teleport To Spawn Safe', function()
    local spawn = workspace:FindFirstChildOfClass('SpawnLocation')
    local root = GetRoot()
    if spawn and root then root.CFrame = spawn.CFrame + Vector3.new(0, 5, 0) end
end)

AddFeatureButton(TabTeleport, 'Teleport To Origin', function()
    local root = GetRoot()
    if root then root.CFrame = CFrame.new(0, 10, 0) end
end)

AddFeatureButton(TabTeleport, 'Back To Saved On Void', function()
    FeatureState.BackSavedVoid = not FeatureState.BackSavedVoid
    if FeatureState.BackSavedVoid and not SavedPosition then
        local root = GetRoot()
        if root then SavedPosition = root.CFrame end
    end
    if FeatureConnections.BackSavedVoid then
        pcall(function() FeatureConnections.BackSavedVoid:Disconnect() end)
        FeatureConnections.BackSavedVoid = nil
    end
    if not FeatureState.BackSavedVoid then return end

    FeatureConnections.BackSavedVoid = RunService.Heartbeat:Connect(function()
        local root = GetRoot()
        local char = GetCharacter()
        if not root or not char or not SavedPosition then return end
        local destroyY = tonumber(workspace.FallenPartsDestroyHeight) or -500
        local triggerY = math.min(destroyY + 60, -50)
        if root.Position.Y <= triggerY then
            local destination = SavedPosition + Vector3.new(0, 3, 0)
            pcall(function() char:PivotTo(destination) end)
            pcall(function() root.CFrame = destination end)
            pcall(function() root.AssemblyLinearVelocity = Vector3.zero end)
            pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
        end
    end)
end)

AddFeatureButton(TabTeleport, 'Cycle Player Teleport', function()
    local all = GetOtherPlayers()
    if #all == 0 then return end
    local idx = ((FeatureState.CyclePlayer or 0) % #all) + 1
    FeatureState.CyclePlayer = idx
    local root = GetRoot()
    local target = all[idx]
    if root and target.Character and target.Character:FindFirstChild('HumanoidRootPart') then root.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0) end
end)

AddFeatureButton(TabTeleport, 'Teleport To Random Player', function()
    local all = GetOtherPlayers()
    if #all == 0 then return end
    local target = all[math.random(1, #all)]
    local root = GetRoot()
    if root and target.Character and target.Character:FindFirstChild('HumanoidRootPart') then
        local destination = target.Character.HumanoidRootPart.CFrame + target.Character.HumanoidRootPart.CFrame.UpVector * 3
        local char = GetCharacter()
        if char then pcall(function() char:PivotTo(destination) end) end
        root.CFrame = destination
    end
end)


-----------------------------------------------------------
-- 6. AUTOMATION & FARM
-----------------------------------------------------------
local autoClicker = false
local function FireMouseClick()
    if type(mouse1click) == 'function' then
        local ok = pcall(mouse1click)
        if ok then return true end
    end
    if type(mouse1press) == 'function' and type(mouse1release) == 'function' then
        local ok = pcall(function()
            mouse1press()
            task.wait(0.015)
            mouse1release()
        end)
        if ok then return true end
    end
    local ok, vim = pcall(function() return game:GetService('VirtualInputManager') end)
    if ok and vim then
        local pos = UserInputService:GetMouseLocation()
        local ok2 = pcall(function()
            vim:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
            vim:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)
        end)
        if ok2 then return true end
    end
    local vOk, vu = pcall(function() return game:GetService('VirtualUser') end)
    if vOk and vu then
        local pos = UserInputService:GetMouseLocation()
        local cam = workspace.CurrentCamera
        local ok3 = pcall(function()
            vu:Button1Down(pos, cam and cam.CFrame or CFrame.new())
            task.wait(0.015)
            vu:Button1Up(pos, cam and cam.CFrame or CFrame.new())
        end)
        if ok3 then return true end
    end
    return false
end
AutomationTokens = {}
function SetAutomationLoop(name, enabled, callback)
    AutomationTokens[name] = (AutomationTokens[name] or 0) + 1
    local token = AutomationTokens[name]
    if not enabled or type(callback) ~= 'function' then return end
    task.spawn(function()
        while AutomationTokens[name] == token and _G.ResetHubSession == ResetHubSession do
            local ok, err = xpcall(callback, function(e) return tostring(e) end)
            if not ok then
                if NotificationsEnabled then Notify(name .. ' error: ' .. tostring(err):sub(1, 120)) end
                task.wait(0.25)
            else
                task.wait(0.05)
            end
        end
    end)
end

AddFeatureButton(TabAuto, 'Fast Auto Clicker', function()
    autoClicker = not autoClicker
    _G.ResetHubAutoClickerActive = autoClicker
    if not autoClicker then
        AutomationTokens['FastAutoClicker'] = (AutomationTokens['FastAutoClicker'] or 0) + 1
        return
    end
    SetAutomationLoop('FastAutoClicker', true, function()
        local char = GetCharacter()
        local tool = char and char:FindFirstChildOfClass('Tool')
        if tool then
            pcall(function() tool:Activate() end)
        else
            FireMouseClick()
        end
        task.wait(0.06)
    end)
end)

AddFeatureButton(TabAuto, 'Auto Jump', function()
    FeatureState.AutoJump = not FeatureState.AutoJump
    FeatureState.AutoJumpNext = 0
    SetAutomationLoop('AutoJump', FeatureState.AutoJump, function()
        local hum = GetHumanoid()
        if hum and hum.Health > 0 and hum.MoveDirection.Magnitude > 0.05 and hum.FloorMaterial ~= Enum.Material.Air then
            local now = os.clock()
            if now >= (FeatureState.AutoJumpNext or 0) then
                FeatureState.AutoJumpNext = now + 0.15
                pcall(function() hum.Jump = true end)
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end
    end)
end)

AddFeatureButton(TabAuto, 'Auto Equip Tool', function()
    AutoEquipEnabled = not AutoEquipEnabled
    SetAutomationLoop('AutoEquip', AutoEquipEnabled, function()
        local char = GetCharacter()
        local hum = GetHumanoid()
        local backpack = LocalPlayer:FindFirstChildOfClass('Backpack')
        if char and hum and backpack and not char:FindFirstChildOfClass('Tool') then
            local tool = backpack:FindFirstChildOfClass('Tool')
            if tool then pcall(function() hum:EquipTool(tool) end) end
        end
    end)
end)

local function GetPromptWorldPosition(prompt)
    local parent = prompt and prompt.Parent
    if not parent then return nil end
    if parent:IsA('BasePart') then return parent.Position end
    if parent:IsA('Attachment') then return parent.WorldPosition end
    local part = parent:FindFirstAncestorWhichIsA('BasePart')
    return part and part.Position or nil
end

local function TriggerPrompt(prompt)
    if not prompt or not prompt.Parent or not prompt.Enabled then return false end
    if type(fireproximityprompt) == 'function' then
        local ok, result = pcall(function() return fireproximityprompt(prompt) end)
        if ok and result ~= false then return true end
    end
    local ok = pcall(function()
        prompt:InputHoldBegin()
        task.wait(0.02)
        prompt:InputHoldEnd()
    end)
    return ok
end

AddFeatureButton(TabAuto, 'Auto Prompt Fire', function()
    AutoPromptEnabled = not AutoPromptEnabled
    SetAutomationLoop('AutoPrompt', AutoPromptEnabled, function()
        local root = GetRoot()
        if not root then return end
        local fired = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if not AutoPromptEnabled or fired >= 6 then break end
            if obj:IsA('ProximityPrompt') and obj.Enabled then
                local pos = GetPromptWorldPosition(obj)
                local distance = tonumber(obj.MaxActivationDistance) or 10
                if pos and (pos - root.Position).Magnitude <= math.max(1, distance) then
                    if TriggerPrompt(obj) then fired = fired + 1 end
                end
            end
        end
        task.wait(0.10)
    end)
end)

AddFeatureButton(TabAuto, 'Auto Collect Touch Items', function()
    AutoCollectEnabled = not AutoCollectEnabled
    SetAutomationLoop('AutoCollect', AutoCollectEnabled, function()
        local root = GetRoot()
        if not root or type(firetouchinterest) ~= 'function' then return end
        local checked = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if checked >= 20 then break end
            if obj:IsA('BasePart') and obj ~= root and obj.CanTouch and (obj.Position - root.Position).Magnitude <= 14 then
                pcall(function() firetouchinterest(root, obj, 0) end)
                task.defer(function()
                    if root.Parent and obj.Parent then pcall(function() firetouchinterest(root, obj, 1) end) end
                end)
                checked = checked + 1
            end
        end
        task.wait(0.2)
    end)
end)

AddFeatureButton(TabAuto, 'Tool Spam', function()
    FeatureState.ToolSpam = not FeatureState.ToolSpam
    SetFeatureConnection('ToolSpam', false)
    if FeatureState.ToolSpam then
        FeatureState.ToolSpamNext = 0
        FeatureState.ToolSpamIndex = 0
        SetFeatureConnection('ToolSpam', true, RunService.Heartbeat, function()
            local now = os.clock()
            if now < (FeatureState.ToolSpamNext or 0) then return end
            FeatureState.ToolSpamNext = now + 0.10
            local char = GetCharacter()
            local hum = GetHumanoid()
            local backpack = LocalPlayer:FindFirstChildOfClass('Backpack')
            if not char or not hum or hum.Health <= 0 then return end
            local tools = {}
            for _, container in ipairs({char, backpack}) do
                if container then
                    for _, obj in ipairs(container:GetChildren()) do
                        if obj:IsA('Tool') then table.insert(tools, obj) end
                    end
                end
            end
            if #tools == 0 then return end
            FeatureState.ToolSpamIndex = (FeatureState.ToolSpamIndex % #tools) + 1
            local tool = tools[FeatureState.ToolSpamIndex]
            if tool then
                pcall(function()
                    if tool.Parent ~= char then hum:EquipTool(tool) end
                    tool:Activate()
                end)
            end
        end)
    end
end)

AddFeatureButton(TabAuto, 'Auto Sit', function()
    FeatureState.AutoSit = not FeatureState.AutoSit
    SetAutomationLoop('AutoSit', FeatureState.AutoSit, function()
        local hum = GetHumanoid()
        if hum then pcall(function() hum.Sit = true end) end
        task.wait(0.15)
    end)
    if not FeatureState.AutoSit then
        local hum = GetHumanoid()
        if hum then
            pcall(function() hum.Sit = false end)
            pcall(function() hum.PlatformStand = false end)
        end
    end
end)

function BindAutoRespawn(char)
    if FeatureConnections.AutoRespawnDied then
        pcall(function() FeatureConnections.AutoRespawnDied:Disconnect() end)
        FeatureConnections.AutoRespawnDied = nil
    end
    if not FeatureState.AutoRespawn or not char then return end
    local hum = char:FindFirstChildOfClass('Humanoid') or char:WaitForChild('Humanoid', 5)
    if not hum then return end
    FeatureConnections.AutoRespawnDied = hum.Died:Connect(function()
        if not FeatureState.AutoRespawn then return end
        task.delay(0.1, function()
            if FeatureState.AutoRespawn then pcall(function() LocalPlayer:LoadCharacter() end) end
        end)
    end)
end

AddFeatureButton(TabAuto, 'Auto Respawn', function()
    FeatureState.AutoRespawn = not FeatureState.AutoRespawn
    if FeatureState.AutoRespawn then
        BindAutoRespawn(GetCharacter())
    elseif FeatureConnections.AutoRespawnDied then
        pcall(function() FeatureConnections.AutoRespawnDied:Disconnect() end)
        FeatureConnections.AutoRespawnDied = nil
    end
end)

if FeatureConnections.AutoRespawnCharacterAdded then FeatureConnections.AutoRespawnCharacterAdded:Disconnect() end
FeatureConnections.AutoRespawnCharacterAdded = LocalPlayer.CharacterAdded:Connect(function(char)
    task.defer(function() BindAutoRespawn(char) end)
end)

AddFeatureButton(TabAuto, 'Auto Sprint', function()
    FeatureState.AutoSprint = not FeatureState.AutoSprint
    SetAutomationLoop('AutoSprint', FeatureState.AutoSprint, function()
        local hum = GetHumanoid()
        if hum and hum.MoveDirection.Magnitude > 0.01 then
            pcall(function() hum.WalkSpeed = tonumber(_G.WalkSpeedValue) or 16 end)
        end
    end)
end)

AddFeatureButton(TabAuto, 'Prompt Duration 0', function()
    FeatureState.PromptDuration0 = not FeatureState.PromptDuration0
    SetAutomationLoop('PromptDuration0', FeatureState.PromptDuration0, function()
        if not FeatureState.PromptDuration0 then return end
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA('ProximityPrompt') then
                if ResetHub_PromptOriginalHoldDurations[prompt] == nil then
                    ResetHub_PromptOriginalHoldDurations[prompt] = tonumber(prompt.HoldDuration) or 0
                end
                pcall(function() prompt.HoldDuration = 0 end)
            end
        end
        task.wait(0.10)
    end)
    if not FeatureState.PromptDuration0 then
        for prompt, original in pairs(ResetHub_PromptOriginalHoldDurations) do
            if prompt and prompt.Parent then pcall(function() prompt.HoldDuration = original end) end
            ResetHub_PromptOriginalHoldDurations[prompt] = nil
        end
    end
end)

AddFeatureButton(TabAuto, 'Auto Rotate', function()
    FeatureState.AutoRotate = not FeatureState.AutoRotate
    SetFeatureConnection('AutoRotateGuard', false)
    SetFeatureConnection('AutoRotateChanged', false)
    if FeatureState.AutoRotate then
        SetFeatureConnection('AutoRotateGuard', true, RunService.Heartbeat, function()
            local hum = GetHumanoid()
            if hum and hum.Health > 0 then
                pcall(function() hum.AutoRotate = true end)
            end
        end)
        local hum = GetHumanoid()
        if hum then
            pcall(function() hum.AutoRotate = true end)
            SetFeatureConnection('AutoRotateChanged', true, hum:GetPropertyChangedSignal('AutoRotate'), function()
                if FeatureState.AutoRotate then pcall(function() hum.AutoRotate = true end) end
            end)
        end
    end
end)
SetFeatureConnection('AutoRotateRespawn', true, LocalPlayer.CharacterAdded, function(char)
    task.defer(function()
        local hum = char:FindFirstChildOfClass('Humanoid') or char:WaitForChild('Humanoid',5)
        if hum and FeatureState.AutoRotate then pcall(function() hum.AutoRotate=true end) end
    end)
end)


AddFeatureButton(TabAuto, 'Auto Heal', function()
    FeatureState.AutoHeal = not FeatureState.AutoHeal
    SetFeatureConnection('AutoHeal', false)
    FeatureState.AutoHealNext = 0
    if FeatureState.AutoHeal then
        SetFeatureConnection('AutoHeal', true, RunService.Heartbeat, function()
            if not FeatureState.AutoHeal then return end
            local hum = GetHumanoid()
            if not hum or hum.Health <= 0 then return end
            local now = os.clock()
            if now < (FeatureState.AutoHealNext or 0) then return end
            FeatureState.AutoHealNext = now + 0.12
            if hum.Health < hum.MaxHealth then
                pcall(function() hum.Health = hum.MaxHealth end)
            end
        end)
    end
end)

AddFeatureButton(TabAuto, 'Auto Jump + Speed', function()
    FeatureState.JumpSpeed = not FeatureState.JumpSpeed
    FeatureState.JumpSpeedNext = 0
    SetAutomationLoop('JumpSpeed', FeatureState.JumpSpeed, function()
        local hum = GetHumanoid()
        if not hum or hum.Health <= 0 then return end
        pcall(function() hum.WalkSpeed = math.clamp(tonumber(_G.WalkSpeedValue) or 16, 0, 250) end)
        pcall(function()
            hum.UseJumpPower = true
            hum.JumpPower = math.clamp(tonumber(_G.JumpPowerValue) or 50, 0, 300)
        end)
        local state = hum:GetState()
        local grounded = state == Enum.HumanoidStateType.Running
            or state == Enum.HumanoidStateType.RunningNoPhysics
            or state == Enum.HumanoidStateType.Landed
        local moving = hum.MoveDirection.Magnitude > 0.05
        local now = os.clock()
        if moving and grounded and now >= (FeatureState.JumpSpeedNext or 0) then
            FeatureState.JumpSpeedNext = now + 0.18
            pcall(function() hum.Jump = true end)
            pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end
        task.wait(0.035)
    end)
end)

AddFeatureButton(TabAuto, 'Auto Face Mouse', function()
    FeatureState.FaceMouse = not FeatureState.FaceMouse
    SetAutomationLoop('FaceMouse', FeatureState.FaceMouse, function()
        local root = GetRoot()
        if root and Mouse.Hit then
            local p = Mouse.Hit.Position
            pcall(function() root.CFrame = CFrame.new(root.Position, Vector3.new(p.X, root.Position.Y, p.Z)) end)
        end
        task.wait(0.03)
    end)
end)

-----------------------------------------------------------
-- WORLD UTILITIES (additive)
-----------------------------------------------------------
AddFeatureButton(TabWorld, 'Fullbright World', function()
    FeatureState.WorldFullbright = not FeatureState.WorldFullbright
    if FeatureState.WorldFullbright then
        Lighting.Ambient = Color3.fromRGB(255,255,255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
        Lighting.Brightness = 2.5
    else
        Lighting.Ambient = OriginalLighting.Ambient
        Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
        Lighting.Brightness = OriginalLighting.Brightness
    end
end)

AddFeatureButton(TabWorld, 'Day Time', function() Lighting.ClockTime = 14 end)
AddFeatureButton(TabWorld, 'Night Time', function() Lighting.ClockTime = 0 end)
AddFeatureButton(TabWorld, 'Morning', function() Lighting.ClockTime = 7 end)
AddFeatureButton(TabWorld, 'Sunset', function() Lighting.ClockTime = 18 end)
AddFeatureButton(TabWorld, 'Toggle Shadows', function() Lighting.GlobalShadows = not Lighting.GlobalShadows end)
AddFeatureButton(TabWorld, 'Restore World Lighting', function()
    Lighting.Ambient = OriginalLighting.Ambient
    Lighting.Brightness = OriginalLighting.Brightness
    Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
    Lighting.ClockTime = OriginalLighting.ClockTime
    Lighting.FogStart = OriginalLighting.FogStart
    Lighting.FogEnd = OriginalLighting.FogEnd
    Lighting.GlobalShadows = OriginalLighting.GlobalShadows
end)
AddFeatureButton(TabWorld, 'Copy Coordinates', function()
    local root = GetRoot()
    if root then SafeSetClipboard(string.format('X: %.1f\nY: %.1f\nZ: %.1f', root.Position.X, root.Position.Y, root.Position.Z)) end
end)
AddFeatureButton(TabWorld, 'Copy Place ID', function() SafeSetClipboard(game.PlaceId) end)
AddFeatureButton(TabWorld, 'Copy Job ID', function() SafeSetClipboard(game.JobId) end)

-----------------------------------------------------------
-- 7. SCRIPT HUBS
-----------------------------------------------------------
AddButton(TabHubs, "Infinite Yield", function()
    pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end)
end)

AddButton(TabHubs, "Dex Explorer", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end)
end)

AddButton(TabHubs, "SimpleSpy RemoteSpy", function()
    pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ex-serum/SimpleSpy/main/SimpleSpy.lua"))() end)
end)



-- ---------------------------------------------------------
-- SCRIPT HUB EXTENSIONS: 15+ working local utilities
-- ---------------------------------------------------------
AddFeatureButton(TabHubs, 'Copy Place ID', function() SafeSetClipboard(game.PlaceId) end)
AddFeatureButton(TabHubs, 'Copy Job ID', function() SafeSetClipboard(game.JobId) end)
AddFeatureButton(TabHubs, 'Copy Executor Hint', function() SafeSetClipboard('ResetHub loaded in the current client') end)
AddFeatureButton(TabHubs, 'Server Hop', function()
    local servers = {}
    if game:GetService('HttpService') then
        local http = game:GetService('HttpService')
        local req = (request or http_request or (syn and syn.request))
        if req then
            local ok, response = pcall(function()
                return req({Url = 'https://games.roblox.com/v1/games/' .. game.PlaceId .. '/servers/Public?sortOrder=Asc&limit=100', Method = 'GET'})
            end)
            if ok and response and response.Body then
                local decodedOk, data = pcall(function() return http:JSONDecode(response.Body) end)
                if decodedOk and data and data.data then servers = data.data end
            end
        end
    end
    for _, server in ipairs(servers) do
        if server.id ~= game.JobId and server.playing < server.maxPlayers then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            break
        end
    end
end)
AddFeatureButton(TabHubs, 'Reload Current Hub', function()
    MainFrame.Visible = true
end)
AddFeatureButton(TabHubs, 'Hide Hub', function() MainFrame.Visible = false end)
AddFeatureButton(TabHubs, 'Show Hub', function() MainFrame.Visible = true end)
AddFeatureButton(TabHubs, 'Clear Notifications', function()
    for _, obj in ipairs(ScreenGui:GetChildren()) do
        if obj:IsA('Frame') and obj ~= MainFrame then obj:Destroy() end
    end
end)
AddFeatureButton(TabHubs, 'Dump Player Names', function()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        table.insert(names, p.Name .. ' (@' .. p.DisplayName .. ')')
    end
    local payload = table.concat(names, '\n')
    local copied = SafeSetClipboard(payload)
    Notify(copied and ('Player names copied: ' .. tostring(#names)) or ('Players: ' .. tostring(#names) .. ' (clipboard unavailable)'))
end)
AddFeatureButton(TabHubs, 'Copy Server Info', function()
    SafeSetClipboard('PlaceId: ' .. tostring(game.PlaceId) .. '\nJobId: ' .. tostring(game.JobId) .. '\nPlayers: ' .. tostring(#Players:GetPlayers()))
end)
AddFeatureButton(TabHubs, 'Local Performance Loop', function()
    FeatureState.Performance = not FeatureState.Performance
    RunService:Set3dRenderingEnabled(not FeatureState.Performance)
end)
AddFeatureButton(TabHubs, 'Restore Camera', function()
    Camera = workspace.CurrentCamera or Camera
    local hum = GetHumanoid()
    pcall(function() Camera.CameraType = Enum.CameraType.Custom end)
    pcall(function() Camera.CameraSubject = hum end)
    pcall(function() Camera.FieldOfView = OriginalFOV end)
    Notify('Camera restored')
end)
AddFeatureButton(TabHubs, 'Restore Gravity', function()
    pcall(function() workspace.Gravity = OriginalGravity end)
    Notify('Gravity restored: ' .. tostring(OriginalGravity))
end)
AddFeatureButton(TabHubs, 'Restore Lighting', function()
    pcall(function() Lighting.Ambient = OriginalLighting.Ambient end)
    pcall(function() Lighting.Brightness = OriginalLighting.Brightness end)
    pcall(function() Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient end)
    pcall(function() Lighting.ClockTime = OriginalLighting.ClockTime end)
    pcall(function() Lighting.FogStart = OriginalLighting.FogStart end)
    pcall(function() Lighting.FogEnd = OriginalLighting.FogEnd end)
    pcall(function() Lighting.GlobalShadows = OriginalLighting.GlobalShadows end)
    Notify('Lighting restored')
end)


-----------------------------------------------------------
-- 8. FUN & EXPLOITS
-----------------------------------------------------------
AddButton(TabFun, "Spin Bot", function()
    FeatureState.SpinBot = not FeatureState.SpinBot
    if FeatureState.SpinBot then
        FeatureState.Spin = false
        FeatureState.SpinMovement = false
        SetFeatureConnection('SpinToggle', false)
        SetFeatureConnection('SpinMovement', false)
    end
    SetFeatureConnection('SpinBot', FeatureState.SpinBot, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.new(0, 60, 0) end
    end)
    if not FeatureState.SpinBot then
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.zero end
    end
end)



-- ---------------------------------------------------------
-- FUN EXTENSIONS: 15+ total fun controls
-- ---------------------------------------------------------
AddFeatureButton(TabFun, 'Spin Toggle', function()
    FeatureState.Spin = not FeatureState.Spin
    if FeatureState.Spin then
        FeatureState.SpinBot = false
        FeatureState.SpinMovement = false
        SetFeatureConnection('SpinBot', false)
        SetFeatureConnection('SpinMovement', false)
    end
    SetFeatureConnection('SpinToggle', FeatureState.Spin, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.new(0, 18, 0) end
    end)
    if not FeatureState.Spin then
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.zero end
    end
end)

AddFeatureButton(TabFun, 'Float', function()
    FeatureState.Float = not FeatureState.Float
    SetFeatureConnection('Float', FeatureState.Float, RunService.Heartbeat, function()
        local root = GetRoot()
        if root then root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 0, root.AssemblyLinearVelocity.Z) end
    end)
end)

AddFeatureButton(TabFun, 'Super Jump Pulse', function()
    local root = GetRoot()
    if root then root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 120, root.AssemblyLinearVelocity.Z) end
end)

AddFeatureButton(TabFun, 'Headless Toggle', function()
    local head = GetHead()
    if head then head.Transparency = head.Transparency == 1 and 0 or 1 end
end)

AddFeatureButton(TabFun, 'Tiny Toggle', function()
    local char = GetCharacter()
    if char then char:ScaleTo(FeatureState.Tiny and 1 or 0.55); FeatureState.Tiny = not FeatureState.Tiny end
end)

AddFeatureButton(TabFun, 'Big Toggle', function()
    local char = GetCharacter()
    if char then char:ScaleTo(FeatureState.Big and 1 or 1.6); FeatureState.Big = not FeatureState.Big end
end)

AddFeatureButton(TabFun, 'Sit Toggle', function()
    local hum = GetHumanoid()
    if not hum then return end
    if hum.Sit then
        hum.Sit = false
        hum.PlatformStand = false
        task.defer(function()
            if hum and hum.Parent then hum:ChangeState(Enum.HumanoidStateType.GettingUp) end
        end)
    else
        hum.Sit = true
    end
end)

AddFeatureButton(TabFun, 'Invisible Local', function()
    local char = GetCharacter()
    if not char then return end
    FeatureState.Invisible = not FeatureState.Invisible
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA('BasePart') then part.LocalTransparencyModifier = FeatureState.Invisible and 1 or 0 end
    end
end)

AddFeatureButton(TabFun, 'Freeze Toggle', function()
    local root = GetRoot()
    if root then root.Anchored = not root.Anchored end
end)

AddFeatureButton(TabFun, 'Walk Backwards', function()
    FeatureState.Backward = not FeatureState.Backward
    SetFeatureConnection('Backward', FeatureState.Backward, RunService.Heartbeat, function()
        local root = GetRoot()
        if root and Camera then root.CFrame = CFrame.new(root.Position, root.Position - Camera.CFrame.LookVector) end
    end)
end)

AddFeatureButton(TabFun, 'Face Mouse', function()
    FeatureState.FunFaceMouse = not FeatureState.FunFaceMouse
    SetFeatureConnection('FunFaceMouse', FeatureState.FunFaceMouse, RunService.RenderStepped, function()
        local root = GetRoot()
        if root and Mouse.Hit then
            local p = Mouse.Hit.Position
            root.CFrame = CFrame.new(root.Position, Vector3.new(p.X, root.Position.Y, p.Z))
        end
    end)
end)

AddFeatureButton(TabFun, 'Spin 60', function()
    local root = GetRoot()
    if root then
        root.AssemblyAngularVelocity = Vector3.new(0, 60, 0)
    end
end)

AddFeatureButton(TabFun, 'Stop Spin', function()
    FeatureState.SpinBot = false
    FeatureState.Spin = false
    FeatureState.SpinMovement = false
    SetFeatureConnection('SpinBot', false)
    SetFeatureConnection('SpinToggle', false)
    SetFeatureConnection('SpinMovement', false)
    local root = GetRoot()
    if root then root.AssemblyAngularVelocity = Vector3.zero end
end)


local function StopActiveFling()
    if ActiveFlingConnection then
        ActiveFlingConnection:Disconnect()
        ActiveFlingConnection = nil
    end
    local root = GetRoot()
    if root then
        root.AssemblyAngularVelocity = Vector3.zero
        if ActiveFlingCanCollide ~= nil then
            root.CanCollide = ActiveFlingCanCollide
        end
    end
    ActiveFlingCanCollide = nil
    pcall(function()
        for _, p in ipairs(GetOtherPlayers()) do
            local obj = p.Character and p.Character:FindFirstChild('ResetHub_FlingVelocity')
            if obj then obj:Destroy() end
        end
    end)
end

do
    local TargetBox = Instance.new('TextBox')
    TargetBox.Name = 'FlingTargetPlayer'
    TargetBox.Size = UDim2.new(0, 255, 0, 44)
    TargetBox.BackgroundTransparency = 0
    TargetBox.ClearTextOnFocus = false
    TargetBox.PlaceholderText = 'Target Player / Username'
    TargetBox.Text = tostring(_G.ResetHubSelectedPlayerName or '')
    TargetBox.Font = Enum.Font.GothamMedium
    TargetBox.TextSize = 10
    TargetBox.TextXAlignment = Enum.TextXAlignment.Left
    TargetBox.AutoLocalize = false
    TargetBox.Parent = TabFun
    RegisterThemeObject(TargetBox, 'BackgroundColor3', 'Card')
    RegisterThemeObject(TargetBox, 'TextColor3', 'Text')
    local tc = Instance.new('UICorner')
    tc.CornerRadius = UDim.new(0, 8)
    tc.Parent = TargetBox
    local tp = Instance.new('UIPadding')
    tp.PaddingLeft = UDim.new(0, 10)
    tp.PaddingRight = UDim.new(0, 8)
    tp.Parent = TargetBox
    local ts = Instance.new('UIStroke')
    ts.Thickness = 1
    ts.Transparency = 0.45
    ts.Parent = TargetBox
    RegisterThemeObject(ts, 'Color', 'Stroke')
    TargetBox.FocusLost:Connect(function()
        local player = ResolveResetHubPlayer(TargetBox.Text)
        if player then
            _G.ResetHubSelectedPlayerName = player.Name
            TargetBox.Text = player.Name
            Notify('Target: ' .. player.Name)
        else
            _G.ResetHubSelectedPlayerName = nil
            Notify('Target player not found')
        end
    end)

    AddFeatureButton(TabFun, 'Fling Selected Player', function()
        local selected = GetSelectedResetHubPlayer()
        if not selected or not IsEnemyPlayer(selected) then
            Notify('Set a valid target first')
            return
        end
        StopActiveFling()
        local root = GetRoot()
        local target = selected.Character and selected.Character:FindFirstChild('HumanoidRootPart')
        if not root or not target then return end
        local power = math.clamp(tonumber(_G.FlingPower) or 180, 10, 600)
        local started = os.clock()
        ActiveFlingCanCollide = root.CanCollide
        root.CanCollide = true
        ActiveFlingConnection = RunService.Heartbeat:Connect(function()
            if _G.ResetHubSession ~= ResetHubSession or not root.Parent or not target.Parent or os.clock() - started > 1.6 then
                StopActiveFling()
                return
            end
            power = math.clamp(tonumber(_G.FlingPower) or power, 10, 600)
            local angle = os.clock() * math.max(30, power * 0.34)
            local radius = math.clamp(1.5 + power / 360, 1.5, 4)
            local destination = target.Position + Vector3.new(math.cos(angle) * radius, 1.2 + math.sin(os.clock()*20) * 0.8, math.sin(angle) * radius)
            local delta = destination - root.Position
            local dir = delta.Magnitude > 0.05 and delta.Unit or Camera.CFrame.LookVector
            pcall(function()
                root.CFrame = CFrame.lookAt(destination, target.Position)
                root.AssemblyLinearVelocity = dir * (power * 3.5) + Vector3.new(0, power * 1.8, 0)
                root.AssemblyAngularVelocity = Vector3.new(power * 3.5, power * 7.0, power * 3.5)
                root:ApplyImpulse(dir * power * root.AssemblyMass * 1.25 + Vector3.new(0, power * root.AssemblyMass * 0.95, 0))
            end)
            pcall(function()
                target.AssemblyLinearVelocity = dir * (power * 4.0) + Vector3.new(0, power * 2.1, 0)
                target.AssemblyAngularVelocity = Vector3.new(power * 3.0, power * 7.5, power * 3.0)
                target:ApplyImpulse(dir * power * target.AssemblyMass * 1.65 + Vector3.new(0, power * target.AssemblyMass * 1.15, 0))
            end)
        end)
    end)
end

AddFeatureButton(TabFun, 'Fling Nearest Player', function()
    StopActiveFling()
    local root = GetRoot()
    if not root then return end

    local nearest, dist = nil, math.huge
    for _, p in ipairs(GetOtherPlayers()) do
        local pr = p.Character and p.Character:FindFirstChild('HumanoidRootPart')
        if pr then
            local d = (pr.Position - root.Position).Magnitude
            if d < dist then
                dist, nearest = d, p
            end
        end
    end

    if not nearest then return end
    local target = nearest.Character and nearest.Character:FindFirstChild('HumanoidRootPart')
    if not target then return end

    local power = math.clamp(tonumber(_G.FlingPower) or 180, 10, 500)
    local started = os.clock()
    ActiveFlingCanCollide = root.CanCollide
    root.CanCollide = true
    ActiveFlingConnection = RunService.Heartbeat:Connect(function()
        if _G.ResetHubSession ~= ResetHubSession then
            StopActiveFling()
            return
        end
        if not root.Parent or not target.Parent or os.clock() - started > 1.35 then
            StopActiveFling()
            return
        end

        power = math.clamp(tonumber(_G.FlingPower) or power or 180, 10, 500)
        local angle = os.clock() * math.max(35, power * 0.30)
        local radius = math.clamp(1.5 + power / 380, 1.5, 3.6)
        local offset = Vector3.new(
            math.cos(angle) * radius,
            0.9 + math.sin(os.clock() * 17) * 0.65,
            math.sin(angle) * radius
        )
        local destination = target.Position + offset
        local delta = destination - root.Position
        local direction = delta.Magnitude > 0.05 and delta.Unit or Camera.CFrame.LookVector

        pcall(function()
            root.CFrame = CFrame.lookAt(destination, target.Position)
            root.AssemblyLinearVelocity = direction * (power * 3.2) + Vector3.new(0, power * 1.6, 0)
            root.AssemblyAngularVelocity = Vector3.new(power * 3.0, power * 6.5, power * 3.0)
            pcall(function() root:ApplyImpulse(direction * power * root.AssemblyMass * 1.15 + Vector3.new(0, power * root.AssemblyMass * 0.85, 0)) end)
        end)
        pcall(function()
            target.AssemblyLinearVelocity = direction * (power * 3.4) + Vector3.new(0, power * 1.85, power * 0)
            target.AssemblyAngularVelocity = Vector3.new(power * 2.8, power * 7.0, power * 2.8)
            pcall(function() target:ApplyImpulse(direction * power * target.AssemblyMass * 1.45 + Vector3.new(0, power * target.AssemblyMass * 1.0, 0)) end)
            local body = target:FindFirstChild('ResetHub_FlingVelocity')
            if not body then
                body = Instance.new('BodyVelocity')
                body.Name = 'ResetHub_FlingVelocity'
                body.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                body.P = 1e5
                body.Parent = target
            end
            body.Velocity = direction * (power * 3.6) + Vector3.new(0, power * 1.95, 0)
        end)
    end)
end)

do
    FlingMin, FlingMax = 60, 600
    _G.FlingPower = math.clamp(tonumber(_G.FlingPower) or 180, FlingMin, FlingMax)
    FlingInput = nil
    FlingFrame = AddFeatureSlider(TabFun, 'Fling Power', FlingMin, FlingMax, _G.FlingPower, function(v)
        _G.FlingPower = math.clamp(math.floor(tonumber(v) or 180), FlingMin, FlingMax)
        if FlingInput and FlingInput.Parent then FlingInput.Text = tostring(_G.FlingPower) end
    end)
    FlingInput = Instance.new('TextBox')
    FlingInput.Name = 'FlingPowerInput'
    FlingInput.Size = UDim2.new(0,58,0,20)
    FlingInput.Position = UDim2.new(1,-66,0,1)
    FlingInput.ClearTextOnFocus = false
    FlingInput.Text = tostring(_G.FlingPower)
    FlingInput.Font = Enum.Font.GothamBold
    FlingInput.TextSize = 9
    FlingInput.TextXAlignment = Enum.TextXAlignment.Center
    FlingInput.ZIndex = 10
    FlingInput.Parent = FlingFrame
    RegisterThemeObject(FlingInput,'BackgroundColor3','Sidebar')
    RegisterThemeObject(FlingInput,'TextColor3','Text')
    FlingCorner = Instance.new('UICorner')
    FlingCorner.CornerRadius = UDim.new(0,5)
    FlingCorner.Parent = FlingInput
    FlingInput.FocusLost:Connect(function()
        local v = math.clamp(math.floor(tonumber(FlingInput.Text) or 180), FlingMin, FlingMax)
        _G.FlingPower = v
        FlingInput.Text = tostring(v)
    end)
end


AddFeatureButton(TabFun, 'Clear Local Effects', function()
    local char = GetCharacter()
    if char then
        for _, obj in ipairs(char:GetDescendants()) do
            if obj:IsA('Highlight') or obj.Name:find('ResetHub_') then obj:Destroy() end
        end
    end
end)




-----------------------------------------------------------
-- TOOLS & ITEMS
-----------------------------------------------------------
do
    local ToolFolder = Instance.new("Folder")
    ToolFolder.Name = "ResetHub_Tools"
    ToolFolder.Parent = LocalPlayer

    local function GetBackpack()
        return LocalPlayer:FindFirstChildOfClass("Backpack")
    end

    local function RemoveTool(toolName)
        local backpack = GetBackpack()
        local char = GetCharacter()
        if backpack then
            local t = backpack:FindFirstChild(toolName)
            if t then t:Destroy() end
        end
        if char then
            local t = char:FindFirstChild(toolName)
            if t then t:Destroy() end
        end
    end

    -- Use the historical Roblox build-tool assets directly.
    -- The original classic model is preserved; click behavior is bound here
    -- because the old embedded scripts do not run reliably on modern clients.
    local ClassicToolConnections = {}

    local function DisconnectClassicTool(name)
        local data = ClassicToolConnections[name]
        if data then
            for _, connection in pairs(data) do
                pcall(function() connection:Disconnect() end)
            end
            ClassicToolConnections[name] = nil
        end
    end

    local function IsBuildTarget(part)
        if not part or not part:IsA("BasePart") then return false end
        if part.Locked then return false end
        if LocalPlayer.Character and part:IsDescendantOf(LocalPlayer.Character) then return false end
        local model = part:FindFirstAncestorOfClass("Model")
        if model and model:FindFirstChildOfClass("Humanoid") then return false end
        return true
    end

    local function BindClassicToolBehavior(tool, mode)
        DisconnectClassicTool(mode)

        pcall(function() tool.RequiresHandle = false end)
        pcall(function() tool.ManualActivationOnly = false end)

        local equippedMouse = Mouse
        local mouseDownConnection
        local equipConnection = tool.Equipped:Connect(function(toolMouse)
            equippedMouse = toolMouse or Mouse
        end)

        local unequipConnection = tool.Unequipped:Connect(function()
            equippedMouse = Mouse
        end)

        local busy = false
        local function HandleClick()
            if busy or _G.ResetHubSession ~= ResetHubSession then return end
            busy = true
            task.delay(0.08, function() busy = false end)

            local mouse = equippedMouse or Mouse
            local target = mouse and mouse.Target
            if not IsBuildTarget(target) then return end

            if mode == "Copy" then
                local clone
                local oldArchivable = target.Archivable
                pcall(function()
                    target.Archivable = true
                    clone = target:Clone()
                end)
                pcall(function() target.Archivable = oldArchivable end)

                if clone then
                    clone.Parent = target.Parent
                    pcall(function()
                        clone.CFrame = target.CFrame + (target.CFrame.RightVector * math.max(target.Size.X, clone.Size.X, 2))
                    end)
                    pcall(function() clone.Anchored = target.Anchored end)
                    pcall(function() clone.CanCollide = target.CanCollide end)
                    pcall(function() clone.AssemblyLinearVelocity = Vector3.zero end)
                    pcall(function() clone.AssemblyAngularVelocity = Vector3.zero end)
                end
            elseif mode == "Delete" then
                local position = target.Position
                pcall(function() target:Destroy() end)

                -- Keep the classic-style local feedback without replacing the tool model.
                pcall(function()
                    local fx = Instance.new("Explosion")
                    fx.Position = position
                    fx.BlastRadius = 0
                    fx.BlastPressure = 0
                    fx.DestroyJointRadiusPercent = 0
                    fx.ExplosionType = Enum.ExplosionType.NoCraters
                    fx.Parent = workspace
                    task.delay(0.12, function()
                        if fx and fx.Parent then fx:Destroy() end
                    end)
                end)
            end
        end

        -- Legacy tools traditionally use the equipped mouse's Button1Down event.
        mouseDownConnection = tool.Equipped:Connect(function(toolMouse)
            local m = toolMouse or Mouse
            pcall(function()
                if ClassicToolConnections[mode] and ClassicToolConnections[mode].mouseDown then
                    ClassicToolConnections[mode].mouseDown:Disconnect()
                end
            end)
            local conn = m.Button1Down:Connect(HandleClick)
            if ClassicToolConnections[mode] then
                ClassicToolConnections[mode].mouseDown = conn
            end
            equippedMouse = m
        end)

        local activatedConnection = tool.Activated:Connect(HandleClick)

        ClassicToolConnections[mode] = {
            equipConnection,
            unequipConnection,
            mouseDownConnection,
            activatedConnection
        }
        ClassicToolConnections[mode].mouseDown = nil
    end

    local function LoadAssetContainer(assetId)
        local objects = nil
        local ok = pcall(function()
            objects = game:GetObjects("rbxassetid://" .. tostring(assetId))
        end)
        if ok and objects and objects[1] then
            return objects[1]
        end
        local success, model = pcall(function()
            return game:GetService('InsertService'):LoadAsset(assetId)
        end)
        return success and model or nil
    end

    local function CreateFallbackBuildTool(requestedName)
        local backpack = GetBackpack()
        if not backpack then return nil end
        RemoveTool(requestedName)
        local tool = Instance.new('Tool')
        tool.Name = requestedName
        tool.ToolTip = requestedName .. ' (local fallback)'
        tool.CanBeDropped = false
        tool.RequiresHandle = true
        local handle = Instance.new('Part')
        handle.Name = 'Handle'
        handle.Size = Vector3.new(0.25, 2.4, 0.25)
        handle.CanCollide = false
        handle.Massless = true
        handle.Color = requestedName == 'Copy' and Color3.fromRGB(20,20,20) or Color3.fromRGB(120,85,45)
        handle.Parent = tool
        tool.Parent = backpack
        BindClassicToolBehavior(tool, requestedName)
        return tool
    end

    local function LoadLegacyBuildTool(assetId, requestedName, fallbackAssetId)
        local backpack = GetBackpack()
        if not backpack then
            error("Backpack is unavailable")
        end

        DisconnectClassicTool(requestedName)
        RemoveTool(requestedName)

        local source = LoadAssetContainer(assetId)
        if not source and fallbackAssetId then
            source = LoadAssetContainer(fallbackAssetId)
        end
        if not source then
            local fallback = CreateFallbackBuildTool(requestedName)
            if fallback then return fallback end
            error("Legacy build tool could not be loaded")
        end

        local tool = source:IsA("Tool") and source or source:FindFirstChildWhichIsA("Tool", true)
        if not tool then
            pcall(function() source:Destroy() end)
            local fallback = CreateFallbackBuildTool(requestedName)
            if fallback then return fallback end
            error("Legacy asset does not contain a Tool")
        end

        tool.Name = requestedName
        tool.ToolTip = requestedName
        tool.CanBeDropped = false
        pcall(function() tool.Enabled = true end)
        pcall(function() tool.RequiresHandle = false end)
        for _, part in ipairs(tool:GetDescendants()) do
            if part:IsA('BasePart') then
                pcall(function() part.Anchored = false end)
                pcall(function() part.CanCollide = false end)
                pcall(function() part.Massless = true end)
            end
        end
        tool.Parent = backpack

        if source ~= tool then
            pcall(function() source:Destroy() end)
        end

        BindClassicToolBehavior(tool, requestedName)
        return tool
    end

    AddButton(TabTools, "ToolF3X", function()
        local ok, err = pcall(function()
            local objects = game:GetObjects("rbxassetid://6695644299")
            local sourceObject = objects and objects[1]
            if not sourceObject or type(sourceObject.Source) ~= "string" then
                error("F3X source is unavailable in this client")
            end
            local runner = loadstring(sourceObject.Source)
            if type(runner) ~= "function" then
                error("F3X source could not be loaded")
            end
            runner()
        end)
        if not ok then
            Notify("F3X Error: " .. tostring(err))
        end
    end)

    -- Classic Roblox Copy Tool: old wand-like building tool.
    -- Use a real Tool-containing classic model first; historical HopperBin remains the fallback.
    AddButton(TabTools, "ToolCopy", function()
        local ok, err = pcall(function()
            LoadLegacyBuildTool(59518544, "Copy", 86699884)
        end)
        if not ok then
            Notify("Copy Error: " .. tostring(err))
        end
    end)

    -- Classic Roblox Delete Tool: old hammer-like building tool.
    -- Creator Store model: 64287204; old HopperBin asset kept as fallback.
    AddButton(TabTools, "ToolDelete", function()
        local ok, err = pcall(function()
            LoadLegacyBuildTool(64287204, "Delete", 16201628)
        end)
        if not ok then
            Notify("Delete Error: " .. tostring(err))
        end
    end)

    -- Classic-style BTools suite. These are intentionally local/client-side tools.
    local BToolConnections = {}
    local function DisconnectBTools()
        for _, c in pairs(BToolConnections) do pcall(function() c:Disconnect() end) end
        BToolConnections = {}
    end
    local function RemoveBTools()
        local backpack = GetBackpack()
        local char = GetCharacter()
        for _, container in ipairs({backpack, char}) do
            if container then
                for _, obj in ipairs(container:GetChildren()) do
                    if obj:IsA('Tool') and obj:GetAttribute('ResetHubBTool') then
                        obj:Destroy()
                    end
                end
            end
        end
    end
    local function CreateBTool(name, action)
        local backpack = GetBackpack()
        if not backpack then return nil end
        local tool = Instance.new('Tool')
        tool.Name = name
        tool.ToolTip = 'BTools - ' .. name
        tool.CanBeDropped = false
        tool.RequiresHandle = true
        tool:SetAttribute('ResetHubBTool', true)
        local handle = Instance.new('Part')
        handle.Name = 'Handle'
        handle.Size = Vector3.new(0.3, 2.2, 0.3)
        handle.CanCollide = false
        handle.Massless = true
        handle.Color = Color3.fromRGB(180,180,180)
        handle.Parent = tool
        tool.Parent = backpack
        table.insert(BToolConnections, tool.Activated:Connect(function()
            local target = Mouse.Target
            if not IsBuildTarget(target) then
                Notify(name .. ': hedef bulunamadı')
                return
            end
            local ok, err = pcall(function() action(target) end)
            if not ok then Notify(name .. ' Error: ' .. tostring(err)) end
        end))
        return tool
    end

    AddButton(TabTools, "BTools", function()
        DisconnectBTools()
        RemoveBTools()
        local made = 0
        local actions = {
            Move = function(part)
                local hit = Mouse.Hit
                if hit then part.CFrame = CFrame.new(hit.Position + Vector3.new(0, part.Size.Y * 0.5, 0)) * (part.CFrame - part.CFrame.Position) end
            end,
            Resize = function(part)
                part.Size = Vector3.new(math.clamp(part.Size.X * 1.2, 0.2, 200), math.clamp(part.Size.Y * 1.2, 0.2, 200), math.clamp(part.Size.Z * 1.2, 0.2, 200))
            end,
            Rotate = function(part)
                part.CFrame = part.CFrame * CFrame.Angles(0, math.rad(90), 0)
            end,
            Anchor = function(part)
                part.Anchored = not part.Anchored
            end,
            Color = function(part)
                part.Color = Color3.fromHSV((os.clock() * 0.17) % 1, 0.85, 1)
            end,
            Copy = function(part)
                local old = part.Archivable
                part.Archivable = true
                local clone = part:Clone()
                part.Archivable = old
                if clone then
                    clone.CFrame = part.CFrame + Vector3.new(math.max(part.Size.X, 2), 0, 0)
                    clone.Parent = part.Parent
                end
            end,
            Delete = function(part)
                part:Destroy()
            end
        }
        for name, action in pairs(actions) do
            if CreateBTool(name, action) then made = made + 1 end
        end
        Notify('BTools hazır: ' .. tostring(made) .. ' araç')
    end)

end

-----------------------------------------------------------
-- 9. OTHER...
-----------------------------------------------------------
UtilityWindows = {}
UtilityLogs = {}
UtilityLogLabels = {}

local function AddUtilityLog(message)
    local line = os.date('%H:%M:%S') .. ' | ' .. tostring(message)
    table.insert(UtilityLogs, line)
    if #UtilityLogs > 150 then table.remove(UtilityLogs, 1) end
    for _, label in ipairs(UtilityLogLabels) do
        if label and label.Parent then label.Text = table.concat(UtilityLogs, '\n') end
    end
end

-- Lightweight hook for existing notifications.
local ExistingNotify = Notify
Notify = function(msg)
    AddUtilityLog(msg)
    return ExistingNotify(msg)
end

local function MakeUtilityWindow(name, title, size)
    local old = UtilityWindows[name]
    if old and old.Parent then
        old.Visible = not old.Visible
        return old
    end
    local frame = Instance.new('Frame')
    frame.Name = 'ResetHubUtility_' .. name
    frame.Size = size or UDim2.new(0, 500, 0, 360)
    frame.Position = UDim2.new(0.5, -(frame.Size.X.Offset / 2), 0.5, -(frame.Size.Y.Offset / 2))
    frame.BackgroundTransparency = 0
    frame.ZIndex = 300
    frame.Parent = ScreenGui
    RegisterThemeObject(frame, 'BackgroundColor3', 'Main')
    local corner = Instance.new('UICorner'); corner.CornerRadius = UDim.new(0, 12); corner.Parent = frame
    local stroke = Instance.new('UIStroke'); stroke.Thickness = 1; stroke.Parent = frame; RegisterThemeObject(stroke, 'Color', 'Accent')

    local top = Instance.new('Frame'); top.Size = UDim2.new(1,0,0,38); top.BackgroundTransparency=1; top.ZIndex=301; top.Parent=frame
    local lbl = Instance.new('TextLabel'); lbl.Size=UDim2.new(1,-48,1,0); lbl.Position=UDim2.new(0,12,0,0); lbl.BackgroundTransparency=1; lbl.Text=title; lbl.Font=Enum.Font.GothamBold; lbl.TextSize=13; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=302; lbl.Parent=top; RegisterThemeObject(lbl,'TextColor3','Text')
    local close=Instance.new('TextButton'); close.Name='Close'; close.Size=UDim2.new(0,32,0,26); close.Position=UDim2.new(1,-38,0,6); close.Text='X'; close.Font=Enum.Font.GothamBold; close.TextSize=11; close.AutoButtonColor=false; close.ZIndex=302; close.Parent=top; RegisterThemeObject(close,'BackgroundColor3','Card'); RegisterThemeObject(close,'TextColor3','Text')
    local cc=Instance.new('UICorner'); cc.CornerRadius=UDim.new(0,7); cc.Parent=close
    close.MouseButton1Click:Connect(function() frame.Visible=false end)
    UtilityWindows[name]=frame
    return frame
end

local function ShowConsole()
    local openedDevConsole = pcall(function() StarterGui:SetCore('DevConsoleVisible', true) end)
    if openedDevConsole then return end
    local frame = MakeUtilityWindow('Console', 'ResetHub Console', UDim2.new(0, 560, 0, 380))
    frame.Visible=true
    local out = frame:FindFirstChild('ConsoleOutput')
    if not out then
        out=Instance.new('TextLabel'); out.Name='ConsoleOutput'; out.Size=UDim2.new(1,-24,1,-98); out.Position=UDim2.new(0,12,0,46); out.BackgroundColor3=Color3.fromRGB(7,7,9); out.TextColor3=Color3.fromRGB(220,220,220); out.TextXAlignment=Enum.TextXAlignment.Left; out.TextYAlignment=Enum.TextYAlignment.Top; out.TextWrapped=false; out.Font=Enum.Font.Code; out.TextSize=11; out.ZIndex=301; out.Parent=frame
        local pad=Instance.new('UIPadding'); pad.PaddingLeft=UDim.new(0,8); pad.PaddingTop=UDim.new(0,8); pad.Parent=out
        local input=Instance.new('TextBox'); input.Name='ConsoleInput'; input.Size=UDim2.new(1,-96,0,34); input.Position=UDim2.new(0,12,1,-46); input.PlaceholderText='clear | placeid | jobid | players | goto NAME | rejoin'; input.Text=''; input.Font=Enum.Font.Code; input.TextSize=11; input.ClearTextOnFocus=false; input.ZIndex=302; input.Parent=frame
        local run=Instance.new('TextButton'); run.Size=UDim2.new(0,70,0,34); run.Position=UDim2.new(1,-82,1,-46); run.Text='RUN'; run.Font=Enum.Font.GothamBold; run.TextSize=10; run.ZIndex=302; run.Parent=frame; RegisterThemeObject(run,'BackgroundColor3','Accent'); RegisterThemeObject(run,'TextColor3','Text')
        local function execute()
            local cmd=input.Text:match('^%s*(.-)%s*$')
            if cmd=='' then return end
            AddUtilityLog('> '..cmd)
            local lower=cmd:lower()
            if lower=='clear' then UtilityLogs={} AddUtilityLog('Console cleared')
            elseif lower=='placeid' then AddUtilityLog('PlaceId: '..tostring(game.PlaceId))
            elseif lower=='jobid' then AddUtilityLog('JobId: '..tostring(game.JobId))
            elseif lower=='players' then AddUtilityLog('Players: '..tostring(#Players:GetPlayers()))
            elseif lower=='rejoin' then TeleportService:Teleport(game.PlaceId, LocalPlayer)
            elseif lower:sub(1,5)=='goto ' then
                local query=cmd:sub(6):lower(); local found
                for _,p in ipairs(Players:GetPlayers()) do if p~=LocalPlayer and (p.Name:lower():find(query,1,true) or p.DisplayName:lower():find(query,1,true)) then found=p; break end end
                local root=GetRoot(); local pr=found and found.Character and found.Character:FindFirstChild('HumanoidRootPart')
                if root and pr then root.CFrame=pr.CFrame+Vector3.new(0,3,0); AddUtilityLog('Goto: '..found.Name) else AddUtilityLog('Oyuncu bulunamadı') end
            else AddUtilityLog('Komut yok. clear/placeid/jobid/players/goto/rejoin') end
            input.Text=''
            if out and out.Parent then out.Text=table.concat(UtilityLogs,'\n') end
        end
        run.MouseButton1Click:Connect(execute); input.FocusLost:Connect(function(enter) if enter then execute() end end)
        table.insert(UtilityLogLabels,out)
    end
    out.Text=table.concat(UtilityLogs,'\n')
end

local function ShowGoto()
    local frame=MakeUtilityWindow('Goto','Goto Player',UDim2.new(0,430,0,420)); frame.Visible=true
    local content=frame:FindFirstChild('GotoContent')
    if content then content:Destroy() end
    content=Instance.new('ScrollingFrame'); content.Name='GotoContent'; content.Size=UDim2.new(1,-24,1,-58); content.Position=UDim2.new(0,12,0,46); content.BackgroundTransparency=1; content.BorderSizePixel=0; content.ScrollBarThickness=3; content.ZIndex=301; content.Parent=frame
    RegisterThemeObject(content,'ScrollBarImageColor3','Accent')
    local layout=Instance.new('UIListLayout'); layout.Padding=UDim.new(0,6); layout.Parent=content
    local pad=Instance.new('UIPadding'); pad.PaddingTop=UDim.new(0,2); pad.PaddingBottom=UDim.new(0,8); pad.Parent=content
    layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function() content.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+12) end)
    for _,p in ipairs(Players:GetPlayers()) do
        if p~=LocalPlayer then
            local b=Instance.new('TextButton'); b.Size=UDim2.new(1,-4,0,32); b.Text=p.DisplayName..'  @'..p.Name; b.Font=Enum.Font.GothamMedium; b.TextSize=10; b.AutoButtonColor=false; b.ZIndex=302; b.Parent=content; RegisterThemeObject(b,'BackgroundColor3','Card'); RegisterThemeObject(b,'TextColor3','Text')
            local bc=Instance.new('UICorner'); bc.CornerRadius=UDim.new(0,8); bc.Parent=b
            b.MouseButton1Click:Connect(function()
                local r=GetRoot(); local pr=p.Character and p.Character:FindFirstChild('HumanoidRootPart')
                if r and pr then r.CFrame=pr.CFrame+Vector3.new(0,3,0); AddUtilityLog('Goto: '..p.Name); Notify('Goto: '..p.Name) end
            end)
        end
    end
end

local function ShowLogs()
    local frame=MakeUtilityWindow('Logs','ResetHub Logs',UDim2.new(0,560,0,380)); frame.Visible=true
    local out=frame:FindFirstChild('LogsOutput')
    if not out then
        out=Instance.new('TextLabel'); out.Name='LogsOutput'; out.Size=UDim2.new(1,-24,1,-90); out.Position=UDim2.new(0,12,0,46); out.BackgroundColor3=Color3.fromRGB(7,7,9); out.TextColor3=Color3.fromRGB(220,220,220); out.TextXAlignment=Enum.TextXAlignment.Left; out.TextYAlignment=Enum.TextYAlignment.Top; out.Font=Enum.Font.Code; out.TextSize=10; out.ZIndex=301; out.Parent=frame; table.insert(UtilityLogLabels,out)
    end
    out.Text=table.concat(UtilityLogs,'\n')
end

local function ShowDarkChat()
    local frame=MakeUtilityWindow('DarkChat','DarkChat',UDim2.new(0,540,0,420)); frame.Visible=true
    local feed=frame:FindFirstChild('ChatFeed')
    if not feed then
        feed=Instance.new('TextLabel'); feed.Name='ChatFeed'; feed.Size=UDim2.new(1,-24,1,-100); feed.Position=UDim2.new(0,12,0,46); feed.BackgroundColor3=Color3.fromRGB(7,7,9); feed.TextColor3=Color3.fromRGB(235,235,235); feed.TextXAlignment=Enum.TextXAlignment.Left; feed.TextYAlignment=Enum.TextYAlignment.Top; feed.Font=Enum.Font.Gotham; feed.TextSize=10; feed.ZIndex=301; feed.Text='DarkChat hazır.\n'; feed.Parent=frame
        local box=Instance.new('TextBox'); box.Name='ChatInput'; box.Size=UDim2.new(1,-92,0,34); box.Position=UDim2.new(0,12,1,-46); box.PlaceholderText='Mesaj...'; box.ClearTextOnFocus=false; box.Font=Enum.Font.Gotham; box.TextSize=10; box.ZIndex=302; box.Parent=frame
        local send=Instance.new('TextButton'); send.Size=UDim2.new(0,68,0,34); send.Position=UDim2.new(1,-80,1,-46); send.Text='SEND'; send.Font=Enum.Font.GothamBold; send.TextSize=10; send.ZIndex=302; send.Parent=frame; RegisterThemeObject(send,'BackgroundColor3','Accent'); RegisterThemeObject(send,'TextColor3','Text')
        local function sendMsg() local txt=box.Text; if txt=='' then return end; local channels=TextChatService:FindFirstChild('TextChannels'); local general=channels and channels:FindFirstChild('RBXGeneral'); if general and type(general.SendAsync)=='function' then pcall(function() general:SendAsync(txt) end) end; AddUtilityLog('[Chat] '..txt); box.Text='' end
        send.MouseButton1Click:Connect(sendMsg); box.FocusLost:Connect(function(enter) if enter then sendMsg() end end)
        if TextChatService.MessageReceived then
            TextChatService.MessageReceived:Connect(function(message) if message and message.Text then feed.Text=(feed.Text or '')..(message.PrefixText or message.TextSource and message.TextSource.Name or 'Player')..': '..message.Text..'\n' end end)
        end
    end
end

local function DuplicateHeldItem()
    local char=GetCharacter(); local backpack=LocalPlayer:FindFirstChildOfClass('Backpack'); local tool=char and char:FindFirstChildOfClass('Tool')
    if not tool or not backpack then Notify('Elde tutulan Tool yok'); return end
    local old=tool.Archivable; tool.Archivable=true
    local ok,clone=pcall(function() return tool:Clone() end); tool.Archivable=old
    if ok and clone then clone.Parent=backpack; Notify('Eşyanın client-side kopyası oluşturuldu') else Notify('Eşya kopyalanamadı') end
end

AddFeatureButton(TabOther,'Console',ShowConsole)
AddFeatureButton(TabOther,'Goto',ShowGoto)
AddFeatureButton(TabOther,'Logs',ShowLogs)
AddFeatureButton(TabOther,'DarkChat',ShowDarkChat)
AddFeatureButton(TabOther,'Duplicate Held Item',DuplicateHeldItem)

-- ---------------------------------------------------------
-- EMOTES (stable button-driven implementation)
-- ---------------------------------------------------------
local ActiveEmoteTrack = nil
local EmoteAnimator = nil

-- Roblox's default R15 emote animation references.
-- Multiple dance variants are included so the dance buttons do not all play the same track.
local ClassicEmoteIds = {
    wave = {R6 = {128777973}, R15 = {12521004586, 507770239}},
    point = {R6 = {128853357}, R15 = {12521007694, 507770453}},
    cheer = {R6 = {129423030}, R15 = {12521021991, 507770677}},
    laugh = {R6 = {129423131}, R15 = {12521018724, 507770818}},
    dance = {R6 = {182435998}, R15 = {12521009666, 507771019, 507771955, 507772104}},
    dance2 = {R6 = {182491037, 182436842, 182491248}, R15 = {12521151637, 12521169800, 12521173533, 507776043, 507776720, 507776879}},
    dance3 = {R6 = {182491065, 182436935, 182491368, 182491423}, R15 = {12521015053, 12521178362, 12521181508, 12521184133, 507777268, 507777451, 507777623}}
}

local EmoteAliases = {
    hello='wave', salute='wave', shrug='point', stadium='cheer',
    dance4='dance', dance5='dance2', floss='dance3', shuffle='dance2',
    robot='dance', twirl='dance2', cartwheel='dance3', monkey='dance', tilt='dance'
}

local LoopingEmotes = {
    dance=true, dance2=true, dance3=true, dance4=true, dance5=true,
    floss=true, shuffle=true, robot=true, twirl=true, cartwheel=true,
    monkey=true, tilt=true
}

local function GetEmoteHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass('Humanoid')
end

local function StopActiveEmote()
    if ActiveEmoteTrack then
        pcall(function() ActiveEmoteTrack:Stop(0.10) end)
        pcall(function() ActiveEmoteTrack:Destroy() end)
        ActiveEmoteTrack = nil
    end
end

local function GetEmoteAnimator(hum)
    if EmoteAnimator and EmoteAnimator.Parent == hum then return EmoteAnimator end
    EmoteAnimator = hum:FindFirstChildOfClass('Animator')
    if not EmoteAnimator then
        local ok, animator = pcall(function()
            local a = Instance.new('Animator')
            a.Parent = hum
            return a
        end)
        if ok then EmoteAnimator = animator end
    end
    return EmoteAnimator
end

local function PlayAnimationId(hum, assetId, looped)
    local animator = GetEmoteAnimator(hum)
    local id = tonumber(assetId)
    if not animator or not id then return false end

    local anim = Instance.new('Animation')
    anim.AnimationId = 'rbxassetid://' .. tostring(id)
    local ok, track = pcall(function() return animator:LoadAnimation(anim) end)
    if not ok or not track then
        pcall(function() anim:Destroy() end)
        return false
    end

    track.Priority = Enum.AnimationPriority.Action4
    track.Looped = looped == true
    local started = pcall(function() track:Play(0.10, 1, 1) end)
    if not started then
        pcall(function() track:Destroy() end)
        pcall(function() anim:Destroy() end)
        return false
    end

    ActiveEmoteTrack = track
    track.Stopped:Connect(function()
        if ActiveEmoteTrack == track then ActiveEmoteTrack = nil end
        pcall(function() track:Destroy() end)
        pcall(function() anim:Destroy() end)
    end)
    return true
end

local function GetDescriptionEmoteId(hum, requested)
    local desc
    if not pcall(function() desc = hum:GetAppliedDescription() end) or not desc then return nil, nil end

    local emotes
    if not pcall(function() emotes = desc:GetEmotes() end) or type(emotes) ~= 'table' then return nil, nil end

    local want = string.lower(tostring(requested))
    local aliases = {hello='wave', salute='wave', shrug='point', stadium='cheer'}
    local canonical = aliases[want] or want

    for name, ids in pairs(emotes) do
        local lname = string.lower(tostring(name))
        if lname == canonical or lname == want then
            if type(ids) == 'table' and #ids > 0 then
                return tostring(name), tonumber(ids[math.random(1, #ids)])
            end
        end
    end
    return nil, nil
end

local function TrySlashEmote(apiName)
    local ok, sent = pcall(function()
        local channels = TextChatService:FindFirstChild('TextChannels')
        local general = channels and channels:FindFirstChild('RBXGeneral')
        if not general or type(general.SendAsync) ~= 'function' then return false end
        general:SendAsync('/e ' .. tostring(apiName))
        return true
    end)
    return ok and sent == true
end

local function PlayRequestedEmote(name)
    local hum = GetEmoteHumanoid()
    if not hum or hum.Health <= 0 then
        Notify('Emote: karakter hazır değil')
        return
    end

    StopActiveEmote()
    local requested = string.lower(tostring(name))
    local canonical = EmoteAliases[requested] or requested
    local descName, descId = GetDescriptionEmoteId(hum, requested)
    if descName and descId and PlayAnimationId(hum, descId, LoopingEmotes[requested] == true) then
        Notify('Emote: ' .. descName)
        return
    end

    local apiName = canonical
    local apiOk, apiResult = pcall(function() return hum:PlayEmoteAsync(apiName) end)
    if apiOk and apiResult == true then
        Notify('Emote: ' .. apiName)
        return
    end

    local builtIn = {wave=true, point=true, cheer=true, laugh=true, dance=true, dance2=true, dance3=true}
    if builtIn[canonical] and TrySlashEmote(apiName) then
        Notify('Emote: /e ' .. apiName)
        return
    end

    local pack = ClassicEmoteIds[canonical]
    if pack then
        local preferred = hum.RigType == Enum.HumanoidRigType.R6 and pack.R6 or pack.R15
        local secondary = hum.RigType == Enum.HumanoidRigType.R6 and pack.R15 or pack.R6
        local candidates = {}
        if preferred then
            for _, id in ipairs(preferred) do table.insert(candidates, id) end
        end
        if secondary then
            for _, id in ipairs(secondary) do table.insert(candidates, id) end
        end
        for i = #candidates, 2, -1 do
            local j = math.random(1, i)
            candidates[i], candidates[j] = candidates[j], candidates[i]
        end
        for _, id in ipairs(candidates) do
            if PlayAnimationId(hum, id, LoopingEmotes[requested] == true) then
                Notify('Emote: ' .. tostring(requested))
                return
            end
        end
    end

    Notify('Emote oynatılamadı: ' .. tostring(name))
end

local EmoteList = {
    {'Wave','wave'}, {'Point','point'}, {'Cheer','cheer'}, {'Laugh','laugh'},
    {'Dance','dance'}, {'Dance 2','dance2'}, {'Dance 3','dance3'}, {'Salute','salute'},
    {'Shrug','shrug'}, {'Hello','hello'}, {'Tilt','tilt'}, {'Stadium','stadium'},
    {'Dance 4','dance4'}, {'Dance 5','dance5'}, {'Floss','floss'}, {'Shuffle','shuffle'},
    {'Robot','robot'}, {'Twirl','twirl'}, {'Cartwheel','cartwheel'}, {'Monkey','monkey'}
}

for _, item in ipairs(EmoteList) do
    AddFeatureButton(TabEmotes, item[1], function()
        PlayRequestedEmote(item[2])
    end)
end

AddFeatureButton(TabEmotes, 'Play Equipped Emotes', function()
    local hum = GetEmoteHumanoid()
    if not hum then Notify('Emote: karakter hazır değil'); return end
    local desc
    if not pcall(function() desc = hum:GetAppliedDescription() end) or not desc then
        Notify('HumanoidDescription bulunamadı')
        return
    end
    local list
    if not pcall(function() list = desc:GetEquippedEmotes() end) or type(list) ~= 'table' or #list == 0 then
        Notify('Takılı emote bulunamadı')
        return
    end
    local pick = list[math.random(1, #list)]
    local name = type(pick) == 'table' and pick.Name or pick
    if name then PlayRequestedEmote(name) end
end)

AddFeatureButton(TabEmotes, 'Open Emote Wheel', function()
    local ok, result = pcall(function()
        return StarterGui:SetCore('EmoteMenuOpen', true)
    end)
    if ok and result ~= false then
        Notify('Emote menüsü açıldı')
    else
        Notify('Emote menüsü bu oyunda kullanılamıyor')
    end
end)

AddFeatureButton(TabEmotes, 'Stop Emote', StopActiveEmote)


-----------------------------------------------------------
-- 9. SETTINGS & THEMES
-----------------------------------------------------------
AddButton(TabSettings, "SwitchLang", function()
    SwitchLanguage()
end)

AddButton(TabSettings, "ThemeDark", function()
    ApplyTheme("Dark")
end)

AddButton(TabSettings, "ThemeBWDark", function()
    ApplyTheme("BlackAndWhiteDark")
end)

AddButton(TabSettings, "ThemeBWLight", function()
    ApplyTheme("BlackAndWhiteLight")
end)

AddButton(TabSettings, "Rejoin", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)



-- ---------------------------------------------------------
-- SETTINGS EXTENSIONS: 15+ total settings controls
-- ---------------------------------------------------------
AddFeatureButton(TabSettings, 'Notifications Toggle', function()
    NotificationsEnabled = not NotificationsEnabled
end)

AddFeatureButton(TabSettings, 'Reset Defaults', function()
    _G.WalkSpeedValue = 16
    _G.JumpPowerValue = 50
    _G.FlySpeedValue = 50
    _G.AimbotFOV = 150
    _G.AimbotSmoothness = 0.2
    _G.VelocityMultiplier = 0.15
    _G.VelocityVertical = 0.85
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed = 16; hum.UseJumpPower = true; hum.JumpPower = 50 end
    Camera.FieldOfView = OriginalFOV
    workspace.Gravity = OriginalGravity
    Lighting.FogStart = OriginalLighting.FogStart
    Lighting.FogEnd = OriginalLighting.FogEnd
    Lighting.GlobalShadows = OriginalLighting.GlobalShadows
end)

AddFeatureButton(TabSettings, 'Reset Camera', function()
    Camera.CameraType = SavedCameraType
    Camera.CameraSubject = SavedCameraSubject or GetHumanoid()
    Camera.FieldOfView = OriginalFOV
end)

AddFeatureButton(TabSettings, 'Reset Gravity', function() workspace.Gravity = OriginalGravity end)

AddFeatureButton(TabSettings, 'Reset Lighting', function()
    Lighting.Ambient = OriginalLighting.Ambient
    Lighting.Brightness = OriginalLighting.Brightness
    Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
    Lighting.ClockTime = OriginalLighting.ClockTime
end)

AddFeatureButton(TabSettings, 'Save Current Position', function()
    local root = GetRoot()
    if root then SavedPosition = root.CFrame end
end)

AddFeatureButton(TabSettings, 'Load Saved Position', function()
    local root = GetRoot()
    if root and SavedPosition then root.CFrame = SavedPosition end
end)

AddFeatureButton(TabSettings, 'Toggle Hub', function() MainFrame.Visible = not MainFrame.Visible end)
AddFeatureButton(TabSettings, 'Destroy Hub', function() ScreenGui:Destroy() end)
AddFeatureButton(TabSettings, 'Restore Local Collisions', function() SetCharacterCollision(true) end)
AddFeatureButton(TabSettings, 'Disable Local Noclip', function() _G.NoclipEnabled = false; SetCharacterCollision(true) end)
AddFeatureButton(TabSettings, 'Clear Local ESP', function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            for _, n in ipairs({'ESPHighlight', 'ResetHub_ESP', 'ResetHub_Chams', 'ResetHub_Name'}) do
                local obj = p.Character:FindFirstChild(n, true)
                if obj then obj:Destroy() end
            end
        end
    end
end)

AddFeatureSlider(TabSettings, 'UI Width', 650, 950, 740, function(val)
    local width = math.floor(val)
    MainFrame.Size = UDim2.new(0, width, 0, MainFrame.Size.Y.Offset)
end)

AddFeatureSlider(TabSettings, 'UI Height', 450, 700, 520, function(val)
    local height = math.floor(val)
    MainFrame.Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, height)
end)


-- Additive config/profile/keybind controls. Existing v23 controls are kept.
HttpService = game:GetService('HttpService')
ConfigProfile = 'Default'
ConfigProfiles = {Default=true, PvP=true, Movement=true, Visual=true}

local function ConfigPath()
    return 'ResetHub_' .. tostring(game.PlaceId) .. '_' .. ConfigProfile .. '.json'
end

local function CanFileIO()
    return type(writefile) == 'function' and type(readfile) == 'function' and type(isfile) == 'function'
end

local function BuildConfigData()
    local features = {}
    for k,v in pairs(FeatureState) do if type(v) == 'boolean' then features[k] = v end end
    local globals = {
        Aimbot=_G.AimbotEnabled, SilentAim=_G.SilentAimEnabled, Triggerbot=_G.TriggerbotEnabled,
        KillAura=_G.KillAuraEnabled, QFly=_G.QFlyEnabled, Noclip=_G.NoclipEnabled,
        ESP=_G.ESPEnabled, Fullbright=_G.FullbrightEnabled, XRay=_G.XRayEnabled, ShowFOV=_G.ShowFOVCircle
    }
    return {
        version=2, profile=ConfigProfile, lang=CurrentLang, theme=CurrentThemeName,
        WalkSpeed=_G.WalkSpeedValue, JumpPower=_G.JumpPowerValue, FlySpeed=_G.FlySpeedValue,
        FOV=_G.FovValue, AimbotFOV=_G.AimbotFOV, AimbotSmoothness=_G.AimbotSmoothness,
        VelocityMultiplier=_G.VelocityMultiplier, VelocityVertical=_G.VelocityVertical,
        VelocityThreshold=_G.VelocityThreshold, DashPower=_G.DashPower,
        features=features, globals=globals, keybinds=Keybinds
    }
end

local function SaveProfile()
    if not CanFileIO() then Notify('Executor file IO desteklemiyor'); return end
    local ok, data = pcall(function() return HttpService:JSONEncode(BuildConfigData()) end)
    if not ok then Notify('Config encode hatası'); return end
    local wrote = pcall(function() writefile(ConfigPath(), data) end)
    Notify(wrote and ('Config saved: ' .. ConfigProfile) or 'Config save failed')
end

local function LoadProfile()
    if not CanFileIO() or not isfile(ConfigPath()) then Notify('Config bulunamadı'); return end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(ConfigPath())) end)
    if not ok or type(data) ~= 'table' then Notify('Config decode hatası'); return end
    _G.WalkSpeedValue = tonumber(data.WalkSpeed) or _G.WalkSpeedValue
    _G.JumpPowerValue = tonumber(data.JumpPower) or _G.JumpPowerValue
    _G.FlySpeedValue = tonumber(data.FlySpeed) or _G.FlySpeedValue
    _G.FovValue = tonumber(data.FOV) or _G.FovValue
    _G.AimbotFOV = tonumber(data.AimbotFOV) or _G.AimbotFOV
    _G.AimbotSmoothness = tonumber(data.AimbotSmoothness) or _G.AimbotSmoothness
    _G.VelocityMultiplier = tonumber(data.VelocityMultiplier) or _G.VelocityMultiplier
    _G.VelocityVertical = tonumber(data.VelocityVertical) or _G.VelocityVertical
    _G.VelocityThreshold = tonumber(data.VelocityThreshold) or _G.VelocityThreshold
    _G.DashPower = tonumber(data.DashPower) or _G.DashPower
    if data.lang == 'TR' or data.lang == 'EN' then CurrentLang = data.lang end
    if data.theme and Themes[data.theme] then ApplyTheme(data.theme) end
    if type(data.keybinds) == 'table' then
        Keybinds = {}
        for k,v in pairs(data.keybinds) do if type(v) == 'string' then Keybinds[k] = v end end
        -- Never allow a stale config to bind Q to the auto-clicker.
        if Keybinds['Fast Auto Clicker'] == 'Q' then
            Keybinds['Fast Auto Clicker'] = nil
        end
        for feature in pairs(KeybindButtons) do RefreshKeybindBadge(feature) end
    end
    if type(data.globals) == 'table' then
        _G.AimbotEnabled = data.globals.Aimbot == true
        _G.SilentAimEnabled = data.globals.SilentAim == true
        _G.TriggerbotEnabled = data.globals.Triggerbot == true
        _G.KillAuraEnabled = data.globals.KillAura == true
        _G.QFlyEnabled = data.globals.QFly == true
        _G.NoclipEnabled = data.globals.Noclip == true
        _G.ESPEnabled = data.globals.ESP == true
        _G.FullbrightEnabled = data.globals.Fullbright == true
        _G.XRayEnabled = data.globals.XRay == true
        _G.ShowFOVCircle = data.globals.ShowFOV == true
    end
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed = _G.WalkSpeedValue; hum.UseJumpPower=true; hum.JumpPower=_G.JumpPowerValue end
    if _G.QFlyEnabled then StartQFly() else CleanupQFly() end
    Notify('Config loaded: ' .. ConfigProfile)
end

local function SafeMode()
    _G.AimbotEnabled=false; _G.SilentAimEnabled=false; _G.TriggerbotEnabled=false; _G.KillAuraEnabled=false
    _G.QFlyEnabled=false; CleanupQFly(); _G.NoclipEnabled=false; _G.NoDamageEnabled=false
    FeatureState.NoDamage=false
    for name in pairs(FeatureConnections) do SetFeatureConnection(name, false) end
    SetCharacterCollision(true)
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed=16; hum.UseJumpPower=true; hum.JumpPower=50; hum.PlatformStand=false end
    Camera.CameraType = SavedCameraType
    Camera.CameraSubject = SavedCameraSubject or hum
    Camera.FieldOfView = OriginalFOV
    workspace.Gravity = OriginalGravity
    Keybinds = {}
    FeatureState.ThirdPerson = false
    SetFeatureConnection('ThirdPerson', false)
    pcall(function() LocalPlayer.CameraMode = OriginalCameraMode end)
    pcall(function() LocalPlayer.CameraMinZoomDistance = OriginalCameraMinZoom end)
    pcall(function() LocalPlayer.CameraMaxZoomDistance = OriginalCameraMaxZoom end)
    for feature in pairs(KeybindButtons) do RefreshKeybindBadge(feature) end
    Notify('Safe Mode aktif')
end

AddFeatureButton(TabSettings, 'Profile: Default', function() ConfigProfile='Default'; Notify('Profile: Default') end)
AddFeatureButton(TabSettings, 'Profile: PvP', function() ConfigProfile='PvP'; Notify('Profile: PvP') end)
AddFeatureButton(TabSettings, 'Profile: Movement', function() ConfigProfile='Movement'; Notify('Profile: Movement') end)
AddFeatureButton(TabSettings, 'Profile: Visual', function() ConfigProfile='Visual'; Notify('Profile: Visual') end)
AddFeatureButton(TabSettings, 'Save Active Profile', SaveProfile)
AddFeatureButton(TabSettings, 'Load Active Profile', LoadProfile)
AddFeatureButton(TabSettings, 'Safe Mode', SafeMode)
AddFeatureButton(TabSettings, 'Clear All Keybinds', function() Keybinds={}; for feature in pairs(KeybindButtons) do RefreshKeybindBadge(feature) end end)



RequestKeybind = function(feature)
    CapturingKeybind = feature
    Notify('Keybind: ' .. feature .. ' | tuşa bas | ESC iptal | BACKSPACE sil')
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    local keyName = input.KeyCode and input.KeyCode.Name
    if not keyName or keyName == 'Unknown' then return end

    if CapturingKeybind then
        local feature = CapturingKeybind
        CapturingKeybind = nil
        if keyName == 'Escape' then Notify('Keybind iptal'); return end
        if keyName == 'Backspace' then
            Keybinds[feature] = nil
            RefreshKeybindBadge(feature)
            Notify('Keybind silindi: ' .. feature)
            return
        end
        if keyName == 'RightControl' or keyName == 'Insert' then
            Notify('RightControl / Insert arayüz için ayrıldı')
            return
        end
        if keyName == 'Q' then
            if feature == 'QFly' then
                Notify('QFly zaten Q tuşunu kullanıyor')
            else
                Notify('Q tuşu yalnızca QFly için ayrıldı')
            end
            return
        end
        ClearKeybind(keyName)
        Keybinds[feature] = keyName
        RefreshKeybindBadge(feature)
        Notify('Atandı: ' .. feature .. ' = ⌨ ' .. keyName)
        return
    end

    if keyName == 'Q' then return end
    for feature, key in pairs(Keybinds) do
        if key == keyName then
            -- Never start the mouse auto-clicker from a keybind.
            -- This prevents a stale/accidental key assignment from clicking unexpectedly.
            if feature == 'Fast Auto Clicker' then
                Notify('Fast Auto Clicker: sadece butondan acilir')
                break
            end
            for _, callback in ipairs(KeybindTargets[feature] or {}) do
                if type(callback) == 'function' then pcall(callback) end
            end
            for _, btn in ipairs(KeybindButtons[feature] or {}) do RefreshToggleIndicator(btn, feature) end
            break
        end
    end
end)

-- Keybind Toggle UI (RightControl / Insert)
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and (input.KeyCode == Enum.KeyCode.RightControl or input.KeyCode == Enum.KeyCode.Insert) then
        MainFrame.Visible = not MainFrame.Visible
    end
end)



_G.TargetStrafe = false
_G.IsFlying = false

-- Continuous velocity shaping; only active when Velocity Guard is enabled.
SetFeatureConnection('VelocityShape', true, RunService.Heartbeat, function()
    if not FeatureState.VelocityGuard then return end
    local root = GetRoot()
    if not root then return end
    local v = root.AssemblyLinearVelocity
    local mult = _G.VelocityMultiplier or 0.15
    local vertical = _G.VelocityVertical or 0.85
    local threshold = _G.VelocityThreshold or 24
    local h = Vector3.new(v.X, 0, v.Z)
    if h.Magnitude >= threshold then h = h * mult end
    root.AssemblyLinearVelocity = Vector3.new(h.X, v.Y * vertical, h.Z)
end)


-- =========================================================
-- OPENING ANIMATION / FINAL UI POLISH
-- =========================================================
NormalMainSize = MainFrame.Size
NormalMainPosition = MainFrame.Position
IsMinimized = false

MinimizeButton.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    Sidebar.Visible = not IsMinimized
    ContentCard.Visible = not IsMinimized
    if IsMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, NormalMainSize.X.Offset, 0, 62)
        }):Play()
        MinimizeButton.Text = "RESTORE"
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = NormalMainSize
        }):Play()
        MinimizeButton.Text = "MINIMIZE"
    end
end)


fpsSamples = {}
fpsTimer = 0
RunService.RenderStepped:Connect(function(dt)
    fpsTimer = fpsTimer + dt
    table.insert(fpsSamples, dt)
    if #fpsSamples > 30 then table.remove(fpsSamples, 1) end
    if fpsTimer >= 0.5 then
        fpsTimer = 0
        local total = 0
        for _, v in ipairs(fpsSamples) do total = total + v end
        local fps = total > 0 and math.floor((#fpsSamples / total) + 0.5) or 0
        local ping = 0
        pcall(function() ping = math.floor(LocalPlayer:GetNetworkPing() * 1000 + 0.5) end)
        Subtitle.Text = string.format('Ultimate Edition - %d FPS - %d ms', fps, ping)
    end
end)

local function PlayOpeningAnimation()
    MainFrame.Visible = true
    MainScale.Scale = 0.94
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 10)
    MainFrame.BackgroundTransparency = 1

    local openInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    TweenService:Create(MainScale, openInfo, {Scale = 1}):Play()
    TweenService:Create(MainFrame, openInfo, {
        Position = NormalMainPosition,
        BackgroundTransparency = 0
    }):Play()

    task.delay(0.08, function()
        for _, obj in ipairs(MainFrame:GetDescendants()) do
            if obj:IsA('TextLabel') or obj:IsA('TextButton') then
                local current = obj.TextTransparency
                obj.TextTransparency = 1
                TweenService:Create(obj, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {TextTransparency = current}):Play()
            end
        end
    end)
end

TabByKey.Home.Switch()
MainFrame.Visible = true
PlayOpeningAnimation()

-- Final motion cleanup: remove leftover physics controllers without touching normal walk velocity.
do
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if root then
        for _, obj in ipairs(root:GetChildren()) do
            local class = obj.ClassName
            if class == "BodyAngularVelocity" or class == "BodyVelocity" or class == "BodyGyro"
                or class == "BodyPosition" or class == "BodyForce" or class == "VectorForce"
                or class == "LinearVelocity" or class == "AngularVelocity" or class == "AlignOrientation" then
                pcall(function() obj:Destroy() end)
            end
        end
        pcall(function() root.AssemblyAngularVelocity = Vector3.zero end)
    end
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then pcall(function() hum.CameraOffset = Vector3.zero end) end
end
-- =========================================================
-- LOCAL CHAT COMMAND ROUTER (CHAT-ONLY PATCH)
-- Every existing button feature is callable from chat by its normalized name.
-- Example: "Bunny Hop" -> :bunnyhop, "Auto Jump + Speed" -> :autojumpspeed
-- =========================================================

local function NormalizeResetHubCommand(value)
    value = tostring(value or ''):lower()
    value = value:gsub('^%s+', ''):gsub('%s+$', '')
    return value:gsub('[^%w]', '')
end

local function ResetHubChatArgs(message)
    local parts = {}
    for token in tostring(message or ''):gmatch('%S+') do
        table.insert(parts, token)
    end
    return parts, string.lower(parts[1] or ''), table.concat(parts, ' ', 2)
end

local function RunChatFeature(featureName)
    local callbacks = KeybindTargets[featureName]
    if type(callbacks) ~= 'table' or #callbacks == 0 then
        return false
    end

    -- A label can exist more than once in legacy builds. Running every callback
    -- could toggle the same feature twice, so chat deliberately invokes only
    -- the most recently registered callback.
    local callback = callbacks[#callbacks]
    if type(callback) ~= 'function' then return false end
    local ok = pcall(callback)
    if not ok then return false end

    task.defer(function()
        for _, btn in ipairs(KeybindButtons[featureName] or {}) do
            pcall(function() RefreshToggleIndicator(btn, featureName) end)
        end
    end)
    return true
end

local function FindChatFeature(command)
    local normalized = NormalizeResetHubCommand(command)
    if normalized == '' then return nil end

    -- Explicit short aliases first.
    local aliases = {
        aimbot = 'Aimbot', aim = 'Aimbot',
        triggerbot = 'Triggerbot',
        aimnearest = 'AimNearest',
        bunnyhop = 'Bunny Hop',
        speedlock = 'Speed Lock',
        jumplock = 'Jump Lock',
        noslow = 'No Slow',
        autojump = 'Auto Jump',
        autoheal = 'Auto Heal',
        autosprint = 'Auto Sprint',
        autoequip = 'Auto Equip Tool',
        toolspam = 'Tool Spam',
        autosit = 'Auto Sit',
        autorotate = 'Auto Rotate',
        autorespawn = 'Auto Respawn',
        godmode = 'Godmode',
        nofall = 'NoFall',
        autoface = 'Auto Face Mouse',
        autorun = 'Auto Sprint',
        cframespeed = 'CFrame Speed',
        airwalk = 'Air Walk',
        longjump = 'Long Jump',
        dash = 'Dash',
        silentaim = 'SilentAim',
        silent = 'SilentAim',
        killaura = 'KillAura',
        autopromptfire = 'Auto Prompt Fire',
        autoprompt = 'Auto Prompt Fire',
        promptduration0 = 'Prompt Duration 0',
        prompt0 = 'Prompt Duration 0',
        instantprompts = 'Prompt Duration 0',
        autorotate = 'Auto Rotate',
        recentercamera = 'Recenter Camera',
        recenter = 'Recenter Camera'
    }
    if aliases[normalized] and KeybindTargets[aliases[normalized]] then
        return aliases[normalized]
    end

    -- Match every existing AddButton/AddFeatureButton automatically.
    for featureName in pairs(KeybindTargets) do
        local featureNorm = NormalizeResetHubCommand(featureName)
        local localizedNorm = NormalizeResetHubCommand(GetText(featureName))
        if normalized == featureNorm or normalized == localizedNorm then
            return featureName
        end
    end

    return nil
end

local function RunChatSlider(cmd, value)
    if not value then return false end
    local sliderCommands = {
        aimbotfov = function(v) _G.AimbotFOV = math.clamp(v, 50, 600) end,
        aimbotsmooth = function(v) _G.AimbotSmoothness = math.clamp(v / 10, 0.02, 1) end,
        hitboxsize = function(v) _G.HitboxSize = math.clamp(v, 2, 40) end,
        velocitymultiplier = function(v) _G.VelocityMultiplier = math.clamp(v, 0, 100) / 100 end,
        velocityvertical = function(v) _G.VelocityVertical = math.clamp(v, 0, 100) / 100 end,
        flyspeed = function(v) _G.FlySpeedValue = math.clamp(v, 20, 200) end,
        dashpower = function(v) _G.DashPower = math.clamp(v, 20, 200) end,
        flingpower = function(v) _G.FlingPower = math.clamp(v, 60, 600) end,
        fov = function(v)
            _G.FovValue = math.clamp(v, 60, 120)
            Camera = workspace.CurrentCamera or Camera
            if Camera then pcall(function() Camera.FieldOfView = _G.FovValue end) end
        end,
        speed = function(v)
            _G.WalkSpeedValue = math.clamp(v, 1, 500)
            local hum = GetHumanoid()
            if hum then pcall(function() hum.WalkSpeed = _G.WalkSpeedValue end) end
        end,
        jump = function(v)
            _G.JumpPowerValue = math.clamp(v, 1, 500)
            local hum = GetHumanoid()
            if hum then
                pcall(function()
                    hum.UseJumpPower = true
                    hum.JumpPower = _G.JumpPowerValue
                end)
            end
        end
    }
    local fn = sliderCommands[cmd]
    if not fn then return false end
    local ok = pcall(fn, value)
    if ok then Notify('Chat value: :' .. cmd .. ' ' .. tostring(value)) end
    return ok
end

local function StopChatFling()
    if type(StopActiveFling) == 'function' then pcall(StopActiveFling) end
    if ActiveFlingConnection then
        pcall(function() ActiveFlingConnection:Disconnect() end)
        ActiveFlingConnection = nil
    end
end

local function ResetHubChatCommandRouter(message)
    message = tostring(message or ''):gsub('^%s+', ''):gsub('%s+$', '')
    if message == '' or message:sub(1,1) ~= ':' then return false end

    local now = os.clock()
    local signature = NormalizeResetHubCommand(message)
    -- SendingMessage + Chatted + legacy bridges can deliver the same command
    -- more than once. Keep a longer chat-only debounce so a toggle is not flipped
    -- back immediately.
    if _G.ResetHubLastChatSignature == signature and now - (_G.ResetHubLastChatDispatch or 0) < 0.90 then
        return true
    end
    _G.ResetHubLastChatSignature = signature
    _G.ResetHubLastChatDispatch = now

    local parts, cmd, rawArgs = ResetHubChatArgs(message)

    -- Accept common multi-word spellings while keeping the existing router intact.
    local second = string.lower(parts[2] or '')
    if cmd == ':silent' and second == 'aim' then cmd = ':silentaim' end
    if cmd == ':kill' and second == 'aura' then cmd = ':killaura' end
    if cmd == ':auto' and second == 'rotate' then cmd = ':autorotate' end
    if cmd == ':auto' and second == 'prompt' then cmd = ':autopromptfire' end
    if cmd == ':prompt' and second == 'duration' and string.lower(parts[3] or '') == '0' then cmd = ':promptduration0' end
    if cmd == ':recenter' and second == 'camera' then cmd = ':recentercamera' end

    -- Movement/chat commands that have custom side effects.
    if cmd == ':fly' then
        Camera = workspace.CurrentCamera or Camera
        if _G.IsFlying then
            _G.IsFlying = false
            _G.QFlyEnabled = false
            if type(CleanupQFly) == 'function' then pcall(CleanupQFly) end
            Notify('Chat command: fly OFF')
        else
            _G.QFlyEnabled = true
            local started = false
            if type(StartQFly) == 'function' then
                local ok, result = pcall(StartQFly)
                started = ok and result == true
            end
            Notify('Chat command: fly ' .. (started and 'ON' or 'FAILED'))
        end
        return true
    elseif cmd == ':unfly' then
        _G.QFlyEnabled = false
        _G.IsFlying = false
        if type(CleanupQFly) == 'function' then pcall(CleanupQFly) end
        Notify('Chat command: unfly')
        return true
    elseif cmd == ':spin' then
        if RunChatFeature('Spin Bot') then
            Notify('Chat command: spin')
        else
            FeatureState.SpinBot = true
            SetFeatureConnection('SpinBot', false)
            SetFeatureConnection('SpinBot', true, RunService.Heartbeat, function()
                local root = GetRoot()
                if root then root.AssemblyAngularVelocity = Vector3.new(0, 75, 0) end
            end)
            Notify('Chat command: spin')
        end
        return true
    elseif cmd == ':unspin' or cmd == ':stopspin' then
        FeatureState.SpinBot = false
        FeatureState.Spin = false
        FeatureState.SpinMovement = false
        SetFeatureConnection('SpinBot', false)
        SetFeatureConnection('SpinToggle', false)
        SetFeatureConnection('SpinMovement', false)
        local root = GetRoot()
        if root then root.AssemblyAngularVelocity = Vector3.zero end
        Notify('Chat command: stop spin')
        return true
    elseif cmd == ':noclip' then
        return RunChatFeature('Noclip')
    elseif cmd == ':restorecamera' or cmd == ':rcamera' then
        Camera = workspace.CurrentCamera or Camera
        local hum = GetHumanoid()
        if Camera then
            pcall(function() Camera.CameraType = Enum.CameraType.Custom end)
            pcall(function() Camera.CameraSubject = hum end)
            pcall(function() Camera.FieldOfView = OriginalFOV end)
        end
        Notify('Chat command: restore camera')
        return true
    elseif cmd == ':restoregravity' or cmd == ':rgravity' then
        pcall(function() workspace.Gravity = OriginalGravity end)
        Notify('Chat command: restore gravity')
        return true
    elseif cmd == ':restorelighting' or cmd == ':rlighting' or cmd == ':restorelight' then
        pcall(function() Lighting.Ambient = OriginalLighting.Ambient end)
        pcall(function() Lighting.Brightness = OriginalLighting.Brightness end)
        pcall(function() Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient end)
        pcall(function() Lighting.ClockTime = OriginalLighting.ClockTime end)
        pcall(function() Lighting.FogStart = OriginalLighting.FogStart end)
        pcall(function() Lighting.FogEnd = OriginalLighting.FogEnd end)
        pcall(function() Lighting.GlobalShadows = OriginalLighting.GlobalShadows end)
        Notify('Chat command: restore lighting')
        return true
    elseif cmd == ':dumpnames' or cmd == ':playernames' then
        local names = {}
        for _, p in ipairs(Players:GetPlayers()) do
            table.insert(names, p.Name .. ' (@' .. p.DisplayName .. ')')
        end
        local copied = SafeSetClipboard(table.concat(names, '\n'))
        Notify(copied and ('Chat: player names copied (' .. tostring(#names) .. ')') or ('Players: ' .. tostring(#names)))
        return true
    elseif cmd == ':target' or cmd == ':targetplayer' or cmd == ':select' then
        local player = ResolveResetHubPlayer(rawArgs)
        if player then
            _G.ResetHubSelectedPlayerName = player.Name
            local box = TabFun and TabFun:FindFirstChild('FlingTargetPlayer')
            if box and box:IsA('TextBox') then box.Text = player.Name end
            Notify('Target: ' .. player.Name)
        else
            Notify('Target player not found: ' .. rawArgs)
        end
        return true
    elseif cmd == ':untarget' or cmd == ':cleartarget' then
        _G.ResetHubSelectedPlayerName = nil
        FeatureState.LockedTarget = nil
        FeatureState.SilentAimTarget = nil
        FeatureState.SilentAimPlayer = nil
        _G.ResetHubSilentAimTarget = nil
        _G.ResetHubSilentAimPlayer = nil
        local box = TabFun and TabFun:FindFirstChild('FlingTargetPlayer')
        if box and box:IsA('TextBox') then box.Text = '' end
        Notify('Target cleared')
        return true
    elseif cmd == ':fling' then
        local player = ResolveResetHubPlayer(rawArgs) or GetSelectedResetHubPlayer()
        if not player then
            Notify('Usage: :fling username')
            return true
        end
        _G.ResetHubSelectedPlayerName = player.Name
        if type(FlingPlayerByTarget) == 'function' then
            local power = tonumber(parts[#parts])
            if power then table.remove(parts, #parts) end
            local targetText = table.concat(parts, ' ', 2)
            if targetText == '' then targetText = player.Name end
            pcall(FlingPlayerByTarget, player, power)
        end
        Notify('Chat fling: ' .. player.Name)
        return true
    elseif cmd == ':stopfling' then
        StopChatFling()
        Notify('Fling stopped')
        return true
    end

    -- Value commands first so :speed 100 / :jump 100 do not fall through.
    local numeric = tonumber(parts[2])
    local normalizedValueCommand = NormalizeResetHubCommand(cmd)
    if RunChatSlider(normalizedValueCommand, numeric) then return true end

    -- Explicit custom combat commands use the same existing feature callbacks;
    -- no new combat implementation is introduced here.
    local featureName = FindChatFeature(cmd:sub(2))
    if featureName then
        local ran = RunChatFeature(featureName)
        if ran then
            Notify('Chat command: ' .. tostring(featureName))
            return true
        end
    end

    return false
end

local function DispatchLocalChatCommand(textValue)
    if type(textValue) ~= 'string' then return false end
    textValue = textValue:gsub('^%s+', ''):gsub('%s+$', '')
    if textValue:sub(1,1) ~= ':' then return false end
    local ok, handled = pcall(ResetHubChatCommandRouter, textValue)
    return ok and handled == true
end

_G.ResetHubChatCommand = ResetHubChatCommandRouter

-- Hub's own chat box: commands execute locally and do not rely on server chat.
pcall(function()
    local customChatPage = TabChat
    local customInput = customChatPage and customChatPage:FindFirstChild('ChatInput')
    if customInput and customInput:IsA('TextBox') and not customInput:GetAttribute('ResetHubCommandBound') then
        customInput:SetAttribute('ResetHubCommandBound', true)
        customInput.FocusLost:Connect(function(enterPressed)
            if not enterPressed then return end
            local textValue = customInput.Text or ''
            if textValue:sub(1,1) == ':' then
                DispatchLocalChatCommand(textValue)
                customInput.Text = ''
            end
        end)
    end
end)

-- Prefer one local-chat event only. Using SendingMessage + Chatted +
-- MessageReceived together could toggle a feature twice for one message.
pcall(function()
    if FeatureConnections.TextChatSendingListener then
        FeatureConnections.TextChatSendingListener:Disconnect()
        FeatureConnections.TextChatSendingListener = nil
    end
end)
pcall(function()
    if FeatureConnections.ChatCommandListener then
        FeatureConnections.ChatCommandListener:Disconnect()
        FeatureConnections.ChatCommandListener = nil
    end
end)
pcall(function()
    if FeatureConnections.TextChatCommandListener then
        FeatureConnections.TextChatCommandListener:Disconnect()
        FeatureConnections.TextChatCommandListener = nil
    end
end)

-- Bind both modern and legacy local chat paths. The router has a short signature
-- guard, so one command cannot toggle twice when both events fire.
pcall(function()
    if TextChatService and TextChatService.SendingMessage then
        FeatureConnections.TextChatSendingListener = TextChatService.SendingMessage:Connect(function(message)
            DispatchLocalChatCommand(message and message.Text or '')
        end)
    end
end)

pcall(function()
    if LocalPlayer and LocalPlayer.Chatted then
        FeatureConnections.ChatCommandListener = LocalPlayer.Chatted:Connect(function(message)
            DispatchLocalChatCommand(message)
        end)
    end
end)

Notify("Reset hub by ssaggajh Loaded! (Right-Ctrl / Q to Fly)")
-- ResetHub v71: requested-only fixes for SilentAim, KillAura, Auto Prompt Fire, Prompt Duration 0, Auto Rotate, Recenter Camera, and chat routing.
