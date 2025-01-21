
package.path = "./scripts/?.lua;"..package.path
local Pacman = require("pacman")
local Map = require("map")
local RedGhost = require("ghost")

local RedGhost = require("redGhost")



local pacman
local map

OFFSET_X = -8
OFFSET_Y = 32


-- Create ghost instances
local redGhost

-- Group all ghosts
local ghosts

local modesTimer = { 7, 20, 7, 20, 5, 20, 5}

function Initialize()
    pacman = Pacman:new(216, 400)
    map = Map:new(0,0)
    redGhost = RedGhost:new(216, 300)

    ghosts = {redGhost}
end

function Paint()
    GameEngine:FillWindowRect(GameEngine:MakeRGB(0,0,0))
    if map then
        map:Paint()
    end
    if pacman then
        pacman:Paint()
    end
    for _, ghost in ipairs(ghosts) do
        if ghost then
            ghost:Paint()
        end
    end
end


function Tick(elapsedSec)
    pacman:Tick(elapsedSec, map)
    for _, ghost in ipairs(ghosts) do
        if ghost then
            ghost:Tick(elapsedSec)
        end
    end
end

function KeyPressed(char)
    pacman:KeyPressed(char)
end

