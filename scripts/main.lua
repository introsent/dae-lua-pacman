
package.path = "./scripts/?.lua;"..package.path
local Pacman = require("pacman")
local Map = require("map")

local pacman
local map

function Initialize()
    print("Initialize function... called")
    pacman = Pacman:new(216, 400)
    map = Map:new(0,0)
end

function Paint()
    GameEngine:FillWindowRect(GameEngine:MakeRGB(0,0,0))
    if map then
        map:Paint()
    end
    if pacman then
        pacman:Paint()
    end
end


function Tick(elapsedSec)
    pacman:Tick(elapsedSec, map)
end

function KeyPressed(char)
    pacman:KeyPressed(char)
end

