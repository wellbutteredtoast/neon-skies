local Nonplayer = {}
Nonplayer.__index = Nonplayer
math.randomseed(os.time())

-- !! NOTE: these pathfinding algs only work in *empty* regions, they will
-- !!       be scrapped as soon as collidable objects can be rendered

local allowedTypes = {
    static = true,       -- unmoving
    wander = true,       -- unpathed wandering
    chasep = true,       -- perfect chasing
    chasev = true,       -- chasing with variance
}

function Nonplayer.new(x, y, type, speed, colr, colg, colb)
    local self = setmetatable({}, Nonplayer)

    self.assetPath = assetPath or ""
    if self.assetPath ~= "" then
        self.sprite = love.graphics.newImage(self.assetPath)
    else
        self.sprite = nil
    end

    self.x = x or 0
    self.y = y or 0
    self.speed = speed or 100
    self.alive = true

    self.type = type or "static"

    self.r = colr or 1
    self.g = colg or 1
    self.b = colb or 1

    return self
end

-- playerpos is assumed to be a table with just x/y positions in them
local function pathToPlayerPerfect(self, playerPos)
    local dx = playerPos.x - self.x
    local dy = playerPos.y - self.y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance > 0 then
        local nx = dx / distance
        local ny = dy / distance
        self.x = self.x + nx * self.speed * love.timer.getDelta()
        self.y = self.y + ny * self.speed * love.timer.getDelta()
    end
end

-- playerpos is assumed to be a table with just x/y positions in them
-- variance is a float from 0.0->1.0 -- 0.0 ~ perfect, 1.0 ~ impossibly bad
local function pathToPlayerVariance(self, playerPos, variance)
    local dx = playerPos.x - self.x
    local dy = playerPos.y - self.y
    local distance = math.sqrt(dx * dx + dy * dy)
    
    if distance > 0 then
        local nx = dx / distance
        local ny = dy / distance
        
        local randomX = (math.random() * 2 - 1) * variance
        local randomY = (math.random() * 2 - 1) * variance
        nx = nx + randomX
        ny = ny + randomY
        
        local newDistance = math.sqrt(nx * nx + ny * ny)
        if newDistance > 0 then
            nx = nx / newDistance
            ny = ny / newDistance
        end
    
        self.x = self.x + nx * self.speed * love.timer.getDelta()
        self.y = self.y + ny * self.speed * love.timer.getDelta()
    end
end


function Nonplayer:update(dt, plrPos)
    -- basically, if the type is something we don't know, then just lock the NPC in place
    if not allowedTypes[self.type] or self.type == "static" then
        self.x, self.y = self.x, self.y
        return
    end
    if self.type == "chasev" then
        pathToPlayerVariance(self, plrPos, math.random())
    end
    if self.type == "chasep" then
        pathToPlayerPerfect(self, plrPos)
    end
end

-- pretty much directly taken from the player, but it works and that's what matters
function Nonplayer:draw(r, g, b)
    love.graphics.setColor(self.r, self.g, self.b)
    if self.sprite then
        love.graphics.draw(self.sprite, self.x, self.y)
    else
        love.graphics.rectangle("fill", self.x, self.y, 32, 32)
    end
end

return Nonplayer