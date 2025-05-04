-- setting package path to minimize path shenanigans for Love
package.path = package.path .. ";content/?.lua"

local Player = require("player")
local NPC = require("npc")

local player

function love.load()
    player = Player.new(70, 70, nil)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    love.graphics.print("Neon Skies - 0.0.1d", 0, 0)
end