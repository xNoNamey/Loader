-- Kirainc Hub Kaitun Scripts

print("Start Kirainc Hub Scripts")

wait(1)

if game.PlaceId == 2753915549 or game.PlaceId == 4442272183 or game.PlaceId == 7449423635 then
local RadientPaid = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")
local pfp
local user
local tag
local userinfo = {}

_G.Key = ""
_G.Discord = ""

if game.CoreGui:FindFirstChild(_G.Key .."," .. _G.Discord) then
   game.CoreGui:FindFirstChild(_G.Key .."," .. _G.Discord):Destroy()
end

pcall(function()
   userinfo = HttpService:JSONDecode(readfile("Radient.txt"));
end)

pfp = userinfo["pfp"] or "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"
user =  userinfo["user"] or game.Players.LocalPlayer.Name
tag = userinfo["tag"] or tostring(math.random(1,10))

local function SaveInfo()
   userinfo["pfp"] = pfp
   userinfo["user"] = user
   userinfo["tag"] = tag
   writefile("Radient.txt", HttpService:JSONEncode(userinfo));
end

local function MakeDraggable(topbarobject, object)
   local Dragging = nil
   local DragInput = nil
   local DragStart = nil
   local StartPosition = nil

   local function Update(input)
      local Delta = input.Position - DragStart
      local pos =
         UDim2.new(StartPosition.X.Scale,StartPosition.X.Offset + Delta.X,StartPosition.Y.Scale,StartPosition.Y.Offset + Delta.Y)
      local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
      Tween:Play()
   end

   topbarobject.InputBegan:Connect(
      function(input)
         if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position

            input.Changed:Connect(function()
               if input.UserInputState == Enum.UserInputState.End then
                  Dragging = false
               end
            end)
         end
      end)

   topbarobject.InputChanged:Connect(
      function(input)
         if
            input.UserInputType == Enum.UserInputType.MouseMovement or
               input.UserInputType == Enum.UserInputType.Touch
         then
            DragInput = input
         end
      end)

   UserInputService.InputChanged:Connect(
      function(input)
         if input == DragInput and Dragging then
            Update(input)
         end
      end)
end

local RadientPaidSC = Instance.new("ScreenGui")
RadientPaidSC.Name = _G.Key .."," .. _G.Discord
RadientPaidSC.Parent = game.CoreGui
RadientPaidSC.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
   if inputObject.KeyCode == Enum.KeyCode.RightControl then
      wait()
      RadientPaidSC.Enabled = not RadientPaidSC.Enabled
   end
end)

