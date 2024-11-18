--Latest version: v0.02
return function()
    local UI = {}
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BottomUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.7, 0, 0.08, 0)
    mainFrame.Position = UDim2.new(0.15, 0, 1.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0.2, 0)
    uiCorner.Parent = mainFrame

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.05, 0, 0.7, 0)
    closeButton.Position = UDim2.new(0.94, 0, 0.15, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Text = "X"
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0.2, 0)
    closeCorner.Parent = closeButton

    local function createButton(name, position, description, scriptToRun)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Size = UDim2.new(0.25, 0, 0.7, 0)
        button.Position = position
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Text = name
        button.TextScaled = true
        button.Font = Enum.Font.Gotham
        button.Parent = mainFrame

        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0.2, 0)
        buttonCorner.Parent = button

        local descBubble = Instance.new("Frame")
        descBubble.Name = "DescriptionBubble"
        descBubble.Size = UDim2.new(1.2, 0, 0.8, 0)
        descBubble.Position = UDim2.new(-0.1, 0, -1, 0)
        descBubble.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        descBubble.BorderSizePixel = 0
        descBubble.Visible = false
        descBubble.Parent = button

        local bubbleCorner = Instance.new("UICorner")
        bubbleCorner.CornerRadius = UDim.new(0.2, 0)
        bubbleCorner.Parent = descBubble

        local descText = Instance.new("TextLabel")
        descText.Name = "DescriptionText"
        descText.Size = UDim2.new(1, 0, 1, 0)
        descText.BackgroundTransparency = 1
        descText.TextColor3 = Color3.new(0, 0, 0)
        descText.Text = description
        descText.TextScaled = true
        descText.Font = Enum.Font.GothamSemibold
        descText.Parent = descBubble

        button.MouseEnter:Connect(function()
            descBubble.Visible = true
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(descBubble, tweenInfo, {Size = UDim2.new(1.2, 0, 0.8, 0), Position = UDim2.new(-0.1, 0, -0.9, 0)})
            tween:Play()
        end)

        button.MouseLeave:Connect(function()
            descBubble.Visible = false
            descBubble.Size = UDim2.new(1.2, 0, 0.8, 0)
            descBubble.Position = UDim2.new(-0.1, 0, -1, 0)
        end)

        button.MouseButton1Click:Connect(function()
            closeUI()
            if scriptToRun then
                scriptToRun()
            end
        end)

        return button
    end

    local function animateUI(show)
        local targetPosition = show and UDim2.new(0.15, 0, 0.91, 0) or UDim2.new(0.15, 0, 1.1, 0)
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tween = TweenService:Create(mainFrame, tweenInfo, {Position = targetPosition})
        tween:Play()
    end

    function closeUI()
        animateUI(false)
        screenGui.Enabled = false
    end

    closeButton.MouseButton1Click:Connect(closeUI)

    function UI.AddButton(name, description, callback)
        local buttonCount = #mainFrame:GetChildren() - 2
        local position = UDim2.new(0.05 + (buttonCount * 0.28), 0, 0.15, 0)
        createButton(name, position, description, callback)
    end    

    function UI.Show()
        screenGui.Enabled = true
        animateUI(true)
    end

    function UI.Hide()
        closeUI()
    end

    return UI
end
