local resourcePath = "resources/map.bmp"

package.path = "./scripts/?.lua;"..package.path

local Pellet = require("pellet")

local TILE_SIZE = 16  -- Size of each tile in the sprite sheet

local OFFSET_X = 8
local OFFSET_Y = 48

local MAP_TILE_SET = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 2, 2, 1, 2, 2, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {1, 1, 1, 1, 1, 0, 0, 1, 2, 2, 1, 1, 2, 2, 2, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 1, 1},
        {2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2},
        {2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 1, 3, 3, 3, 3, 3, 1, 2, 2, 2, 0, 0, 2, 2, 2, 2, 2},
        {1, 1, 1, 1, 1, 0, 0, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 1, 1},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 1, 2, 2, 2, 2},
        {1, 1, 1, 1, 1, 0, 0, 1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 1, 0, 0, 1, 1, 1, 1, 1},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
        {1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
}
    

-- Define the Map class
Map = {}
Map.__index = Map

function Map:new(posX, posY)
    print("Initializing Map... begin")
    local obj = setmetatable({}, self)

    obj.pellets = self:InstatiatePellets()


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


function Map:InstatiatePellets()
    local pellets = {}
    for y, row in ipairs(MAP_TILE_SET) do
        if (y >= #MAP_TILE_SET)  then
            print("Number of pellets: " .. #pellets)
            return pellets
        end
        for x, tile in ipairs(row) do
            if (x >= #MAP_TILE_SET[1]) then
                print("Number of pellets: " .. #pellets)
                break 
            end    
            if (MAP_TILE_SET[y][x] == 0 and MAP_TILE_SET[y][x+1] == 0 and MAP_TILE_SET[y+1][x] == 0 and MAP_TILE_SET[y+1][x+1] == 0) then
                local pellet = Pellet:new(OFFSET_X + x * TILE_SIZE, OFFSET_Y + y * TILE_SIZE)
                table.insert(pellets, pellet)
            end
        end
    end
    return pellets
end

function Map:CheckIntersectionWithPellets(pacman)
    local pacmanX, pacmanY = pacman:GetLocation()

    pacmanX = pacmanX + TILE_SIZE
    pacmanY = pacmanY + TILE_SIZE

    
    
    local indexToDelete = -1
    for inx, pellet in ipairs(self.pellets) do
        local pelletX, pelletY = pellet:GetLocation()

        local delta = math.sqrt((pelletX- pacmanX) ^ 2 + (pelletY- pacmanY) ^ 2 )

        if delta <  TILE_SIZE then
        --if pelletX >= pacmanX and pelletX <= pacmanX + TILE_SIZE * 2 and pelletY >= pacmanY and pelletY  <= pacmanY + TILE_SIZE * 2 then
            pacman:IncreaseScore(10)
            indexToDelete = inx
            break
        end
    end

    if indexToDelete > 0 then
        print("Pellet to remove")
        table.remove(self.pellets, indexToDelete)
        print("Pellet to removed")
    end

end

function Map:GetMapTilesSet()
    return MAP_TILE_SET
end

function Map:SnapToTileBasedOnCurrentPosition(x, y)
    -- Convert Pacman's world position to map space (local to the grid)
    local localX = x - OFFSET_X
    local localY = y - OFFSET_Y

    -- Snap position to the nearest tile
    local snappedTileX = math.floor(localX / TILE_SIZE + 0.5)
    local snappedTileY = math.floor(localY / TILE_SIZE + 0.5)

    -- Convert back to world space and update Pacman's position
    return snappedTileX * TILE_SIZE + OFFSET_X, snappedTileY * TILE_SIZE + OFFSET_Y

end

-- Paint Map
function Map:Paint()
    GameEngine:DrawBitmap(self.texture, self.posX, self.posY)

    for _, pellet in ipairs(self.pellets) do
        pellet:Paint()  -- Call the pellet function on each Pellet instance
    end

    GameEngine:SetColor(GameEngine:MakeRGB(0, 0, 255))
    for y, row in ipairs(MAP_TILE_SET) do
        for x, tile in ipairs(row) do
            if tile == 1 then
                GameEngine:FillRect(OFFSET_X + TILE_SIZE * (x-1),  OFFSET_Y + TILE_SIZE * (y-1), OFFSET_X + TILE_SIZE * x, OFFSET_Y + TILE_SIZE * y)
            end
        end
    end

end

function Map:CheckCollision(x, y, directionX, directionY)
    -- Pacman's position
    local pacmanSize = TILE_SIZE * 2 -- Pacman is 2x2 tiles

    -- Determine the tiles to check based on direction
    local tilesToCheck = {}
    if directionX > 0 then -- Moving right
        table.insert(tilesToCheck, {x + pacmanSize + 1, y}) -- Top-right tile
        table.insert(tilesToCheck, {x + pacmanSize + 1, y + pacmanSize - 1}) -- Bottom-right tile
        table.insert(tilesToCheck, {x + pacmanSize + 1, y + TILE_SIZE - 1})
    elseif directionX < 0 then -- Moving left
        table.insert(tilesToCheck, {x - 1, y}) -- Top-left tile
        table.insert(tilesToCheck, {x - 1, y +  pacmanSize - 1}) -- Bottom-left tile
        table.insert(tilesToCheck, {x - 1, y + TILE_SIZE - 1})
    elseif directionY < 0 then -- Moving up
        table.insert(tilesToCheck, {x, y - 1}) -- Top-left tile
        table.insert(tilesToCheck, {x +  pacmanSize - 1, y - 1}) -- Top-right tile
        table.insert(tilesToCheck, {x +  TILE_SIZE  - 1, y - 1})
    elseif directionY > 0 then -- Moving down
        table.insert(tilesToCheck, {x, y + pacmanSize + 1}) -- Bottom-left tile
        table.insert(tilesToCheck, {x + pacmanSize- 1, y + pacmanSize + 1}) -- Bottom-right tile
        table.insert(tilesToCheck, {x +  TILE_SIZE  - 1, y + pacmanSize + 1})
    end


    local wallTiles = 0

    -- Check all relevant tiles
    for _, pos in ipairs(tilesToCheck) do
        local tileX = math.floor((pos[1] - OFFSET_X) /  TILE_SIZE) + 1
        local tileY = math.floor((pos[2] - OFFSET_Y) /  TILE_SIZE) + 1
        -- Out of bounds check
        if tileX < 1 or tileY < 1 or tileX > #MAP_TILE_SET[1] or tileY > #MAP_TILE_SET then
            wallTiles = wallTiles + 1
        end

        -- Wall check
        if MAP_TILE_SET[tileY][tileX] == 1 then
            wallTiles = wallTiles + 1
        end
    end

    return wallTiles
end

-- Return the Map class for require
return Map