function RadientPaid:Window(text,maincolor)

   local currentservertoggled = ""
   local minimized = false
   local fs = false
   local settingsopened = false
   local MainFrame = Instance.new("Frame")
   local TopFrame = Instance.new("Frame")
   local Title = Instance.new("TextLabel")
   local CloseBtn = Instance.new("TextButton")
   local CloseIcon = Instance.new("ImageLabel")
   local MinimizeBtn = Instance.new("TextButton")
   local MinimizeIcon = Instance.new("ImageLabel")
   local ServersHolder = Instance.new("Folder")
   local Userpad = Instance.new("Frame")
   local UserIcon = Instance.new("Frame")
   local UserIconCorner = Instance.new("UICorner")
   local Corner_1 = Instance.new("UICorner")
   local UserImage = Instance.new("ImageLabel")
   local UserCircleImage = Instance.new("ImageLabel")
   local UserName = Instance.new("TextLabel")
   local UserTag = Instance.new("TextLabel")
   local ServersHoldFrame = Instance.new("Frame")
   local ServersHold = Instance.new("ScrollingFrame")
   local ServersHoldLayout = Instance.new("UIListLayout")
   local ServersHoldPadding = Instance.new("UIPadding")
   local TopFrameHolder = Instance.new("Frame")
   local TopFramess = Instance.new("Frame")

   MainFrame.Name = "MainFrame"
   MainFrame.Parent = RadientPaidSC
   MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
   MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
   MainFrame.BackgroundTransparency = 1
   MainFrame.BorderSizePixel = 0
   MainFrame.ClipsDescendants = true
   MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
   MainFrame.Size = UDim2.new(0, 611, 0, 396)

   Corner_1.CornerRadius = UDim.new(0, 7)
   Corner_1.Name = "UserIconCorner"
   Corner_1.Parent = MainFrame

   TopFrame.Name = "TopFrame"
   TopFrame.Parent = MainFrame
   TopFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
   TopFrame.BackgroundTransparency = 1
   TopFrame.BorderSizePixel = 0
   TopFrame.Position = UDim2.new(-0.000658480625, 0, 0, 0)
   TopFrame.Size = UDim2.new(0, 681, 0, 22)

   TopFramess.Name = "TopFramess"
   TopFramess.Parent = TopFrame
   TopFramess.BackgroundColor3 = Color3.fromRGB(255,255,255)
   TopFramess.BackgroundTransparency = 1
   TopFramess.BorderSizePixel = 0
   TopFramess.ZIndex = 99
   TopFramess.Position = UDim2.new(-0.2, 0, 1.3, 0)
   TopFramess.Size = UDim2.new(0, 681, 0, 22)

   TopFrameHolder.Name = "TopFrameHolder"
   TopFrameHolder.Parent = TopFrame
   TopFrameHolder.BackgroundColor3 = Color3.fromRGB(20,20,20)
   TopFrameHolder.BackgroundTransparency = 1.000
   TopFrameHolder.BorderSizePixel = 0
   TopFrameHolder.Position = UDim2.new(-0.000658480625, 0, 0, 0)
   TopFrameHolder.Size = UDim2.new(0, 20, 0, 22)


   Title.Name = "Title"
   Title.Parent = TopFrame
   Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   Title.BackgroundTransparency = 1.000
   Title.Position = UDim2.new(0.0102790017, 0, 0, 0)
   Title.Size = UDim2.new(0, 192, 0, 23)
   Title.Font = Enum.Font.GothamBold
   Title.Text = text
   Title.TextTransparency = 0
   Title.TextColor3 = Color3.fromRGB(255,255,255)
   Title.TextSize = 13.000
   Title.TextXAlignment = Enum.TextXAlignment.Left

   CloseBtn.Name = "CloseBtn"
   CloseBtn.Parent = TopFrame
   CloseBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
   CloseBtn.BackgroundTransparency = 1
   CloseBtn.Position = UDim2.new(0.85, 0, 1.3, 0)
   CloseBtn.Size = UDim2.new(0, 28, 0, 22)
   CloseBtn.Font = Enum.Font.Gotham
   CloseBtn.Text = ""
   CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
   CloseBtn.TextSize = 14.000
   CloseBtn.BorderSizePixel = 0
   CloseBtn.AutoButtonColor = false

   CloseIcon.Name = "CloseIcon"
   CloseIcon.Parent = CloseBtn
   CloseIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   CloseIcon.BackgroundTransparency = 1.000
   CloseIcon.Position = UDim2.new(0.2, 0, 0.128935531, 0)
   CloseIcon.Size = UDim2.new(0, 17, 0, 17)
   CloseIcon.Image = "http://www.roblox.com/asset/?id=6035047409"
   CloseIcon.ImageColor3 = Color3.fromRGB(220, 221, 222)

   MinimizeBtn.Name = "MinimizeButton"
   MinimizeBtn.Parent = TopFrame
   MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
   MinimizeBtn.BackgroundTransparency = 1
   MinimizeBtn.Position = UDim2.new(0.8, 0, 1.3, 0)
   MinimizeBtn.Size = UDim2.new(0, 28, 0, 22)
   MinimizeBtn.Font = Enum.Font.Gotham
   MinimizeBtn.Text = ""
   MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
   MinimizeBtn.TextSize = 14.000
   MinimizeBtn.BorderSizePixel = 0
   MinimizeBtn.AutoButtonColor = false

   MinimizeIcon.Name = "MinimizeLabel"
   MinimizeIcon.Parent = MinimizeBtn
   MinimizeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   MinimizeIcon.BackgroundTransparency = 1.000
   MinimizeIcon.Position = UDim2.new(0.2, 0, 0.128935531, 0)
   MinimizeIcon.Size = UDim2.new(0, 17, 0, 17)
   MinimizeIcon.Image = "http://www.roblox.com/asset/?id=6035067836"
   MinimizeIcon.ImageColor3 = Color3.fromRGB(220, 221, 222)

   ServersHolder.Name = "ServersHolder"
   ServersHolder.Parent = TopFrameHolder

   Userpad.Name = "Userpad"
   Userpad.Parent = TopFrameHolder
   Userpad.BackgroundColor3 = Color3.fromRGB(20,20,20)
   Userpad.BorderSizePixel = 0
   Userpad.Position = UDim2.new(0.106243297, 0, 15.9807148, 0)
   Userpad.Size = UDim2.new(0, 179, 0, 43)

   UserIcon.Name = "UserIcon"
   UserIcon.Parent = Userpad
   UserIcon.BackgroundColor3 = Color3.fromRGB(20,20,20)
   UserIcon.BorderSizePixel = 0
   UserIcon.Position = UDim2.new(0.0340000018, 0, 0.123999998, 0)
   UserIcon.Size = UDim2.new(0, 32, 0, 32)

   UserIconCorner.CornerRadius = UDim.new(1, 8)
   UserIconCorner.Name = "UserIconCorner"
   UserIconCorner.Parent = UserIcon

   UserImage.Name = "UserImage"
   UserImage.Parent = UserIcon
   UserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserImage.BackgroundTransparency = 1.000
   UserImage.Size = UDim2.new(0, 32, 0, 32)
   UserImage.Image = "http://www.roblox.com/asset/?id=7677290950"

   UserCircleImage.Name = "UserImage"
   UserCircleImage.Parent = UserImage
   UserCircleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserCircleImage.BackgroundTransparency = 1.000
   UserCircleImage.Size = UDim2.new(0, 32, 0, 32)
   UserCircleImage.Image = "rbxassetid://4031889928"
   UserCircleImage.ImageColor3 = Color3.fromRGB(20,20,20)

   UserName.Name = "UserName"
   UserName.Parent = Userpad
   UserName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserName.BackgroundTransparency = 1.000
   UserName.BorderSizePixel = 0
   UserName.Position = UDim2.new(0.230000004, 0, 0.115999997, 0)
   UserName.Size = UDim2.new(0, 98, 0, 17)
   UserName.Font = Enum.Font.GothamSemibold
   UserName.TextSize = 13.000
   UserName.TextTransparency = 1
   UserName.TextXAlignment = Enum.TextXAlignment.Left
   UserName.ClipsDescendants = true

   UserTag.Name = "UserTag"
   UserTag.Parent = Userpad
   UserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserTag.BackgroundTransparency = 1.000
   UserTag.BorderSizePixel = 0
   UserTag.Position = UDim2.new(0.230000004, 0, 0.275000013, 0)
   UserTag.Size = UDim2.new(0, 95, 0, 17)
   UserTag.Font = Enum.Font.GothamBold
   UserTag.TextColor3 = Color3.fromRGB(233, 25, 42)
   UserTag.TextSize = 13.000
   UserTag.TextTransparency = 0
   UserTag.TextXAlignment = Enum.TextXAlignment.Left

   UserName.Text = "Relax Hub"
   UserTag.Text = "#" .. " Relax"

   ServersHoldFrame.Name = "ServersHoldFrame"
   ServersHoldFrame.Parent = MainFrame
   ServersHoldFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   ServersHoldFrame.BackgroundTransparency = 1.000
   ServersHoldFrame.BorderColor3 = Color3.fromRGB(20,20,20)
   ServersHoldFrame.Size = UDim2.new(0, 71, 0, 396)

   ServersHold.Name = "ServersHold"
   ServersHold.Parent = ServersHoldFrame
   ServersHold.Active = true
   ServersHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   ServersHold.BackgroundTransparency = 1.000
   ServersHold.BorderSizePixel = 0
   ServersHold.Position = UDim2.new(-0.000359333731, 0, 0.0580808073, 0)
   ServersHold.Size = UDim2.new(0, 71, 0, 373)
   ServersHold.ScrollBarThickness = 1
   ServersHold.ScrollBarImageTransparency = 1
   ServersHold.CanvasSize = UDim2.new(0, 0, 0, 0)

   ServersHoldLayout.Name = "ServersHoldLayout"
   ServersHoldLayout.Parent = ServersHold
   ServersHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
   ServersHoldLayout.Padding = UDim.new(0, 7)

   ServersHoldPadding.Name = "ServersHoldPadding"
   ServersHoldPadding.Parent = ServersHold

   CloseBtn.MouseButton1Click:Connect(
      function()
         MainFrame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .5, true)
      end
   )

   CloseBtn.MouseEnter:Connect(
      function()
         CloseBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
      end
   )

   CloseBtn.MouseLeave:Connect(
      function()
         CloseBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
      end
   )

   MinimizeBtn.MouseEnter:Connect(
      function()
         MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
      end
   )

   MinimizeBtn.MouseLeave:Connect(
      function()
         MinimizeBtn.BackgroundColor3 = Color3.fromRGB(15,15,15)
      end
   )

   MinimizeBtn.MouseButton1Click:Connect(
      function()
         if minimized == false then
            MainFrame:TweenSize(
               UDim2.new(0, 611, 0, 64),
               Enum.EasingDirection.Out,
               Enum.EasingStyle.Quart,
               .3,
               true
            )
         else
            MainFrame:TweenSize(
               UDim2.new(0, 611, 0, 396),
               Enum.EasingDirection.Out,
               Enum.EasingStyle.Quart,
               .3,
               true
            )
         end
         minimized = not minimized
      end
   )

   local SettingsOpenBtn = Instance.new("TextButton")
   local SettingsOpenBtnIco = Instance.new("ImageLabel")

   SettingsOpenBtn.Name = "SettingsOpenBtn"
   SettingsOpenBtn.Parent = Userpad
   SettingsOpenBtn.BackgroundColor3 = Color3.fromRGB(53, 56, 62)
   SettingsOpenBtn.BackgroundTransparency = 1.000
   SettingsOpenBtn.Position = UDim2.new(0.849161983, 0, 0.279069781, 0)
   SettingsOpenBtn.Size = UDim2.new(0, 0, 0, 0)
   SettingsOpenBtn.Font = Enum.Font.SourceSans
   SettingsOpenBtn.Text = ""
   SettingsOpenBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
   SettingsOpenBtn.TextSize = 14.000

   SettingsOpenBtnIco.Name = "SettingsOpenBtnIco"
   SettingsOpenBtnIco.Parent = SettingsOpenBtn
   SettingsOpenBtnIco.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
   SettingsOpenBtnIco.BackgroundTransparency = 1.000
   SettingsOpenBtnIco.Size = UDim2.new(0, 0, 0, 0)
   SettingsOpenBtnIco.ImageTransparency = 1
   SettingsOpenBtnIco.Image = "http://www.roblox.com/asset/?id=6031280882"
   SettingsOpenBtnIco.ImageColor3 = Color3.fromRGB(220, 220, 220)
   local SettingsFrame = Instance.new("Frame")
   local Settings = Instance.new("Frame")
   local SettingsHolder = Instance.new("Frame")
   local CloseSettingsBtn = Instance.new("TextButton")
   local CloseSettingsBtnCorner = Instance.new("UICorner")
   local CloseSettingsBtnCircle = Instance.new("Frame")
   local CloseSettingsBtnCircleCorner = Instance.new("UICorner")
   local CloseSettingsBtnIcon = Instance.new("ImageLabel")
   local TextLabel = Instance.new("TextLabel")
   local UserPanel = Instance.new("Frame")
   local UserSettingsPad = Instance.new("Frame")
   local UserSettingsPadCorner = Instance.new("UICorner")
   local UsernameText = Instance.new("TextLabel")
   local UserSettingsPadUserTag = Instance.new("Frame")
   local UserSettingsPadUser = Instance.new("TextLabel")
   local UserSettingsPadUserTagLayout = Instance.new("UIListLayout")
   local UserSettingsPadTag = Instance.new("TextLabel")
   local EditBtn = Instance.new("TextButton")
   local EditBtnCorner = Instance.new("UICorner")
   local UserPanelUserIcon = Instance.new("TextButton")
   local UserPanelUserImage = Instance.new("ImageLabel")
   local UserPanelUserCircle = Instance.new("ImageLabel")
   local BlackFrame = Instance.new("Frame")
   local BlackFrameCorner = Instance.new("UICorner")
   local ChangeAvatarText = Instance.new("TextLabel")
   local SearchIcoFrame = Instance.new("Frame")
   local SearchIcoFrameCorner = Instance.new("UICorner")
   local SearchIco = Instance.new("ImageLabel")
   local UserPanelUserTag = Instance.new("Frame")
   local UserPanelUser = Instance.new("TextLabel")
   local UserPanelUserTagLayout = Instance.new("UIListLayout")
   local UserPanelTag = Instance.new("TextLabel")
   local UserPanelCorner = Instance.new("UICorner")
   local LeftFrame = Instance.new("Frame")
   local MyAccountBtn = Instance.new("TextButton")
   local MyAccountBtnCorner = Instance.new("UICorner")
   local MyAccountBtnTitle = Instance.new("TextLabel")
   local SettingsTitle = Instance.new("TextLabel")
   local DiscordInfo = Instance.new("TextLabel")
   local CurrentSettingOpen = Instance.new("TextLabel")

   SettingsFrame.Name = "SettingsFrame"
   SettingsFrame.Parent = MainFrame
   SettingsFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
   SettingsFrame.BackgroundTransparency = 1.000
   SettingsFrame.Size = UDim2.new(0, 681, 0, 396)
   SettingsFrame.Visible = false

   Settings.Name = "Settings"
   Settings.Parent = SettingsFrame
   Settings.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
   Settings.BorderSizePixel = 0
   Settings.Position = UDim2.new(0, 0, 0.0530303046, 0)
   Settings.Size = UDim2.new(0, 681, 0, 375)

   SettingsHolder.Name = "SettingsHolder"
   SettingsHolder.Parent = Settings
   SettingsHolder.AnchorPoint = Vector2.new(0.5, 0.5)
   SettingsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   SettingsHolder.BackgroundTransparency = 1.000
   SettingsHolder.ClipsDescendants = true
   SettingsHolder.Position = UDim2.new(0.49926579, 0, 0.498666674, 0)
   SettingsHolder.Size = UDim2.new(0, 0, 0, 0)

   CloseSettingsBtn.Name = "CloseSettingsBtn"
   CloseSettingsBtn.Parent = SettingsHolder
   CloseSettingsBtn.AnchorPoint = Vector2.new(0.5, 0.5)
   CloseSettingsBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
   CloseSettingsBtn.Position = UDim2.new(0.952967286, 0, 0.0853333324, 0)
   CloseSettingsBtn.Selectable = false
   CloseSettingsBtn.Size = UDim2.new(0, 30, 0, 30)
   CloseSettingsBtn.AutoButtonColor = false
   CloseSettingsBtn.Font = Enum.Font.SourceSans
   CloseSettingsBtn.Text = ""
   CloseSettingsBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
   CloseSettingsBtn.TextSize = 14.000

   CloseSettingsBtnCorner.CornerRadius = UDim.new(1, 0)
   CloseSettingsBtnCorner.Name = "CloseSettingsBtnCorner"
   CloseSettingsBtnCorner.Parent = CloseSettingsBtn

   CloseSettingsBtnCircle.Name = "CloseSettingsBtnCircle"
   CloseSettingsBtnCircle.Parent = CloseSettingsBtn
   CloseSettingsBtnCircle.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
   CloseSettingsBtnCircle.Position = UDim2.new(0.0879999995, 0, 0.118000001, 0)
   CloseSettingsBtnCircle.Size = UDim2.new(0, 24, 0, 24)

   CloseSettingsBtnCircleCorner.CornerRadius = UDim.new(1, 0)
   CloseSettingsBtnCircleCorner.Name = "CloseSettingsBtnCircleCorner"
   CloseSettingsBtnCircleCorner.Parent = CloseSettingsBtnCircle

   CloseSettingsBtnIcon.Name = "CloseSettingsBtnIcon"
   CloseSettingsBtnIcon.Parent = CloseSettingsBtnCircle
   CloseSettingsBtnIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   CloseSettingsBtnIcon.BackgroundTransparency = 1.000
   CloseSettingsBtnIcon.Position = UDim2.new(0, 2, 0, 2)
   CloseSettingsBtnIcon.Size = UDim2.new(0, 19, 0, 19)
   CloseSettingsBtnIcon.Image = "http://www.roblox.com/asset/?id=6035047409"
   CloseSettingsBtnIcon.ImageColor3 = Color3.fromRGB(222, 222, 222)

   CloseSettingsBtn.MouseButton1Click:Connect(function()
      settingsopened = false
      TopFrameHolder.Visible = true
      ServersHoldFrame.Visible = true
      SettingsHolder:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
      TweenService:Create(
         Settings,
         TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 1}
      ):Play()
      for i,v in next, SettingsHolder:GetChildren() do
         TweenService:Create(
            v,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
      end
      wait(.3)
      SettingsFrame.Visible = false
   end)

   CloseSettingsBtn.MouseEnter:Connect(function()
      CloseSettingsBtnCircle.BackgroundColor3 = Color3.fromRGB(72,76,82)
   end)

   CloseSettingsBtn.MouseLeave:Connect(function()
      CloseSettingsBtnCircle.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
   end)

   UserInputService.InputBegan:Connect(
      function(io, p)
         if io.KeyCode == Enum.KeyCode.RightControl then
            if settingsopened == true then
               settingsopened = false
               TopFrameHolder.Visible = true
               ServersHoldFrame.Visible = true
               SettingsHolder:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
               TweenService:Create(
                  Settings,
                  TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {BackgroundTransparency = 1}
               ):Play()
               for i,v in next, SettingsHolder:GetChildren() do
                  TweenService:Create(
                     v,
                     TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                     {BackgroundTransparency = 1}
                  ):Play()
               end
               wait(.3)
               SettingsFrame.Visible = false
            end
         end
      end
   )

   TextLabel.Parent = CloseSettingsBtn
   TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   TextLabel.BackgroundTransparency = 1.000
   TextLabel.Position = UDim2.new(-0.0666666701, 0, 1.06666672, 0)
   TextLabel.Size = UDim2.new(0, 34, 0, 22)
   TextLabel.Font = Enum.Font.GothamSemibold
   TextLabel.Text = "rightctrl"
   TextLabel.TextColor3 = Color3.fromRGB(113, 117, 123)
   TextLabel.TextSize = 11.000

   UserPanel.Name = "UserPanel"
   UserPanel.Parent = SettingsHolder
   UserPanel.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
   UserPanel.Position = UDim2.new(0.365638763, 0, 0.130666673, 0)
   UserPanel.Size = UDim2.new(0, 362, 0, 164)

   UserSettingsPad.Name = "UserSettingsPad"
   UserSettingsPad.Parent = UserPanel
   UserSettingsPad.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
   UserSettingsPad.Position = UDim2.new(0.0331491716, 0, 0.568140388, 0)
   UserSettingsPad.Size = UDim2.new(0, 337, 0, 56)

   UserSettingsPadCorner.Name = "UserSettingsPadCorner"
   UserSettingsPadCorner.Parent = UserSettingsPad

   UsernameText.Name = "UsernameText"
   UsernameText.Parent = UserSettingsPad
   UsernameText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UsernameText.BackgroundTransparency = 1.000
   UsernameText.Position = UDim2.new(0.0419999994, 0, 0.154714286, 0)
   UsernameText.Size = UDim2.new(0, 65, 0, 19)
   UsernameText.Font = Enum.Font.GothamBold
   UsernameText.Text = "USERNAME"
   UsernameText.TextColor3 = Color3.fromRGB(126, 130, 136)
   UsernameText.TextSize = 11.000
   UsernameText.TextXAlignment = Enum.TextXAlignment.Left

   UserSettingsPadUserTag.Name = "UserSettingsPadUserTag"
   UserSettingsPadUserTag.Parent = UserSettingsPad
   UserSettingsPadUserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserSettingsPadUserTag.BackgroundTransparency = 1.000
   UserSettingsPadUserTag.Position = UDim2.new(0.0419999994, 0, 0.493999988, 0)
   UserSettingsPadUserTag.Size = UDim2.new(0, 65, 0, 19)

   UserSettingsPadUser.Name = "UserSettingsPadUser"
   UserSettingsPadUser.Parent = UserSettingsPadUserTag
   UserSettingsPadUser.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserSettingsPadUser.BackgroundTransparency = 1.000
   UserSettingsPadUser.Font = Enum.Font.Gotham
   UserSettingsPadUser.TextColor3 = Color3.fromRGB(255, 255, 255)
   UserSettingsPadUser.TextSize = 13.000
   UserSettingsPadUser.TextXAlignment = Enum.TextXAlignment.Left
   UserSettingsPadUser.Text = user
   UserSettingsPadUser.Size = UDim2.new(0, UserSettingsPadUser.TextBounds.X + 2, 0, 19)

   UserSettingsPadUserTagLayout.Name = "UserSettingsPadUserTagLayout"
   UserSettingsPadUserTagLayout.Parent = UserSettingsPadUserTag
   UserSettingsPadUserTagLayout.FillDirection = Enum.FillDirection.Horizontal
   UserSettingsPadUserTagLayout.SortOrder = Enum.SortOrder.LayoutOrder

   UserSettingsPadTag.Name = "UserSettingsPadTag"
   UserSettingsPadTag.Parent = UserSettingsPadUserTag
   UserSettingsPadTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserSettingsPadTag.BackgroundTransparency = 1.000
   UserSettingsPadTag.Position = UDim2.new(0.0419999994, 0, 0.493999988, 0)
   UserSettingsPadTag.Size = UDim2.new(0, 65, 0, 19)
   UserSettingsPadTag.Font = Enum.Font.Gotham
   UserSettingsPadTag.Text = "#" .. tag
   UserSettingsPadTag.TextColor3 = Color3.fromRGB(184, 186, 189)
   UserSettingsPadTag.TextSize = 13.000
   UserSettingsPadTag.TextXAlignment = Enum.TextXAlignment.Left

   EditBtn.Name = "EditBtn"
   EditBtn.Parent = UserSettingsPad
   EditBtn.BackgroundColor3 = Color3.fromRGB(116, 127, 141)
   EditBtn.Position = UDim2.new(0.797671914, 0, 0.232142866, 0)
   EditBtn.Size = UDim2.new(0, 55, 0, 30)
   EditBtn.Font = Enum.Font.Gotham
   EditBtn.Text = "Edit"
   EditBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
   EditBtn.TextSize = 14.000
   EditBtn.AutoButtonColor = false

   EditBtn.MouseEnter:Connect(function()
      TweenService:Create(
         EditBtn,
         TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundColor3 = Color3.fromRGB(104,114,127)}
      ):Play()
   end)

   EditBtn.MouseLeave:Connect(function()
      TweenService:Create(
         EditBtn,
         TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundColor3 = Color3.fromRGB(116, 127, 141)}
      ):Play()
   end)

   EditBtnCorner.CornerRadius = UDim.new(0, 3)
   EditBtnCorner.Name = "EditBtnCorner"
   EditBtnCorner.Parent = EditBtn

   UserPanelUserIcon.Name = "UserPanelUserIcon"
   UserPanelUserIcon.Parent = UserPanel
   UserPanelUserIcon.BackgroundColor3 = Color3.fromRGB(31, 33, 36)
   UserPanelUserIcon.BorderSizePixel = 0
   UserPanelUserIcon.Position = UDim2.new(0.0340000018, 0, 0.074000001, 0)
   UserPanelUserIcon.Size = UDim2.new(0, 71, 0, 71)
   UserPanelUserIcon.AutoButtonColor = false
   UserPanelUserIcon.Text = ""

   UserPanelUserImage.Name = "UserPanelUserImage"
   UserPanelUserImage.Parent = UserPanelUserIcon
   UserPanelUserImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserPanelUserImage.BackgroundTransparency = 1.000
   UserPanelUserImage.Size = UDim2.new(0, 71, 0, 71)
   UserPanelUserImage.Image = pfp

   UserPanelUserCircle.Name = "UserPanelUserCircle"
   UserPanelUserCircle.Parent = UserPanelUserImage
   UserPanelUserCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserPanelUserCircle.BackgroundTransparency = 1.000
   UserPanelUserCircle.Size = UDim2.new(0, 71, 0, 71)
   UserPanelUserCircle.Image = "rbxassetid://4031889928"
   UserPanelUserCircle.ImageColor3 = Color3.fromRGB(47, 49, 54)

   BlackFrame.Name = "BlackFrame"
   BlackFrame.Parent = UserPanelUserIcon
   BlackFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
   BlackFrame.BackgroundTransparency = 0.400
   BlackFrame.BorderSizePixel = 0
   BlackFrame.Size = UDim2.new(0, 71, 0, 71)
   BlackFrame.Visible = false

   BlackFrameCorner.CornerRadius = UDim.new(1, 8)
   BlackFrameCorner.Name = "BlackFrameCorner"
   BlackFrameCorner.Parent = BlackFrame

   ChangeAvatarText.Name = "ChangeAvatarText"
   ChangeAvatarText.Parent = BlackFrame
   ChangeAvatarText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   ChangeAvatarText.BackgroundTransparency = 1.000
   ChangeAvatarText.Size = UDim2.new(0, 71, 0, 71)
   ChangeAvatarText.Font = Enum.Font.GothamBold
   ChangeAvatarText.Text = "CHAGNE    AVATAR"
   ChangeAvatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
   ChangeAvatarText.TextSize = 11.000
   ChangeAvatarText.TextWrapped = true

   SearchIcoFrame.Name = "SearchIcoFrame"
   SearchIcoFrame.Parent = UserPanelUserIcon
   SearchIcoFrame.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
   SearchIcoFrame.Position = UDim2.new(0.657999992, 0, 0, 0)
   SearchIcoFrame.Size = UDim2.new(0, 20, 0, 20)

   SearchIcoFrameCorner.CornerRadius = UDim.new(1, 8)
   SearchIcoFrameCorner.Name = "SearchIcoFrameCorner"
   SearchIcoFrameCorner.Parent = SearchIcoFrame

   SearchIco.Name = "SearchIco"
   SearchIco.Parent = SearchIcoFrame
   SearchIco.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   SearchIco.BackgroundTransparency = 1.000
   SearchIco.Position = UDim2.new(0.150000006, 0, 0.100000001, 0)
   SearchIco.Size = UDim2.new(0, 15, 0, 15)
   SearchIco.Image = "http://www.roblox.com/asset/?id=6034407084"
   SearchIco.ImageColor3 = Color3.fromRGB(114, 118, 125)

   UserPanelUserIcon.MouseEnter:Connect(function()
      BlackFrame.Visible = true
   end)

   UserPanelUserIcon.MouseLeave:Connect(function()
      BlackFrame.Visible = false
   end)

   UserPanelUserIcon.MouseButton1Click:Connect(function()
      local NotificationHolder = Instance.new("TextButton")
      NotificationHolder.Name = "NotificationHolder"
      NotificationHolder.Parent = SettingsHolder
      NotificationHolder.BackgroundColor3 = Color3.fromRGB(22,22,22)
      NotificationHolder.Position = UDim2.new(-0.00881057233, 0, -0.00266666664, 0)
      NotificationHolder.Size = UDim2.new(0, 687, 0, 375)
      NotificationHolder.AutoButtonColor = false
      NotificationHolder.Font = Enum.Font.SourceSans
      NotificationHolder.Text = ""
      NotificationHolder.TextColor3 = Color3.fromRGB(0, 0, 0)
      NotificationHolder.TextSize = 14.000
      NotificationHolder.BackgroundTransparency = 1
      NotificationHolder.Visible = true
      TweenService:Create(
         NotificationHolder,
         TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0.2}
      ):Play()



      local AvatarChange = Instance.new("Frame")
      local UserChangeCorner = Instance.new("UICorner")
      local UnderBar = Instance.new("Frame")
      local UnderBarCorner = Instance.new("UICorner")
      local UnderBarFrame = Instance.new("Frame")
      local Text1 = Instance.new("TextLabel")
      local Text2 = Instance.new("TextLabel")
      local TextBoxFrame = Instance.new("Frame")
      local TextBoxFrameCorner = Instance.new("UICorner")
      local TextBoxFrame1 = Instance.new("Frame")
      local TextBoxFrame1Corner = Instance.new("UICorner")
      local AvatarTextbox = Instance.new("TextBox")
      local ChangeBtn = Instance.new("TextButton")
      local ChangeCorner = Instance.new("UICorner")
      local CloseBtn2 = Instance.new("TextButton")
      local Close2Icon = Instance.new("ImageLabel")
      local CloseBtn1 = Instance.new("TextButton")
      local CloseBtn1Corner = Instance.new("UICorner")
      local ResetBtn = Instance.new("TextButton")
      local ResetCorner = Instance.new("UICorner")


      AvatarChange.Name = "AvatarChange"
      AvatarChange.Parent = NotificationHolder
      AvatarChange.AnchorPoint = Vector2.new(0.5, 0.5)
      AvatarChange.BackgroundColor3 = Color3.fromRGB(20,20,20)
      AvatarChange.ClipsDescendants = true
      AvatarChange.Position = UDim2.new(0.513071597, 0, 0.4746176, 0)
      AvatarChange.Size = UDim2.new(0, 0, 0, 0)
      AvatarChange.BackgroundTransparency = 1

      AvatarChange:TweenSize(UDim2.new(0, 346, 0, 198), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
      TweenService:Create(
         AvatarChange,
         TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0}
      ):Play()


      UserChangeCorner.CornerRadius = UDim.new(0, 5)
      UserChangeCorner.Name = "UserChangeCorner"
      UserChangeCorner.Parent = AvatarChange

      UnderBar.Name = "UnderBar"
      UnderBar.Parent = AvatarChange
      UnderBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
      UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
      UnderBar.Size = UDim2.new(0, 346, 0, 13)

      UnderBarCorner.CornerRadius = UDim.new(0, 5)
      UnderBarCorner.Name = "UnderBarCorner"
      UnderBarCorner.Parent = UnderBar

      UnderBarFrame.Name = "UnderBarFrame"
      UnderBarFrame.Parent = UnderBar
      UnderBarFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
      UnderBarFrame.BorderSizePixel = 0
      UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -2.53846145, 0)
      UnderBarFrame.Size = UDim2.new(0, 346, 0, 39)

      Text1.Name = "Text1"
      Text1.Parent = AvatarChange
      Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Text1.BackgroundTransparency = 1.000
      Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
      Text1.Size = UDim2.new(0, 346, 0, 68)
      Text1.Font = Enum.Font.GothamSemibold
      Text1.Text = "Change your avatar"
      Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
      Text1.TextSize = 20.000

      Text2.Name = "Text2"
      Text2.Parent = AvatarChange
      Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Text2.BackgroundTransparency = 1.000
      Text2.Position = UDim2.new(-0.000594122568, 0, 0.141587839, 0)
      Text2.Size = UDim2.new(0, 346, 0, 63)
      Text2.Font = Enum.Font.Gotham
      Text2.Text = "Enter your new profile in a Roblox decal link."
      Text2.TextColor3 = Color3.fromRGB(171, 172, 176)
      Text2.TextSize = 14.000

      TextBoxFrame.Name = "TextBoxFrame"
      TextBoxFrame.Parent = AvatarChange
      TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
      TextBoxFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
      TextBoxFrame.Position = UDim2.new(0.49710983, 0, 0.560606062, 0)
      TextBoxFrame.Size = UDim2.new(0, 319, 0, 38)

      TextBoxFrameCorner.CornerRadius = UDim.new(0, 3)
      TextBoxFrameCorner.Name = "TextBoxFrameCorner"
      TextBoxFrameCorner.Parent = TextBoxFrame

      TextBoxFrame1.Name = "TextBoxFrame1"
      TextBoxFrame1.Parent = TextBoxFrame
      TextBoxFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
      TextBoxFrame1.BackgroundColor3 = Color3.fromRGB(48, 51, 57)
      TextBoxFrame1.ClipsDescendants = true
      TextBoxFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
      TextBoxFrame1.Size = UDim2.new(0, 317, 0, 36)

      TextBoxFrame1Corner.CornerRadius = UDim.new(0, 3)
      TextBoxFrame1Corner.Name = "TextBoxFrame1Corner"
      TextBoxFrame1Corner.Parent = TextBoxFrame1

      AvatarTextbox.Name = "AvatarTextbox"
      AvatarTextbox.Parent = TextBoxFrame1
      AvatarTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      AvatarTextbox.BackgroundTransparency = 1.000
      AvatarTextbox.Position = UDim2.new(0.0378548913, 0, 0, 0)
      AvatarTextbox.Size = UDim2.new(0, 293, 0, 37)
      AvatarTextbox.Font = Enum.Font.Gotham
      AvatarTextbox.Text = ""
      AvatarTextbox.TextColor3 = Color3.fromRGB(193, 195, 197)
      AvatarTextbox.TextSize = 14.000
      AvatarTextbox.TextXAlignment = Enum.TextXAlignment.Left

      ChangeBtn.Name = "ChangeBtn"
      ChangeBtn.Parent = AvatarChange
      ChangeBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
      ChangeBtn.Position = UDim2.new(0.749670506, 0, 0.823232353, 0)
      ChangeBtn.Size = UDim2.new(0, 76, 0, 27)
      ChangeBtn.Font = Enum.Font.Gotham
      ChangeBtn.Text = "Change"
      ChangeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
      ChangeBtn.TextSize = 13.000
      ChangeBtn.AutoButtonColor = false

      ChangeBtn.MouseEnter:Connect(function()
         TweenService:Create(
            ChangeBtn,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(103,123,196)}
         ):Play()
      end)

      ChangeBtn.MouseLeave:Connect(function()
         TweenService:Create(
            ChangeBtn,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
         ):Play()
      end)

      ChangeBtn.MouseButton1Click:Connect(function()
         pfp = tostring(AvatarTextbox.Text)
         UserImage.Image = pfp
         UserPanelUserImage.Image = pfp
         SaveInfo()

         AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            AvatarChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)



      ChangeCorner.CornerRadius = UDim.new(0, 4)
      ChangeCorner.Name = "ChangeCorner"
      ChangeCorner.Parent = ChangeBtn

      CloseBtn2.Name = "CloseBtn2"
      CloseBtn2.Parent = AvatarChange
      CloseBtn2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn2.BackgroundTransparency = 1.000
      CloseBtn2.Position = UDim2.new(0.898000002, 0, 0, 0)
      CloseBtn2.Size = UDim2.new(0, 26, 0, 26)
      CloseBtn2.Font = Enum.Font.Gotham
      CloseBtn2.Text = ""
      CloseBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn2.TextSize = 14.000

      Close2Icon.Name = "Close2Icon"
      Close2Icon.Parent = CloseBtn2
      Close2Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Close2Icon.BackgroundTransparency = 1.000
      Close2Icon.Position = UDim2.new(-0.0384615399, 0, 0.312910825, 0)
      Close2Icon.Size = UDim2.new(0, 25, 0, 25)
      Close2Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
      Close2Icon.ImageColor3 = Color3.fromRGB(119, 122, 127)

      CloseBtn1.Name = "CloseBtn1"
      CloseBtn1.Parent = AvatarChange
      CloseBtn1.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
      CloseBtn1.BackgroundTransparency = 1.000
      CloseBtn1.Position = UDim2.new(0.495000005, 0, 0.823000014, 0)
      CloseBtn1.Size = UDim2.new(0, 76, 0, 27)
      CloseBtn1.Font = Enum.Font.Gotham
      CloseBtn1.Text = "Close"
      CloseBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn1.TextSize = 13.000

      CloseBtn1Corner.CornerRadius = UDim.new(0, 4)
      CloseBtn1Corner.Name = "CloseBtn1Corner"
      CloseBtn1Corner.Parent = CloseBtn1

      ResetBtn.Name = "ResetBtn"
      ResetBtn.Parent = AvatarChange
      ResetBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
      ResetBtn.BackgroundTransparency = 1.000
      ResetBtn.Position = UDim2.new(0.260895967, 0, 0.823000014, 0)
      ResetBtn.Size = UDim2.new(0, 76, 0, 27)
      ResetBtn.Font = Enum.Font.Gotham
      ResetBtn.Text = "Reset"
      ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
      ResetBtn.TextSize = 13.000

      ResetBtn.MouseButton1Click:Connect(function()
         pfp = "https://www.roblox.com/headshot-thumbnail/image?userId=".. game.Players.LocalPlayer.UserId .."&width=420&height=420&format=png"
         UserImage.Image = pfp
         UserPanelUserImage.Image = pfp
         SaveInfo()

         AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            AvatarChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)

      ResetCorner.CornerRadius = UDim.new(0, 4)
      ResetCorner.Name = "ResetCorner"
      ResetCorner.Parent = ResetBtn

      CloseBtn1.MouseButton1Click:Connect(function()
         AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            AvatarChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)

      CloseBtn2.MouseButton1Click:Connect(function()
         AvatarChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            AvatarChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)

      CloseBtn2.MouseEnter:Connect(function()
         TweenService:Create(
            Close2Icon,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(210,210,210)}
         ):Play()
      end)

      CloseBtn2.MouseLeave:Connect(function()
         TweenService:Create(
            Close2Icon,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(119, 122, 127)}
         ):Play()
      end)


      AvatarTextbox.Focused:Connect(function()
         TweenService:Create(
            TextBoxFrame,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
         ):Play()
      end)

      AvatarTextbox.FocusLost:Connect(function()
         TweenService:Create(
            TextBoxFrame,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(37, 40, 43)}
         ):Play()
      end)


   end)

   UserPanelUserTag.Name = "UserPanelUserTag"
   UserPanelUserTag.Parent = UserPanel
   UserPanelUserTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserPanelUserTag.BackgroundTransparency = 1.000
   UserPanelUserTag.Position = UDim2.new(0.271143615, 0, 0.231804818, 0)
   UserPanelUserTag.Size = UDim2.new(0, 113, 0, 19)

   UserPanelUser.Name = "UserPanelUser"
   UserPanelUser.Parent = UserPanelUserTag
   UserPanelUser.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserPanelUser.BackgroundTransparency = 1.000
   UserPanelUser.Font = Enum.Font.GothamSemibold
   UserPanelUser.TextColor3 = Color3.fromRGB(255, 255, 255)
   UserPanelUser.TextSize = 17.000
   UserPanelUser.TextXAlignment = Enum.TextXAlignment.Left
   UserPanelUser.Text = user
   UserPanelUser.Size = UDim2.new(0, UserPanelUser.TextBounds.X + 2, 0, 19)


   UserPanelUserTagLayout.Name = "UserPanelUserTagLayout"
   UserPanelUserTagLayout.Parent = UserPanelUserTag
   UserPanelUserTagLayout.FillDirection = Enum.FillDirection.Horizontal
   UserPanelUserTagLayout.SortOrder = Enum.SortOrder.LayoutOrder

   UserPanelTag.Name = "UserPanelTag"
   UserPanelTag.Parent = UserPanelUserTag
   UserPanelTag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   UserPanelTag.BackgroundTransparency = 1.000
   UserPanelTag.Position = UDim2.new(0.0419999994, 0, 0.493999988, 0)
   UserPanelTag.Size = UDim2.new(0, 65, 0, 19)
   UserPanelTag.Font = Enum.Font.Gotham
   UserPanelTag.Text = "#" .. tag
   UserPanelTag.TextColor3 = Color3.fromRGB(184, 186, 189)
   UserPanelTag.TextSize = 17.000
   UserPanelTag.TextXAlignment = Enum.TextXAlignment.Left

   UserPanelCorner.Name = "UserPanelCorner"
   UserPanelCorner.Parent = UserPanel

   LeftFrame.Name = "LeftFrame"
   LeftFrame.Parent = SettingsHolder
   LeftFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
   LeftFrame.BorderSizePixel = 0
   LeftFrame.Position = UDim2.new(0, 0, -0.000303059904, 0)
   LeftFrame.Size = UDim2.new(0, 233, 0, 375)

   MyAccountBtn.Name = "MyAccountBtn"
   MyAccountBtn.Parent = LeftFrame
   MyAccountBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
   MyAccountBtn.BorderSizePixel = 0
   MyAccountBtn.Position = UDim2.new(0.271232396, 0, 0.101614028, 0)
   MyAccountBtn.Size = UDim2.new(0, 160, 0, 30)
   MyAccountBtn.AutoButtonColor = false
   MyAccountBtn.Font = Enum.Font.SourceSans
   MyAccountBtn.Text = ""
   MyAccountBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
   MyAccountBtn.TextSize = 14.000

   MyAccountBtnCorner.CornerRadius = UDim.new(0, 6)
   MyAccountBtnCorner.Name = "MyAccountBtnCorner"
   MyAccountBtnCorner.Parent = MyAccountBtn

   MyAccountBtnTitle.Name = "MyAccountBtnTitle"
   MyAccountBtnTitle.Parent = MyAccountBtn
   MyAccountBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   MyAccountBtnTitle.BackgroundTransparency = 1.000
   MyAccountBtnTitle.BorderSizePixel = 0
   MyAccountBtnTitle.Position = UDim2.new(0.0759999976, 0, -0.166999996, 0)
   MyAccountBtnTitle.Size = UDim2.new(0, 95, 0, 39)
   MyAccountBtnTitle.Font = Enum.Font.GothamSemibold
   MyAccountBtnTitle.Text = "My Account"
   MyAccountBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
   MyAccountBtnTitle.TextSize = 14.000
   MyAccountBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

   SettingsTitle.Name = "SettingsTitle"
   SettingsTitle.Parent = LeftFrame
   SettingsTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   SettingsTitle.BackgroundTransparency = 1.000
   SettingsTitle.Position = UDim2.new(0.308999985, 0, 0.0450000018, 0)
   SettingsTitle.Size = UDim2.new(0, 65, 0, 19)
   SettingsTitle.Font = Enum.Font.GothamBlack
   SettingsTitle.Text = "SETTINGS"
   SettingsTitle.TextColor3 = Color3.fromRGB(142, 146, 152)
   SettingsTitle.TextSize = 11.000
   SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left

   DiscordInfo.Name = "DiscordInfo"
   DiscordInfo.Parent = LeftFrame
   DiscordInfo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   DiscordInfo.BackgroundTransparency = 1.000
   DiscordInfo.Position = UDim2.new(0.304721028, 0, 0.821333349, 0)
   DiscordInfo.Size = UDim2.new(0, 133, 0, 44)
   DiscordInfo.Font = Enum.Font.Gotham
   DiscordInfo.Text = "Stable 1.0.0 (00001)  Host 0.0.0.1                Roblox Lua Engine    "
   DiscordInfo.TextColor3 = Color3.fromRGB(101, 108, 116)
   DiscordInfo.TextSize = 13.000
   DiscordInfo.TextWrapped = true
   DiscordInfo.TextXAlignment = Enum.TextXAlignment.Left
   DiscordInfo.TextYAlignment = Enum.TextYAlignment.Top

   CurrentSettingOpen.Name = "CurrentSettingOpen"
   CurrentSettingOpen.Parent = LeftFrame
   CurrentSettingOpen.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
   CurrentSettingOpen.BackgroundTransparency = 1.000
   CurrentSettingOpen.Position = UDim2.new(1.07294846, 0, 0.0450000018, 0)
   CurrentSettingOpen.Size = UDim2.new(0, 65, 0, 19)
   CurrentSettingOpen.Font = Enum.Font.GothamBlack
   CurrentSettingOpen.Text = "MY ACCOUNT"
   CurrentSettingOpen.TextColor3 = Color3.fromRGB(255, 255, 255)
   CurrentSettingOpen.TextSize = 14.000
   CurrentSettingOpen.TextXAlignment = Enum.TextXAlignment.Left


   SettingsOpenBtn.MouseButton1Click:Connect(function ()
      settingsopened = true
      TopFrameHolder.Visible = false
      ServersHoldFrame.Visible = false
      SettingsFrame.Visible = true
      SettingsHolder:TweenSize(UDim2.new(0, 681, 0, 375), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
      Settings.BackgroundTransparency = 1
      TweenService:Create(
         Settings,
         TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0}
      ):Play()
      for i,v in next, SettingsHolder:GetChildren() do
         v.BackgroundTransparency = 1
         TweenService:Create(
            v,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0}
         ):Play()
      end
   end)

   EditBtn.MouseButton1Click:Connect(function()
      local NotificationHolder = Instance.new("TextButton")
      NotificationHolder.Name = "NotificationHolder"
      NotificationHolder.Parent = SettingsHolder
      NotificationHolder.BackgroundColor3 = Color3.fromRGB(22,22,22)
      NotificationHolder.Position = UDim2.new(-0.00881057233, 0, -0.00266666664, 0)
      NotificationHolder.Size = UDim2.new(0, 687, 0, 375)
      NotificationHolder.AutoButtonColor = false
      NotificationHolder.Font = Enum.Font.SourceSans
      NotificationHolder.Text = ""
      NotificationHolder.TextColor3 = Color3.fromRGB(0, 0, 0)
      NotificationHolder.TextSize = 14.000
      NotificationHolder.BackgroundTransparency = 1
      NotificationHolder.Visible = true
      TweenService:Create(
         NotificationHolder,
         TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0.2}
      ):Play()

      local UserChange = Instance.new("Frame")
      local UserChangeCorner = Instance.new("UICorner")
      local UnderBar = Instance.new("Frame")
      local UnderBarCorner = Instance.new("UICorner")
      local UnderBarFrame = Instance.new("Frame")
      local Text1 = Instance.new("TextLabel")
      local Text2 = Instance.new("TextLabel")
      local TextBoxFrame = Instance.new("Frame")
      local TextBoxFrameCorner = Instance.new("UICorner")
      local TextBoxFrame1 = Instance.new("Frame")
      local TextBoxFrame1Corner = Instance.new("UICorner")
      local UsernameTextbox = Instance.new("TextBox")
      local Seperator = Instance.new("Frame")
      local HashtagLabel = Instance.new("TextLabel")
      local TagTextbox = Instance.new("TextBox")
      local ChangeBtn = Instance.new("TextButton")
      local ChangeCorner = Instance.new("UICorner")
      local CloseBtn2 = Instance.new("TextButton")
      local Close2Icon = Instance.new("ImageLabel")
      local CloseBtn1 = Instance.new("TextButton")
      local CloseBtn1Corner = Instance.new("UICorner")

      UserChange.Name = "UserChange"
      UserChange.Parent = NotificationHolder
      UserChange.AnchorPoint = Vector2.new(0.5, 0.5)
      UserChange.BackgroundColor3 = Color3.fromRGB(25,25,25)
      UserChange.ClipsDescendants = true
      UserChange.Position = UDim2.new(0.513071597, 0, 0.4746176, 0)
      UserChange.Size = UDim2.new(0, 0, 0, 0)
      UserChange.BackgroundTransparency = 1

      UserChange:TweenSize(UDim2.new(0, 346, 0, 198), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
      TweenService:Create(
         UserChange,
         TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0}
      ):Play()

      UserChangeCorner.CornerRadius = UDim.new(0, 5)
      UserChangeCorner.Name = "UserChangeCorner"
      UserChangeCorner.Parent = UserChange

      UnderBar.Name = "UnderBar"
      UnderBar.Parent = UserChange
      UnderBar.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
      UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
      UnderBar.Size = UDim2.new(0, 346, 0, 13)

      UnderBarCorner.CornerRadius = UDim.new(0, 5)
      UnderBarCorner.Name = "UnderBarCorner"
      UnderBarCorner.Parent = UnderBar

      UnderBarFrame.Name = "UnderBarFrame"
      UnderBarFrame.Parent = UnderBar
      UnderBarFrame.BackgroundColor3 = Color3.fromRGB(47, 49, 54)
      UnderBarFrame.BorderSizePixel = 0
      UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -2.53846145, 0)
      UnderBarFrame.Size = UDim2.new(0, 346, 0, 39)

      Text1.Name = "Text1"
      Text1.Parent = UserChange
      Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Text1.BackgroundTransparency = 1.000
      Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
      Text1.Size = UDim2.new(0, 346, 0, 68)
      Text1.Font = Enum.Font.GothamSemibold
      Text1.Text = "Change your username"
      Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
      Text1.TextSize = 20.000

      Text2.Name = "Text2"
      Text2.Parent = UserChange
      Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Text2.BackgroundTransparency = 1.000
      Text2.Position = UDim2.new(-0.000594122568, 0, 0.141587839, 0)
      Text2.Size = UDim2.new(0, 346, 0, 63)
      Text2.Font = Enum.Font.Gotham
      Text2.Text = "Enter your new username."
      Text2.TextColor3 = Color3.fromRGB(171, 172, 176)
      Text2.TextSize = 14.000

      TextBoxFrame.Name = "TextBoxFrame"
      TextBoxFrame.Parent = UserChange
      TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
      TextBoxFrame.BackgroundColor3 = Color3.fromRGB(37, 40, 43)
      TextBoxFrame.Position = UDim2.new(0.49710983, 0, 0.560606062, 0)
      TextBoxFrame.Size = UDim2.new(0, 319, 0, 38)

      TextBoxFrameCorner.CornerRadius = UDim.new(0, 3)
      TextBoxFrameCorner.Name = "TextBoxFrameCorner"
      TextBoxFrameCorner.Parent = TextBoxFrame

      TextBoxFrame1.Name = "TextBoxFrame1"
      TextBoxFrame1.Parent = TextBoxFrame
      TextBoxFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
      TextBoxFrame1.BackgroundColor3 = Color3.fromRGB(48, 51, 57)
      TextBoxFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
      TextBoxFrame1.Size = UDim2.new(0, 317, 0, 36)

      TextBoxFrame1Corner.CornerRadius = UDim.new(0, 3)
      TextBoxFrame1Corner.Name = "TextBoxFrame1Corner"
      TextBoxFrame1Corner.Parent = TextBoxFrame1

      UsernameTextbox.Name = "UsernameTextbox"
      UsernameTextbox.Parent = TextBoxFrame1
      UsernameTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      UsernameTextbox.BackgroundTransparency = 1.000
      UsernameTextbox.Position = UDim2.new(0.0378548913, 0, 0, 0)
      UsernameTextbox.Size = UDim2.new(0, 221, 0, 37)
      UsernameTextbox.Font = Enum.Font.Gotham
      UsernameTextbox.Text = user
      UsernameTextbox.TextColor3 = Color3.fromRGB(193, 195, 197)
      UsernameTextbox.TextSize = 14.000
      UsernameTextbox.TextXAlignment = Enum.TextXAlignment.Left

      Seperator.Name = "Seperator"
      Seperator.Parent = TextBoxFrame1
      Seperator.AnchorPoint = Vector2.new(0.5, 0.5)
      Seperator.BackgroundColor3 = Color3.fromRGB(25,25,25)
      Seperator.BorderSizePixel = 0
      Seperator.Position = UDim2.new(0.753000021, 0, 0.500999987, 0)
      Seperator.Size = UDim2.new(0, 1, 0, 25)

      HashtagLabel.Name = "HashtagLabel"
      HashtagLabel.Parent = TextBoxFrame1
      HashtagLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      HashtagLabel.BackgroundTransparency = 1.000
      HashtagLabel.Position = UDim2.new(0.765877604, 0, -0.0546001866, 0)
      HashtagLabel.Size = UDim2.new(0, 23, 0, 37)
      HashtagLabel.Font = Enum.Font.Gotham
      HashtagLabel.Text = "#"
      HashtagLabel.TextColor3 = Color3.fromRGB(79, 82, 88)
      HashtagLabel.TextSize = 16.000

      TagTextbox.Name = "TagTextbox"
      TagTextbox.Parent = TextBoxFrame1
      TagTextbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      TagTextbox.BackgroundTransparency = 1.000
      TagTextbox.Position = UDim2.new(0.824999988, 0, -0.0280000009, 0)
      TagTextbox.Size = UDim2.new(0, 59, 0, 38)
      TagTextbox.Font = Enum.Font.Gotham
      TagTextbox.PlaceholderColor3 = Color3.fromRGB(210, 211, 212)
      TagTextbox.Text = tag
      TagTextbox.TextColor3 = Color3.fromRGB(193, 195, 197)
      TagTextbox.TextSize = 14.000
      TagTextbox.TextXAlignment = Enum.TextXAlignment.Left

      ChangeBtn.Name = "ChangeBtn"
      ChangeBtn.Parent = UserChange
      ChangeBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
      ChangeBtn.Position = UDim2.new(0.749670506, 0, 0.823232353, 0)
      ChangeBtn.Size = UDim2.new(0, 76, 0, 27)
      ChangeBtn.Font = Enum.Font.Gotham
      ChangeBtn.Text = "Change"
      ChangeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
      ChangeBtn.TextSize = 13.000
      ChangeBtn.AutoButtonColor = false

      ChangeBtn.MouseEnter:Connect(function()
         TweenService:Create(
            ChangeBtn,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(103,123,196)}
         ):Play()
      end)

      ChangeBtn.MouseLeave:Connect(function()
         TweenService:Create(
            ChangeBtn,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
         ):Play()
      end)

      ChangeBtn.MouseButton1Click:Connect(function()
         user = UsernameTextbox.Text
         tag = TagTextbox.Text
         UserSettingsPadUser.Text = user
         UserSettingsPadUser.Size = UDim2.new(0, UserSettingsPadUser.TextBounds.X + 2, 0, 19)
         UserSettingsPadTag.Text = "#" .. tag
         UserPanelTag.Text = "#" .. tag
         UserPanelUser.Text = user
         UserPanelUser.Size = UDim2.new(0, UserPanelUser.TextBounds.X + 2, 0, 19)
         UserName.Text = user
         UserTag.Text = "#" .. tag
         SaveInfo()

         UserChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            UserChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)

      ChangeCorner.CornerRadius = UDim.new(0, 4)
      ChangeCorner.Name = "ChangeCorner"
      ChangeCorner.Parent = ChangeBtn

      CloseBtn2.Name = "CloseBtn2"
      CloseBtn2.Parent = UserChange
      CloseBtn2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn2.BackgroundTransparency = 1.000
      CloseBtn2.Position = UDim2.new(0.898000002, 0, 0, 0)
      CloseBtn2.Size = UDim2.new(0, 26, 0, 26)
      CloseBtn2.Font = Enum.Font.Gotham
      CloseBtn2.Text = ""
      CloseBtn2.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn2.TextSize = 14.000

      Close2Icon.Name = "Close2Icon"
      Close2Icon.Parent = CloseBtn2
      Close2Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Close2Icon.BackgroundTransparency = 1.000
      Close2Icon.Position = UDim2.new(-0.0384615399, 0, 0.312910825, 0)
      Close2Icon.Size = UDim2.new(0, 25, 0, 25)
      Close2Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
      Close2Icon.ImageColor3 = Color3.fromRGB(119, 122, 127)

      CloseBtn1.Name = "CloseBtn1"
      CloseBtn1.Parent = UserChange
      CloseBtn1.BackgroundColor3 = Color3.fromRGB(114, 137, 228)
      CloseBtn1.BackgroundTransparency = 1.000
      CloseBtn1.Position = UDim2.new(0.495000005, 0, 0.823000014, 0)
      CloseBtn1.Size = UDim2.new(0, 76, 0, 27)
      CloseBtn1.Font = Enum.Font.Gotham
      CloseBtn1.Text = "Close"
      CloseBtn1.TextColor3 = Color3.fromRGB(255, 255, 255)
      CloseBtn1.TextSize = 13.000

      CloseBtn1Corner.CornerRadius = UDim.new(0, 4)
      CloseBtn1Corner.Name = "CloseBtn1Corner"
      CloseBtn1Corner.Parent = CloseBtn1

      CloseBtn1.MouseButton1Click:Connect(function()
         UserChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            UserChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)

      CloseBtn2.MouseButton1Click:Connect(function()
         UserChange:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            UserChange,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         TweenService:Create(
            NotificationHolder,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait(.2)
         NotificationHolder:Destroy()
      end)

      CloseBtn2.MouseEnter:Connect(function()
         TweenService:Create(
            Close2Icon,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(210,210,210)}
         ):Play()
      end)

      CloseBtn2.MouseLeave:Connect(function()
         TweenService:Create(
            Close2Icon,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(119, 122, 127)}
         ):Play()
      end)

      TagTextbox.Changed:Connect(function()
         TagTextbox.Text = TagTextbox.Text:sub(1,4)
      end)

      TagTextbox:GetPropertyChangedSignal("Text"):Connect(function()
         TagTextbox.Text = TagTextbox.Text:gsub('%D+', '');
      end)

      UsernameTextbox.Changed:Connect(function()
         UsernameTextbox.Text = UsernameTextbox.Text:sub(1,13)
      end)

      TagTextbox.Focused:Connect(function()
         TweenService:Create(
            TextBoxFrame,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
         ):Play()
      end)

      TagTextbox.FocusLost:Connect(function()
         TweenService:Create(
            TextBoxFrame,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(37, 40, 43)}
         ):Play()
      end)

      UsernameTextbox.Focused:Connect(function()
         TweenService:Create(
            TextBoxFrame,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
         ):Play()
      end)

      UsernameTextbox.FocusLost:Connect(function()
         TweenService:Create(
            TextBoxFrame,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(37, 40, 43)}
         ):Play()
      end)

   end)

   function RadientPaid:Notification(titletext, desctext, btntext)
      local NotificationHolderMain = Instance.new("TextButton")
      local Notification = Instance.new("Frame")
      local NotificationCorner = Instance.new("UICorner")
      local UnderBar = Instance.new("Frame")
      local UnderBarCorner = Instance.new("UICorner")
      local UnderBarFrame = Instance.new("Frame")
      local Text1 = Instance.new("TextLabel")
      local Text2 = Instance.new("TextLabel")
      local AlrightBtn = Instance.new("TextButton")
      local AlrightCorner = Instance.new("UICorner")

      NotificationHolderMain.Name = "NotificationHolderMain"
      NotificationHolderMain.Parent = MainFrame
      NotificationHolderMain.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
      NotificationHolderMain.BackgroundTransparency = 1
      NotificationHolderMain.BorderSizePixel = 0
      NotificationHolderMain.Position = UDim2.new(0, 0, 0.0560000017, 0)
      NotificationHolderMain.Size = UDim2.new(0, 681, 0, 374)
      NotificationHolderMain.AutoButtonColor = false
      NotificationHolderMain.Font = Enum.Font.SourceSans
      NotificationHolderMain.Text = ""
      NotificationHolderMain.TextColor3 = Color3.fromRGB(0, 0, 0)
      NotificationHolderMain.TextSize = 14.000
      TweenService:Create(
         NotificationHolderMain,
         TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0.2}
      ):Play()


      Notification.Name = "Notification"
      Notification.Parent = NotificationHolderMain
      Notification.AnchorPoint = Vector2.new(0.5, 0.5)
      Notification.BackgroundColor3 = Color3.fromRGB(15,15,15)
      Notification.ClipsDescendants = true
      Notification.Position = UDim2.new(0.524819076, 0, 0.469270051, 0)
      Notification.Size = UDim2.new(0, 0, 0, 0)
      Notification.BackgroundTransparency = 1

      Notification:TweenSize(UDim2.new(0, 346, 0, 176), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)

      TweenService:Create(
         Notification,
         TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
         {BackgroundTransparency = 0}
      ):Play()

      NotificationCorner.CornerRadius = UDim.new(0, 5)
      NotificationCorner.Name = "NotificationCorner"
      NotificationCorner.Parent = Notification

      UnderBar.Name = "UnderBar"
      UnderBar.Parent = Notification
      UnderBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
      UnderBar.Position = UDim2.new(-0.000297061284, 0, 0.945048928, 0)
      UnderBar.Size = UDim2.new(0, 346, 0, 10)

      UnderBarCorner.CornerRadius = UDim.new(0, 5)
      UnderBarCorner.Name = "UnderBarCorner"
      UnderBarCorner.Parent = UnderBar

      UnderBarFrame.Name = "UnderBarFrame"
      UnderBarFrame.Parent = UnderBar
      UnderBarFrame.BackgroundColor3 = Color3.fromRGB(14,14,14)
      UnderBarFrame.BorderSizePixel = 0
      UnderBarFrame.Position = UDim2.new(-0.000297061284, 0, -3.76068449, 0)
      UnderBarFrame.Size = UDim2.new(0, 346, 0, 40)

      Text1.Name = "Text1"
      Text1.Parent = Notification
      Text1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Text1.BackgroundTransparency = 1.000
      Text1.Position = UDim2.new(-0.000594122568, 0, 0.0202020202, 0)
      Text1.Size = UDim2.new(0, 346, 0, 68)
      Text1.Font = Enum.Font.GothamSemibold
      Text1.Text = titletext
      Text1.TextColor3 = Color3.fromRGB(255, 255, 255)
      Text1.TextSize = 20.000

      Text2.Name = "Text2"
      Text2.Parent = Notification
      Text2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Text2.BackgroundTransparency = 1.000
      Text2.Position = UDim2.new(0.106342293, 0, 0.317724228, 0)
      Text2.Size = UDim2.new(0, 272, 0, 63)
      Text2.Font = Enum.Font.Gotham
      Text2.Text = desctext
      Text2.TextColor3 = Color3.fromRGB(171, 172, 176)
      Text2.TextSize = 14.000
      Text2.TextWrapped = true

      AlrightBtn.Name = "AlrightBtn"
      AlrightBtn.Parent = Notification
      AlrightBtn.BackgroundColor3 = Color3.fromRGB(206, 61, 73)
      AlrightBtn.Position = UDim2.new(0.0332369953, 0, 0.789141417, 0)
      AlrightBtn.Size = UDim2.new(0, 322, 0, 27)
      AlrightBtn.Font = Enum.Font.Gotham
      AlrightBtn.Text = btntext
      AlrightBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
      AlrightBtn.TextSize = 13.000
      AlrightBtn.AutoButtonColor = false

      AlrightCorner.CornerRadius = UDim.new(0, 4)
      AlrightCorner.Name = "AlrightCorner"
      AlrightCorner.Parent = AlrightBtn

      AlrightBtn.MouseButton1Click:Connect(function()
         TweenService:Create(
            NotificationHolderMain,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         Notification:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .2, true)
         TweenService:Create(
            Notification,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
         ):Play()
         wait()
         NotificationHolderMain:Destroy()
      end)

      AlrightBtn.MouseEnter:Connect(function()
         TweenService:Create(
            AlrightBtn,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(233, 25, 42)}
         ):Play()
      end)

      AlrightBtn.MouseLeave:Connect(function()
         TweenService:Create(
            AlrightBtn,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(206, 61, 73)}
         ):Play()
      end)
   end

   MakeDraggable(TopFramess, MainFrame)
   ServersHoldPadding.PaddingLeft = UDim.new(0, 14)
   local ServerHold = {}
   function ServerHold:Server(text,textgame, img)
      local fc = false
      local currentchanneltoggled = ""
      local Server = Instance.new("TextButton")
      local ServerBtnCorner = Instance.new("UICorner")
      local ServerIco = Instance.new("ImageLabel")
      local ServerWhiteFrame = Instance.new("Frame")
      local ServerWhiteFrameCorner = Instance.new("UICorner")

      Server.Name = text .. "Server"
      Server.Parent = ServersHold
      Server.BackgroundColor3 = Color3.fromRGB(20,20,20)
      Server.Position = UDim2.new(0.125, 0, 0, 0)
      Server.Size = UDim2.new(0, 47, 0, 47)
      Server.AutoButtonColor = false
      Server.Font = Enum.Font.Gotham
      Server.Text = ""
      Server.BackgroundTransparency = 1
      Server.TextTransparency = 1
      Server.TextColor3 = Color3.fromRGB(233, 25, 42)
      Server.TextSize = 18.000

      ServerBtnCorner.CornerRadius = UDim.new(1, 0)
      ServerBtnCorner.Name = "ServerCorner"
      ServerBtnCorner.Parent = Server

      ServerWhiteFrame.Name = "ServerWhiteFrame"
      ServerWhiteFrame.Parent = Server
      ServerWhiteFrame.AnchorPoint = Vector2.new(0.5, 0.5)
      ServerWhiteFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ServerWhiteFrame.BackgroundTransparency = 1
      ServerWhiteFrame.Position = UDim2.new(-0.347378343, 0, 0.502659559, 0)
      ServerWhiteFrame.Size = UDim2.new(0, 11, 0, 10)

      ServerWhiteFrameCorner.CornerRadius = UDim.new(1, 0)
      ServerWhiteFrameCorner.Name = "ServerWhiteFrameCorner"
      ServerWhiteFrameCorner.Parent = ServerWhiteFrame
      ServersHold.CanvasSize = UDim2.new(0, 0, 0, ServersHoldLayout.AbsoluteContentSize.Y)

      local ServerFrame = Instance.new("Frame")
      local ServerFrame1 = Instance.new("Frame")
      local ServerFrame2 = Instance.new("Frame")
      local ServerTitleFrame = Instance.new("Frame")
      local ServerTitle = Instance.new("TextLabel")
      local ServerTitle2 = Instance.new("TextLabel")
      local GlowFrame = Instance.new("Frame")
      local Glow = Instance.new("ImageLabel")
      local ServerContentFrame = Instance.new("Frame")
      local ServerCorner = Instance.new("UICorner")
      local ChannelCorner = Instance.new("UICorner")
      local ChannelTitleFrame = Instance.new("Frame")
      local Hashtag = Instance.new("TextLabel")
      local ChannelTitle = Instance.new("TextLabel")
      local ChannelContentFrame = Instance.new("Frame")
      local GlowChannel = Instance.new("ImageLabel")
      local ServerChannelHolder = Instance.new("ScrollingFrame")
      local ServerChannelHolderLayout = Instance.new("UIListLayout")
      local ServerChannelHolderPadding = Instance.new("UIPadding")


      ServerFrame.Name = "ServerFrame"
      ServerFrame.Parent = ServersHolder
      ServerFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
      ServerFrame.BorderSizePixel = 0
      ServerFrame.ClipsDescendants = true
      ServerFrame.Position = UDim2.new(0.105726875, 0, 1.01262593, 0)
      ServerFrame.Size = UDim2.new(0, 609, 0, 373)
      ServerFrame.Visible = false

      ServerFrame1.Name = "ServerFrame1"
      ServerFrame1.Parent = ServerFrame
      ServerFrame1.BackgroundColor3 = Color3.fromRGB(20,20,20)
      ServerFrame1.BorderSizePixel = 0
      ServerFrame1.Position = UDim2.new(0, 0, 0.972290039, 0)
      ServerFrame1.Size = UDim2.new(0, 12, 0, 10)

      ServerFrame2.Name = "ServerFrame2"
      ServerFrame2.Parent = ServerFrame
      ServerFrame2.BackgroundColor3 = Color3.fromRGB(20,20,20)
      ServerFrame2.BorderSizePixel = 0
      ServerFrame2.Position = UDim2.new(0.980295539, 0, 0.972290039, 0)
      ServerFrame2.Size = UDim2.new(0, 12, 0, 9)

      ServerTitleFrame.Name = "ServerTitleFrame"
      ServerTitleFrame.Parent = ServerFrame
      ServerTitleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
      ServerTitleFrame.BackgroundTransparency = 1.000
      ServerTitleFrame.BorderSizePixel = 0
      ServerTitleFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
      ServerTitleFrame.Size = UDim2.new(0, 180, 0, 40)

      ServerTitle.Name = "ServerTitle"
      ServerTitle.Parent = ServerTitleFrame
      ServerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ServerTitle.BackgroundTransparency = 1.000
      ServerTitle.BorderSizePixel = 0
      ServerTitle.Position = UDim2.new(0.0751359761, 0, 0, 0)
      ServerTitle.Size = UDim2.new(0, 97, 0, 39)
      ServerTitle.Font = Enum.Font.GothamSemibold
      ServerTitle.Text = text
      ServerTitle.TextColor3 = Color3.fromRGB(233, 25, 42)
      ServerTitle.TextSize = 15.000
      ServerTitle.TextXAlignment = Enum.TextXAlignment.Left

      ServerTitle2.Name = "ServerTitle"
      ServerTitle2.Parent = ServerTitleFrame
      ServerTitle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ServerTitle2.BackgroundTransparency = 1
      ServerTitle2.BorderSizePixel = 0
      ServerTitle2.Position = UDim2.new(0.0541359761, 0, 7.5, 0)
      ServerTitle2.Size = UDim2.new(0, 97, 0, 39)
      ServerTitle2.ZIndex = 999
      ServerTitle2.Font = Enum.Font.GothamSemibold
      ServerTitle2.Text = textgame
      ServerTitle2.TextColor3 = Color3.fromRGB(255, 255, 255)
      ServerTitle2.TextTransparency = 0.8
      ServerTitle2.TextSize = 13.000
      ServerTitle2.TextXAlignment = Enum.TextXAlignment.Left

      GlowFrame.Name = "GlowFrame"
      GlowFrame.Parent = ServerFrame
      GlowFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
      GlowFrame.BackgroundTransparency = 1.000
      GlowFrame.BorderSizePixel = 0
      GlowFrame.Position = UDim2.new(-0.0010054264, 0, -0.000900391256, 0)
      GlowFrame.Size = UDim2.new(0, 609, 0, 40)

      Glow.Name = "Glow"
      Glow.Parent = GlowFrame
      Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Glow.BackgroundTransparency = 1.000
      Glow.BorderSizePixel = 0
      Glow.Position = UDim2.new(0, -15, 0, -15)
      Glow.Size = UDim2.new(1, 30, 1, 30)
      Glow.ZIndex = 0
      Glow.Image = "rbxassetid://4996891970"
      Glow.ImageColor3 = Color3.fromRGB(15, 15, 15)
      Glow.ScaleType = Enum.ScaleType.Slice
      Glow.SliceCenter = Rect.new(20, 20, 280, 280)

      ServerContentFrame.Name = "ServerContentFrame"
      ServerContentFrame.Parent = ServerFrame
      ServerContentFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
      ServerContentFrame.BackgroundTransparency = 1.000
      ServerContentFrame.BorderSizePixel = 0
      ServerContentFrame.Position = UDim2.new(-0.0010054264, 0, 0.106338218, 0)
      ServerContentFrame.Size = UDim2.new(0, 180, 0, 333)

      ServerCorner.CornerRadius = UDim.new(0, 4)
      ServerCorner.Name = "ServerCorner"
      ServerCorner.Parent = ServerFrame

      ChannelTitleFrame.Name = "ChannelTitleFrame"
      ChannelTitleFrame.Parent = ServerFrame
      ChannelTitleFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
      ChannelTitleFrame.BorderSizePixel = 0
      ChannelTitleFrame.Position = UDim2.new(0.294561088, 0, -0.000900391256, 0)
      ChannelTitleFrame.Size = UDim2.new(0, 429, 0, 40)

      Hashtag.Name = "Hashtag"
      Hashtag.Parent = ChannelTitleFrame
      Hashtag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      Hashtag.BackgroundTransparency = 1.000
      Hashtag.BorderSizePixel = 0
      Hashtag.Position = UDim2.new(0.0279720277, 0, 0, 0)
      Hashtag.Size = UDim2.new(0, 19, 0, 39)
      Hashtag.Font = Enum.Font.Gotham
      Hashtag.Text = "#"
      Hashtag.TextColor3 = Color3.fromRGB(114, 118, 125)
      Hashtag.TextSize = 25.000

      ChannelTitle.Name = "ChannelTitle"
      ChannelTitle.Parent = ChannelTitleFrame
      ChannelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ChannelTitle.BackgroundTransparency = 1.000
      ChannelTitle.BorderSizePixel = 0
      ChannelTitle.Position = UDim2.new(0.0862470865, 0, 0, 0)
      ChannelTitle.Size = UDim2.new(0, 95, 0, 39)
      ChannelTitle.Font = Enum.Font.GothamSemibold
      ChannelTitle.Text = ""
      ChannelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
      ChannelTitle.TextSize = 15.000
      ChannelTitle.TextXAlignment = Enum.TextXAlignment.Left

      ChannelContentFrame.Name = "ChannelContentFrame"
      ChannelContentFrame.Parent = ServerFrame
      ChannelContentFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
      ChannelContentFrame.BorderSizePixel = 0
      ChannelContentFrame.ClipsDescendants = true
      ChannelContentFrame.Position = UDim2.new(0.294561088, 0, 0.106338218, 0)
      ChannelContentFrame.Size = UDim2.new(0, 429, 0, 333)

      GlowChannel.Name = "GlowChannel"
      GlowChannel.Parent = ChannelContentFrame
      GlowChannel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      GlowChannel.BackgroundTransparency = 1.000
      GlowChannel.BorderSizePixel = 0
      GlowChannel.Position = UDim2.new(0, -33, 0, -91)
      GlowChannel.Size = UDim2.new(1.06396091, 30, 0.228228226, 30)
      GlowChannel.ZIndex = 0
      GlowChannel.Image = "rbxassetid://4996891970"
      GlowChannel.ImageColor3 = Color3.fromRGB(15, 15, 15)
      GlowChannel.ScaleType = Enum.ScaleType.Slice
      GlowChannel.SliceCenter = Rect.new(20, 20, 280, 280)

      ServerChannelHolder.Name = "ServerChannelHolder"
      ServerChannelHolder.Parent = ServerContentFrame
      ServerChannelHolder.Active = true
      ServerChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
      ServerChannelHolder.BackgroundTransparency = 1.000
      ServerChannelHolder.BorderSizePixel = 0
      ServerChannelHolder.Position = UDim2.new(0.00535549596, 0, 0.0241984241, 0)
      ServerChannelHolder.Selectable = false
      ServerChannelHolder.Size = UDim2.new(0, 179, 0, 278)
      ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
      ServerChannelHolder.ScrollBarThickness = 4
      ServerChannelHolder.ScrollBarImageColor3 = Color3.fromRGB(18, 19, 21)
      ServerChannelHolder.ScrollBarImageTransparency = 1

      ServerChannelHolderLayout.Name = "ServerChannelHolderLayout"
      ServerChannelHolderLayout.Parent = ServerChannelHolder
      ServerChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
      ServerChannelHolderLayout.Padding = UDim.new(0, 4)

      ServerChannelHolderPadding.Name = "ServerChannelHolderPadding"
      ServerChannelHolderPadding.Parent = ServerChannelHolder
      ServerChannelHolderPadding.PaddingLeft = UDim.new(0, 9)

      ServerChannelHolder.MouseEnter:Connect(function()
         ServerChannelHolder.ScrollBarImageTransparency = 0
      end)

      ServerChannelHolder.MouseLeave:Connect(function()
         ServerChannelHolder.ScrollBarImageTransparency = 1
      end)

      Server.MouseEnter:Connect(
         function()
            if currentservertoggled ~= Server.Name then
               TweenService:Create(
                  Server,
                  TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {BackgroundColor3 = Color3.fromRGB(114, 137, 228)}
               ):Play()
               TweenService:Create(
                  ServerBtnCorner,
                  TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {CornerRadius = UDim.new(0, 15)}
               ):Play()
               ServerWhiteFrame:TweenSize(
                  UDim2.new(0, 11, 0, 27),
                  Enum.EasingDirection.Out,
                  Enum.EasingStyle.Quart,
                  .3,
                  true
               )
            end
         end
      )

      Server.MouseLeave:Connect(
         function()
            if currentservertoggled ~= Server.Name then
               TweenService:Create(
                  Server,
                  TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {BackgroundColor3 = Color3.fromRGB(25,25,25)}
               ):Play()
               TweenService:Create(
                  ServerBtnCorner,
                  TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {CornerRadius = UDim.new(1, 0)}
               ):Play()
               ServerWhiteFrame:TweenSize(
                  UDim2.new(0, 11, 0, 10),
                  Enum.EasingDirection.Out,
                  Enum.EasingStyle.Quart,
                  .3,
                  true
               )
            end
         end
      )

      Server.MouseButton1Click:Connect(
         function()
            currentservertoggled = Server.Name
            for i, v in next, ServersHolder:GetChildren() do
               if v.Name == "ServerFrame" then
                  v.Visible = false
               end
               ServerFrame.Visible = true
            end
            for i, v in next, ServersHold:GetChildren() do
               if v.ClassName == "TextButton" then
                  TweenService:Create(
                     v,
                     TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                     {BackgroundColor3 = Color3.fromRGB(25,25,25)}
                  ):Play()
                  TweenService:Create(
                     Server,
                     TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                     {BackgroundColor3 = Color3.fromRGB(25,25,25)}
                  ):Play()
                  TweenService:Create(
                     v.ServerCorner,
                     TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                     {CornerRadius = UDim.new(1, 0)}
                  ):Play()
                  TweenService:Create(
                     ServerBtnCorner,
                     TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                     {CornerRadius = UDim.new(0, 15)}
                  ):Play()
                  v.ServerWhiteFrame:TweenSize(
                     UDim2.new(0, 11, 0, 10),
                     Enum.EasingDirection.Out,
                     Enum.EasingStyle.Quart,
                     .3,
                     true
                  )
                  ServerWhiteFrame:TweenSize(
                     UDim2.new(0, 11, 0, 46),
                     Enum.EasingDirection.Out,
                     Enum.EasingStyle.Quart,
                     .3,
                     true
                  )
               end
            end
         end
      )

      if fs == false then
         TweenService:Create(
            Server,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(25,25,25)}
         ):Play()
         TweenService:Create(
            ServerBtnCorner,
            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {CornerRadius = UDim.new(0, 15)}
         ):Play()
         ServerWhiteFrame:TweenSize(
            UDim2.new(0, 11, 0, 46),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .3,
            true
         )
         ServerFrame.Visible = true
         Server.Name = text .. "Server"
         currentservertoggled = Server.Name
         fs = true
      end
      local ChannelHold = {}
      function ChannelHold:Channel(text)
         local ChannelBtn = Instance.new("TextButton")
         local ChannelBtnCorner = Instance.new("UICorner")
         local ChannelBtnHashtag = Instance.new("TextLabel")
         local ChannelBtnTitle = Instance.new("TextLabel")

         ChannelBtn.Name = text .. "ChannelBtn"
         ChannelBtn.Parent = ServerChannelHolder
         ChannelBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
         ChannelBtn.BorderSizePixel = 0
         ChannelBtn.Position = UDim2.new(0.24118948, 0, 0.578947365, 0)
         ChannelBtn.Size = UDim2.new(0, 160, 0, 30)
         ChannelBtn.AutoButtonColor = false
         ChannelBtn.Font = Enum.Font.SourceSans
         ChannelBtn.Text = ""
         ChannelBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
         ChannelBtn.TextSize = 14.000

         ChannelBtnCorner.CornerRadius = UDim.new(0, 8)
         ChannelBtnCorner.Name = "ChannelBtnCorner"
         ChannelBtnCorner.Parent = ChannelBtn

         ChannelBtnHashtag.Name = "ChannelBtnHashtag"
         ChannelBtnHashtag.Parent = ChannelBtn
         ChannelBtnHashtag.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         ChannelBtnHashtag.BackgroundTransparency = 1.000
         ChannelBtnHashtag.BorderSizePixel = 0
         ChannelBtnHashtag.Position = UDim2.new(0.08, 0, 0, 0)
         ChannelBtnHashtag.Size = UDim2.new(0, 24, 0, 30)
         ChannelBtnHashtag.Font = Enum.Font.Gotham
         ChannelBtnHashtag.Text = ""
         ChannelBtnHashtag.TextColor3 = Color3.fromRGB(114, 118, 125)
         ChannelBtnHashtag.TextSize = 21.000

         ChannelBtnTitle.Name = "ChannelBtnTitle"
         ChannelBtnTitle.Parent = ChannelBtn
         ChannelBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         ChannelBtnTitle.BackgroundTransparency = 1.000
         ChannelBtnTitle.BorderSizePixel = 0
         ChannelBtnTitle.Position = UDim2.new(0.05, 0, -0.166666672, 0)
         ChannelBtnTitle.Size = UDim2.new(0, 95, 0, 39)
         ChannelBtnTitle.Font = Enum.Font.Gotham
         ChannelBtnTitle.Text = text
         ChannelBtnTitle.TextColor3 = Color3.fromRGB(114, 118, 125)
         ChannelBtnTitle.TextSize = 14.000
         ChannelBtnTitle.TextXAlignment = Enum.TextXAlignment.Left
         ServerChannelHolder.CanvasSize = UDim2.new(0, 0, 0, ServerChannelHolderLayout.AbsoluteContentSize.Y)

         local ChannelHolder = Instance.new("ScrollingFrame")
         local ChannelHolderLayout = Instance.new("UIListLayout")

         ChannelHolder.Name = "ChannelHolder"
         ChannelHolder.Parent = ChannelContentFrame
         ChannelHolder.Active = true
         ChannelHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
         ChannelHolder.BackgroundTransparency = 1.000
         ChannelHolder.BorderSizePixel = 0
         ChannelHolder.Position = UDim2.new(0.0360843192, 0, 0.0241984241, 0)
         ChannelHolder.Size = UDim2.new(0, 412, 0, 314)
         ChannelHolder.ScrollBarThickness = 6
         ChannelHolder.CanvasSize = UDim2.new(0,0,0,0)
         ChannelHolder.ScrollBarImageTransparency = 0
         ChannelHolder.ScrollBarImageColor3 = Color3.fromRGB(18, 19, 21)
         ChannelHolder.Visible = false
         ChannelHolder.ClipsDescendants = false

         ChannelHolderLayout.Name = "ChannelHolderLayout"
         ChannelHolderLayout.Parent = ChannelHolder
         ChannelHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
         ChannelHolderLayout.Padding = UDim.new(0, 8)

         ChannelBtn.MouseEnter:Connect(function()
            if currentchanneltoggled ~= ChannelBtn.Name then
               ChannelBtn.BackgroundColor3 = Color3.fromRGB(10,10,10)
               ChannelBtnTitle.TextColor3 = Color3.fromRGB(220,221,222)
            end
         end)

         ChannelBtn.MouseLeave:Connect(function()
            if currentchanneltoggled ~= ChannelBtn.Name then
               ChannelBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
               ChannelBtnTitle.TextColor3 = Color3.fromRGB(114, 118, 125)
            end
         end)

         ChannelBtn.MouseButton1Click:Connect(function()
            for i, v in next, ChannelContentFrame:GetChildren() do
               if v.Name == "ChannelHolder" then
                  v.Visible = false
               end
               ChannelHolder.Visible = true
            end
            for i, v in next, ServerChannelHolder:GetChildren() do
               if v.ClassName == "TextButton" then
                  v.BackgroundColor3 = Color3.fromRGB(25,25,25)
                  v.ChannelBtnTitle.TextColor3 = Color3.fromRGB(114, 118, 125)
               end
               ServerFrame.Visible = true
            end
            ChannelTitle.Text = text
            ChannelBtn.BackgroundColor3 = Color3.fromRGB(10,10,10)
            ChannelBtnTitle.TextColor3 = Color3.fromRGB(255,255,255)
            currentchanneltoggled = ChannelBtn.Name
         end)

         if fc == false then
            fc = true
            ChannelTitle.Text = text
            ChannelBtn.BackgroundColor3 = Color3.fromRGB(10,10,10)
            ChannelBtnTitle.TextColor3 = Color3.fromRGB(255,255,255)
            currentchanneltoggled = ChannelBtn.Name
            ChannelHolder.Visible = true
         end
         local ChannelContent = {}
         function ChannelContent:Button(text,callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")

            Button.Name = "Button"
            Button.Parent = ChannelHolder
            Button.BackgroundColor3 = Color3.fromRGB(20,20,20)
            Button.Size = UDim2.new(0, 401, 0, 30)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14.000
            Button.Text = text

            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            Button.MouseEnter:Connect(function()
               TweenService:Create(
                  Button,
                  TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                  {BackgroundColor3 = Color3.fromRGB(15,15,15)}
               ):Play()
            end)

            Button.MouseButton1Click:Connect(function()
               pcall(callback)
               Button.TextSize = 0
               TweenService:Create(
                  Button,
                  TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                  {TextSize = 14}
               ):Play()
            end)

            Button.MouseLeave:Connect(function()
               TweenService:Create(
                  Button,
                  TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                  {BackgroundColor3 = Color3.fromRGB(20,20,20)}
               ):Play()
            end)
            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
         end
         function ChannelContent:Toggle(text,default,callback)
            local toggled = false
            local Toggle = Instance.new("TextButton")
            local ToggleTitle = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleFrameCircle = Instance.new("Frame")
            local ToggleFrameCircleCorner = Instance.new("UICorner")
            local Icon = Instance.new("ImageLabel")

            Toggle.Name = "Toggle"
            Toggle.Parent = ChannelHolder
            Toggle.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Toggle.BorderSizePixel = 0
            Toggle.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
            Toggle.Size = UDim2.new(0, 401, 0, 30)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.Gotham
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.TextSize = 14.000

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0, 5, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 200, 0, 30)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
            ToggleFrame.Position = UDim2.new(0.900481343, -5, 0.13300018, 0)
            ToggleFrame.Size = UDim2.new(0, 40, 0, 21)

            ToggleFrameCorner.CornerRadius = UDim.new(0, 4)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleFrameCircle.Name = "ToggleFrameCircle"
            ToggleFrameCircle.Parent = ToggleFrame
            ToggleFrameCircle.BackgroundColor3 = Color3.fromRGB(50,50,50)
            ToggleFrameCircle.Position = UDim2.new(0.234999999, -5, 0.133000001, 0)
            ToggleFrameCircle.Size = UDim2.new(0, 15, 0, 15)

            ToggleFrameCircleCorner.CornerRadius = UDim.new(0, 4)
            ToggleFrameCircleCorner.Name = "ToggleFrameCircleCorner"
            ToggleFrameCircleCorner.Parent = ToggleFrameCircle

            Icon.Name = "Icon"
            Icon.Parent = ToggleFrameCircle
            Icon.AnchorPoint = Vector2.new(0.5, 0.5)
            Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Icon.BackgroundTransparency = 1.000
            Icon.BorderColor3 = Color3.fromRGB(255,255,255)
            Icon.Position = UDim2.new(0, 7, 0, 7)
            Icon.Size = UDim2.new(0, 13, 0, 13)
            Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
            Icon.ImageColor3 = Color3.fromRGB(255,255,255)

            Toggle.MouseButton1Click:Connect(function()
               if toggled == false then
                  TweenService:Create(Icon,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
                  TweenService:Create(ToggleFrame,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(233, 25, 42)}):Play()
                  ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                  TweenService:Create(Icon,TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                  Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
                  wait(.1)
                  TweenService:Create(Icon,TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
               else
                  TweenService:Create(Icon,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
                  TweenService:Create(ToggleFrame,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(10,10,10)}):Play()
                  ToggleFrameCircle:TweenPosition(UDim2.new(0.234999999, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
                  TweenService:Create(Icon,TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
                  Icon.Image = "http://www.roblox.com/asset/?id=6035047409"
                  wait(.01)
                  TweenService:Create(Icon,TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
               end
               toggled = not toggled
               pcall(callback, toggled)
            end)
            if default == true then
               toggled = false
               TweenService:Create(Icon,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
               TweenService:Create(ToggleFrame,TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundColor3 = Color3.fromRGB(233, 25, 42)}):Play()
               ToggleFrameCircle:TweenPosition(UDim2.new(0.655, -5, 0.133000001, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .3, true)
               TweenService:Create(Icon,TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = 1}):Play()
               Icon.Image = "http://www.roblox.com/asset/?id=6023426926"
               wait(.1)
               TweenService:Create(Icon,TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{ImageTransparency = 0}):Play()
               toggled = not toggled
               pcall(callback, toggled)
            else
               wait(.1)
            end
            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
         end

         function ChannelContent:Slider(text, min, max, start, callback)
            local SliderFunc = {}
            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderTitle = Instance.new("TextLabel")
            local SliderFrame = Instance.new("Frame")
            local SliderFrameCorner = Instance.new("UICorner")
            local CurrentValueFrame = Instance.new("Frame")
            local CurrentValueFrameCorner = Instance.new("UICorner")
            local Zip = Instance.new("Frame")
            local ZipCorner = Instance.new("UICorner")
            local ValueBubble = Instance.new("Frame")
            local ValueBubbleCorner = Instance.new("UICorner")
            local SquareBubble = Instance.new("Frame")
            local GlowBubble = Instance.new("ImageLabel")
            local ValueLabel = Instance.new("TextLabel")


            Slider.Name = "Slider"
            Slider.Parent = ChannelHolder
            Slider.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Slider.BorderSizePixel = 0
            Slider.Position = UDim2.new(0, 0, 0.216560602, 0)
            Slider.Size = UDim2.new(0, 401, 0, 38)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.Gotham
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
            Slider.TextSize = 14.000

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(233, 25, 42)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0, 5, 0, -4)
            SliderTitle.Size = UDim2.new(0, 200, 0, 27)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderFrame.Name = "SliderFrame"
            SliderFrame.Parent = Slider
            SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
            SliderFrame.Position = UDim2.new(0.497999996, 0, 0.757000029, 0)
            SliderFrame.Size = UDim2.new(0, 385, 0, 8)

            SliderFrameCorner.Name = "SliderFrameCorner"
            SliderFrameCorner.Parent = SliderFrame

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SliderFrame
            CurrentValueFrame.BackgroundColor3 = Color3.fromRGB(233, 25, 42)
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 8)

            CurrentValueFrameCorner.Name = "CurrentValueFrameCorner"
            CurrentValueFrameCorner.Parent = CurrentValueFrame

            Zip.Name = "Zip"
            Zip.Parent = SliderFrame
            Zip.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Zip.Position = UDim2.new((start or 0)/max, -6,-0.644999981, 0)
            Zip.Size = UDim2.new(0, 10, 0, 18)
            ZipCorner.CornerRadius = UDim.new(0, 3)
            ZipCorner.Name = "ZipCorner"
            ZipCorner.Parent = Zip

            ValueBubble.Name = "ValueBubble"
            ValueBubble.Parent = Zip
            ValueBubble.AnchorPoint = Vector2.new(0.5, 0.5)
            ValueBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            ValueBubble.Position = UDim2.new(0.5, 0, -1.00800002, 0)
            ValueBubble.Size = UDim2.new(0, 36, 0, 21)
            ValueBubble.Visible = false


            Zip.MouseEnter:Connect(function()
               if dragging == false then
                  ValueBubble.Visible = true
               end
            end)

            Zip.MouseLeave:Connect(function()
               if dragging == false then
                  ValueBubble.Visible = false
               end
            end)


            ValueBubbleCorner.CornerRadius = UDim.new(0, 3)
            ValueBubbleCorner.Name = "ValueBubbleCorner"
            ValueBubbleCorner.Parent = ValueBubble

            SquareBubble.Name = "SquareBubble"
            SquareBubble.Parent = ValueBubble
            SquareBubble.AnchorPoint = Vector2.new(0.5, 0.5)
            SquareBubble.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            SquareBubble.BorderSizePixel = 0
            SquareBubble.Position = UDim2.new(0.493000001, 0, 0.637999971, 0)
            SquareBubble.Rotation = 45.000
            SquareBubble.Size = UDim2.new(0, 19, 0, 19)

            GlowBubble.Name = "GlowBubble"
            GlowBubble.Parent = ValueBubble
            GlowBubble.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            GlowBubble.BackgroundTransparency = 1.000
            GlowBubble.BorderSizePixel = 0
            GlowBubble.Position = UDim2.new(0, -15, 0, -15)
            GlowBubble.Size = UDim2.new(1, 30, 1, 30)
            GlowBubble.ZIndex = 0
            GlowBubble.Image = "rbxassetid://4996891970"
            GlowBubble.ImageColor3 = Color3.fromRGB(15, 15, 15)
            GlowBubble.ScaleType = Enum.ScaleType.Slice
            GlowBubble.SliceCenter = Rect.new(20, 20, 280, 280)

            ValueLabel.Name = "ValueLabel"
            ValueLabel.Parent = ValueBubble
            ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.BackgroundTransparency = 1.000
            ValueLabel.Size = UDim2.new(0, 36, 0, 21)
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 10.000
            local function move(input)
               local pos =
                  UDim2.new(
                     math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1),
                     -6,
                     -0.644999981,
                     0
                  )
               local pos1 =
                  UDim2.new(
                     math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1),
                     0,
                     0,
                     8
                  )
               CurrentValueFrame.Size = pos1
               Zip.Position = pos
               local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
               ValueLabel.Text = tostring(value)
               pcall(callback, value)
            end
            Zip.InputBegan:Connect(
               function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then
                     dragging = true
                     ValueBubble.Visible = true
                  end
               end
            )
            Zip.InputEnded:Connect(
               function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then
                     dragging = false
                     ValueBubble.Visible = false
                  end
               end
            )
            game:GetService("UserInputService").InputChanged:Connect(
            function(input)
               if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                  move(input)
               end
            end
            )

            function SliderFunc:Change(tochange)
               CurrentValueFrame.Size = UDim2.new((tochange or 0) / max, 0, 0, 8)
               Zip.Position = UDim2.new((tochange or 0)/max, -6,-0.644999981, 0)
               ValueLabel.Text = tostring(tochange and math.floor((tochange / max) * (max - min) + min) or 0)
               pcall(callback, tochange)
            end

            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            return SliderFunc
         end
         function ChannelContent:Line()
            local Seperator1 = Instance.new("Frame")
            local Seperator2 = Instance.new("Frame")

            Seperator1.Name = "Seperator1"
            Seperator1.Parent = ChannelHolder
            Seperator1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Seperator1.BackgroundTransparency = 1.000
            Seperator1.Position = UDim2.new(0, 0, 0.350318581, 0)
            Seperator1.Size = UDim2.new(0, 100, 0, 8)

            Seperator2.Name = "Seperator2"
            Seperator2.Parent = Seperator1
            Seperator2.BackgroundColor3 = Color3.fromRGB(66, 69, 74)
            Seperator2.BorderSizePixel = 0
            Seperator2.Position = UDim2.new(0, 0, 0, 4)
            Seperator2.Size = UDim2.new(0, 401, 0, 1)
            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
         end
         function ChannelContent:Dropdown(text, list, callback)
            local DropFunc = {}
            local itemcount = 0
            local framesize = 0
            local DropTog = false
            local Dropdown = Instance.new("Frame")
            local DropdownTitle = Instance.new("TextLabel")
            local DropdownFrameOutline = Instance.new("Frame")
            local DropdownFrameOutlineCorner = Instance.new("UICorner")
            local DropdownFrame = Instance.new("Frame")
            local DropdownFrameCorner = Instance.new("UICorner")
            local CurrentSelectedText = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropdownFrameBtn = Instance.new("TextButton")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = ChannelHolder
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
            Dropdown.Size = UDim2.new(0, 403, 0, 73)

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0, 5, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 200, 0, 29)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            DropdownFrameOutline.Name = "DropdownFrameOutline"
            DropdownFrameOutline.Parent = DropdownTitle
            DropdownFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
            DropdownFrameOutline.BackgroundColor3 = Color3.fromRGB(15,15,15)
            DropdownFrameOutline.Position = UDim2.new(0.988442957, 0, 1.6197437, 0)
            DropdownFrameOutline.Size = UDim2.new(0, 396, 0, 36)

            DropdownFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
            DropdownFrameOutlineCorner.Name = "DropdownFrameOutlineCorner"
            DropdownFrameOutlineCorner.Parent = DropdownFrameOutline

            DropdownFrame.Name = "DropdownFrame"
            DropdownFrame.Parent = DropdownTitle
            DropdownFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
            DropdownFrame.ClipsDescendants = true
            DropdownFrame.Position = UDim2.new(0.00999999978, 0, 1.06638527, 0)
            DropdownFrame.Selectable = true
            DropdownFrame.Size = UDim2.new(0, 392, 0, 32)

            DropdownFrameCorner.CornerRadius = UDim.new(0, 4)
            DropdownFrameCorner.Name = "DropdownFrameCorner"
            DropdownFrameCorner.Parent = DropdownFrame

            CurrentSelectedText.Name = "CurrentSelectedText"
            CurrentSelectedText.Parent = DropdownFrame
            CurrentSelectedText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CurrentSelectedText.BackgroundTransparency = 1.000
            CurrentSelectedText.Position = UDim2.new(0.0178571437, 0, 0, 0)
            CurrentSelectedText.Size = UDim2.new(0, 193, 0, 32)
            CurrentSelectedText.Font = Enum.Font.Gotham
            CurrentSelectedText.Text = "..."
            CurrentSelectedText.TextColor3 = Color3.fromRGB(212, 212, 212)
            CurrentSelectedText.TextSize = 14.000
            CurrentSelectedText.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = CurrentSelectedText
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(1.84974098, 0, 0.167428851, 0)
            ArrowImg.Size = UDim2.new(0, 22, 0, 22)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818372"
            ArrowImg.ImageColor3 = Color3.fromRGB(212, 212, 212)

            DropdownFrameBtn.Name = "DropdownFrameBtn"
            DropdownFrameBtn.Parent = DropdownFrame
            DropdownFrameBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownFrameBtn.BackgroundTransparency = 1.000
            DropdownFrameBtn.Size = UDim2.new(0, 392, 0, 32)
            DropdownFrameBtn.Font = Enum.Font.SourceSans
            DropdownFrameBtn.Text = ""
            DropdownFrameBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownFrameBtn.TextSize = 14.000

            local DropdownFrameMainOutline = Instance.new("Frame")
            local DropdownFrameMainOutlineCorner = Instance.new("UICorner")
            local DropdownFrameMain = Instance.new("Frame")
            local DropdownFrameMainCorner = Instance.new("UICorner")
            local DropItemHolderLabel = Instance.new("TextLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropItemHolderLayout = Instance.new("UIListLayout")

            DropdownFrameMainOutline.Name = "DropdownFrameMainOutline"
            DropdownFrameMainOutline.Parent = DropdownTitle
            DropdownFrameMainOutline.BackgroundColor3 = Color3.fromRGB(15,15,15)
            DropdownFrameMainOutline.Position = UDim2.new(-0.00155700743, 0, 2.16983342, 0)
            DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 81)
            DropdownFrameMainOutline.Visible = false

            DropdownFrameMainOutlineCorner.CornerRadius = UDim.new(0, 3)
            DropdownFrameMainOutlineCorner.Name = "DropdownFrameMainOutlineCorner"
            DropdownFrameMainOutlineCorner.Parent = DropdownFrameMainOutline

            DropdownFrameMain.Name = "DropdownFrameMain"
            DropdownFrameMain.Parent = DropdownTitle
            DropdownFrameMain.BackgroundColor3 = Color3.fromRGB(25,25,25)
            DropdownFrameMain.ClipsDescendants = true
            DropdownFrameMain.Position = UDim2.new(0.00999999978, 0, 2.2568965, 0)
            DropdownFrameMain.Selectable = true
            DropdownFrameMain.Size = UDim2.new(0, 392, 0, 77)
            DropdownFrameMain.Visible = false

            DropdownFrameMainCorner.CornerRadius = UDim.new(0, 4)
            DropdownFrameMainCorner.Name = "DropdownFrameMainCorner"
            DropdownFrameMainCorner.Parent = DropdownFrameMain

            DropItemHolderLabel.Name = "ItemHolderLabel"
            DropItemHolderLabel.Parent = DropdownFrameMain
            DropItemHolderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropItemHolderLabel.BackgroundTransparency = 1.000
            DropItemHolderLabel.Position = UDim2.new(0.0178571437, 0, 0, 0)
            DropItemHolderLabel.Size = UDim2.new(0, 193, 0, 13)
            DropItemHolderLabel.Font = Enum.Font.Gotham
            DropItemHolderLabel.Text = ""
            DropItemHolderLabel.TextColor3 = Color3.fromRGB(212, 212, 212)
            DropItemHolderLabel.TextSize = 14.000
            DropItemHolderLabel.TextXAlignment = Enum.TextXAlignment.Left

            DropItemHolder.Name = "ItemHolder"
            DropItemHolder.Parent = DropItemHolderLabel
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropItemHolder.BackgroundTransparency = 1.000
            DropItemHolder.Position = UDim2.new(0, 0, 0.215384638, 0)
            DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 4
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.ScrollBarImageColor3 = Color3.fromRGB(233, 25, 42)

            DropItemHolderLayout.Name = "ItemHolderLayout"
            DropItemHolderLayout.Parent = DropItemHolder
            DropItemHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropItemHolderLayout.Padding = UDim.new(0, 0)

            DropdownFrameBtn.MouseButton1Click:Connect(function()
               if DropTog == false then
                  DropdownFrameMain.Visible = true
                  DropdownFrameMainOutline.Visible = true
                  Dropdown.Size = UDim2.new(0, 403, 0, 73 + DropdownFrameMainOutline.AbsoluteSize.Y)
                  ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)

               else
                  Dropdown.Size = UDim2.new(0, 403, 0, 73)
                  DropdownFrameMain.Visible = false
                  DropdownFrameMainOutline.Visible = false
                  ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
               end
               DropTog = not DropTog
            end)


            for i,v in next, list do
               itemcount = itemcount + 1

               if itemcount == 1 then
                  framesize = 29
               elseif itemcount == 2 then
                  framesize = 58
               elseif itemcount >= 3 then
                  framesize = 87
               end

               local Item = Instance.new("TextButton")
               local ItemCorner = Instance.new("UICorner")
               local ItemText = Instance.new("TextLabel")

               Item.Name = "Item"
               Item.Parent = DropItemHolder
               Item.BackgroundColor3 = Color3.fromRGB(10,10,10)
               Item.Size = UDim2.new(0, 379, 0, 29)
               Item.AutoButtonColor = false
               Item.Font = Enum.Font.SourceSans
               Item.Text = ""
               Item.TextColor3 = Color3.fromRGB(0, 0, 0)
               Item.TextSize = 14.000
               Item.BackgroundTransparency = 1

               ItemCorner.CornerRadius = UDim.new(0, 4)
               ItemCorner.Name = "ItemCorner"
               ItemCorner.Parent = Item

               ItemText.Name = "ItemText"
               ItemText.Parent = Item
               ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
               ItemText.BackgroundTransparency = 1.000
               ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
               ItemText.Size = UDim2.new(0, 192, 0, 29)
               ItemText.Font = Enum.Font.Gotham
               ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
               ItemText.TextSize = 14.000
               ItemText.TextXAlignment = Enum.TextXAlignment.Left
               ItemText.Text = v

               Item.MouseEnter:Connect(function()
                  ItemText.TextColor3 = Color3.fromRGB(255,255,255)
                  Item.BackgroundTransparency = 0
               end)

               Item.MouseLeave:Connect(function()
                  ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
                  Item.BackgroundTransparency = 1
               end)

               Item.MouseButton1Click:Connect(function()
                  CurrentSelectedText.Text = v
                  pcall(callback, v)
                  Dropdown.Size = UDim2.new(0, 403, 0, 73)
                  DropdownFrameMain.Visible = false
                  DropdownFrameMainOutline.Visible = false
                  ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
                  DropTog = not DropTog
               end)

               DropItemHolder.CanvasSize = UDim2.new(0,0,0,DropItemHolderLayout.AbsoluteContentSize.Y)

               DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
               DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
               DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
            end

            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)

            function DropFunc:Clear()
               for i,v in next, DropItemHolder:GetChildren() do
                  if v.Name == "Item" then
                     v:Destroy()
                  end
               end

               CurrentSelectedText.Text = "..."

               itemcount = 0
               framesize = 0
               DropItemHolder.Size = UDim2.new(0, 385, 0, 0)
               DropdownFrameMain.Size = UDim2.new(0, 392, 0, 0)
               DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, 0)
               Dropdown.Size = UDim2.new(0, 403, 0, 73)
               DropdownFrameMain.Visible = false
               DropdownFrameMainOutline.Visible = false
               ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            end

            function DropFunc:Add(textadd)
               itemcount = itemcount + 1

               if itemcount == 1 then
                  framesize = 29
               elseif itemcount == 2 then
                  framesize = 58
               elseif itemcount >= 3 then
                  framesize = 87
               end

               local Item = Instance.new("TextButton")
               local ItemCorner = Instance.new("UICorner")
               local ItemText = Instance.new("TextLabel")

               Item.Name = "Item"
               Item.Parent = DropItemHolder
               Item.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
               Item.Size = UDim2.new(0, 379, 0, 29)
               Item.AutoButtonColor = false
               Item.Font = Enum.Font.SourceSans
               Item.Text = ""
               Item.TextColor3 = Color3.fromRGB(0, 0, 0)
               Item.TextSize = 14.000
               Item.BackgroundTransparency = 1

               ItemCorner.CornerRadius = UDim.new(0, 4)
               ItemCorner.Name = "ItemCorner"
               ItemCorner.Parent = Item

               ItemText.Name = "ItemText"
               ItemText.Parent = Item
               ItemText.BackgroundColor3 = Color3.fromRGB(42, 44, 48)
               ItemText.BackgroundTransparency = 1.000
               ItemText.Position = UDim2.new(0.0211081803, 0, 0, 0)
               ItemText.Size = UDim2.new(0, 192, 0, 29)
               ItemText.Font = Enum.Font.Gotham
               ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
               ItemText.TextSize = 14.000
               ItemText.TextXAlignment = Enum.TextXAlignment.Left
               ItemText.Text = textadd

               Item.MouseEnter:Connect(function()
                  ItemText.TextColor3 = Color3.fromRGB(255,255,255)
                  Item.BackgroundTransparency = 0
               end)

               Item.MouseLeave:Connect(function()
                  ItemText.TextColor3 = Color3.fromRGB(212, 212, 212)
                  Item.BackgroundTransparency = 1
               end)

               Item.MouseButton1Click:Connect(function()
                  CurrentSelectedText.Text = textadd
                  pcall(callback, textadd)
                  Dropdown.Size = UDim2.new(0, 403, 0, 73)
                  DropdownFrameMain.Visible = false
                  DropdownFrameMainOutline.Visible = false
                  ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
                  DropTog = not DropTog
               end)

               DropItemHolder.CanvasSize = UDim2.new(0,0,0,DropItemHolderLayout.AbsoluteContentSize.Y)

               DropItemHolder.Size = UDim2.new(0, 385, 0, framesize)
               DropdownFrameMain.Size = UDim2.new(0, 392, 0, framesize + 6)
               DropdownFrameMainOutline.Size = UDim2.new(0, 396, 0, framesize + 10)
            end
            return DropFunc
         end
         function ChannelContent:Colorpicker(text, preset, callback)
            local OldToggleColor = Color3.fromRGB(0, 0, 0)
            local OldColor = Color3.fromRGB(0, 0, 0)
            local OldColorSelectionPosition = nil
            local OldHueSelectionPosition = nil
            local ColorH, ColorS, ColorV = 1, 1, 1
            local RainbowColorPicker = false
            local ColorPickerInput = nil
            local ColorInput = nil
            local HueInput = nil

            local Colorpicker = Instance.new("Frame")
            local ColorpickerTitle = Instance.new("TextLabel")
            local ColorpickerFrameOutline = Instance.new("Frame")
            local ColorpickerFrameOutlineCorner = Instance.new("UICorner")
            local ColorpickerFrame = Instance.new("Frame")
            local ColorpickerFrameCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")
            local PresetClr = Instance.new("Frame")
            local PresetClrCorner = Instance.new("UICorner")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = ChannelHolder
            Colorpicker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Colorpicker.BackgroundTransparency = 1.000
            Colorpicker.Position = UDim2.new(0.0895741582, 0, 0.474232763, 0)
            Colorpicker.Size = UDim2.new(0, 403, 0, 175)

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0, 5, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 200, 0, 29)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = "Colorpicker"
            ColorpickerTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            ColorpickerFrameOutline.Name = "ColorpickerFrameOutline"
            ColorpickerFrameOutline.Parent = ColorpickerTitle
            ColorpickerFrameOutline.BackgroundColor3 = Color3.fromRGB(37, 40, 43)
            ColorpickerFrameOutline.Position = UDim2.new(-0.00100000005, 0, 0.991999984, 0)
            ColorpickerFrameOutline.Size = UDim2.new(0, 238, 0, 139)

            ColorpickerFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
            ColorpickerFrameOutlineCorner.Name = "ColorpickerFrameOutlineCorner"

            ColorpickerFrameOutlineCorner.Parent = ColorpickerFrameOutline

            ColorpickerFrame.Name = "ColorpickerFrame"
            ColorpickerFrame.Parent = ColorpickerTitle
            ColorpickerFrame.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
            ColorpickerFrame.ClipsDescendants = true
            ColorpickerFrame.Position = UDim2.new(0.00999999978, 0, 1.06638515, 0)
            ColorpickerFrame.Selectable = true
            ColorpickerFrame.Size = UDim2.new(0, 234, 0, 135)

            ColorpickerFrameCorner.CornerRadius = UDim.new(0, 3)
            ColorpickerFrameCorner.Name = "ColorpickerFrameCorner"
            ColorpickerFrameCorner.Parent = ColorpickerFrame

            Color.Name = "Color"
            Color.Parent = ColorpickerFrame
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 10, 0, 10)
            Color.Size = UDim2.new(0, 154, 0, 118)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"

            ColorCorner.CornerRadius = UDim.new(0, 3)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit

            Hue.Name = "Hue"
            Hue.Parent = ColorpickerFrame
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0, 171, 0, 10)
            Hue.Size = UDim2.new(0, 18, 0, 118)

            HueCorner.CornerRadius = UDim.new(0, 3)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = Hue

            HueGradient.Color = ColorSequence.new {
               ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
               ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
               ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
               ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
               ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
               ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
               ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
            }
            HueGradient.Rotation = 270
            HueGradient.Name = "HueGradient"
            HueGradient.Parent = Hue

            HueSelection.Name = "HueSelection"
            HueSelection.Parent = Hue
            HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"

            PresetClr.Name = "PresetClr"
            PresetClr.Parent = ColorpickerFrame
            PresetClr.BackgroundColor3 = preset
            PresetClr.Position = UDim2.new(0.846153855, 0, 0.0740740746, 0)
            PresetClr.Size = UDim2.new(0, 25, 0, 25)

            PresetClrCorner.CornerRadius = UDim.new(0, 3)
            PresetClrCorner.Name = "PresetClrCorner"
            PresetClrCorner.Parent = PresetClr

            local function UpdateColorPicker(nope)
               PresetClr.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
               Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

               pcall(callback, PresetClr.BackgroundColor3)
            end

            ColorH =
               1 -
               (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                  Hue.AbsoluteSize.Y)
            ColorS =
               (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                  Color.AbsoluteSize.X)
            ColorV =
               1 -
               (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                  Color.AbsoluteSize.Y)

            PresetClr.BackgroundColor3 = preset
            Color.BackgroundColor3 = preset
            pcall(callback, PresetClr.BackgroundColor3)

            Color.InputBegan:Connect(
               function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then

                     if ColorInput then
                        ColorInput:Disconnect()
                     end

                     ColorInput =
                        RunService.RenderStepped:Connect(
                           function()
                           local ColorX =
                              (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                                 Color.AbsoluteSize.X)
                           local ColorY =
                              (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                                 Color.AbsoluteSize.Y)

                           ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                           ColorS = ColorX
                           ColorV = 1 - ColorY

                           UpdateColorPicker(true)
                        end
                        )
                  end
               end
            )

            Color.InputEnded:Connect(
               function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then
                     if ColorInput then
                        ColorInput:Disconnect()
                     end
                  end
               end
            )

            Hue.InputBegan:Connect(
               function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then


                     if HueInput then
                        HueInput:Disconnect()
                     end

                     HueInput =
                        RunService.RenderStepped:Connect(
                           function()
                           local HueY =
                              (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                                 Hue.AbsoluteSize.Y)

                           HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                           ColorH = 1 - HueY

                           UpdateColorPicker(true)
                        end
                        )
                  end
               end
            )

            Hue.InputEnded:Connect(
               function(input)
                  if input.UserInputType == Enum.UserInputType.MouseButton1 then
                     if HueInput then
                        HueInput:Disconnect()
                     end
                  end
               end
            )

            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
         end

         function ChannelContent:Textbox(text, placetext, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrameOutline = Instance.new("Frame")
            local TextboxFrameOutlineCorner = Instance.new("UICorner")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = ChannelHolder
            Textbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Textbox.BackgroundTransparency = 1.000
            Textbox.Position = UDim2.new(0.0796874985, 0, 0.445175439, 0)
            Textbox.Size = UDim2.new(0, 403, 0, 73)

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0, 5, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 200, 0, 29)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrameOutline.Name = "TextboxFrameOutline"
            TextboxFrameOutline.Parent = TextboxTitle
            TextboxFrameOutline.AnchorPoint = Vector2.new(0.5, 0.5)
            TextboxFrameOutline.BackgroundColor3 = Color3.fromRGB(15,15,15)
            TextboxFrameOutline.Position = UDim2.new(0.988442957, 0, 1.6197437, 0)
            TextboxFrameOutline.Size = UDim2.new(0, 396, 0, 36)

            TextboxFrameOutlineCorner.CornerRadius = UDim.new(0, 3)
            TextboxFrameOutlineCorner.Name = "TextboxFrameOutlineCorner"
            TextboxFrameOutlineCorner.Parent = TextboxFrameOutline

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = TextboxTitle
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
            TextboxFrame.ClipsDescendants = true
            TextboxFrame.Position = UDim2.new(0.00999999978, 0, 1.06638527, 0)
            TextboxFrame.Selectable = true
            TextboxFrame.Size = UDim2.new(0, 392, 0, 32)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 4)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Position = UDim2.new(0.0178571437, 0, 0, 0)
            TextBox.Size = UDim2.new(0, 377, 0, 32)
            TextBox.Font = Enum.Font.Gotham
            TextBox.PlaceholderColor3 = Color3.fromRGB(255,255,255)
            TextBox.PlaceholderText = placetext
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(193, 195, 197)
            TextBox.TextSize = 14.000
            TextBox.TextXAlignment = Enum.TextXAlignment.Left

            TextBox.Focused:Connect(function()
               TweenService:Create(
                  TextboxFrameOutline,
                  TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {BackgroundColor3 = Color3.fromRGB(255, 170, 0)}
               ):Play()
            end)

            TextBox.FocusLost:Connect(function(ep)
               TweenService:Create(
                  TextboxFrameOutline,
                  TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                  {BackgroundColor3 = Color3.fromRGB(15,15,15)}
               ):Play()
               if ep then
                  if #TextBox.Text > 0 then
                     pcall(callback, TextBox.Text)
                     if disapper then
                        TextBox.Text = ""
                     end
                  end
               end
            end)

            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
         end

         function ChannelContent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelTitle = Instance.new("TextLabel")
            local labelfunc = {}

            Label.Name = "Label"
            Label.Parent = ChannelHolder
            Label.BackgroundColor3 = Color3.fromRGB(25,25,25)
            Label.BorderSizePixel = 0
            Label.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
            Label.Size = UDim2.new(0, 401, 0, 30)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.Gotham
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14.000

            LabelTitle.Name = "LabelTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Position = UDim2.new(0, 5, 0, 0)
            LabelTitle.Size = UDim2.new(0, 200, 0, 30)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            LabelTitle.TextSize = 14.000
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
            function labelfunc:Refresh(tochange)
               Label.Text = tochange
            end

            return labelfunc
         end

         function ChannelContent:Bind(text, presetbind, callback)
            local Key = presetbind.Name
            local Keybind = Instance.new("TextButton")
            local KeybindTitle = Instance.new("TextLabel")
            local KeybindText = Instance.new("TextLabel")

            Keybind.Name = "Keybind"
            Keybind.Parent = ChannelHolder
            Keybind.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
            Keybind.BorderSizePixel = 0
            Keybind.Position = UDim2.new(0.261979163, 0, 0.190789461, 0)
            Keybind.Size = UDim2.new(0, 401, 0, 30)
            Keybind.AutoButtonColor = false
            Keybind.Font = Enum.Font.Gotham
            Keybind.Text = ""
            Keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
            Keybind.TextSize = 14.000

            KeybindTitle.Name = "KeybindTitle"
            KeybindTitle.Parent = Keybind
            KeybindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindTitle.BackgroundTransparency = 1.000
            KeybindTitle.Position = UDim2.new(0, 5, 0, 0)
            KeybindTitle.Size = UDim2.new(0, 200, 0, 30)
            KeybindTitle.Font = Enum.Font.Gotham
            KeybindTitle.Text = text
            KeybindTitle.TextColor3 = Color3.fromRGB(127, 131, 137)
            KeybindTitle.TextSize = 14.000
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left

            KeybindText.Name = "KeybindText"
            KeybindText.Parent = Keybind
            KeybindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            KeybindText.BackgroundTransparency = 1.000
            KeybindText.Position = UDim2.new(0, 316, 0, 0)
            KeybindText.Size = UDim2.new(0, 85, 0, 30)
            KeybindText.Font = Enum.Font.Gotham
            KeybindText.Text = presetbind.Name
            KeybindText.TextColor3 = Color3.fromRGB(127, 131, 137)
            KeybindText.TextSize = 14.000
            KeybindText.TextXAlignment = Enum.TextXAlignment.Right

            Keybind.MouseButton1Click:Connect(function()
               KeybindText.Text = "..."
               local inputwait = game:GetService("UserInputService").InputBegan:wait()
               if inputwait.KeyCode.Name ~= "Unknown" then
                  KeybindText.Text = inputwait.KeyCode.Name
                  Key = inputwait.KeyCode.Name
               end
            end)

            game:GetService("UserInputService").InputBegan:connect(function(current, pressed)
               if not pressed then
                  if current.KeyCode.Name == Key then
                     pcall(callback)
                  end
               end
            end)
            ChannelHolder.CanvasSize = UDim2.new(0,0,0,ChannelHolderLayout.AbsoluteContentSize.Y)
         end

         return ChannelContent
      end

      return ChannelHold
   end
   return ServerHold
