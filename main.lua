-- ==========================================
--     PHANTOM UI (ULTIMATE V20.4 FPS FIX)
-- ==========================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Stats = game:GetService("Stats")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local pGui = LocalPlayer:WaitForChild("PlayerGui")

-- تنظيف الواجهات القديمة لمنع التداخل
if pGui:FindFirstChild("DeltaCustomHub") then
    pGui.DeltaCustomHub:Destroy()
end

-- ================= === [ إنشاء الواجهة الرئيسية ] === ================= --

local MainGui = Instance.new("ScreenGui")
MainGui.Name = "DeltaCustomHub"
MainGui.Parent = pGui
MainGui.ResetOnSpawn = false

local TARGET_SIZE = UDim2.new(0, 480, 0, 310)
local TARGET_POS = UDim2.new(0.5, -240, 0.5, -155)

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Parent = MainGui
Frame.Size = TARGET_SIZE
Frame.Position = TARGET_POS
Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Frame.BackgroundTransparency = 0.2
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.ClipsDescendants = true
Frame.Visible = false

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 10)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Color = Color3.fromRGB(255, 0, 0)
FrameStroke.Thickness = 2
FrameStroke.Transparency = 0.2

-- ================= === [ شاشة أنميشن البداية ] === ================= --

local IntroOverlay = Instance.new("Frame", MainGui)
IntroOverlay.Size = UDim2.new(1, 0, 1, 0)
IntroOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
IntroOverlay.BackgroundTransparency = 0.6
IntroOverlay.Visible = false
IntroOverlay.ZIndex = 100

local IntroBox = Instance.new("Frame", IntroOverlay)
IntroBox.Size = UDim2.new(0, 0, 0, 45)
IntroBox.Position = UDim2.new(0.5, 0, 0.5, -22)
IntroBox.AnchorPoint = Vector2.new(0.5, 0.5)
IntroBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
IntroBox.BackgroundTransparency = 0.15
IntroBox.BorderSizePixel = 0
IntroBox.ZIndex = 101
IntroBox.ClipsDescendants = true

local IntroStroke = Instance.new("UIStroke", IntroBox)
IntroStroke.Color = Color3.fromRGB(255, 40, 40)
IntroStroke.Thickness = 2

local IntroCorner = Instance.new("UICorner", IntroBox)
IntroCorner.CornerRadius = UDim.new(0, 2)

local IntroText = Instance.new("TextLabel", IntroBox)
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.Text = ""
IntroText.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroText.TextSize = 18
IntroText.Font = Enum.Font.GothamBold
IntroText.BackgroundTransparency = 1
IntroText.ZIndex = 102

local TextGlow = Instance.new("UIStroke", IntroText)
TextGlow.Color = Color3.fromRGB(255, 0, 0)
TextGlow.Thickness = 2
TextGlow.Transparency = 0

-- ================= === [ نظام الإشعارات ] === ================= --

local NotifContainer = Instance.new("Frame", MainGui)
NotifContainer.Name = "NotifContainer"
NotifContainer.Size = UDim2.new(0, 300, 0, 280)
NotifContainer.Position = UDim2.new(1, -310, 1, -290)
NotifContainer.BackgroundTransparency = 1

local NotifLayout = Instance.new("UIListLayout", NotifContainer)
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifLayout.Padding = UDim.new(0, 6)

