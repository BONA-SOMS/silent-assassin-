--==================================================
-- BONA SILENT ASSASSINS
-- RAYFIELD TITLE REBRAND
--==================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local SOURCE =
    "https://raw.githubusercontent.com/carterx2008/Script/refs/heads/main/%25SilentAssassins%25.lua"

--==================================================
-- BONA BRANDING
--==================================================

local function ReplaceBONA(obj)
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton")) then
        return
    end

    local text = obj.Text

    -- Loading screen
    if text == "Silent Assassins" then
        obj.Text = "BONA Silent Assassins"
    end

    -- Main Rayfield title
    if text == "Silent Assassins - v1.8.0" then
        obj.Text = "BONA Silent Assassins - v1.8.0"
    end

    -- Original creator text
    if text == "make by carter4321" then
        obj.Text = "made by BONA"
    end
end

local function Scan(root)
    for _, obj in ipairs(root:GetDescendants()) do
        ReplaceBONA(obj)
    end
end

--==================================================
-- WATCH UI BEFORE SCRIPT LOADS
--==================================================

local function Watch(root)
    Scan(root)

    root.DescendantAdded:Connect(function(obj)
        task.defer(function()
            ReplaceBONA(obj)
            task.wait()
            ReplaceBONA(obj)
        end)
    end)
end

Watch(CoreGui)

task.spawn(function()
    local player = Players.LocalPlayer

    if player then
        local gui = player:WaitForChild("PlayerGui", 10)

        if gui then
            Watch(gui)
        end
    end
end)

--==================================================
-- CONTINUOUS SCAN
--==================================================

task.spawn(function()
    while task.wait(0.05) do
        pcall(function()
            Scan(CoreGui)

            local player = Players.LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                Scan(player.PlayerGui)
            end
        end)
    end
end)

--==================================================
-- RUN ORIGINAL
--==================================================

task.spawn(function()
    local success, err = pcall(function()
        loadstring(game:HttpGet(SOURCE))()
    end)

    if not success then
        warn("[BONA] Silent Assassins error: " .. tostring(err))
    end
end)
