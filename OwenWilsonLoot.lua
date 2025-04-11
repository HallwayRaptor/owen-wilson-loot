local OwenWilsonLoot = CreateFrame("Frame")
OwenWilsonLoot.sounds = {
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowa.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowb.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowc.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowd.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowe.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowf.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowg.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowh.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowi.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowj.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\wowk.mp3',
    'Interface\\AddOns\\OwenWilsonLoot\\sounds\\Kachow.mp3',
}

OwenWilsonLoot.config = {
    enabled = true,
    soundChannel = "Master",
    cooldown = 1,
}

OwenWilsonLoot.lastPlayed = 0
OwenWilsonLoot.soundCount = #OwenWilsonLoot.sounds
OwenWilsonLoot:RegisterEvent("LOOT_OPENED")
OwenWilsonLoot:RegisterEvent("ADDON_LOADED")

local function PlayRandomWow()
    if not OwenWilsonLoot.config.enabled then return end
    
    local currentTime = GetTime()
    if currentTime - OwenWilsonLoot.lastPlayed >= OwenWilsonLoot.config.cooldown then
        local soundIndex = math.random(OwenWilsonLoot.soundCount)
        PlaySoundFile(OwenWilsonLoot.sounds[soundIndex], OwenWilsonLoot.config.soundChannel)
        OwenWilsonLoot.lastPlayed = currentTime
    end
end

local function InitializeAddon(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "OwenWilsonLoot" then
        SLASH_OWENWILSONLOOT1 = "/owl"
        
        SlashCmdList["OWENWILSONLOOT"] = function(msg)
            msg = string.lower(msg)
            if msg == "on" then
                OwenWilsonLoot.config.enabled = true
                print("|cFF00FF00Owen Wilson|r sounds enabled!")
            elseif msg == "off" then
                OwenWilsonLoot.config.enabled = false
                print("|cFF00FF00Owen Wilson|r sounds disabled!")
            else
                print("Owen Wilson commands:")
                print("/owl on - Enable sounds")
                print("/owl off - Disable sounds")
            end
        end
    end
end

OwenWilsonLoot:SetScript("OnEvent", function(self, event, ...)
    if event == "LOOT_OPENED" then
        PlayRandomWow()
    elseif event == "ADDON_LOADED" then
        InitializeAddon(self, event, ...)
    end
end)