end

	if _G.HideUi then
		wait(1)
		game:GetService("VirtualInputManager"):SendKeyEvent(true,305,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
		game:GetService("VirtualInputManager"):SendKeyEvent(false,305,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
	end

	wait(3)
	local win = RadientPaid:Window("")

	local serv = win:Server("Kirainc Hub", "")

	local General = serv:Channel("General")

    General:Toggle("Enable Start Kaitun",true,function(value)
        _G.AutoFarm = value
	      Auto_Farm = value
	      _G.Auto_New_World = value
	      _G.Auto_Saber = value
	      Magnet = value  
    end)

  -- Kaitun Farmming Setting

  print("Start Setting Kaitun")

  -- Auto Equip Melee

		spawn(function()
		while wait() do
		if _G.AutoFarm then
				pcall(function()
				while wait() do
				for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
				   if v.ToolTip == "Melee" then
				  if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
					  local ToolSe = tostring(v.Name)
					 local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
					 wait(.4)
					 game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
				  end
				   end
				end
			   end
			end)
		end
		end
		end)

-- AutoHaki

spawn(function()
    while wait(.1) do
        if _G.AutoFarm then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- RedeemCode

spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoFarm then
                function UseCode(Text)
                    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
                end
                UseCode("EXP_5B")
                UseCode("kittgaming")
                UseCode("Sub2Fer999")
                UseCode("Enyu_is_Pro")
                UseCode("Magicbus")
                UseCode("JCWK")
                UseCode("Starcodeheo")
                UseCode("Bluxxy")
                UseCode("fudd10_v2")
                UseCode("FUDD10")
                UseCode("BIGNEWS")
                UseCode("THEGREATACE")
                UseCode("SUB2GAMERROBOT_EXP1")
                UseCode("Sub2OfficialNoobie")
                UseCode("StrawHatMaine")
                UseCode("SUB2NOOBMASTER123")
                UseCode("Sub2Daigrock")
                UseCode("Axiore")
                UseCode("TantaiGaming")
            end
        end
    end)
end)
	
	local plr = game.Players.LocalPlayer
	local CbFw = getupvalues(require(plr.PlayerScripts.CombatFramework))
	local CbFw2 = CbFw[2]
	
	function GetCurrentBlade() 
		local p13 = CbFw2.activeController
		local ret = p13.blades[1]
		if not ret then return end
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
		return ret
	end
	
	function AttackNoCD()
		if not Auto_Farm_Bounty and not Auto_Farm_Fruit or Mix_Farm then
			if not Auto_Raid then
				local AC = CbFw2.activeController
				for i = 1, 1 do 
					local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
						plr.Character,
						{plr.Character.HumanoidRootPart},
						60
					)
					local cac = {}
					local hash = {}
					for k, v in pairs(bladehit) do
						if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
							table.insert(cac, v.Parent.HumanoidRootPart)
							hash[v.Parent] = true
						end
					end
					bladehit = cac
					if #bladehit > 0 then
						local u8 = debug.getupvalue(AC.attack, 5)
						local u9 = debug.getupvalue(AC.attack, 6)
						local u7 = debug.getupvalue(AC.attack, 4)
						local u10 = debug.getupvalue(AC.attack, 7)
						local u12 = (u8 * 798405 + u7 * 727595) % u9
						local u13 = u7 * 798405
						(function()
							u12 = (u12 * u9 + u13) % 1099511627776
							u8 = math.floor(u12 / u9)
							u7 = u12 - u8 * u9
						end)()
						u10 = u10 + 1
						debug.setupvalue(AC.attack, 5, u8)
						debug.setupvalue(AC.attack, 6, u9)
						debug.setupvalue(AC.attack, 4, u7)
						debug.setupvalue(AC.attack, 7, u10)
						pcall(function()
							if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
								AC.animator.anims.basic[1]:Play(0.01,0.01,0.01)
								game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
								game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
								game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
							end
						end)
					end
				end
			end
		end
		if Auto_Farm_Bounty or Auto_Farm_Fruit and not Mix_Farm then
			local Fast = getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
			local Lop = Fast[2]
			Lop.activeController.timeToNextAttack = (-math.huge^math.huge*math.huge)
			Lop.activeController.attacking = false
			Lop.activeController.timeToNextBlock = 0
			Lop.activeController.humanoid.AutoRotate = 80
			Lop.activeController.increment = 3
			Lop.activeController.blocking = false
			Lop.activeController.hitboxMagnitude = 80
		end
	end

	-- Auto NextSea

	spawn(function()
        while wait() do
            if _G.Auto_New_World then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 700 and World1 then
                        _G.AutoFarm = false
                        if game.Workspace.Map.Ice.Door.CanCollide == true and game.Workspace.Map.Ice.Door.Transparency == 0 then
                            repeat wait() getgenv().ToTarget(CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563)) until (CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_New_World
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                            EquipWeapon("Key")
                            local pos2 = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                            repeat wait() getgenv().ToTarget(pos2) until (pos2.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_New_World
                            wait(3)
                        elseif game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v.Humanoid.Health > 0 then
                                        repeat wait()
                                            AutoHaki()
                                            EquipWeapon(_G.Select_Weapon)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            getgenv().ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,_G.Select_Distance,0))
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 870),workspace.CurrentCamera.CFrame)
                                        until v.Humanoid.Health <= 0 or not v.Parent or not _G.Auto_New_World
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                    end
                                end
                            else
                                getgenv().ToTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Buy All Haki

					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Geppo"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)
					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Buso"
									}
							
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)
					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Soru"
									}
									game:GetService("ReplicatedStorage I").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)

	-- AutoSaber

	spawn(function()
		while wait() do
			if _G.Auto_Saber then
				if game.Players.localPlayer.Data.Level.Value < 200 then
					_G.AutoFarm = false
				else
					if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
						if _G.Auto_Saber and game.ReplicatedStorage:FindFirstChild("Saber Expert [Lv. 200] [Boss]") or game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
							if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												AutoHaki()
												EquipWeapon(_G.Select_Weapon)
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
												game:GetService'VirtualUser':CaptureController()
												game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
											end
										until not _G.Auto_Saber or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							else
								Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
								if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
								end
							end
						else
							if _G.Auto_Saber_Hop then
								Hop()
							end
						end
					elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
						EquipWeapon("Relic")
						wait(0.5)
						Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
						if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
						end
					else
						if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
							if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
										if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if _G.Auto_Saber and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
													repeat
														pcall(function() wait() 
															if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
																Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
															elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
																if Farmtween then
																	Farmtween:Stop()
																end
																AutoHaki()
																EquipWeapon(_G.Select_Weapon)
																if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
																	local args = {
																		[1] = "Buso"
																	}
																	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
																end
																game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
																game:GetService'VirtualUser':CaptureController()
																game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
															end
														end)
													until not _G.Auto_Saber or not v.Parent or v.Humanoid.Health <= 0
												end
											end
										else
											Questtween = toTarget(CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position,CFrame.new(-2848.59399, 7.4272871, 5342.44043))
											if (CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107)
											end
										end
									elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
											EquipWeapon("Relic")
											wait(0.5)
											Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
											if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055)
											end
										else
											Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
											if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624, 0.00685182028, -1.53155766e-09, -0.999976516, 9.15205245e-09, 1, -1.46888401e-09, 0.999976516, -9.14177267e-09, 0.00685182028)
												wait(.5)
												local args = {
													[1] = "ProQuestProgress",
													[2] = "RichSon"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
										if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624)
											local args = {
												[1] = "ProQuestProgress",
												[2] = "RichSon"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
									end
								else
									if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
										EquipWeapon("Cup")
										if game.Players.LocalPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
											Questtween = toTarget(CFrame.new(1397.229, 37.3480148, -1320.85217).Position,CFrame.new(1397.229, 37.3480148, -1320.85217))
											if (CFrame.new(1397.229, 37.3480148, -1320.85217).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1397.229, 37.3480148, -1320.85217, -0.11285457, 2.01368788e-08, 0.993611455, 1.91641178e-07, 1, 1.50028845e-09, -0.993611455, 1.90586206e-07, -0.11285457)
											end
										else
											wait(0.5)
											if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
												local args = {
													[1] = "ProQuestProgress",
													[2] = "SickMan"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										Questtween = toTarget(game.Workspace.Map.Desert.Cup.Position,game.Workspace.Map.Desert.Cup.CFrame)
										if (game.Workspace.Map.Desert.Cup.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Desert.Cup.CFrame
										end
										-- firetouchinterest(game.Workspace.Map.Desert.Cup.TouchInterest,game.Players.LocalPlayer.Character.Head, 1)
									end
								end
							else
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
									EquipWeapon("Torch")
									Questtween = toTarget(CFrame.new(1114.87708, 4.9214654, 4349.8501).Position,CFrame.new(1114.87708, 4.9214654, 4349.8501))
									if (CFrame.new(1114.87708, 4.9214654, 4349.8501).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
									end
								else
									Questtween = toTarget(CFrame.new(-1610.00757, 11.5049858, 164.001587).Position,CFrame.new(-1610.00757, 11.5049858, 164.001587))
									if (CFrame.new(-1610.00757, 11.5049858, 164.001587).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408)
									end
								end
							end
						else
							for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
								if v:IsA("Model") then wait()
									if v.Button.BrickColor ~= BrickColor.new("Camo") then
										repeat wait()
											Questtween = toTarget(v.Button.Position,v.Button.CFrame)
											if (v.Button.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
											end
										until not _G.Auto_Saber or v.Button.BrickColor == BrickColor.new("Camo")
									end
								end
							end    
						end
					end
				end 
			end
		end
	end)
	
	-- Mob
	
	task.spawn(function()
		while true do wait()
			if setscriptable then
				setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
				sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			pcall(function()
				if StartMagnet then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
							if InMyNetWork(v.HumanoidRootPart) then
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.Size = Vector3.new(60,60,60)
								v.HumanoidRootPart.Transparency = 1
								v.HumanoidRootPart.CanCollide = false
								v.Head.CanCollide = false
								if v.Humanoid:FindFirstChild("Animator") then
									v.Humanoid.Animator:Destroy()
								end
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
							end
						end
					end
				end
			end)
		end
	end)

	-- Hit Melee

    local Client = game.Players.LocalPlayer
    local PC = require(Client.PlayerScripts.CombatFramework.Particle)
    local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
    if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
    if not shared.cpc then shared.cpc = PC.play end
    RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
        local Hits = RL.getBladeHits(b,c,d)
        if Hits then
            PC.play = function() end
            a:Play(0.01,0.01,0.01)
            func(Hits)
            PC.play = shared.cpc
            wait(a.length * 0.5)
            a:Stop()
        end
    end

spawn(function()
    if _G.AutoFarm == true then
        local Client = game.Players.LocalPlayer
        local PC = require(Client.PlayerScripts.CombatFramework.Particle)
        local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
        if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
        if not shared.cpc then shared.cpc = PC.play end
        RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
            local Hits = RL.getBladeHits(b,c,d)
            if Hits then
                PC.play = function() end
                a:Play(0.01,0.01,0.01)
                func(Hits)
                PC.play = shared.cpc
                wait(a.length * 0.5)
                a:Stop()
            end
        end
    end
end)
	
	-- Fast Attack Modulex2
	
	local Module = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
	
	spawn(function()
		while true do
			if _G.AutoFarm then
				pcall(function()
					CameraShakerR:Stop()
					CombatFramework.activeController.attacking = false
					CombatFramework.activeController.timeToNextAttack = 0
					CombatFramework.activeController.increment = 3
					CombatFramework.activeController.hitboxMagnitude = 100
					CombatFramework.activeController.blocking = false
					CombatFramework.activeController.timeToNextBlock = 0
					CombatFramework.activeController.focusStart = 0
					CombatFramework.activeController.humanoid.AutoRotate = true
				end)
			end
			task.wait()
		end
	end)
	
	-- FastAttackFrameWork
	
	local Module = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
	spawn(function()
		while true do
			if _G.AutoFarm then
				pcall(function()
					CameraShakerR:Stop()
					CombatFramework.activeController.attacking = false
					CombatFramework.activeController.timeToNextAttack = 0
					CombatFramework.activeController.increment = 3
					CombatFramework.activeController.hitboxMagnitude = 100
					CombatFramework.activeController.blocking = false
					CombatFramework.activeController.timeToNextBlock = 0
					CombatFramework.activeController.focusStart = 0
					CombatFramework.activeController.humanoid.AutoRotate = true
				end)
			end
			task.wait()
		end
	end)
	
	-- FastAttackShaker
	
	local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
	CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	y = debug.getupvalues(CombatFrameworkR)[2]
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm then
				if typeof(y) == "table" then
					pcall(function()
						CameraShaker:Stop()
						y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
						y.activeController.timeToNextAttack = 0
						y.activeController.hitboxMagnitude = 9999
						y.activeController.active = false
						y.activeController.timeToNextBlock = 0
						y.activeController.focusStart = 0
						y.activeController.increment = 4
						y.activeController.blocking = false
						y.activeController.attacking = false
						y.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end)
	end)
	
	-- FastAttackConnect
	
	local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
	CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	y = debug.getupvalues(CombatFrameworkR)[2]
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm then
				if typeof(y) == "table" then
					pcall(function()
						CameraShaker:Stop()
						y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
						y.activeController.timeToNextAttack = 0
						y.activeController.hitboxMagnitude = 9999
						y.activeController.active = false
						y.activeController.timeToNextBlock = 0
						y.activeController.focusStart = 0
						y.activeController.increment = 4
						y.activeController.blocking = false
						y.activeController.attacking = false
						y.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end)
	end)
	
	-- CameraShaker
	
	function CameraShaker()
		task.spawn(function()
			local Camera = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
			while wait() do
				pcall(function()
					if _G.Settings.Configs["Camera Shaker"] then
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 0
					else
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 3
					end
				end)
			end
		end)
	end
	
	-- No Stun
	
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm == true then
				game.Players.LocalPlayer.Character.Stun.Value = 0
				game.Players.LocalPlayer.Character.Humanoid.Sit = false
				game.Players.LocalPlayer.Character.Busy.Value = false        
			end
		end)
	end)
	
	-- Auto Buso
	
	spawn(function()
		while wait(.1) do
			if _G.AutoFarm then 
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					local args = {
						[1] = "Buso"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
	end)
	
	-- BringFruits
	
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AutoFarm then
					for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
						if v:IsA("Tool") then
							if string.find(v.Name, "Fruit") then
								repeat wait()
									wait()
									firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
									wait()
								until not _G.BringFruit or v.Parent == game.Players.LocalPlayer.Character
							end
						end
					end
				end
			end)
		end
	end)
	
	-- StoreFruits
	
	spawn(function()
		pcall(function()
			while wait() do
				if _G.AutoStoreFruit then
					for i,v in pairs(FruitList) do
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v)
					end
				end
			end
		end)
	end)
	
	-- AutoRejoin
	
	spawn(function()
		while wait() do
			if _G.AutoFarm then
				_G.AutoFarm = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
					if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
						print("Xennia Hub Rejoin Connecting")
						game:GetService("TeleportService"):Teleport(game.PlaceId)
					end
				end)
			end
		end
	end)

	-- RedeemAllCode

	spawn(function()
		pcall(function()
			while wait() do
				if _G.AutoFarm then
					function UseCode(Text)
						game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
					end
					UseCode("EXP_5B")
					UseCode("kittgaming")
					UseCode("Sub2Fer999")
					UseCode("Enyu_is_Pro")
					UseCode("Magicbus")
					UseCode("JCWK")
					UseCode("Starcodeheo")
					UseCode("Bluxxy")
					UseCode("fudd10_v2")
					UseCode("FUDD10")
					UseCode("BIGNEWS")
					UseCode("THEGREATACE")
					UseCode("SUB2GAMERROBOT_EXP1")
					UseCode("Sub2OfficialNoobie")
					UseCode("StrawHatMaine")
					UseCode("SUB2NOOBMASTER123")
					UseCode("Sub2Daigrock")
					UseCode("Axiore")
					UseCode("TantaiGaming")
				end
			end
		end)
	end)

	-- Auto Buy Legendary Sword

		spawn(function()
			while wait() do
				if _G.AutoFarm then
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
						if _G.AutoBuyLegendarySword_Hop and _G.AutoFarm and New_World then
							wait(10)
							Hop()
						end
					end)
				end 
			end
		end)

	-- BuySoru

	spawn(function()
		pcall(function()
			while wait() do
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Soru") and game.Players.LocalPlayer.Backpack:FindFirstChild("Soru").Level.Value >= 300 then
				if _G.AutoFarm then
					local args = {
						[1] = "BuyHaki",
						[2] = "Soru"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
		end)
	end)

	-- AutoHaki

	spawn(function()
		while wait(.1) do
			if _G.AutoFarm then
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
				end
			end
		end
	end)

	-- Setfflag

			if _G.AutoFarm == true then
				while _G.AutoFarm do wait()
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
				setfflag("CrashUploadToBacktracePercentage", "0")
				setfflag("CrashUploadToBacktraceBlackholeToken", "")
				setfflag("CrashUploadToBacktraceWindowsPlayerToken", "")
			end
		end

	-- Quest
	Old_World = false
	New_World = false
	Three_World = false

	local placeId = game.PlaceId
	if placeId == 2753915549 then
		Old_World = true
	elseif placeId == 4442272183 then
		New_World = true
	elseif placeId == 7449423635 then
		Three_World = true
	end

	function toTarget(targetPos, targetCFrame)
			if FastTween then
				Distance = (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
				if Distance < 10000 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
					Speed = 500
				elseif Distance >= 10000 then
					Speed = 450
				end
			else
				Distance = (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
				if Distance < 10000 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
					Speed = 500
				elseif Distance >= 10000 then
					Speed = 450
				end
			end
			local tweenfunc = {}
		
			local tween_s = game:service"TweenService"
			local info = TweenInfo.new((targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
			local tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame * CFrame.fromAxisAngle(Vector3.new(1,0,0), math.rad(0))})
			tween:Play()
		
			function tweenfunc:Stop()
				tween:Cancel()
			end 
		
			if not tween then return tween end
			return tweenfunc
		end

	function SlowtoTarget(CFgo)
		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/250, Enum.EasingStyle.Linear)
		local tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
		tween:Play()
	end

	function totarget(CFgo)
		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/300, Enum.EasingStyle.Linear)
		local tween, err = pcall(function()
			tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
			tween:Play()
		end)
		if not tween then return err end
	end

	spawn(function()
		game:GetService("RunService").Stepped:Connect(function()
			if farm or Auto_Farm or AutoFarmBone or AutoFarmChest or FramBoss or KillAllBoss or _G.AutoNew or _G.AutoThird or _G.AutoSaber or _G.AutoPoleHOP or _G.AutoPole or _G.AutoRengoku or _G.AutoEvoRace2 or _G.AutoQuestBartilo or _G.AutoHakiRainbow or _G.AutoEliteHunter or _G.AutoYama or _G.HolyTorch then
				if not KRNL_LOADED and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
					setfflag("HumanoidParallelRemoveNoPhysics", "False")
					setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				else
					if not game:GetService("Workspace"):FindFirstChild("LOL") then
						local LOL = Instance.new("Part")
						LOL.Name = "LOL"
						LOL.Parent = game.Workspace
						LOL.Anchored = true
						LOL.Transparency = 10
						LOL.Size = Vector3.new(10,0,10)
					elseif game:GetService("Workspace"):FindFirstChild("LOL") then
						game.Workspace["LOL"].CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y - 3.8,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
					end
				end
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end)
	end)

	spawn(function()
			game:GetService("RunService").Heartbeat:Connect(function()
			if _G.Noclip then
			if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
				end
			end
		end)
	end)

	function CheckLevel()
		local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
		if Old_World then
			if Lv == 1 or Lv <= 14 or SelectMonster == "Bandit [Lv. 5]" then -- Bandit
				Ms = "Bandit [Lv. 5]"
				NameQuest = "BanditQuest1"
				QuestLv = 1
				NameMon = "Bandit"
				CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
				CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
			elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
				Ms = "Gorilla [Lv. 20]"
				NameQuest = "JungleQuest"
				QuestLv = 2
				NameMon = "Gorilla"
				CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
				CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
			elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate [Lv. 35]" then -- Pirate
				Ms = "Pirate [Lv. 35]"
				NameQuest = "BuggyQuest1"
				QuestLv = 1
				NameMon = "Pirate"
				CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
				CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
			elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute [Lv. 45]" then -- Brute
				Ms = "Brute [Lv. 45]"
				NameQuest = "BuggyQuest1"
				QuestLv = 2
				NameMon = "Brute"
				CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
				CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
			elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
				Ms = "Desert Bandit [Lv. 60]"
				NameQuest = "DesertQuest"
				QuestLv = 1
				NameMon = "Desert Bandit"
				CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
				CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
			elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
				Ms = "Desert Officer [Lv. 70]"
				NameQuest = "DesertQuest"
				QuestLv = 2
				NameMon = "Desert Officer"
				CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
				CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
			elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
				Ms = "Snow Bandit [Lv. 90]"
				NameQuest = "SnowQuest"
				QuestLv = 1
				NameMon = "Snow Bandit"
				CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
				CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
			elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman [Lv. 100]" then -- Snowman
				Ms = "Snowman [Lv. 100]"
				NameQuest = "SnowQuest"
				QuestLv = 2
				NameMon = "Snowman"
				CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
				CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
			elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
				Ms = "Chief Petty Officer [Lv. 120]"
				NameQuest = "MarineQuest2"
				QuestLv = 1
				NameMon = "Chief Petty Officer"
				CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
				CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
			elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
				Ms = "Sky Bandit [Lv. 150]"
				NameQuest = "SkyQuest"
				QuestLv = 1
				NameMon = "Sky Bandit"
				CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
				CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
			elseif Lv == 175 or Lv <= 189 or SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
				Ms = "Dark Master [Lv. 175]"
				NameQuest = "SkyQuest"
				QuestLv = 2
				NameMon = "Dark Master"
				CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
				CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
			elseif Lv == 190 or Lv <= 209 or SelectMonster == "Prisoner [Lv. 190]" then -- Prisoner
				Ms = "Prisoner [Lv. 190]"
				NameQuest = "PrisonerQuest"
				QuestLv = 1
				NameMon = "Prisoner"
				CFrameQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
				CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
			elseif Lv == 210 or Lv <= 249 or SelectMonster == "Dangerous Prisoner [Lv. 210]" then -- Dangerous Prisoner
				Ms = "Dangerous Prisoner [Lv. 210]"
				NameQuest = "PrisonerQuest"
				QuestLv = 2
				NameMon = "Dangerous Prisoner"
				CFrameQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
				CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
					elseif Lv == 250 or Lv <= 274 or SelectMonster == "Toga Warrior [Lv. 250]" then -- Toga Warrior
						Ms = "Toga Warrior [Lv. 250]"
						NameQuest = "ColosseumQuest"
						QuestLv = 1
						NameMon = "Toga Warrior"
						CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
						CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
					elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
						Ms = "Gladiator [Lv. 275]"
						NameQuest = "ColosseumQuest"
						QuestLv = 2
						NameMon = "Gladiator"
						CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
						CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
			elseif Lv == 300 or Lv <= 324 or SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
				Ms = "Military Soldier [Lv. 300]"
				NameQuest = "MagmaQuest"
				QuestLv = 1
				NameMon = "Military Soldier"
				CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
				CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
			elseif Lv == 325 or Lv <= 374 or SelectMonster == "Military Spy [Lv. 325]" then -- Military Spy
				Ms = "Military Spy [Lv. 325]"
				NameQuest = "MagmaQuest"
				QuestLv = 2
				NameMon = "Military Spy"
				CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
				CFrameMon = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
			elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
				Ms = "Fishman Warrior [Lv. 375]"
				NameQuest = "FishmanQuest"
				QuestLv = 1
				NameMon = "Fishman Warrior"
				CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				end
			elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
				Ms = "Fishman Commando [Lv. 400]"
				NameQuest = "FishmanQuest"
				QuestLv = 2
				NameMon = "Fishman Commando"
				CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				end
			elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
				Ms = "God's Guard [Lv. 450]"
				NameQuest = "SkyExp1Quest"
				QuestLv = 1
				NameMon = "God's Guard"
				CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
				CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
				end
			elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda [Lv. 475]" then -- Shanda
				Ms = "Shanda [Lv. 475]"
				NameQuest = "SkyExp1Quest"
				QuestLv = 2
				NameMon = "Shanda"
				CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
				CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
				end
			elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
				Ms = "Royal Squad [Lv. 525]"
				NameQuest = "SkyExp2Quest"
				QuestLv = 1
				NameMon = "Royal Squad"
				CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
				CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
			elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
				Ms = "Royal Soldier [Lv. 550]"
				NameQuest = "SkyExp2Quest"
				QuestLv = 2
				NameMon = "Royal Soldier"
				CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
				CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
			elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
				Ms = "Galley Pirate [Lv. 625]"
				NameQuest = "FountainQuest"
				QuestLv = 1
				NameMon = "Galley Pirate"
				CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
				CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
			elseif Lv >= 650 or SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
				Ms = "Galley Captain [Lv. 650]"
				NameQuest = "FountainQuest"
				QuestLv = 2
				NameMon = "Galley Captain"
				CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
				CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
			end
		end
		if New_World then
			if Lv == 700 or Lv <= 724 or SelectMonster == "Raider [Lv. 700]" then -- Raider
				Ms = "Raider [Lv. 700]"
				NameQuest = "Area1Quest"
				QuestLv = 1
				NameMon = "Raider"
				CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
				CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
			elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
				Ms = "Mercenary [Lv. 725]"
				NameQuest = "Area1Quest"
				QuestLv = 2
				NameMon = "Mercenary"
				CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
				CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
			elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
				Ms = "Swan Pirate [Lv. 775]"
				NameQuest = "Area2Quest"
				QuestLv = 1
				NameMon = "Swan Pirate"
				CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
				CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
			elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
				Ms = "Factory Staff [Lv. 800]"
				NameQuest = "Area2Quest"
				QuestLv = 2
				NameMon = "Factory Staff"
				CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
				CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
			elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
				Ms = "Marine Lieutenant [Lv. 875]"
				NameQuest = "MarineQuest3"
				QuestLv = 1
				NameMon = "Marine Lieutenant"
				CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
				CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
			elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
				Ms = "Marine Captain [Lv. 900]"
				NameQuest = "MarineQuest3"
				QuestLv = 2
				NameMon = "Marine Captain"
				CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
				CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
			elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie [Lv. 950]" then -- Zombie
				Ms = "Zombie [Lv. 950]"
				NameQuest = "ZombieQuest"
				QuestLv = 1
				NameMon = "Zombie"
				CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
				CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
			elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire [Lv. 975]" then -- Vampire
				Ms = "Vampire [Lv. 975]"
				NameQuest = "ZombieQuest"
				QuestLv = 2
				NameMon = "Vampire"
				CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
				CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
			elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
				Ms = "Snow Trooper [Lv. 1000]"
				NameQuest = "SnowMountainQuest"
				QuestLv = 1
				NameMon = "Snow Trooper"
				CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
				CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
			elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
				Ms = "Winter Warrior [Lv. 1050]"
				NameQuest = "SnowMountainQuest"
				QuestLv = 2
				NameMon = "Winter Warrior"
				CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
				CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
			elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
				Ms = "Lab Subordinate [Lv. 1100]"
				NameQuest = "IceSideQuest"
				QuestLv = 1
				NameMon = "Lab Subordinate"
				CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
				CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
			elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
				Ms = "Horned Warrior [Lv. 1125]"
				NameQuest = "IceSideQuest"
				QuestLv = 2
				NameMon = "Horned Warrior"
				CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
				CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
			elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
				Ms = "Magma Ninja [Lv. 1175]"
				NameQuest = "FireSideQuest"
				QuestLv = 1
				NameMon = "Magma Ninja"
				CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
				CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
			elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
				Ms = "Lava Pirate [Lv. 1200]"
				NameQuest = "FireSideQuest"
				QuestLv = 2
				NameMon = "Lava Pirate"
				CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
				CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
			elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
				Ms = "Ship Deckhand [Lv. 1250]"
				NameQuest = "ShipQuest1"
				QuestLv = 1
				NameMon = "Ship Deckhand"
				CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
				CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
				Ms = "Ship Engineer [Lv. 1275]"
				NameQuest = "ShipQuest1"
				QuestLv = 2
				NameMon = "Ship Engineer"
				CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
				CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
				Ms = "Ship Steward [Lv. 1300]"
				NameQuest = "ShipQuest2"
				QuestLv = 1
				NameMon = "Ship Steward"
				CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
				CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
				Ms = "Ship Officer [Lv. 1325]"
				NameQuest = "ShipQuest2"
				QuestLv = 2
				NameMon = "Ship Officer"
				CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
				CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
				Ms = "Arctic Warrior [Lv. 1350]"
				NameQuest = "FrostQuest"
				QuestLv = 1
				NameMon = "Arctic Warrior"
				CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
				CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
				end
			elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
				Ms = "Snow Lurker [Lv. 1375]"
				NameQuest = "FrostQuest"
				QuestLv = 2
				NameMon = "Snow Lurker"
				CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
				CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
			elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
				Ms = "Sea Soldier [Lv. 1425]"
				NameQuest = "ForgottenQuest"
				QuestLv = 1
				NameMon = "Sea Soldier"
				CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
				CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
			elseif Lv >= 1450 or SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
				Ms = "Water Fighter [Lv. 1450]"
				NameQuest = "ForgottenQuest"
				QuestLv = 2
				NameMon = "Water Fighter"
				CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
				CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
			end
		end
		if Three_World then
			if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
				Ms = "Pirate Millionaire [Lv. 1500]"
				NameQuest = "PiratePortQuest"
				QuestLv = 1
				NameMon = "Pirate Millionaire"
				CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
				CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
			elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
				Ms = "Pistol Billionaire [Lv. 1525]"
				NameQuest = "PiratePortQuest"
				QuestLv = 2
				NameMon = "Pistol Billionaire"
				CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
				CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
			elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
				Ms = "Dragon Crew Warrior [Lv. 1575]"
				NameQuest = "AmazonQuest"
				QuestLv = 1
				NameMon = "Dragon Crew Warrior"
				CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
				CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
			elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
				Ms = "Dragon Crew Archer [Lv. 1600]"
				NameQuest = "AmazonQuest"
				QuestLv = 2
				NameMon = "Dragon Crew Archer"
				CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
				CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
			elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander
				Ms = "Female Islander [Lv. 1625]"
				NameQuest = "AmazonQuest2"
				QuestLv = 1
				NameMon = "Female Islander"
				CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
				CFrameMon = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
			elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander
				Ms = "Giant Islander [Lv. 1650]"
				NameQuest = "AmazonQuest2"
				QuestLv = 2
				NameMon = "Giant Islander"
				CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
				CFrameMon = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
			elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
				Ms = "Marine Commodore [Lv. 1700]"
				NameQuest = "MarineTreeIsland"
				QuestLv = 1
				NameMon = "Marine Commodore"
				CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
				CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
			elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
				Ms = "Marine Rear Admiral [Lv. 1725]"
				NameQuest = "MarineTreeIsland"
				QuestLv = 2
				NameMon = "Marine Rear Admiral"
				CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
				CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
			elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
				Ms = "Fishman Raider [Lv. 1775]"
				NameQuest = "DeepForestIsland3"
				QuestLv = 1
				NameMon = "Fishman Raider"
				CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
				CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
			elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
				Ms = "Fishman Captain [Lv. 1800]"
				NameQuest = "DeepForestIsland3"
				QuestLv = 2
				NameMon = "Fishman Captain"
				CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
				CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
			elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
				Ms = "Forest Pirate [Lv. 1825]"
				NameQuest = "DeepForestIsland"
				QuestLv = 1
				NameMon = "Forest Pirate"
				CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
				CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
			elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
				Ms = "Mythological Pirate [Lv. 1850]"
				NameQuest = "DeepForestIsland"
				QuestLv = 2
				NameMon = "Mythological Pirate"
				CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
				CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
			elseif Lv == 1900 or Lv <= 1924 or SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
				Ms = "Jungle Pirate [Lv. 1900]"
				NameQuest = "DeepForestIsland2"
				QuestLv = 1
				NameMon = "Jungle Pirate"
				CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
				CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
			elseif Lv == 1925 or Lv <= 1974 or SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
				Ms = "Musketeer Pirate [Lv. 1925]"
				NameQuest = "DeepForestIsland2"
				QuestLv = 2
				NameMon = "Musketeer Pirate"
				CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
				CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
			elseif Lv == 1975 or Lv <= 1999 or SelectMonster == "Reborn Skeleton [Lv. 1975]" then
				Ms = "Reborn Skeleton [Lv. 1975]"
				NameQuest = "HauntedQuest1"
				QuestLv = 1
				NameMon = "Reborn Skeleton"
				CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
				CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
			elseif Lv == 2000 or Lv <= 2024 or SelectMonster == "Living Zombie [Lv. 2000]" then
				Ms = "Living Zombie [Lv. 2000]"
				NameQuest = "HauntedQuest1"
				QuestLv = 2
				NameMon = "Living Zombie"
				CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
				CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
			elseif Lv == 2025 or Lv <= 2049 or SelectMonster == "Demonic Soul [Lv. 2025]" then
				Ms = "Demonic Soul [Lv. 2025]"
				NameQuest = "HauntedQuest2"
				QuestLv = 1
				NameMon = "Demonic Soul"
				CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
				CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
			elseif Lv == 2050 or Lv <= 2074 or SelectMonster == "Posessed Mummy [Lv. 2050]" then
				Ms = "Posessed Mummy [Lv. 2050]"
				NameQuest = "HauntedQuest2"
				QuestLv = 2
				NameMon = "Posessed Mummy"
				CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
				CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
			elseif Lv == 2075 and Lv <= 2099 or SelectMonster == "Peanut Scout [Lv. 2075]" then
				Ms = "Peanut Scout [Lv. 2075]"
				NameQuest = "NutsIslandQuest"
				QuestLv = 1
				NameMon = "Peanut Scout"
				CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-2126.47998, 192.095154, -10204.6553, 0.0779861137, -9.29044361e-08, 0.996954441, 6.59006432e-08, 1, 8.80332109e-08, -0.996954441, 5.88345728e-08, 0.0779861137)
			elseif Lv == 2100 and Lv <= 2124 or SelectMonster == "Peanut President [Lv. 2100]" then
				Ms = "Peanut President [Lv. 2100]"
				NameQuest = "NutsIslandQuest"
				QuestLv = 2
				NameMon = "Peanut President"
				CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-2126.47998, 192.095154, -10204.6553, 0.0779861137, -9.29044361e-08, 0.996954441, 6.59006432e-08, 1, 8.80332109e-08, -0.996954441, 5.88345728e-08, 0.0779861137)
			elseif Lv == 2125 and Lv <= 2149 or SelectMonster == "Ice Cream Chef [Lv. 2125]" then
				Ms = "Ice Cream Chef [Lv. 2125]"
				NameQuest = "IceCreamIslandQuest"
				QuestLv = 1
				NameMon = "Ice Cream Chef"
				CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
			elseif Lv == 2150 or Lv <= 2199 or SelectMonster == "Ice Cream Commander [Lv. 2150]" then
				Ms = "Ice Cream Commander [Lv. 2150]"
				NameQuest = "IceCreamIslandQuest"
				QuestLv = 2
				NameMon = "Ice Cream Commander"
				CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
			elseif Lv == 2200 or Lv <= 2224 or SelectMonster == "Cookie Crafter [Lv. 2200]" then
				Ms = "Cookie Crafter [Lv. 2200]"
				NameQuest = "CakeQuest1"
				QuestLv = 1
				NameMon = "Cookie Crafter"
				CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
				CFrameMon = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)
			elseif Lv == 2225 or Lv <= 2249 or SelectMonster == "Cake Guard [Lv. 2225]" then
				Ms = "Cake Guard [Lv. 2225]"
				NameQuest = "CakeQuest1"
				QuestLv = 2
				NameMon = "Cake Guard"
				CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
				CFrameMon = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)
			elseif Lv == 2250 or Lv <= 2274 or SelectMonster == "Baking Staff [Lv. 2250]" then
				Ms = "Baking Staff [Lv. 2250]"
				NameQuest = "CakeQuest2"
				QuestLv = 1
				NameMon = "Baking Staff"
				CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
				CFrameMon = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)
			elseif Lv == 2275 or Lv <= 2299 or SelectMonster == "Head Baker [Lv. 2275]" then
				Ms = "Head Baker [Lv. 2275]"
				NameQuest = "CakeQuest2"
				QuestLv = 2
				NameMon = "Head Baker"
				CFrameQ = CFrame.new(-1927.9107666015625, 37.79813003540039, -12843.78515625)
				CFrameMon = CFrame.new(-2203.302490234375, 109.90937042236328, -12788.7333984375)
			elseif MyLevel == 2300 or Lv <= 2324 or SelectMonster == "Cocoa Warrior [Lv. 2300]" then
				Ms = "Cocoa Warrior [Lv. 2300]"
				NameQuest = "ChocQuest1"
				QuestLv = 1
				NameMon = "Cocoa Warrior"
				CFrameQ = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
				CFrameMon = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
			elseif MyLevel == 2325 or Lv <= 2349 or SelectMonster == "Chocolate Bar Battler [Lv. 2325]" then
				Ms = "Chocolate Bar Battler [Lv. 2325]"
				NameQuest = "ChocQuest1"
				QuestLv = 2
				NameMon = "Chocolate Bar Battler"
				CFrameQ = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
				CFrameMon = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
			elseif Lv == 2350 or Lv <= 2374 or SelectMonster == "Sweet Thief [Lv. 2350]" then
				Ms = "Sweet Thief [Lv. 2350]"
				NameQuest = "ChocQuest2"
				QuestLv = 1
				NameMon = "Sweet Thief"
				CFrameQ = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
				CFrameMon = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
			elseif Lv >= 2375 or SelectMonster == "Candy Rebel [Lv. 2375]" then
				Ms = "Candy Rebel [Lv. 2375]"
				NameQuest = "ChocQuest2"
				QuestLv = 2
				NameMon = "Candy Rebel"
				CFrameQ = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
				CFrameMon = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
			end
		end
	end

	function EquipWeapon(ToolSe)
		if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
			local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
			wait(.4)
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
		end
	end

	Type = 1
	spawn(function()
		while wait(.1) do
			if Type == 1 then
				Farm_Mode = CFrame.new(0, 15, 0)
			end
		end
	end)

	spawn(function()
		while wait(.1) do
			Type = 1
			wait(.1)
		end
	end)

	pcall(function()
		for i,v in pairs(game:GetService("Workspace").Map.Dressrosa.Tavern:GetDescendants()) do
			if v.ClassName == "Seat" then
				v:Destroy()
			end
		end
	end)

	spawn(function()
		while wait() do
			if Auto_Farm then
				if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					MagnetActive = false
					CheckLevel()
					totarget(CFrameQ)
					if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
						wait(1.1)
						CheckLevel()
						if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
						else
							totarget(CFrameQ)
						end
					end
				elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					pcall(function()
						CheckLevel()
						if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == Ms and v:FindFirstChild("Humanoid") then
									if v.Humanoid.Health > 0 then
										repeat game:GetService("RunService").Heartbeat:wait()
											if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
												if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
													EquipWeapon(SelectToolWeapon)
													totarget(v.HumanoidRootPart.CFrame * Farm_Mode)
													v.HumanoidRootPart.CanCollide = false
													v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
													game:GetService("VirtualUser"):CaptureController()
													game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
													PosMon = v.HumanoidRootPart.CFrame
													MagnetActive = true
												else
													MagnetActive = false    
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
												end
											else
												MagnetActive = false
												CheckLevel()
												totarget(CFrameMon)
											end
										until not v.Parent or v.Humanoid.Health <= 0 or Auto_Farm == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
									end
								end
							end
						else
							MagnetActive = false
							CheckLevel()
							totarget(CFrameMon)
						end
					end)
				end
			end
		end
	end)

	function Click()
		game:GetService'VirtualUser':CaptureController()
		game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
	end

	if SelectToolWeapon then
	else
		SelectToolWeapon = ""
	end

	SelectBoss = ""
		function CheckQuestBoss()
			-- Old World
			if SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
				MsBoss = "Saber Expert [Lv. 200] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
				CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
			elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
				MsBoss = "The Saw [Lv. 100] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854)
				CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188, 6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
			elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
				MsBoss = "Greybeard [Lv. 750] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666)
				CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171, -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
			elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
				MsBoss = "Mob Leader [Lv. 120] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043)
				CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
			
			elseif SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
				MsBoss = "The Gorilla King [Lv. 25] [Boss]"
				NameQuestBoss = "JungleQuest"
				LevelQuestBoss = 3
				NameBoss = "The Gorilla King"
				CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
				CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
			elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
				MsBoss = "Bobby [Lv. 55] [Boss]"
				NameQuestBoss = "BuggyQuest1"
				LevelQuestBoss = 3
				NameBoss = "Bobby"
				CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
				CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
			elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
				MsBoss = "Yeti [Lv. 110] [Boss]"
				NameQuestBoss = "SnowQuest"
				LevelQuestBoss = 3
				NameBoss = "Yeti"
				CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943, -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
				CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851, 6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
			elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
				MsBoss = "Vice Admiral [Lv. 130] [Boss]"
				NameQuestBoss = "MarineQuest2"
				LevelQuestBoss = 2
				NameBoss = "Vice Admiral"
				CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739, -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
				CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
			elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
				MsBoss = "Warden [Lv. 175] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 1
				NameBoss = "Warden"
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
				MsBoss = "Chief Warden [Lv. 200] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 2
				NameBoss = "Chief Warden"
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Swan [Lv. 225] [Boss]" then
				MsBoss = "Swan [Lv. 225] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 3
				NameBoss = "Swan"
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
				MsBoss = "Magma Admiral [Lv. 350] [Boss]"
				NameQuestBoss = "MagmaQuest"
				LevelQuestBoss = 3
				NameBoss = "Magma Admiral"
				CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515, -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
				CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294, 1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
			elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
				MsBoss = "Fishman Lord [Lv. 425] [Boss]"
				NameQuestBoss = "FishmanQuest"
				LevelQuestBoss = 3
				NameBoss = "Fishman Lord"
				CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129, -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
				CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
			elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
				MsBoss = "Wysper [Lv. 500] [Boss]"
				NameQuestBoss = "SkyExp1Quest"
				LevelQuestBoss = 3
				NameBoss = "Wysper"
				CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991, 1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
				CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379, 3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
			elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
				MsBoss = "Thunder God [Lv. 575] [Boss]"
				NameQuestBoss = "SkyExp2Quest"
				LevelQuestBoss = 3
				NameBoss = "Thunder God"
				CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07, 0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
				CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069, -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
			elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
				MsBoss = "Cyborg [Lv. 675] [Boss]"
				NameQuestBoss = "FountainQuest"
				LevelQuestBoss = 3
				NameBoss = "Cyborg"
				CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521, 2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
				CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457, -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
			
				-- New World
			elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
				MsBoss = "Don Swan [Lv. 1000] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Don Swan"
				CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174, 8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
			
			elseif SelectBoss == "Diamond [Lv. 750] [Boss]" then
				MsBoss = "Diamond [Lv. 750] [Boss]"
				NameQuestBoss = "Area1Quest"
				LevelQuestBoss = 3
				NameBoss = "Diamond"
				CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
				CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
			elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
				MsBoss = "Jeremy [Lv. 850] [Boss]"
				NameQuestBoss = "Area2Quest"
				LevelQuestBoss = 3
				NameBoss = "Jeremy"
				CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
				CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
			elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
				MsBoss = "Fajita [Lv. 925] [Boss]"
				NameQuestBoss = "MarineQuest3"
				LevelQuestBoss = 3
				NameBoss = "Fajita"
				CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
				CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449, -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
			elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
				MsBoss = "Smoke Admiral [Lv. 1150] [Boss]"
				NameQuestBoss = "IceSideQuest"
				LevelQuestBoss = 3
				NameBoss = "Smoke Admiral"
				CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337, -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
				CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282, 4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
			elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
				MsBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
				NameQuestBoss = "FrostQuest"
				LevelQuestBoss = 3
				NameBoss = "Awakened Ice Admiral"
				CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472, 4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
				CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424, -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
			elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
				MsBoss = "Tide Keeper [Lv. 1475] [Boss]"
				NameQuestBoss = "ForgottenQuest"             
				LevelQuestBoss = 3
				NameBoss = "Tide Keeper"
				CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771, -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
				CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
			
			elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
				MsBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Cursed Captain"
				CFrameQuestBoss = CFrame.new(916.928589, 181.092773, 33422)
				CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364, 8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
			elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				MsBoss = "Darkbeard [Lv. 1000] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Darkbeard"
				CFrameQuestBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777)
				CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836, 4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
			elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
				MsBoss = "Order [Lv. 1250] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Order"
				CFrameQuestBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584)
				CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505, 5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
			
				-- Thire World
			elseif SelectBoss == "Stone [Lv. 1550] [Boss]" then
				MsBoss = "Stone [Lv. 1550] [Boss]"
				NameQuestBoss = "PiratePortQuest"             
				LevelQuestBoss = 3
				NameBoss = "Stone"
				CFrameQuestBoss = CFrame.new(-290, 44, 5577)
				CFrameBoss = CFrame.new(-1085, 40, 6779)
			elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
				MsBoss = "Island Empress [Lv. 1675] [Boss]"
				NameQuestBoss = "AmazonQuest2"             
				LevelQuestBoss = 3
				NameBoss = "Island Empress"
				CFrameQuestBoss = CFrame.new(5443, 602, 752)
				CFrameBoss = CFrame.new(5659, 602, 244)
			elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
				MsBoss = "Kilo Admiral [Lv. 1750] [Boss]"
				NameQuestBoss = "MarineTreeIsland"             
				LevelQuestBoss = 3
				NameBoss = "Kilo Admiral"
				CFrameQuestBoss = CFrame.new(2178, 29, -6737)
				CFrameBoss =CFrame.new(2846, 433, -7100)
			elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
				MsBoss = "Captain Elephant [Lv. 1875] [Boss]"
				NameQuestBoss = "DeepForestIsland"             
				LevelQuestBoss = 3
				NameBoss = "Captain Elephant"
				CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
				CFrameBoss = CFrame.new(-13221, 325, -8405)
			elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
				MsBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
				NameQuestBoss = "DeepForestIsland2"             
				LevelQuestBoss = 3
				NameBoss = "Beautiful Pirate"
				CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
				CFrameBoss = CFrame.new(5182, 23, -20)
			elseif SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
				MsBoss = "Cake Queen [Lv. 2175] [Boss]"
				NameQuestBoss = "IceCreamIslandQuest"             
				LevelQuestBoss = 3
				NameBoss = "Cake Queen"
				CFrameQuestBoss = CFrame.new(-716, 382, -11010)
				CFrameBoss = CFrame.new(-821, 66, -10965)
		
			elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
				MsBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"
				LevelQuestBoss = 3
				NameQuestBoss = ""
				NameBoss = "rip_indra True Form"
				CFrameQuestBoss = CFrame.new(-5359, 424, -2735)
				CFrameBoss = CFrame.new(-5359, 424, -2735)
			elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
				MsBoss = "Longma [Lv. 2000] [Boss]"
				LevelQuestBoss = 3
				NameQuestBoss = ""
				NameBoss = "Longma"
				CFrameQuestBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
				CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
			elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
				MsBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"
				LevelQuestBoss = 3
				NameQuestBoss = ""
				NameBoss = "Soul Reaper"
				CFrameQuestBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
				CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
			end
		end
		CheckQuestBoss() 
		
		AutoQuestBoss = true
		function CheckQuestBoss()
			-- Old World
			if SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
				MsBoss = "Saber Expert [Lv. 200] [Boss]"
				CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
			elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
				MsBoss = "The Saw [Lv. 100] [Boss]"
				CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188, 6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
			elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
				MsBoss = "Greybeard [Lv. 750] [Raid Boss]"
				CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171, -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
			elseif SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
				MsBoss = "The Gorilla King [Lv. 25] [Boss]"
				NameQuestBoss = "JungleQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
				CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
			elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
				MsBoss = "Bobby [Lv. 55] [Boss]"
				NameQuestBoss = "BuggyQuest1"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
				CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
			elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
				MsBoss = "Yeti [Lv. 110] [Boss]"
				NameQuestBoss = "SnowQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943, -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
				CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851, 6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
			elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
				MsBoss = "Mob Leader [Lv. 120] [Boss]"
				CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
			elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
				MsBoss = "Vice Admiral [Lv. 130] [Boss]"
				NameQuestBoss = "MarineQuest2"
				LevelQuestBoss = 2
				CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739, -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
				CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
			elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
				MsBoss = "Warden [Lv. 175] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 1
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
				MsBoss = "Chief Warden [Lv. 200] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 2
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Swan [Lv. 225] [Boss]" then
				MsBoss = "Swan [Lv. 225] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
				MsBoss = "Magma Admiral [Lv. 350] [Boss]"
				NameQuestBoss = "MagmaQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515, -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
				CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294, 1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
			elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
				MsBoss = "Fishman Lord [Lv. 425] [Boss]"
				NameQuestBoss = "FishmanQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129, -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
				CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
			elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
				MsBoss = "Wysper [Lv. 500] [Boss]"
				NameQuestBoss = "SkyExp1Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991, 1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
				CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379, 3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
			elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
				MsBoss = "Thunder God [Lv. 575] [Boss]"
				NameQuestBoss = "SkyExp2Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07, 0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
				CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069, -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
			elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
				MsBoss = "Cyborg [Lv. 675] [Boss]"
				NameQuestBoss = "FountainQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521, 2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
				CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457, -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
			-- New World
			elseif SelectBoss == "Diamond [Lv. 750] [Boss]" then
				MsBoss = "Diamond [Lv. 750] [Boss]"
				NameQuestBoss = "Area1Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
				CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
			elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
				MsBoss = "Jeremy [Lv. 850] [Boss]"
				NameQuestBoss = "Area2Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
				CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
			elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
				MsBoss = "Fajita [Lv. 925] [Boss]"
				NameQuestBoss = "MarineQuest3"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
				CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449, -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
			elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
				MsBoss = "Don Swan [Lv. 1000] [Boss]"
				CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174, 8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
			elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
				MsBoss = "Smoke Admiral [Lv. 1150] [Boss]"
				NameQuestBoss = "IceSideQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337, -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
				CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282, 4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
			elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
				MsBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
				CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364, 8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
				elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				MsBoss = "Darkbeard [Lv. 1000] [Raid Boss]"
				CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836, 4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
				elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
				MsBoss = "Order [Lv. 1250] [Raid Boss]"
				CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505, 5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
			elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
				MsBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
				NameQuestBoss = "FrostQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472, 4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
				CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424, -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
			elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
				MsBoss = "Tide Keeper [Lv. 1475] [Boss]"
				NameQuestBoss = "ForgottenQuest"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771, -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
				CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
			-- Thire World
			elseif SelectBoss == "Stone [Lv. 1550] [Boss]" then
				MsBoss = "Stone [Lv. 1550] [Boss]"
				NameQuestBoss = "PiratePortQuest"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-290, 44, 5577)
				CFrameBoss = CFrame.new(-1085, 40, 6779)
			elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
				MsBoss = "Island Empress [Lv. 1675] [Boss]"
				NameQuestBoss = "AmazonQuest2"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(5443, 602, 752)
				CFrameBoss = CFrame.new(5659, 602, 244)
			elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
				MsBoss = "Kilo Admiral [Lv. 1750] [Boss]"
				NameQuestBoss = "MarineTreeIsland"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(2178, 29, -6737)
				CFrameBoss =CFrame.new(2846, 433, -7100)
			elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
				MsBoss = "Captain Elephant [Lv. 1875] [Boss]"
				NameQuestBoss = "DeepForestIsland"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
				CFrameBoss = CFrame.new(-13221, 325, -8405)
			elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
				MsBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
				NameQuestBoss = "DeepForestIsland2"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
				CFrameBoss = CFrame.new(5182, 23, -20)
			elseif SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
				MsBoss = "Cake Queen [Lv. 2175] [Boss]"
				NameQuestBoss = "IceCreamIslandQuest"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-716, 382, -11010)
				CFrameBoss = CFrame.new(-821, 66, -10965)
			elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
				MsBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"
				CFrameBoss = CFrame.new(-5359, 424, -2735)
			elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
				MsBoss = "Longma [Lv. 2000] [Boss]"
				CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
			elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
				MsBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"
				CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
			end
		end
	function AutoFramBoss()
		CheckQuestBoss()
			if MsBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or MsBoss == "Order [Lv. 1250] [Raid Boss]" or MsBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or MsBoss == "Longma [Lv. 2000] [Boss]" or MsBoss == "The Saw [Lv. 100] [Boss]" or MsBoss == "Greybeard [Lv. 750] [Raid Boss]" or MsBoss == "Don Swan [Lv. 1000] [Boss]" or MsBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or MsBoss == "Saber Expert [Lv. 200] [Boss]" or MsBoss == "Mob Leader [Lv. 120] [Boss]" or MsBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if FramBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MsBoss then
							repeat wait() 
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
								elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									if Farmtween then
										Farmtween:Stop()
									end
									EquipWeapon(SelectToolWeapon)
									Usefastattack = true
									if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
										local args = {
											[1] = "Buso"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
									Click()
								end
							until not FramBoss or not v.Parent or v.Humanoid.Health <= 0
							Usefastattack = false
						end
					end
				else
					Usefastattack = false
					Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
					if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						wait(1)
					end 
				end
			else
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					Usefastattack = false
					CheckQuestBoss()
					Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
					if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
						wait(1.1)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, LevelQuestBoss)
					end 
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(MsBoss) then print("Find")
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if FramBoss and v.Name == MsBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat wait()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
										EquipWeapon(SelectToolWeapon)
										if Farmtween then
											Farmtween:Stop()
										end
										if Modstween then
											Modstween:Stop()
										end
										Usefastattack = true
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											local args = {
												[1] = "Buso"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
										Click()
									end
								until not FramBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
								Usefastattack = false
							end
						end
					else
						Usefastattack = false
						Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
						if ThreeWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1925 and MsBoss == "Beautiful Pirate [Lv. 1950] [Boss]" and (CFrameBoss.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude < 500 then
							if Questtween then
								Questtween:Stop()
							end
							local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
							UseTween = false
							wait(.1)
						elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						end 
					end
				end
			end
		end
	KillBossuseGet = false
		function AutoFramAllBoss()
			for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
				if not KillBossuseGet then
					if v.Name == "Diamond [Lv. 750] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 750 then
						SelectBoss = "Diamond [Lv. 750] [Boss]"
					elseif v.Name == "Jeremy [Lv. 850] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 850 then
						SelectBoss = "Jeremy [Lv. 850] [Boss]"
					elseif v.Name == "Fajita [Lv. 925] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 925  then
						SelectBoss = "Fajita [Lv. 925] [Boss]"
					elseif v.Name == "Don Swan [Lv. 1000] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1000 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1") == 0 then
						SelectBoss = "Don Swan [Lv. 1000] [Boss]" 
					elseif v.Name == "Smoke Admiral [Lv. 1150] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1150 then
						SelectBoss = "Smoke Admiral [Lv. 1150] [Boss]"
					elseif v.Name == "Cursed Captain [Lv. 1325] [Raid Boss]" and game.Players.localPlayer.Data.Level.Value >= 1325 then
						SelectBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
					elseif v.Name == "Awakened Ice Admiral [Lv. 1400] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1400  then
						SelectBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
					elseif v.Name == "Tide Keeper [Lv. 1475] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1475  then
						SelectBoss = "Tide Keeper [Lv. 1475] [Boss]"
					-- Old World
					elseif v.Name == "The Gorilla King [Lv. 25] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 20  then
						SelectBoss = "The Gorilla King [Lv. 25] [Boss]"
					elseif v.Name == "Bobby [Lv. 55] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 55  then
						SelectBoss = "Bobby [Lv. 55] [Boss]" 
					elseif v.Name == "Yeti [Lv. 110] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 105  then
						SelectBoss = "Yeti [Lv. 110] [Boss]"
					elseif v.Name == "Mob Leader [Lv. 120] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 120 then
						SelectBoss = "Mob Leader [Lv. 120] [Boss]"
					elseif v.Name == "Vice Admiral [Lv. 130] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 130 then
						SelectBoss = "Vice Admiral [Lv. 130] [Boss]"
					elseif v.Name == "Warden [Lv. 175] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 175 then
						SelectBoss = "Warden [Lv. 175] [Boss]"
					elseif v.Name == "Saber Expert [Lv. 200] [Boss]" and game.Workspace.Map.Jungle.Final.Part.Transparency == 1 then
						SelectBoss = "Saber Expert [Lv. 200] [Boss]"
					elseif v.Name == "Chief Warden [Lv. 200] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 200 then
						SelectBoss = "Chief Warden [Lv. 200] [Boss]"
					elseif v.Name == "Swan [Lv. 225] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 250 then
						SelectBoss = "Swan [Lv. 225] [Boss]"
					elseif v.Name == "Magma Admiral [Lv. 350] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 350  then
						SelectBoss = "Magma Admiral [Lv. 350] [Boss]"
					elseif v.Name == "Fishman Lord [Lv. 425] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 425  then
						SelectBoss = "Fishman Lord [Lv. 425] [Boss]"
					elseif v.Name == "Wysper [Lv. 500] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 500 then
						SelectBoss = "Wysper [Lv. 500] [Boss]"
					elseif v.Name == "Thunder God [Lv. 575] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 575 then
						SelectBoss = "Thunder God [Lv. 575] [Boss]"
					elseif v.Name == "Cyborg [Lv. 675] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 675 then
						SelectBoss = "Cyborg [Lv. 675] [Boss]"
					-- Thire World
					elseif v.Name == "Stone [Lv. 1550] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1550 then
						SelectBoss = "Stone [Lv. 1550] [Boss]"
					elseif v.Name == "Island Empress [Lv. 1675] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1675 then
						SelectBoss = "Island Empress [Lv. 1675] [Boss]"
					elseif v.Name == "Kilo Admiral [Lv. 1750] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1750 then
						SelectBoss = "Kilo Admiral [Lv. 1750] [Boss]"
					elseif v.Name == "Captain Elephant [Lv. 1875] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1875 then
						SelectBoss = "Captain Elephant [Lv. 1875] [Boss]"
					elseif v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1950 then
						SelectBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
					end 
				end 
			end
			CheckQuestBoss()
			if SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or SelectBoss == "Order [Lv. 1250] [Raid Boss]" or SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or SelectBoss == "Longma [Lv. 2000] [Boss]" or SelectBoss == "The Saw [Lv. 100] [Boss]" or SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" or SelectBoss == "Don Swan [Lv. 1000] [Boss]" or SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or SelectBoss == "Saber Expert [Lv. 200] [Boss]" or SelectBoss == "Mob Leader [Lv. 120] [Boss]" or SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if KillAllBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MsBoss then
							repeat wait() 
								KillBossuseGet = true
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
								elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									if Farmtween then
										Farmtween:Stop()
									end
									EquipWeapon(SelectToolWeapon)
									Usefastattack = true
									if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
										local args = {
											[1] = "Buso"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
									Click()
								end
							until not KillAllBoss or not v.Parent or v.Humanoid.Health <= 0
							Usefastattack = false
							KillBossuseGet = false
						end
					end
				else
					KillBossuseGet = true
					Usefastattack = false
					Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
					if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						wait(1)
					end 
				end
			else
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					Usefastattack = false
					KillBossuseGet = true
					CheckQuestBoss()
					Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
					if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
						wait(1.1)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, LevelQuestBoss)
					end 
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(MsBoss) then print("Find")
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if KillAllBoss and v.Name == MsBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat wait()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
										EquipWeapon(SelectToolWeapon)
										if Farmtween then
											Farmtween:Stop()
										end
										if Modstween then
											Modstween:Stop()
										end
										Usefastattack = true
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											local args = {
												[1] = "Buso"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
										Click()
									end
								until not KillAllBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
								Usefastattack = false
								KillBossuseGet = false
							end
						end
					else
						KillBossuseGet = true
						Usefastattack = false
						Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
						if ThreeWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1925 and MsBoss == "Beautiful Pirate [Lv. 1950] [Boss]" and (CFrameBoss.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 20000 then
							if Questtween then
								Questtween:Stop()
							end
							local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
							wait(.1)
							UseTween = false
						elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						end 
					end
				end
			end
		end

	spawn(function()
	while wait() do
		pcall(function()
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
				if Auto_Farm and MagnetActive and Magnet then
					if v.Name == Ms and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if v.Name == "Factory Staff [Lv. 800]" then
							if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 250 then
								v.Head.CanCollide = false
								v.HumanoidRootPart.CanCollide = false
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
								v.Humanoid:ChangeState(11)
							end
						elseif v.Name == Ms then
							if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 400 then
								v.Head.CanCollide = false
								v.HumanoidRootPart.CanCollide = false
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
								v.Humanoid:ChangeState(11)
							end
						end
					end
				elseif _G.AutoFarmBone and MagnetFarmBone and Magnet then
					if (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and (v.HumanoidRootPart.Position - PosFarmBone.Position).Magnitude <= 500 then 
						if sethiddenproperty then 
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  10000)
						end
						v.Head.CanCollide = false
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						v.HumanoidRootPart.CFrame = PosFarmBone
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
					end
				elseif _G.AutoFramEctoplasm and StatrMagnetEctoplasm and Magnet then
					if (v.Name == "Ship Deckhand [Lv. 1250]" or v.Name == "Ship Engineer [Lv. 1275]" or v.Name == "Ship Steward [Lv. 1300]" or v.Name == "Ship Officer [Lv. 1325]") and (v.HumanoidRootPart.Position - PosMonEctoplasm.Position).Magnitude <= 500 then 
						if sethiddenproperty then 
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  10000)
						end
						v.Head.CanCollide = false
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						v.HumanoidRootPart.CFrame = PosMonEctoplasm
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						end
					end
				end
			end)
		end
	end)

	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.AutoFarm then
					if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
					else
						wait(3)
					end
				end
			end)
		end
	end)