local function notify(title, text)
    task.spawn(function()
        local notifFrame = Instance.new("Frame", NotifContainer)
        notifFrame.Size = UDim2.new(1, 0, 0, 42)
        notifFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        notifFrame.BackgroundTransparency = 0.15
        notifFrame.BorderSizePixel = 0
        notifFrame.Position = UDim2.new(1, 310, 0, 0)

        local corner = Instance.new("UICorner", notifFrame)
        corner.CornerRadius = UDim.new(0, 8)

        local stroke = Instance.new("UIStroke", notifFrame)
        stroke.Color = FrameStroke.Color
        stroke.Thickness = 1.5
        stroke.Transparency = 0.3

        local tLabel = Instance.new("TextLabel", notifFrame)
        tLabel.Size = UDim2.new(1, -16, 0, 18)
        tLabel.Position = UDim2.new(0, 8, 0, 4)
        tLabel.Text = title
        tLabel.TextColor3 = FrameStroke.Color
        tLabel.TextSize = 11
        tLabel.Font = Enum.Font.GothamBold
        tLabel.BackgroundTransparency = 1
        tLabel.TextXAlignment = Enum.TextXAlignment.Left

        local dLabel = Instance.new("TextLabel", notifFrame)
        dLabel.Size = UDim2.new(1, -16, 0, 16)
        dLabel.Position = UDim2.new(0, 8, 0, 20)
        dLabel.Text = text
        dLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        dLabel.TextSize = 10
        dLabel.Font = Enum.Font.Gotham
        dLabel.BackgroundTransparency = 1
        dLabel.TextXAlignment = Enum.TextXAlignment.Left

        local tInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        TweenService:Create(notifFrame, tInfo, {Position = UDim2.new(0, 0, 0, 0)}):Play()

        task.delay(2.5, function()
            if notifFrame and notifFrame.Parent then
                local closeTween = TweenService:Create(notifFrame, tInfo, {Position = UDim2.new(1, 310, 0, 0)})
                closeTween:Play()
                closeTween.Completed:Connect(function()
                    notifFrame:Destroy()
                end)
            end
        end)
    end)
end

-- شريط العنوان العلوي
local TitleBar = Instance.new("Frame", Frame)
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BackgroundTransparency = 0.3
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 10)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.Text = "PHANTOM UI V20.4 ULTIMATE"
TitleText.TextColor3 = Color3.fromRGB(255, 40, 40)
TitleText.TextSize = 13
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -31, 0, 6)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 13
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
CloseBtn.BackgroundTransparency = 0.2

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

local TabBar = Instance.new("Frame", Frame)
TabBar.Size = UDim2.new(0, 115, 1, -66)
TabBar.Position = UDim2.new(0, 0, 0, 38)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TabBar.BackgroundTransparency = 0.35
TabBar.BorderSizePixel = 0

local StatsBar = Instance.new("Frame", Frame)
StatsBar.Size = UDim2.new(1, 0, 0, 26)
StatsBar.Position = UDim2.new(0, 0, 1, -26)
StatsBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
StatsBar.BackgroundTransparency = 0.2
StatsBar.BorderSizePixel = 0
StatsBar.ZIndex = 5

local StatsCorner = Instance.new("UICorner", StatsBar)
StatsCorner.CornerRadius = UDim.new(0, 10)

local StatsLabel = Instance.new("TextLabel", StatsBar)
StatsLabel.Size = UDim2.new(1, -20, 1, 0)
StatsLabel.Position = UDim2.new(0, 10, 0, 0)
StatsLabel.Text = "FPS: -- | Ping: --ms"
StatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatsLabel.TextSize = 11
StatsLabel.Font = Enum.Font.Code
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
StatsLabel.ZIndex = 6

-- تعديل نظام الـ FPS ليتحدث كل نصف ثانية (ثابت وواضح للقراءة)
task.spawn(function()
    while true do
        local dt = RunService.RenderStepped:Wait()
        if dt > 0 then
            local fps = math.floor(1 / dt)
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            StatsLabel.Text = "FPS: " .. tostring(fps) .. " | Ping: " .. tostring(ping) .. "ms"
        end
        task.wait(0.4) -- التحديث يتم كل 0.4 ثانية لكي تلاحق العين قراءة الأرقام بثبات تام
    end
end)

local ContentHolder = Instance.new("Frame", Frame)
ContentHolder.Size = UDim2.new(1, -125, 1, -70)
ContentHolder.Position = UDim2.new(0, 120, 0, 42)
ContentHolder.BackgroundTransparency = 1

local tabs = {}
local isAnimating = false

local function animateButtonClick(btn)
    task.spawn(function()
        local originalSize = btn.Size
        local shrinkSize = UDim2.new(originalSize.X.Scale * 0.95, originalSize.X.Offset * 0.95, originalSize.Y.Scale * 0.95, originalSize.Y.Offset * 0.95)
        local tInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween1 = TweenService:Create(btn, tInfo, {Size = shrinkSize})
        local tween2 = TweenService:Create(btn, tInfo, {Size = originalSize})
        tween1:Play()
        tween1.Completed:Connect(function() tween2:Play() end)
    end)
end

