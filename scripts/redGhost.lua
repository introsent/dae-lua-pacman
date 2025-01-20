package.path = "./scripts/?.lua;"..package.path

local Ghost = require("ghost")

local RedGhost = setmetatable({}, Ghost)
RedGhost.__index = RedGhost

function RedGhost:new(posX, posY)
    local self = Ghost.new(self, posX, posY)
    
    self.animationRow = 0

    return self
end

function RedGhost:GetTextureRect()
    local baseRect, baseColumn = Ghost.GetTextureRect(self)

    -- Calculate the rectangle
    local x = baseColumn  * TILE_SIZE
    local y = self.animationRow * TILE_SIZE

    return {x = x, y = y, width = TILE_SIZE, height = TILE_SIZE}
end

return RedGhost