-- AutoUpdate

spawn(function()
	while wait() do
		if _G.AutoFarm then
			if game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value < 2400 then
				local args = {
					[1] = "AddPoint",
					[2] = "Melee",
					[3] = tonumber(UpStatus)
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			else
				local args = {
					[1] = "AddPoint",
					[2] = "Defense",
					[3] = tonumber(UpStatus)
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))				
			end
		end
	end
end)

		if _G.AutoFarm then
			game:GetService("Lighting").FantasySky:Destroy()
			local g = game
			local w = g.Workspace
			local l = g.Lighting
			local t = w.Terrain
			t.WaterWaveSize = 0
			t.WaterWaveSpeed = 0
			t.WaterReflectance = 0
			t.WaterTransparency = 0
			l.GlobalShadows = false
			l.FogEnd = 9e9
			l.Brightness = 0
			settings().Rendering.QualityLevel = "Level01"
			for i, v in pairs(g:GetDescendants()) do
				if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
					v.Material = "Plastic"
					v.Reflectance = 0
				elseif v:IsA("Decal") or v:IsA("Texture") then
					v.Transparency = 1
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Lifetime = NumberRange.new(0)
				elseif v:IsA("Explosion") then
					v.BlastPressure = 1
					v.BlastRadius = 1
				elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
					v.Enabled = false
				elseif v:IsA("MeshPart") then
					v.Material = "Plastic"
					v.Reflectance = 0
					v.TextureID = 10385902758728957
				end
			end
			for i, e in pairs(l:GetChildren()) do
				if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
					e.Enabled = false
				end
			end
			for i, v in pairs(game:GetService("Workspace").Camera:GetDescendants()) do
				if v.Name == ("Water;") then
					v.Transparency = 1
					v.Material = "Plastic"
				end
			end
		end)
	end)

if _G.AutoFarm then
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
end

if _G.AutoFarm then
	game:GetService("RunService"):Set3dRenderingEnabled(false)
else
	game:GetService("RunService"):Set3dRenderingEnabled(true)
end