-- دالة فتح السكربت بالأنميشن
local function toggleUI()
    if isAnimating then return end
    isAnimating = true

    if not Frame.Visible then
        IntroOverlay.Visible = true
        IntroBox.Size = UDim2.new(0, 0, 0, 45)
        IntroText.Text = ""
        TextGlow.Transparency = 0

        local expandTween = TweenService:Create(IntroBox, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 45)})
        expandTween:Play()
        expandTween.Completed:Connect(function()
            local targetString = "PHANTOM UI V20.4"
            task.spawn(function()
                for i = 1, #targetString do
                    IntroText.Text = string.sub(targetString, 1, i)
                    task.wait(0.05)
                end

                local normalTween = TweenService:Create(TextGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1})
                local shrinkBox = TweenService:Create(IntroBox, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
                normalTween:Play()
                shrinkBox:Play()
                
                shrinkBox.Completed:Connect(function()
                    IntroOverlay.Visible = false
                    IntroBox.BackgroundTransparency = 0.15

                    Frame.Size = UDim2.new(0, 480, 0, 0)
                    Frame.Position = UDim2.new(0.5, -240, 0.5, 0)
                    Frame.Visible = true

                    TitleBar.BackgroundTransparency = 1
                    TitleText.TextTransparency = 1
                    CloseBtn.BackgroundTransparency = 1
                    CloseBtn.TextTransparency = 1
                    TabBar.BackgroundTransparency = 1
                    StatsBar.BackgroundTransparency = 1
                    StatsLabel.TextTransparency = 1

                    local openTween = TweenService:Create(Frame, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                        Size = TARGET_SIZE,
                        Position = TARGET_POS
                    })
                    openTween:Play()

                    task.spawn(function()
                        task.wait(0.2)
                        local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                        TweenService:Create(TitleBar, fadeInfo, {BackgroundTransparency = 0.3}):Play()
                        TweenService:Create(TitleText, fadeInfo, {TextTransparency = 0}):Play()
                        TweenService:Create(CloseBtn, fadeInfo, {BackgroundTransparency = 0.2, TextTransparency = 0}):Play()
                        TweenService:Create(TabBar, fadeInfo, {BackgroundTransparency = 0.35}):Play()
                        TweenService:Create(StatsBar, fadeInfo, {BackgroundTransparency = 0.2}):Play()
                        TweenService:Create(StatsLabel, fadeInfo, {TextTransparency = 0}):Play()
                    end)

                    openTween.Completed:Connect(function()
                        isAnimating = false
                    end)
                end)
            end)
        end)
    else
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        local closeTween = TweenService:Create(Frame, tweenInfo, {Size = UDim2.new(0, 480, 0, 0), Position = UDim2.new(0.5, -240, 0.5, 0)})
        closeTween:Play()
        closeTween.Completed:Connect(function()
            Frame.Visible = false
            Frame.Size = TARGET_SIZE
            Frame.Position = TARGET_POS
            isAnimating = false
        end)
    end
end

CloseBtn.MouseButton1Click:Connect(function()
    animateButtonClick(CloseBtn)
    toggleUI()
end)

local function createTab(name)
    local tabBtn = Instance.new("TextButton", TabBar)
    tabBtn.Size = UDim2.new(1, -8, 0, 30)
    tabBtn.Position = UDim2.new(0, 4, 0, (#tabs * 34) + 6)
    tabBtn.Text = name
    tabBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    tabBtn.TextSize = 11
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    tabBtn.BackgroundTransparency = 0.4
    
    local btnCorner = Instance.new("UICorner", tabBtn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    local container = Instance.new("ScrollingFrame", ContentHolder)
    container.Size = UDim2.new(1, 0, 1, 0)
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Visible = false
    container.ScrollBarThickness = 3
    container.ScrollBarImageColor3 = FrameStroke.Color

    local layout = Instance.new("UIListLayout", container)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)

    tabBtn.MouseButton1Click:Connect(function()
        animateButtonClick(tabBtn)
        for _, t in pairs(tabs) do
            t.container.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            t.btn.BackgroundTransparency = 0.4
            t.btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        end
        container.Visible = true
        tabBtn.BackgroundColor3 = FrameStroke.Color
        tabBtn.BackgroundTransparency = 0.2
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)

    table.insert(tabs, {btn = tabBtn, container = container})
    return container
end

local moveContainer     = createTab("الحركة")
local visContainer      = createTab("الرؤية")
local combatContainer   = createTab("القتال واللاعبين")
local tpContainer       = createTab("المواقع")
local settingsContainer = createTab("الإعدادات")

if tabs[1] then
    tabs[1].container.Visible = true
    tabs[1].btn.BackgroundColor3 = FrameStroke.Color
    tabs[1].btn.BackgroundTransparency = 0.2
    tabs[1].btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

local function addBtn(parent, text, callback)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -8, 0, 30)
    b.Text = text
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 11
    b.Font = Enum.Font.GothamMedium
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    b.BackgroundTransparency = 0.35
    
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 6)
    
    local s = Instance.new("UIStroke", b)
    s.Color = Color3.fromRGB(70, 70, 70)
    s.Thickness = 1
    s.Transparency = 0.4
    
    b.MouseButton1Click:Connect(function()
        animateButtonClick(b)
        callback()
    end)
    return b
