local Nonplayer = require("npc")
local json = require("rxiJson")
local log = require("logSys")

local npcManager = {}
npcManager.npcs = {}

-- cannot accept plaintext JSON, will break everything
local function decodeBase64Json(path)
    local encoded, size = love.filesystem.read(path)
    if not encoded then return nil end

    local ok, decoded = pcall(love.data.decode, "string", "base64", encoded)
    if not ok or not decoded then
        log.error("Base64 decoding failed for: " .. path)
        return nil
    end

    if not decoded:match("^[%w%s%p%c]*$") then
        log.error("Decoded string contains invalid characters: " .. path)
        return nil
    end

    local ok2, data = pcall(json.decode, decoded)
    if not ok2 then
        log.error("JSON decoding failed for: " .. path)
        return nil
    end

    return data
    -- local encoded, size = love.filesystem.read(path)
    -- if not encoded then return nil end
    -- local decoded = love.data.decode("string", "base64", encoded)
    -- return json.decode(decoded)
end

-- Due to previous crashes and misery this was made far more verbose temporarily
function npcManager:loadAll(directory)
    local files = love.filesystem.getDirectoryItems(directory)
    for _, file in ipairs(files) do
        if file:match("%.npc$") then
            local fullpath = directory .. "/" .. file
            log.info("Processing NPC: " .. fullpath)
            local data = decodeBase64Json(fullpath)
            if data then
                log.info("Opened sucessfully: " .. fullpath)
                local ok, npc = pcall(Nonplayer.new, data)
                if ok then
                    table.insert(self.npcs, npc)
                    log.info("NPC created: " .. file)
                else
                    log.error("NPC creation failed: " .. file .. " | Error: " .. tostring(npc))
                end
            else
                log.error("Failed to decode NPC file: " .. fullpath)
            end
        end
    end
end

function npcManager:update(dt, playerPos)
    for _, npc in ipairs(self.npcs) do
        npc:update(dt, playerPos)
    end
end

function npcManager:draw()
    for _, npc in ipairs(self.npcs) do
        npc:draw()
    end
end

return npcManager
