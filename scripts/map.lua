local resourcePath = "resources/map.bmp"

-- Define the Map class
Map = {}
Map.__index = Map

function Map:new(posX, posY)
    print("Initializing Map... begin")
    local obj = setmetatable({}, self)
    obj.texture = self:LoadBMPTexture()
    obj.posX = posX or 0
    obj.posY = posY or 0
    print("Initializing Map... end")
    return obj
end

-- Load Map textrue
function Map:LoadBMPTexture()
    print("Load BMP... begin")
	local texture = Bitmap.new(resourcePath, true)
    print("Load BMP... end")
	texture:SetTransparencyColor(GameEngine:MakeRGB(0, 0, 0))
	return texture
end


-- Paint Pacman
function Map:Paint()
    GameEngine:DrawBitmap(self.texture, self.posX, self.posY)
end

-- Return the Map class for require
return Map

