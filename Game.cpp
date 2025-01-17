//-----------------------------------------------------------------
// Main Game File
// C++ Source - Game.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "Game.h"

//-----------------------------------------------------------------
// Game Member Functions																				
//-----------------------------------------------------------------

Game::Game() 																	
{
	// nothing to create
}

Game::~Game()																						
{
	// nothing to destroy
}

void Game::Initialize()			
{
	// Code that needs to execute (once) at the start of the game, before the game window is created

	AbstractGame::Initialize();
	GAME_ENGINE->SetTitle(_T("SE_Exam_Ivans_Minajevs_PACMAN"));	
	
	GAME_ENGINE->SetWidth(448);
	GAME_ENGINE->SetHeight(576);
    GAME_ENGINE->SetFrameRate(50);


	lua.open_libraries(sol::lib::base);
	lua.open_libraries(sol::lib::package);
	lua.open_libraries(sol::lib::math);
	lua.open_libraries(sol::lib::table);
	lua.open_libraries(sol::lib::io);

	lua.safe_script_file("scripts/main.lua");

	BindGame();

	lua["Initialize"]();
	// Set the keys that the game needs to listen to
	//tstringstream buffer;
	//buffer << _T("KLMO");
	//buffer << (char) VK_LEFT;
	//buffer << (char) VK_RIGHT;
	//GAME_ENGINE->SetKeyList(buffer.str());
}

void Game::Start()
{
	// Insert code that needs to execute (once) at the start of the game, after the game window is created
}

void Game::End()
{
	// Insert code that needs to execute when the game ends
}

void Game::Paint(RECT rect) const
{
	lua["Paint"]();
	//auto funcRect = lua["PaintRect"];
	//funcRect();

	// Insert paint code 
}

void Game::Tick()
{
	lua["Tick"]();
	// Insert non-paint code that needs to execute each tick 
}

void Game::MouseButtonAction(bool isLeft, bool isDown, int x, int y, WPARAM wParam)
{	
	// Insert code for a mouse button action

	/* Example:
	if (isLeft == true && isDown == true) // is it a left mouse click?
	{
		if ( x > 261 && x < 261 + 117 ) // check if click lies within x coordinates of choice
		{
			if ( y > 182 && y < 182 + 33 ) // check if click also lies within y coordinates of choice
			{
				GAME_ENGINE->MessageBox(_T("Clicked."));
			}
		}
	}
	*/
}

void Game::MouseWheelAction(int x, int y, int distance, WPARAM wParam)
{	
	// Insert code for a mouse wheel action
}

void Game::MouseMove(int x, int y, WPARAM wParam)
{	
	// Insert code that needs to execute when the mouse pointer moves across the game window

	/* Example:
	if ( x > 261 && x < 261 + 117 ) // check if mouse position is within x coordinates of choice
	{
		if ( y > 182 && y < 182 + 33 ) // check if mouse position also is within y coordinates of choice
		{
			GAME_ENGINE->MessageBox("Mouse move.");
		}
	}
	*/
}

void Game::CheckKeyboard()
{	
	// Here you can check if a key is pressed down
	// Is executed once per frame 

	/* Example:
	if (GAME_ENGINE->IsKeyDown(_T('K'))) xIcon -= xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('L'))) yIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('M'))) xIcon += xSpeed;
	if (GAME_ENGINE->IsKeyDown(_T('O'))) yIcon -= ySpeed;
	*/
}

void Game::KeyPressed(TCHAR key)
{	
	// DO NOT FORGET to use SetKeyList() !!

	// Insert code that needs to execute when a key is pressed
	// The function is executed when the key is *released*
	// You need to specify the list of keys with the SetKeyList() function

	/* Example:
	switch (key)
	{
	case _T('K'): case VK_LEFT:
		GAME_ENGINE->MessageBox("Moving left.");
		break;
	case _T('L'): case VK_DOWN:
		GAME_ENGINE->MessageBox("Moving down.");
		break;
	case _T('M'): case VK_RIGHT:
		GAME_ENGINE->MessageBox("Moving right.");
		break;
	case _T('O'): case VK_UP:
		GAME_ENGINE->MessageBox("Moving up.");
		break;
	case VK_ESCAPE:
		GAME_ENGINE->MessageBox("Escape menu.");
	}
	*/
}

void Game::CallAction(Caller* callerPtr)
{
	// Insert the code that needs to execute when a Caller (= Button, TextBox, Timer, Audio) executes an action
}

