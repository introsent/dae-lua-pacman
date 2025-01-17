local resourcePath = "resources/sprite.bmp"

-- Define the Pacman class
Pacman = {}
Pacman.__index = Pacman

function Pacman:new(posX, posY)
    print("Initializing Pacman... begin")
    local obj = setmetatable({}, self)
    obj.texture = self:LoadBMPTexture()
    obj.posX = posX or 0
    obj.posY = posY or 0
    print("Initializing Pacman... end")
    return obj
end

-- Load Pacman textrue
function Pacman:LoadBMPTexture()
	local texture = Bitmap.new(resourcePath, true)
	texture:SetTransparencyColor(GameEngine:MakeRGB(0, 0, 0))
	return texture
end


-- Paint Pacman
function Pacman:Paint()
    GameEngine:DrawBitmap(self.texture, self.posX, self.posY)
end

-- Return the Pacman class for require
return Pacman

