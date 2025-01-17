
package.path = "./scripts/?.lua;"..package.path
local Pacman = require("pacman")
local Map = require("map")

local pacman
local map

function Initialize()
    print("Initialize function... called")
    pacman = Pacman:new(100, 100)
    map = Map:new(0,0)
end

function Paint()
    if map then
        map:Paint()
    end
    --if pacman then
        -- pacman:Paint()
    --end
end


function Tick(elapsedSec)
    
end

function CheckKeyboard()

end

