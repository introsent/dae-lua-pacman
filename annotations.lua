---@meta
-- This file provides type annotations for Lua scripts interacting with C++ via SOL2.

---@class GameEngine
GameEngine = {}

--- Sets the window title.
---@param title string # The new title for the window.
---@return nil
function GameEngine:SetTitle(title) end

--- Sets the window position.
---@param left integer # The X-coordinate of the window's top-left corner.
---@param top integer # The Y-coordinate of the window's top-left corner.
---@return nil
function GameEngine:SetWindowPosition(left, top) end

--- Sets the window width.
---@param width integer # The new width of the window.
---@return nil
function GameEngine:SetWidth(width) end

--- Sets the window height.
---@param height integer # The new height of the window.
---@return nil
function GameEngine:SetHeight(height) end

--- Sets the frame rate of the game.
---@param frameRate integer # Frames per second.
---@return nil
function GameEngine:SetFrameRate(frameRate) end

--- Starts the game engine.
---@param hInstance userdata # The application instance handle.
---@param cmdShow integer # Command show parameter.
---@return boolean # True if the game runs successfully, false otherwise.
function GameEngine:Run(hInstance, cmdShow) end

--- Quits the game engine.
---@return nil
function GameEngine:Quit() end

--- Checks if a key is pressed.
---@param vKey integer # The virtual key code of the key.
---@return boolean # True if the key is pressed, false otherwise.
function GameEngine:IsKeyDown(vKey) end

--- Sets the color used for drawing.
---@param color integer # The color in COLORREF format.
---@return nil
function GameEngine:SetColor(color) end

--- Sets the font used for drawing text.
---@param font userdata # The font object.
---@return nil
function GameEngine:SetFont(font) end

--- Draws a string of text on the screen.
---@param text string # The text to draw.
---@param left integer # The X-coordinate for the text's top-left corner.
---@param top integer # The Y-coordinate for the text's top-left corner.
---@return integer # The number of characters drawn.
function GameEngine:DrawString(text, left, top) end

--- Gets the current window title.
---@return string # The current window title.
function GameEngine:GetTitle() end

--- Gets the current window width.
---@return integer # The width of the window.
function GameEngine:GetWidth() end

--- Gets the current window height.
---@return integer # The height of the window.
function GameEngine:GetHeight() end

--- Gets the frame rate of the game.
---@return integer # The current frame rate.
function GameEngine:GetFrameRate() end

--- Draws a line between two points.
---@param x1 integer # The X-coordinate of the start point.
---@param y1 integer # The Y-coordinate of the start point.
---@param x2 integer # The X-coordinate of the end point.
---@param y2 integer # The Y-coordinate of the end point.
---@return boolean # True if the line was drawn successfully.
function GameEngine:DrawLine(x1, y1, x2, y2) end

--- Draws a rectangle.
---@param left integer # The X-coordinate of the rectangle's top-left corner.
---@param top integer # The Y-coordinate of the rectangle's top-left corner.
---@param right integer # The X-coordinate of the rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the rectangle's bottom-right corner.
---@return boolean # True if the rectangle was drawn successfully.
function GameEngine:DrawRect(left, top, right, bottom) end

--- Fills a rectangle with color.
---@param left integer # The X-coordinate of the rectangle's top-left corner.
---@param top integer # The Y-coordinate of the rectangle's top-left corner.
---@param right integer # The X-coordinate of the rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the rectangle's bottom-right corner.
---@param opacity integer|nil # Opacity value (optional, defaults to fully opaque).
---@return boolean # True if the rectangle was filled successfully.
function GameEngine:FillRect(left, top, right, bottom, opacity) end

--- Draws a rounded rectangle.
---@param left integer # The X-coordinate of the rectangle's top-left corner.
---@param top integer # The Y-coordinate of the rectangle's top-left corner.
---@param right integer # The X-coordinate of the rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the rectangle's bottom-right corner.
---@param radius integer # The radius of the rounded corners.
---@return boolean # True if the rounded rectangle was drawn successfully.
function GameEngine:DrawRoundRect(left, top, right, bottom, radius) end

--- Fills a rounded rectangle with color.
---@param left integer # The X-coordinate of the rectangle's top-left corner.
---@param top integer # The Y-coordinate of the rectangle's top-left corner.
---@param right integer # The X-coordinate of the rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the rectangle's bottom-right corner.
---@param radius integer # The radius of the rounded corners.
---@return boolean # True if the rounded rectangle was filled successfully.
function GameEngine:FillRoundRect(left, top, right, bottom, radius) end