end

local function applyThemeColor(col)
    FrameStroke.Color = col
    TitleText.TextColor3 = col
    IntroStroke.Color = col
    TextGlow.Color = col
    for _, tab in pairs(tabs) do
        if tab.container.Visible then
            tab.btn.BackgroundColor3 = col
        end
        tab.container.ScrollBarImageColor3 = col
    end
end

-- ================= === [ 1. تبويب الحركة ] === ================= --

local currentSpeed = 16
local SpeedLabel = Instance.new("TextLabel", moveContainer)
SpeedLabel.Size = UDim2.new(1, -8, 0, 24)
SpeedLabel.Text = "السرعة الحالية: 16"
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextSize = 11
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpeedLabel.BackgroundTransparency = 0.35
local SpeedLabelCorner = Instance.new("UICorner", SpeedLabel)
SpeedLabelCorner.CornerRadius = UDim.new(0, 6)

local SpeedFrame = Instance.new("Frame", moveContainer)
SpeedFrame.Size = UDim2.new(1, -8, 0, 30)
SpeedFrame.BackgroundTransparency = 1

local PlusBtn = Instance.new("TextButton", SpeedFrame)
PlusBtn.Size = UDim2.new(0.48, 0, 1, 0)
PlusBtn.Text = "زيادة (+50)"
PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PlusBtn.TextSize = 13
PlusBtn.Font = Enum.Font.GothamBold
PlusBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
PlusBtn.BackgroundTransparency = 0.1
local PlusCorner = Instance.new("UICorner", PlusBtn)
PlusCorner.CornerRadius = UDim.new(0, 6)

local MinusBtn = Instance.new("TextButton", SpeedFrame)
MinusBtn.Size = UDim2.new(0.48, 0, 1, 0)
MinusBtn.Position = UDim2.new(0.52, 0, 0, 0)
MinusBtn.Text = "نقصان (-50)"
MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinusBtn.TextSize = 13
MinusBtn.Font = Enum.Font.GothamBold
MinusBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MinusBtn.BackgroundTransparency = 0.1
local MinusCorner = Instance.new("UICorner", MinusBtn)
MinusCorner.CornerRadius = UDim.new(0, 6)

local function updateSpeed(newSpeed)
    if newSpeed < 16 then newSpeed = 16 end
    currentSpeed = newSpeed
    SpeedLabel.Text = "السرعة الحالية: " .. tostring(currentSpeed)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = currentSpeed
    end
    notify("سرعة الحركة", "تم ضبط السرعة إلى: " .. tostring(currentSpeed))
end

PlusBtn.MouseButton1Click:Connect(function() animateButtonClick(PlusBtn) updateSpeed(currentSpeed + 50) end)
MinusBtn.MouseButton1Click:Connect(function() animateButtonClick(MinusBtn) updateSpeed(currentSpeed - 50) end)

addBtn(moveContainer, "إعادة السرعة الأصلية (16)", function() updateSpeed(16) end)

local flying = false
local flySpeed = 50
local bodyVelocity, bodyGyro

local function toggleFly()
    flying = not flying
    if flying then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            bodyVelocity = Instance.new("BodyVelocity", hrp)
            bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyGyro = Instance.new("BodyGyro", hrp)
            bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bodyGyro.CFrame = hrp.CFrame
        end
        notify("الطيران", "تم تفعيل الطيران [F]")
    else
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        notify("الطيران", "تم تعطيل الطيران")
    end
end

