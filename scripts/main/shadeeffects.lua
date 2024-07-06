local ENV = env
GLOBAL.setfenv(1, GLOBAL)


if _G.TheNet:IsDedicated() then
    local nullfunc = function() end
    SpawnJunkShade = nullfunc
    DespawnJunkShade = nullfunc
    ShadeRendererEnabled = nil
    return
end

ShadeTypes.JunkShade = ShadeRenderer:CreateShadeType()
    
ShadeRenderer:SetShadeMaxRotation(ShadeTypes.JunkShade, 0)
ShadeRenderer:SetShadeRotationSpeed(ShadeTypes.JunkShade, 0)

ShadeRenderer:SetShadeMaxTranslation(ShadeTypes.JunkShade, 0)
ShadeRenderer:SetShadeTranslationSpeed(ShadeTypes.JunkShade, 0)

ShadeRenderer:SetShadeTexture(ShadeTypes.JunkShade, resolvefilepath("images/rtjunkpillar.tex"))

function SpawnJunkShade(x, z)
    return ShadeRenderer:SpawnShade(ShadeTypes.JunkShade, x, z, math.random() * 10, TUNING.CANOPY_SCALE)
end

function DespawnJunkShade(id)
    ShadeRenderer:RemoveShade(ShadeTypes.JunkShade, id)
end
     
local _ShadeEffectUpdate = ShadeEffectUpdate
    function ShadeEffectUpdate(dt, ...)
        local r, g, b = TheSim:GetAmbientColour()
    
        ShadeRenderer:SetShadeStrength(ShadeTypes.JunkShade, Lerp(0.3, 0.5, ((r + g + b) / 3) / 255))
        return _ShadeEffectUpdate(dt, ...)
end






