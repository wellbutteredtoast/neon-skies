-- setting package path to minimize path shenanigans for Love
package.path = package.path .. ";content/?.lua"

local Player = require("player")
local NPC = require("npc")

local player
local testp
local tests

function love.load()
    player = Player.new(70, 70, nil)
    testp = NPC.new(100, 100, "chasev", 100)
    tests = NPC.new(200, 200, "static", nil)
end

function love.update(dt)
    player:update(dt)
    local playerPos = { x = player.x, y = player.y }
    testp:update(dt, playerPos)
    tests:update(dt, playerPos)

end

function love.draw()
    player:draw()
    testp:draw()
    tests:draw()
    love.graphics.print("Neon Skies - NPC Test 5", 0, 0)
end