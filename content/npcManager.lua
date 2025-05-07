local Nonplayer = require("npc")
local json = require("rxiJson")

local npcManager = {}
npcManager.npcs = {}

local function decodeBase64Json(path)
    local encoded, size = love.filesystem.read(path)
    if not encoded then return nil end
    local decoded = love.data.decode("string", "base64", encoded)
    return json.decode(decoded)
end

function npcManager:loadAll(directory)
    local files = love.filesystem.getDirectoryItems(directory)
    for _, file in ipairs(files) do
        if file:match("%.npc$") then
            local fullpath = directory .. "/" .. file
            local data = decodeBase64Json(fullpath)
            if data then
                local npc = Nonplayer.new(data)
                table.insert(self.npcs, npc)
            else
                print("Failed to decode NPC file: " .. fullpath)
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
