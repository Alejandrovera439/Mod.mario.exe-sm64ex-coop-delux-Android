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




local function on_character_sound(m, sound)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_MX then return _G.charSelect.voice.sound(m, sound) end
end

local function on_character_snore(m)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_MX then return _G.charSelect.voice.snore(m) end
end

hook_event(HOOK_CHARACTER_SOUND, on_character_sound)
hook_event(HOOK_MARIO_UPDATE, on_character_snore)
-- Cargar modelos y texturas (esto debería estar antes de la creación del NPC)
local E_MODEL_MX = smlua_model_util_get_id("mx_geo")
local TEX_MX = get_texture_info("icon_mx")

-- Función para crear NPCs de *MX* en varias ubicaciones
function spawn_multiple_mx_npcs()
    local locations = {
        {100, 0, 100},  -- Coordenadas 1
        {200, 0, 200},  -- Coordenadas 2
        {300, 0, 300}   -- Coordenadas 3
    }
    
    for _, coords in ipairs(locations) do
        local x, y, z = unpack(coords)
        local mx_npc = create_npc(E_MODEL_MX, x, y, z)  -- Crea el NPC de *MX*
        set_npc_behavior(mx_npc)  -- Define el comportamiento del NPC
    end
end

-- Llamamos a la función para que *MX* aparezca en las ubicaciones especificadas al inicio del juego
spawn_multiple_mx_npcs()
-- Función para hacer que *MX* ataque al jugador cuando esté cerca
function on_player_near_mx(player)
    if is_near(player, mx_npc) then
        -- Aquí podemos definir el comportamiento de ataque, como hacerle daño al jugador
        -- Ejemplo: hacer que *MX* le dé un golpe al jugador
        deal_damage_to_player(player, 10)  -- Daño de 10 al jugador (ajustar según sea necesario)
        play_scary_sound("mx-kick.ogg")  -- Reproduce el sonido de ataque (puedes usar otro sonido)
    end
end

-- Función que verifica si el jugador está cerca de *MX*
function is_near(player, mx_npc)
    local player_x, player_y, player_z = get_player_position(player)
    local npc_x, npc_y, npc_z = get_npc_position(mx_npc)
    
    -- Compara las posiciones y verifica si el jugador está lo suficientemente cerca
    local distance = math.sqrt((player_x - npc_x)^2 + (player_y - npc_y)^2 + (player_z - npc_z)^2)
    
    if distance < 50 then  -- Ajusta el rango de proximidad según lo necesites
        return true
    else
        return false
    end
end
-- Registrar el evento para que el ataque de *MX* se active cuando el jugador esté cerca
hook_event(HOOK_PLAYER_UPDATE, on_player_near_mx)
-- Cargar modelos y texturas (esto debería estar antes de la creación del NPC)
local E_MODEL_MX = smlua_model_util_get_id("mx_geo")
local TEX_MX = get_texture_info("icon_mx")

-- Función para crear NPCs de *MX* en varias ubicaciones
function spawn_multiple_mx_npcs()
    local locations = {
        {100, 0, 100},  -- Coordenadas 1
        {200, 0, 200},  -- Coordenadas 2
        {300, 0, 300}   -- Coordenadas 3
    }
    
    for _, coords in ipairs(locations) do
        local x, y, z = unpack(coords)
        local mx_npc = create_npc(E_MODEL_MX, x, y, z)  -- Crea el NPC de *MX*
        set_npc_behavior(mx_npc)  -- Define el comportamiento del NPC
    end
end

-- Llamamos a la función para que *MX* aparezca en las ubicaciones especificadas al inicio del juego
spawn_multiple_mx_npcs()

-- Función para hacer que *MX* ataque al jugador cuando esté cerca
function on_player_near_mx(player)
    if is_near(player, mx_npc) then
        -- Aquí podemos definir el comportamiento de ataque, como hacerle daño al jugador
        -- Ejemplo: hacer que *MX* le dé un golpe al jugador
        deal_damage_to_player(player, 10)  -- Daño de 10 al jugador (ajustar según sea necesario)
        play_scary_sound("mx-kick.ogg")  -- Reproduce el sonido de ataque (puedes usar otro sonido)
    end
end

-- Función que verifica si el jugador está cerca de *MX*
function is_near(player, mx_npc)
    local player_x, player_y, player_z = get_player_position(player)
    local npc_x, npc_y, npc_z = get_npc_position(mx_npc)
    
    -- Compara las posiciones y verifica si el jugador está lo suficientemente cerca
    local distance = math.sqrt((player_x - npc_x)^2 + (player_y - npc_y)^2 + (player_z - npc_z)^2)
    
    if distance < 50 then  -- Ajusta el rango de proximidad según lo necesites
        return true
    else
        return false
    end
end

-- Registrar el evento para que el ataque de *MX* se active cuando el jugador esté cerca
hook_event(HOOK_PLAYER_UPDATE, on_player_near_mx)