local flyBtn = addBtn(moveContainer, "", function() end)
local function updateFlyText()
    flyBtn.Text = "الطيران (Fly) [F]: " .. (flying and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
flyBtn.RichText = true
updateFlyText()

flyBtn.MouseButton1Click:Connect(function()
    animateButtonClick(flyBtn)
    toggleFly()
    updateFlyText()
end)

RunService.RenderStepped:Connect(function()
    if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local cam = workspace.CurrentCamera
        if bodyVelocity and bodyGyro then
            bodyGyro.CFrame = cam.CFrame
            bodyVelocity.Velocity = cam.CFrame.LookVector * flySpeed
        end
    end
end)

local infJump = false
local infBtn = addBtn(moveContainer, "", function() end)
infBtn.RichText = true

local function updateInfText()
    infBtn.Text = "القفز اللانهائي: " .. (infJump and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateInfText()

infBtn.MouseButton1Click:Connect(function()
    animateButtonClick(infBtn)
    infJump = not infJump
    updateInfText()
    notify("القفز اللانهائي", infJump and "تم تفعيل القفز اللانهائي" or "تم تعطيل القفز اللانهائي")
end)

UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local noclip = false
local function toggleNoclip()
    noclip = not noclip
    notify("اختراق الجدران", noclip and "تم تفعيل Noclip [N]" or "تم تعطيل Noclip")
end

local noclipBtn = addBtn(moveContainer, "", function() end)
noclipBtn.RichText = true
local function updateNoclipText()
    noclipBtn.Text = "اختراق الجدران (Noclip) [N]: " .. (noclip and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateNoclipText()

noclipBtn.MouseButton1Click:Connect(function()
    animateButtonClick(noclipBtn)
    toggleNoclip()
    updateNoclipText()
end)

RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ================= === [ 2. تبويب الرؤية ] === ================= --

local fullBrightOn = false
local defaultAmbient, defaultOutdoor, defaultBrightness = Lighting.Ambient, Lighting.OutdoorAmbient, Lighting.Brightness
local brightBtn = addBtn(visContainer, "", function() end)
brightBtn.RichText = true

local function updateBrightText()
    brightBtn.Text = "إلغاء الظلام (FullBright): " .. (fullBrightOn and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateBrightText()

brightBtn.MouseButton1Click:Connect(function()
    animateButtonClick(brightBtn)
    fullBrightOn = not fullBrightOn
    if fullBrightOn then
        defaultAmbient, defaultOutdoor, defaultBrightness = Lighting.Ambient, Lighting.OutdoorAmbient, Lighting.Brightness
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        notify("إلغاء الظلام", "تم تفعيل الرؤية الساطعة")
    else
        Lighting.Ambient = defaultAmbient
        Lighting.OutdoorAmbient = defaultOutdoor
        Lighting.Brightness = defaultBrightness
        notify("إلغاء الظلام", "تم إرجاع الإضاءة الأصلية")
    end
    updateBrightText()
end)

local fogRemoved = false
local defaultFogEnd = Lighting.FogEnd
local fogBtn = addBtn(visContainer, "", function() end)
fogBtn.RichText = true

local function updateFogText()
    fogBtn.Text = "إزالة الضباب (Remove Fog): " .. (fogRemoved and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateFogText()

fogBtn.MouseButton1Click:Connect(function()
    animateButtonClick(fogBtn)
    fogRemoved = not fogRemoved
    if fogRemoved then
        defaultFogEnd = Lighting.FogEnd
        Lighting.FogEnd = 9e9
        notify("الضباب", "تمت إزالة الضباب بالكامل")
    else
        Lighting.FogEnd = defaultFogEnd
        notify("الضباب", "تم إرجاع الضباب")
    end
    updateFogText()
end)

-- ================= === [ 3. تبويب القتال واللاعبين ] === ================= --

local autoClickerOn = false
local autoClickBtn = addBtn(combatContainer, "", function() end)
autoClickBtn.RichText = true

local function updateAutoClickText()
    autoClickBtn.Text = "الكليكر التلقائي: " .. (autoClickerOn and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateAutoClickText()

autoClickBtn.MouseButton1Click:Connect(function()
    animateButtonClick(autoClickBtn)
    autoClickerOn = not autoClickerOn
    updateAutoClickText()
    notify("الكليكر التلقائي", autoClickerOn and "تم تفعيل الكليكر التلقائي" or "تم تعطيل الكليكر التلقائي")
end)

task.spawn(function()
    while true do
        task.wait(0.05)
        if autoClickerOn then
            pcall(function()
                VirtualUser:Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(0.02)
                VirtualUser:Button1Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
    end
end)

local clickTPOn = false
local clickTPBtn = addBtn(combatContainer, "", function() end)
clickTPBtn.RichText = true

local function updateClickTPText()
    clickTPBtn.Text = "الانتقال بنقرة الماوس/الجوال: " .. (clickTPOn and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateClickTPText()

clickTPBtn.MouseButton1Click:Connect(function()
    animateButtonClick(clickTPBtn)
    clickTPOn = not clickTPOn
    updateClickTPText()
    notify("الانتقال باللمس/الماوس", clickTPOn and "تم التفعيل! اضغط Ctrl+الماوس أو استخدم زر الجوال العائم" or "تم تعطيل الانتقال")
end)

local MobileTPTrigger = Instance.new("TextButton", MainGui)
MobileTPTrigger.Name = "MobileTPTrigger"
MobileTPTrigger.Size = UDim2.new(0, 45, 0, 45)
MobileTPTrigger.Position = UDim2.new(0, 80, 0.4, 0)
MobileTPTrigger.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
MobileTPTrigger.BackgroundTransparency = 0.3
MobileTPTrigger.Text = "TP"
MobileTPTrigger.TextColor3 = Color3.fromRGB(255, 255, 255)
MobileTPTrigger.TextSize = 12
MobileTPTrigger.Font = Enum.Font.GothamBold
MobileTPTrigger.Active = true
MobileTPTrigger.Draggable = true
MobileTPTrigger.Visible = false

local MCorner = Instance.new("UICorner", MobileTPTrigger)
MCorner.CornerRadius = UDim.new(1, 0)

RunService.RenderStepped:Connect(function()
    MobileTPTrigger.Visible = clickTPOn
end)

MobileTPTrigger.MouseButton1Click:Connect(function()
    if clickTPOn and Mouse.Hit and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 3, 0)
        notify("انتقال سريع", "تم الانتقال للموقع المحدد عبر الجوال بنجاح")
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and clickTPOn and input.UserInputType == Enum.UserInputType.MouseButton1 and (UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService.TouchEnabled) then
        if Mouse.Hit and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = Mouse.Hit + Vector3.new(0, 3, 0)
            notify("انتقال سريع", "تم الانتقال للموقع المحدد بنجاح")
        end
    end
end)

-- نظام مشاهدة منظور اللاعبين الآخرين (Spectate)
local SpecLabel = Instance.new("TextLabel", combatContainer)
SpecLabel.Size = UDim2.new(1, -8, 0, 22)
SpecLabel.Text = "اختر لاعباً لمشاهدته:"
SpecLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
SpecLabel.TextSize = 11
SpecLabel.Font = Enum.Font.GothamBold
SpecLabel.BackgroundTransparency = 1

local SpecScroll = Instance.new("ScrollingFrame", combatContainer)
SpecScroll.Size = UDim2.new(1, -8, 0, 95)
SpecScroll.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
SpecScroll.BackgroundTransparency = 0.4
SpecScroll.BorderSizePixel = 0
SpecScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SpecScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SpecScroll.ScrollBarThickness = 3
local SpecScrollCorner = Instance.new("UICorner", SpecScroll)
SpecScrollCorner.CornerRadius = UDim.new(0, 6)
local SpecLayout = Instance.new("UIListLayout", SpecScroll)
SpecLayout.Padding = UDim.new(0, 2)

local function refreshSpectateList()
    for _, child in pairs(SpecScroll:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local pBtn = Instance.new("TextButton", SpecScroll)
            pBtn.Size = UDim2.new(1, -4, 0, 26)
            pBtn.Text = p.Name
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.TextSize = 10
            pBtn.Font = Enum.Font.GothamMedium
            pBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            pBtn.BackgroundTransparency = 0.3
            local c = Instance.new("UICorner", pBtn)
            c.CornerRadius = UDim.new(0, 4)
            
            pBtn.MouseButton1Click:Connect(function()
                animateButtonClick(pBtn)
                if p.Character and p.Character:FindFirstChild("Humanoid") then
                    workspace.CurrentCamera.CameraSubject = p.Character.Humanoid
                    notify("المشاهدة", "جاري مشاهدة اللاعب: " .. p.Name)
                end
            end)
        end
    end
end

refreshSpectateList()
Players.PlayerAdded:Connect(refreshSpectateList)
Players.PlayerRemoving:Connect(refreshSpectateList)

addBtn(combatContainer, "إلغاء المشاهدة (الرجوع لشخصيتك)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
        notify("المشاهدة", "تم العودة لشخصيتك الأصلية")
    end
end)

-- ================= === [ 4. تبويب المواقع ] === ================= --

local savedLocations = {}
local fileName = "PhantomUI_SavedLocations.json"

local NameInput = Instance.new("TextBox", tpContainer)
NameInput.Size = UDim2.new(1, -8, 0, 28)
NameInput.PlaceholderText = "اكتب اسم المكان أو اتركه فارغاً..."
NameInput.Text = ""
NameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
NameInput.TextSize = 11
NameInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
NameInput.BackgroundTransparency = 0.35
local InputCorner = Instance.new("UICorner", NameInput)
InputCorner.CornerRadius = UDim.new(0, 6)

local LocationListFrame = Instance.new("Frame", tpContainer)
LocationListFrame.Size = UDim2.new(1, -8, 0, 0)
LocationListFrame.AutomaticSize = Enum.AutomaticSize.Y
LocationListFrame.BackgroundTransparency = 1
local LocLayout = Instance.new("UIListLayout", LocationListFrame)
LocLayout.Padding = UDim.new(0, 4)

local function saveLocationsToFile()
    if writefile and HttpService then
        local dataToSave = {}
        for name, cf in pairs(savedLocations) do
            local components = {cf:GetComponents()}
            dataToSave[name] = components
        end
        pcall(function()
            writefile(fileName, HttpService:JSONEncode(dataToSave))
        end)
    end
end

local function renderLocationButtons()
    for _, child in pairs(LocationListFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    for locName, cf in pairs(savedLocations) do
        local itemFrame = Instance.new("Frame", LocationListFrame)
        itemFrame.Size = UDim2.new(1, 0, 0, 24)
        itemFrame.BackgroundTransparency = 1
        
        local tpLocBtn = Instance.new("TextButton", itemFrame)
        tpLocBtn.Size = UDim2.new(1, -30, 1, 0)
        tpLocBtn.Text = "انتقال: " .. locName
        tpLocBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpLocBtn.TextSize = 10
        tpLocBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
        tpLocBtn.BackgroundTransparency = 0.2
        local c = Instance.new("UICorner", tpLocBtn)
        c.CornerRadius = UDim.new(0, 5)
        
        tpLocBtn.MouseButton1Click:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = cf
                notify("انتقال", "تم الانتقال إلى الموقع: " .. locName)
            end
        end)
        
        local trashBtn = Instance.new("TextButton", itemFrame)
        trashBtn.Size = UDim2.new(0, 24, 1, 0)
        trashBtn.Position = UDim2.new(1, -26, 0, 0)
        trashBtn.Text = "DEL"
        trashBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        trashBtn.TextSize = 8
        trashBtn.Font = Enum.Font.GothamBold
        trashBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        trashBtn.BackgroundTransparency = 0.1
        local tc = Instance.new("UICorner", trashBtn)
        tc.CornerRadius = UDim.new(0, 5)
        
        trashBtn.MouseButton1Click:Connect(function()
            savedLocations[locName] = nil
            saveLocationsToFile()
            renderLocationButtons()
            notify("حذف موقع", "تم حذف الموقع: " .. locName)
        end)
    end
end

if readfile and isfile and isfile(fileName) then
    pcall(function()
        local decoded = HttpService:JSONDecode(readfile(fileName))
        for name, comps in pairs(decoded) do
            savedLocations[name] = CFrame.new(table.unpack(comps))
        end
        renderLocationButtons()
    end)
end

addBtn(tpContainer, "حفظ مكاني الحالي", function()
    local locName = NameInput.Text
    if locName == "" then
        local count = 1
        while savedLocations["موقع " .. tostring(count)] do count = count + 1 end
        locName = "موقع " .. tostring(count)
    end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        savedLocations[locName] = LocalPlayer.Character.HumanoidRootPart.CFrame
        saveLocationsToFile()
        renderLocationButtons()
        notify("حفظ موقع", "تم حفظ الموقع باسم: " .. locName)
        NameInput.Text = ""
    end
end)

-- ================= === [ 5. تبويب الإعدادات (مع تحسين الأداء) ] === ================= --

local fpsBoostActive = false
local fpsBoostBtn = addBtn(settingsContainer, "", function() end)
fpsBoostBtn.RichText = true

local function updateFpsBoostText()
    fpsBoostBtn.Text = "تحسين الأداء (FPS Boost): " .. (fpsBoostActive and "<font color='#00FF00'>[ON]</font>" or "<font color='#FF0000'>[OFF]</font>")
end
updateFpsBoostText()

fpsBoostBtn.MouseButton1Click:Connect(function()
    animateButtonClick(fpsBoostBtn)
    fpsBoostActive = not fpsBoostActive
    updateFpsBoostText()
    
    if fpsBoostActive then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = false
                elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                end
            end
        end)
        notify("تحسين الأداء", "تم تفعيل مسرع الـ FPS وتقليل الجسيمات والثقل بنجاح!")
    else
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CastShadow = true
                end
            end
        end)
        notify("تحسين الأداء", "تم إلغاء مسرع الـ FPS")
    end
end)

addBtn(settingsContainer, "إعادة الانضمام للسيرفر (Rejoin)", function()
    notify("Rejoin", "جاري إعادة الاتصال بالسيرفر...")
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

addBtn(settingsContainer, "منع الخروج التلقائي (Anti-AFK)", function()
    LocalPlayer.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    notify("Anti-AFK", "تم تفعيل حماية عدم الخروج بنجاح")
end)

-- أزرار الألوان
local colors = {
    {name = "أحمر", col = Color3.fromRGB(255, 0, 0)},
    {name = "أزرق", col = Color3.fromRGB(0, 150, 255)},
    {name = "أخضر", col = Color3.fromRGB(0, 220, 100)},
    {name = "بنفسجي", col = Color3.fromRGB(170, 0, 255)},
    {name = "أبيض", col = Color3.fromRGB(255, 255, 255)}
}

local themeFrame = Instance.new("Frame", settingsContainer)
themeFrame.Size = UDim2.new(1, -8, 0, 26)
themeFrame.BackgroundTransparency = 1

for i, t in ipairs(colors) do
    local cBtn = Instance.new("TextButton", themeFrame)
    cBtn.Size = UDim2.new(1 / #colors - 0.02, 0, 1, 0)
    cBtn.Position = UDim2.new((i - 1) * (1 / #colors), 0, 0, 0)
    cBtn.Text = t.name
    cBtn.TextColor3 = (t.name == "أبيض") and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(255, 255, 255)
    cBtn.TextSize = 9
    cBtn.Font = Enum.Font.GothamBold
    cBtn.BackgroundColor3 = t.col
    cBtn.BackgroundTransparency = 0.2
    local cCorner = Instance.new("UICorner", cBtn)
    cCorner.CornerRadius = UDim.new(0, 5)
    
    cBtn.MouseButton1Click:Connect(function()
        animateButtonClick(cBtn)
        applyThemeColor(t.col)
        notify("الثيم", "تم تغيير لون الواجهة إلى " .. t.name)
    end)
end

-- Keybinds
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
        updateFlyText()
    elseif input.KeyCode == Enum.KeyCode.N then
        toggleNoclip()
        updateNoclipText()
    end
end)

-- الزر الجانبي الأساسي (PHNT)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ProToggleBtn"
ToggleBtn.Parent = MainGui
ToggleBtn.Size = UDim2.new(0, 52, 0, 52)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
ToggleBtn.BackgroundTransparency = 0.25
ToggleBtn.Text = "PHNT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 40, 40)
ToggleBtn.TextSize = 11
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Active = true
ToggleBtn.Draggable = true

local Corner = Instance.new("UICorner", ToggleBtn)
Corner.CornerRadius = UDim.new(1, 0)

local Stroke = Instance.new("UIStroke", ToggleBtn)
Stroke.Color = Color3.fromRGB(255, 0, 0)
Stroke.Thickness = 2
Stroke.Transparency = 0.2

ToggleBtn.MouseButton1Click:Connect(function()
    animateButtonClick(ToggleBtn)
    toggleUI()
end)

toggleUI()
notify("Phantom UI", "تم تعديل سرعة عداد الـ FPS ليصبح ثابتاً وسهل القراءة V20.4!")
