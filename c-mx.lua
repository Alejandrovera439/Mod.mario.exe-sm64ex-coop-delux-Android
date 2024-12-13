if not _G.charSelectExists then return end

local E_MODEL_MX = smlua_model_util_get_id("mx_geo")
local TEX_MX = get_texture_info("icon_mx")

local CAPTABLE_MX = {
	normal = smlua_model_util_get_id("mx_cap_geo"),
	wing = smlua_model_util_get_id("mx_wing_cap_geo"),
	metal = smlua_model_util_get_id("mx_metal_cap_geo"),
	metalWing = smlua_model_util_get_id("mx_metalwing_cap_geo")
}

local VOICETABLE_MX = {
    [CHAR_SOUND_ATTACKED] = 'both-hurt.ogg',
    [CHAR_SOUND_COUGHING1] = 'mx-cough.ogg',
    [CHAR_SOUND_COUGHING2] = 'mx-cough.ogg',
    [CHAR_SOUND_COUGHING3] = 'mx-cough.ogg',
    [CHAR_SOUND_DOH] = 'both-bump.ogg',
    --[CHAR_SOUND_DROWNING] = 'no-sound.ogg',
    [CHAR_SOUND_DYING] = 'both-die.ogg',
    [CHAR_SOUND_EEUH] = 'both-pickup.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'both-pound.ogg',
    --[CHAR_SOUND_HAHA] = 'no-sound.ogg',
    --[CHAR_SOUND_HAHA_2] = 'no-sound.ogg',
    --[CHAR_SOUND_HELLO] = 'no-sound.ogg',
    --[CHAR_SOUND_HERE_WE_GO] = 'no-sound.ogg',
    [CHAR_SOUND_HOOHOO] = 'mx-jump2.ogg',
    [CHAR_SOUND_HRMM] = 'both-pickup.ogg',
    --[CHAR_SOUND_IMA_TIRED] = 'no-sound.ogg',
    --[CHAR_SOUND_LETS_A_GO] = 'no-sound.ogg',
    --[CHAR_SOUND_MAMA_MIA] = 'no-sound.ogg',
    --[CHAR_SOUND_ON_FIRE] = 'no-sound.ogg',
    --[CHAR_SOUND_OOOF] = 'no-sound.ogg',
    --[CHAR_SOUND_OOOF2] = 'no-sound.ogg',
    --[CHAR_SOUND_PANTING] = 'no-sound.ogg',
    --[CHAR_SOUND_PANTING_COLD] = 'no-sound.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'mx-kick.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'mx-punch2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'mx-punch1.ogg',
    [CHAR_SOUND_SNORING1] = 'mx-snore1.ogg',
    [CHAR_SOUND_SNORING2] = 'mx-snore2.ogg',
    [CHAR_SOUND_SNORING3] = {'mx-snore2.ogg', 'mx-snore1.ogg'},
    --[CHAR_SOUND_SO_LONGA_BOWSER] = 'no-sound.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'mx-jump3.ogg',
    [CHAR_SOUND_UH] = 'both-bump.ogg',
    [CHAR_SOUND_UH2] = 'both-bump.ogg',
    [CHAR_SOUND_UH2_2] = 'both-bump.ogg',
    --[CHAR_SOUND_WAAAOOOW] = 'no-sound.ogg',
    --[CHAR_SOUND_WAH2] = 'no-sound.ogg',
    --[CHAR_SOUND_WHOA] = 'no-sound.ogg',
    [CHAR_SOUND_YAHOO] = 'mx-jump3.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'mx-jump2.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'mx-jump1.ogg',
    --[CHAR_SOUND_YAWNING] = 'no-sound.ogg',
}

--[[
local PALETTE_MX = {
    [PANTS]  = "ffffff",
    [SHIRT]  = "ffffff",
    [GLOVES] = "ffffff",
    [SHOES]  = "ffffff",
    [HAIR]   = "ffffff",
    [SKIN]   = "ffffff",
    [CAP]    = "ffffff",
}
]]

_G.CT_MX = _G.charSelect.character_add("MX", {"IT'S FUN, ISN'T IT?", "PLAYING AROUND HERE."}, "5UP34 and Razz", {r = 170, g = 0, b = 0}, E_MODEL_MX, CT_MARIO, TEX_MX, 1.3)
_G.charSelect.character_add_caps(E_MODEL_MX, CAPTABLE_MX)
_G.charSelect.character_add_voice(E_MODEL_MX, VOICETABLE_MX)
--_G.charSelect.character_add_palette_preset(E_MODEL_MX, PALETTE_MX)

local function on_character_sound(m, sound)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_MX then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_MX then return _G.charSelect.voice.snore(m) end
end

hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)