void Game::BindGame()
{


	lua.new_usertype<Game>("Game",
		sol::constructors<Game()>(),  // Constructor for Game
		"Initialize", &Game::Initialize,
		"Start", &Game::Start,
		"End", &Game::End,
		"Paint", &Game::Paint,
		"Tick", &Game::Tick,
		"MouseButtonAction", &Game::MouseButtonAction,
		"MouseWheelAction", &Game::MouseWheelAction,
		"MouseMove", &Game::MouseMove,
		"CheckKeyboard", &Game::CheckKeyboard,
		"KeyPressed", &Game::KeyPressed,
		"CallAction", &Game::CallAction
	);

    lua.new_usertype<Bitmap>("Bitmap",
        sol::constructors<Bitmap(const tstring&, bool)>(),
        "SetTransparencyColor", &Bitmap::SetTransparencyColor,
        "SetOpacity", &Bitmap::SetOpacity,
        "Exists", &Bitmap::Exists,
        "GetWidth", &Bitmap::GetWidth,
        "GetHeight", &Bitmap::GetHeight,
        "GetTransparencyColor", &Bitmap::GetTransparencyColor,
        "GetOpacity", &Bitmap::GetOpacity,
        "HasAlphaChannel", &Bitmap::HasAlphaChannel,
        "SaveToFile", &Bitmap::SaveToFile,
        "GetHandle", &Bitmap::GetHandle
    );

    lua.new_usertype<GameEngine>("GameEngine",
        sol::constructors<GameEngine()>(),
        "SetWindowPosition", &GameEngine::SetWindowPosition,
        "SetWidth", &GameEngine::SetWidth,
        "SetHeight", &GameEngine::SetHeight,
        "SetFrameRate", &GameEngine::SetFrameRate,
        "Run", &GameEngine::Run,
        "Quit", &GameEngine::Quit,
        "IsKeyDown", &GameEngine::IsKeyDown,
        "SetColor", sol::overload(
            sol::resolve<void(int, int, int)>(&GameEngine::SetColor),
            sol::resolve<void(COLORREF)>(&GameEngine::SetColor)
        ),
        "SetFont", &GameEngine::SetFont,
        //"DrawString", &GameEngine::DrawString,
        "GetTitle", &GameEngine::GetTitle,
        "GetWidth", &GameEngine::GetWidth,
        "GetHeihgt", &GameEngine::GetHeight,
        "GetFrameRate", &GameEngine::GetFrameRate,
        "DrawLine", &GameEngine::DrawLine,
        "DrawRect", &GameEngine::DrawRect,
        "FillRect", sol::overload(
            sol::resolve<bool(int, int, int, int) const>(&GameEngine::FillRect),
            sol::resolve<bool(int, int, int, int, int) const>(&GameEngine::FillRect)
        ),
        "DrawRoundRect", &GameEngine::DrawRoundRect,
        "FillRoundRect", &GameEngine::FillRoundRect,
        "DrawOval", &GameEngine::DrawOval,
        "DrawArc", &GameEngine::DrawArc,
        "FillArc", &GameEngine::FillArc,
        "MakeRGB", &GameEngine::MakeRGB,
        "DrawBitmap", sol::overload(
            sol::resolve<bool(const Bitmap*, int, int) const>(&GameEngine::DrawBitmap),
            sol::resolve<bool(const Bitmap*, int, int, RECT) const>(&GameEngine::DrawBitmap)
        )

    );

    //lua["Shape"] = lua.create_table_with(
    //    "Ellipse", HitRegion::Shape::Ellipse,
    //    "Rectangle", HitRegion::Shape::Rectangle
    //);
    //lua.new_enum<HitRegion::Shape>("Shape",
    //    { {"Ellipse", HitRegion::Shape::Ellipse},
    //      {"Rectangle", HitRegion::Shape::Rectangle}
    //    });

    //lua.new_usertype<HitRegion>("HitRegion",
    //    sol::constructors<HitRegion(HitRegion::Shape, int, int, int, int)>(),
    //    sol::constructors<HitRegion(const POINT*, int)>(),
    //    sol::constructors<HitRegion(const Bitmap*, COLORREF, COLORREF)>(),
    //    "Move", &HitRegion::Move,
    //    "HitTest", sol::overload(
    //        sol::resolve<bool(int, int) const>(&HitRegion::HitTest),
    //        sol::resolve<bool(const HitRegion*) const>(&HitRegion::HitTest)
    //    ),
    //    "CollisionTest", &HitRegion::CollisionTest,
    //    "GetBounds", &HitRegion::GetBounds,
    //    "Exists", &HitRegion::Exists,
    //    "GetHandle", &HitRegion::GetHandle
    //);

    lua.set("GameEngine", GAME_ENGINE);

	lua.set("Game", this);
}




