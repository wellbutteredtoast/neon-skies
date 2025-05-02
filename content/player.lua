local Player = {}
Player.__index = Player

function Player.new(x, y)
    local self = setmetatable({}, Player)
    -- i'll come back to this in a bit
    self.assetPath = ""

    -- player position / movement speed
    self.x = x or 0
    self.y = y or 0
    self.speed = 100

    -- stat system stub
    self.hpCurrent = 100
    self.hpMax = 100

    -- currencies
    self.account = {
        credits = 0,
        shards = 0,
        metal = 0,
    }

    return self
end

function Player:update(dt)
    local sprintBoost = 1.3
    local moveX, moveY = 0, 0

    if love.keyboard.isDown("w") then moveY = moveY - 1 end
    if love.keyboard.isDown("s") then moveY = moveY + 1 end
    if love.keyboard.isDown("d") then moveX = moveX + 1 end
    if love.keyboard.isDown("a") then moveX = moveX - 1 end

    -- only normalize if we're actually moving
    local len = math.sqrt(moveX * moveX + moveY * moveY)
    if len > 0 then
        moveX, moveY = moveX / len, moveY / len
    end

    -- are we sprinting?
    local speedMul = 1
    if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
        speedMul = sprintBoost
    end

    self.x = self.x + moveX * self.speed * speedMul * dt
    self.y = self.y + moveY * self.speed * speedMul * dt
end


function Player:draw()
    love.graphics.setColor(1, 1, 1) -- white
    love.graphics.rectangle("fill", self.x, self.y, 32, 32)
end

return Player