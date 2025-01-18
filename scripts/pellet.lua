Pellet = {}
Pellet.__index = Pellet

function Pellet:new(posX, posY)
    local obj = setmetatable({}, self)

    --General
    obj.color = GameEngine:MakeRGB(255, 200, 200)
    obj.x = posX or 0
    obj.y = posY or 0

    return obj
end

function Pellet:Paint()
    GameEngine:SetColor(self.color)
    GameEngine:FillOval(self.x - 3, self.y - 3, self.x + 3, self.y + 3)
end

return Pellet