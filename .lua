local Lighting = game:GetService("Lighting")

local defaultSettings = {
    Ambient = Color3.fromRGB(0, 0, 0),
    Brightness = 1,
    ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
    ColorShift_Top = Color3.fromRGB(0, 0, 0),
    EnvironmentDiffuseScale = 0,
    EnvironmentSpecularScale = 0,
    ExposureCompensation = 0,
    GeographicLatitude = 41,
    OutdoorAmbient = Color3.fromRGB(128, 128, 128),
    ShadowSoftness = 0,
    TimeOfDay = "14:00:00"
}

local function applyDefaultSettings()
    for property, value in pairs(defaultSettings) do
        Lighting[property] = value
    end
end
local function removeAtmosphereObjects()
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("Atmosphere") or 
           child:IsA("BloomEffect") or 
           child:IsA("BlurEffect") or 
           child:IsA("ColorCorrectionEffect") or 
           child:IsA("SunRaysEffect") or 
           child:IsA("Clouds") or 
           child:IsA("Sky") then
            child:Destroy()
        end
    end
end
local function checkAndRestore()
    removeAtmosphereObjects()
    for property, value in pairs(defaultSettings) do
        if Lighting[property] ~= value then
            applyDefaultSettings()
            break
        end
    end
end

removeAtmosphereObjects()
applyDefaultSettings()

for property in pairs(defaultSettings) do
    Lighting:GetPropertyChangedSignal(property):Connect(checkAndRestore)
end
Lighting.ChildAdded:Connect(function(child)
    if child:IsA("Atmosphere") or 
       child:IsA("BloomEffect") or 
       child:IsA("BlurEffect") or 
       child:IsA("ColorCorrectionEffect") or 
       child:IsA("SunRaysEffect") or 
       child:IsA("Clouds") or 
       child:IsA("Sky") then
        child:Destroy()
    end
end)
