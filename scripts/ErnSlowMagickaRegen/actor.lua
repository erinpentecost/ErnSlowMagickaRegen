--[[
ErnSlowMagickaRegen for OpenMW.
Copyright (C) 2025 Erin Pentecost

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]
local interfaces = require("openmw.interfaces")
local settings = require("scripts.ErnSlowMagickaRegen.settings")
local types = require("openmw.types")
local self = require("openmw.self")

local partialMagicka = 0.0

local function isStunted(actor)
    for _, effect in pairs(types.Actor.activeEffects(self)) do
        if effect.id == "stuntedmagicka" then
            return true
        end
    end
    return false
end

local function regen(actor, durationInSeconds)
    if (self.type ~= types.Player) and (settings.enableNPCs() ~= true) then
        return
    end

    local magickaStat = self.type.stats.dynamic.magicka(self)
    local maximumMagicka = magickaStat.base
    if magickaStat.current >= maximumMagicka then
        partialMagicka = 0.0
        return
    end

    if isStunted(actor) then
        return
    end

    local fatigueStat = self.type.stats.dynamic.fatigue(self)
    local fatigueRatio = fatigueStat.current / fatigueStat.base

    local intelligence = self.type.stats.attributes.intelligence(actor).modified

    local magickaDelta = 0.00125 * intelligence * fatigueRatio * settings.scale()

    partialMagicka = partialMagicka + (magickaDelta * durationInSeconds)

    if partialMagicka >= 1.0 then
        local wholeIncrease = math.floor(partialMagicka)
        partialMagicka = partialMagicka - wholeIncrease
        
        if magickaStat.current < maximumMagicka then
            settings.debugPrint("Regenerating "..wholeIncrease..
                " magicka for actor ".. self.id .. ". Currently " ..
                magickaStat.current .. " of " .. maximumMagicka ..
                ". Instant rate is " .. magickaDelta .. " per second.")

            magickaStat.current = math.min(magickaStat.current+wholeIncrease, maximumMagicka)
        end
    end
end

local function onUpdate(dt)
    regen(self, dt)
end

return {
    engineHandlers = {
        onUpdate = onUpdate,
    }
}