--- Draws an oval.
---@param left integer # The X-coordinate of the oval's bounding rectangle's top-left corner.
---@param top integer # The Y-coordinate of the oval's bounding rectangle's top-left corner.
---@param right integer # The X-coordinate of the oval's bounding rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the oval's bounding rectangle's bottom-right corner.
---@return boolean # True if the oval was drawn successfully.
function GameEngine:DrawOval(left, top, right, bottom) end

--- Fills an oval with color.
---@param left integer # The X-coordinate of the oval's bounding rectangle's top-left corner.
---@param top integer # The Y-coordinate of the oval's bounding rectangle's top-left corner.
---@param right integer # The X-coordinate of the oval's bounding rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the oval's bounding rectangle's bottom-right corner.
---@param opacity integer|nil # Opacity value (optional, defaults to fully opaque).
---@return boolean # True if the oval was filled successfully.
function GameEngine:FillOval(left, top, right, bottom, opacity) end

--- Draws an arc.
---@param left integer # The X-coordinate of the arc's bounding rectangle's top-left corner.
---@param top integer # The Y-coordinate of the arc's bounding rectangle's top-left corner.
---@param right integer # The X-coordinate of the arc's bounding rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the arc's bounding rectangle's bottom-right corner.
---@param startDegree integer # The starting angle of the arc in degrees.
---@param angle integer # The sweep angle of the arc in degrees.
---@return boolean # True if the arc was drawn successfully.
function GameEngine:DrawArc(left, top, right, bottom, startDegree, angle) end

--- Fills an arc with color.
---@param left integer # The X-coordinate of the arc's bounding rectangle's top-left corner.
---@param top integer # The Y-coordinate of the arc's bounding rectangle's top-left corner.
---@param right integer # The X-coordinate of the arc's bounding rectangle's bottom-right corner.
---@param bottom integer # The Y-coordinate of the arc's bounding rectangle's bottom-right corner.
---@param startDegree integer # The starting angle of the arc in degrees.
---@param angle integer # The sweep angle of the arc in degrees.
---@return boolean # True if the arc was filled successfully.
function GameEngine:FillArc(left, top, right, bottom, startDegree, angle) end


---Combines red, green, and blue values into a single RGB COLORREF.
---@param r integer # Red component (0-255).
---@param g integer # Green component (0-255).
---@param b integer # Blue component (0-255).
---@return integer # The combined RGB value.
function GameEngine:MakeRGB(r, g, b) end



---Combines left, top, right and bottom values into a single RECT.
---@param left integer # The X-coordinate of the rectangle's top-left corner.
---@param top integer # The Y-coordinate of the rectangle's top-left corner.
---@param right integer # The X-coordinate of the rectangle's bottom-right corner.
---@param bottom integer  # The Y-coordinate of the rectangle's bottom-right corner.
---@return integer # The combined RECT value.
function GameEngine:MakeRect(left, top,  right, bottom) end

---Draws a bitmap at the specified position.
---@overload fun(bitmap: Bitmap, x: integer, y: integer): boolean
---@param bitmap Bitmap # The bitmap to draw.
---@param x integer # The x-coordinate of the position to draw the bitmap.
---@param y integer # The y-coordinate of the position to draw the bitmap.
---@param rect? RECT # (Optional) The source rectangle to draw from the bitmap.
---@return boolean # True if the bitmap was drawn successfully, otherwise false.
function GameEngine:DrawBitmap(bitmap, x, y, rect) end

---@param color integer
function GameEngine:FillWindowRect(color) end

--- Class representing a bitmap image
---@class Bitmap
---@field public filename string
---@field public createAlphaChannel boolean
Bitmap = {}

--- Creates a new Bitmap object
---@param filename string # The file path of the bitmap image
---@param createAlphaChannel? boolean # Whether to create an alpha channel (default: true)
---@return Bitmap
function Bitmap:new(filename, createAlphaChannel) end

--- Sets the transparency color for the bitmap
---@param color number # The color to set as transparent
---@return nil
function Bitmap:SetTransparencyColor(color) end

--- Sets the opacity for the bitmap
---@param opacity number # Opacity value (0-100)
---@return nil
function Bitmap:SetOpacity(opacity) end

--- Checks if the bitmap exists
---@return boolean
function Bitmap:Exists() end

--- Gets the width of the bitmap
---@return number
function Bitmap:GetWidth() end

--- Gets the height of the bitmap
---@return number
function Bitmap:GetHeight() end

--- Gets the transparency color of the bitmap
---@return number
function Bitmap:GetTransparencyColor() end

--- Gets the opacity of the bitmap
---@return number
function Bitmap:GetOpacity() end

--- Checks if the bitmap has an alpha channel
---@return boolean
function Bitmap:HasAlphaChannel() end

--- Saves the bitmap to a file
---@param filename string # The file path to save the bitmap
---@return boolean
function Bitmap:SaveToFile(filename) end

