local mod = RegisterMod("Manchis&Rei", 1)
local COLLECTIBLE_MANCHAS = Isaac.GetItemIdByName("Manchi's head")
local COLLECTIBLE_REI = Isaac.GetItemIdByName("Rei's head")
local sfx = SFXManager()


function mod:itemUse(_, _, player, _, _, _)
    Isaac.GridSpawn(GridEntityType.GRID_POOP, 4, Isaac.GetPlayer(0).Position)
    sfx:Play(SoundEffect.SOUND_FART)
    return true
end

mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.itemUse, COLLECTIBLE_MANCHAS)


function mod:OnPickup(player, cacheFlag)
    if cacheFlag & CacheFlag.CACHE_DAMAGE == CacheFlag.CACHE_DAMAGE then
        local itemCount = player:GetCollectibleNum(COLLECTIBLE_REI)
        local damageToAdd = 0.6 * itemCount
        player.Damage = player.Damage + damageToAdd
    
    end    
    if cacheFlag & CacheFlag.CACHE_FIREDELAY == CacheFlag.CACHE_FIREDELAY then
        local itemCount = player:GetCollectibleNum(COLLECTIBLE_REI)
        player.MaxFireDelay = player.MaxFireDelay - (1.1 * itemCount)
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.OnPickup)

