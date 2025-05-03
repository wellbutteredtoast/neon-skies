-- setting package path to minimize path shenanigans for Love
package.path = package.path .. ";content/?.lua"

local Player = require("player")
local NPC = require("npc")

local player
local testPerfect
local testImperfect
local testStatic

function love.load()
    player = Player.new(70, 70, nil)
    testPerfect = NPC.new( 100, 200, "chasep")
    testImperfect = NPC.new( 100, 300, "chasev")
    testStatic = NPC.new( 100, 400, "static")
end

function love.update(dt)
    testPerfect:update(dt, {player.x, player.y})
    testImperfect:update(dt, {player.x, player.y})
    testStatic:update(dt, {player.x, player.y})
    player:update(dt)
end

function love.draw()
    player:draw()
    love.graphics.print("Neon Skies - NPC Test 1", 0, 0)
end