--- Gets the handle of the bitmap
---@return userdata
function Bitmap:GetHandle() end


--- Class representing a hit region
---@class HitRegion
---@field public shape string # Shape type ("Ellipse" or "Rectangle")
---@field public left number
---@field public top number
---@field public right number
---@field public bottom number
HitRegion = {}

--- Creates a new HitRegion object with a basic shape
---@param shape string # The shape type ("Ellipse" or "Rectangle")
---@param left number # Left position
---@param top number # Top position
---@param right number # Right position
---@param bottom number # Bottom position
---@return HitRegion
function HitRegion.new(shape, left, top, right, bottom) end

--- Creates a new HitRegion object with points
---@param pointsArr table # Array of points
---@param numberOfPoints number # Number of points
---@return HitRegion
function HitRegion:newWithPoints(pointsArr, numberOfPoints) end

--- Creates a new HitRegion object from a bitmap
---@param bmp Bitmap # The bitmap object
---@param cTransparent number # The transparent color
---@param cTolerance number # The color tolerance
---@return HitRegion
function HitRegion:newFromBitmap(bmp, cTransparent, cTolerance) end

--- Moves the hit region
---@param deltaX number # X displacement
---@param deltaY number # Y displacement
---@return nil
function HitRegion:Move(deltaX, deltaY) end

--- Performs a hit test for a point
---@param x number # X-coordinate
---@param y number # Y-coordinate
---@return boolean
function HitRegion:HitTest(x, y) end

--- Performs a hit test with another region
---@param region HitRegion # The other hit region
---@return boolean
function HitRegion:HitTestWithRegion(region) end

--- Tests for collision with another region
---@param region HitRegion # The other hit region
---@return table # Returns a point {x, y} or {-1000000, -1000000} if no collision
function HitRegion:CollisionTest(region) end

--- Gets the bounding rectangle of the region
---@return table # A rectangle {left, top, right, bottom}
function HitRegion:GetBounds() end

--- Checks if the region exists
---@return boolean
function HitRegion:Exists() end

--- Gets the handle of the hit region
---@return userdata
function HitRegion:GetHandle() end



---@class Caller
---@field m_TargetList Callable[] # List of target objects to notify
Caller = {}

--- Gets the type of the caller.
---@return Caller.Type # The type of the caller.
function Caller:GetType() end

--- Adds an action listener to the caller.
---@param targetPtr Callable # The target to add as a listener.
---@return boolean # True if the listener was added successfully.
function Caller:AddActionListener(targetPtr) end

--- Removes an action listener from the caller.
---@param targetPtr Callable # The target to remove as a listener.
---@return boolean # True if the listener was removed successfully.
function Caller:RemoveActionListener(targetPtr) end

--- Calls all listeners for the caller.
---@protected
---@return boolean # True if all listeners were called successfully.
function Caller:CallListeners() end

---@class Caller.Type
---@field TextBox integer
---@field Button integer
---@field Timer integer
---@field Audio integer
---@field Video integer



---@class Callable
Callable = {}

--- Calls the action for the callable object.
---@param callerPtr Caller # The caller object triggering the action.
function Callable:CallAction(callerPtr) end



---@class Audio : Caller
Audio = {}

---Creates a new Audio instance.
---@param filename string # The name of the audio file to load.
---@return Audio
function Audio.new(filename) end

---Updates the audio state. Must be called on the main thread.
---@return nil
function Audio:Tick() end

---Starts playing the audio.
---@param msecStart? integer # The start time in milliseconds (default is 0).
---@param msecStop? integer # The stop time in milliseconds (default is -1, which means play to the end).
---@return nil
function Audio:Play(msecStart, msecStop) end

---Pauses the audio.
---@return nil
function Audio:Pause() end

---Stops the audio.
---@return nil
function Audio:Stop() end

---Sets the volume of the audio.
---@param volume integer # The volume level (0-100).
---@return nil
function Audio:SetVolume(volume) end

---Sets whether the audio should repeat.
---@param torepeat boolean # True to repeat, false otherwise.
---@return nil
function Audio:SetRepeat(torepeat) end

---Gets the name of the audio file.
---@return string
function Audio:GetName() end

---Gets the alias used for the audio.
---@return string
function Audio:GetAlias() end

---Gets the duration of the audio in milliseconds.
---@return integer
function Audio:GetDuration() end

---Checks if the audio is currently playing.
---@return boolean
function Audio:IsPlaying() end

---Checks if the audio is currently paused.
---@return boolean
function Audio:IsPaused() end

---Gets whether the audio is set to repeat.
---@return boolean
function Audio:GetRepeat() end

---Checks if the audio file exists.
---@return boolean
function Audio:Exists() end

---Gets the current volume level.
---@return integer
function Audio:GetVolume() end

