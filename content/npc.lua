local util = require("utility")

local Nonplayer = {}
Nonplayer.__index = Nonplayer
math.randomseed(os.time())

local log = require("logSys")

-- remember, to load an NPC from `gamedata/npc` it must be encoded in base64!
-- plain JSON will get decoded into broken text and will not be loaded!

local allowedTypes = {
    static = true,
    chasev = true,
    chasep = true,
    wander = true
}

function Nonplayer.new(data)
    local self = setmetatable({}, Nonplayer)

    self.type = data.type or "static"
    self.speed = data.speed or 0
    self.x = data.xpos or 0
    self.y = data.ypos or 0
    self.r = (data.colour_r or 255) / 255
    self.g = (data.colour_g or 255) / 255
    self.b = (data.colour_b or 255) / 255
    self.assetPath = data.assetPath or ""
    self.sprite = ""
    self.alive = true
    self.width = 32
    self.height = 32
    self.isColliding = true

    if self.assetPath ~= "" then
        if love.filesystem.getInfo(self.assetPath, "file") then
            local ok, img = pcall(love.graphics.newImage, self.assetPath)
            if ok then 
                self.sprite = img
            else
                log.error("Failed to load sprite " .. self.assetPath)
                self.sprite = nil
            end
        else
            log.warn("Asset not found: " .. self.assetPath)
            self.sprite = nil
        end
    else
        self.sprite = nil
    end
    return self
end

-- mathematically perfect chasing
local function pathToPlayerPerfect(self, playerPos)
    local dx = playerPos.x - self.x
    local dy = playerPos.y - self.y
    local dist = math.sqrt(dx * dx + dy * dy)
    if dist > 0 then
        local nx = dx / dist
        local ny = dy / dist
        self.x = self.x + nx * self.speed * love.timer.getDelta()
        self.y = self.y + ny * self.speed * love.timer.getDelta()
    end
end

-- chasing the player with a variance
-- 0 -> perfect
-- 1 -> cataclysmic
local function pathToPlayerVariance(self, playerPos, variance)
    local dx = playerPos.x - self.x
    local dy = playerPos.y - self.y
    local dist = math.sqrt(dx * dx + dy * dy)
    if dist > 0 then
        local nx = dx / dist + (math.random() * 2 - 1) * variance
        local ny = dy / dist + (math.random() * 2 - 1) * variance
        local newDist = math.sqrt(nx * nx + ny * ny)
        if newDist > 0 then
            nx = nx / newDist
            ny = ny / newDist
        end
        self.x = self.x + nx * self.speed * love.timer.getDelta()
        self.y = self.y + ny * self.speed * love.timer.getDelta()
    end
end

-- randomly wandering around the map
local function wanderRandom(self)
    if not self.wanderTimer or self.wanderTimer <= 0 then
        self.wanderAngle = math.random() * math.pi * 2
        self.wanderTimer = 1 + math.random()
    end
    self.wanderTimer = self.wanderTimer - love.timer.getDelta()
    self.x = self.x + math.cos(self.wanderAngle) * self.speed * love.timer.getDelta()
    self.y = self.y + math.sin(self.wanderAngle) * self.speed * love.timer.getDelta()
end

function Nonplayer:update(dt, playerPos)

    if checkCollision(self, playerPos) then
        self.isColliding = true
    end

    if not allowedTypes[self.type] or self.type == "static" then return end
    
    if self.isColliding then
        -- left blank intentionally, using return breaks this
    else
        if self.type == "chasep" then
            pathToPlayerPerfect(self, playerPos)
        elseif self.type == "chasev" then
            pathToPlayerVariance(self, playerPos, 0.5)
        elseif self.type == "wander" then
            wanderRandom(self)
        end
    end

    -- last-minute bounds detection addition!
    local mWidth, mHeight = love.graphics.getDimensions()
    local sprSize = 32

    self.x = math.max(0, math.min(self.x, mWidth - sprSize))
    self.y = math.max(0, math.min(self.y, mHeight - sprSize))

    self.isColliding = false
end

function Nonplayer:draw()
    love.graphics.setColor(self.r, self.g, self.b)
    if self.sprite then
        love.graphics.draw(self.sprite, self.x, self.y)
    else
        love.graphics.rectangle("fill", self.x, self.y, 32, 32)
    end
    love.graphics.setColor(1, 1, 1)
end

return Nonplayer
