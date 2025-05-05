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

    -- reset colours b/c text rendering
    love.graphics.setColor(1.0, 1.0, 1.0)
    love.graphics.print("Neon Skies - 0.0.5d", 0, 0)
end