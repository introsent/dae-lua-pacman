//-----------------------------------------------------------------
// Game Engine WinMain Function
// C++ Source - GameWinMain.cpp - version v8_01
//-----------------------------------------------------------------

//-----------------------------------------------------------------
// Include Files
//-----------------------------------------------------------------
#include "GameWinMain.h"
#include "GameEngine.h"

#include "Game.h"	

//-----------------------------------------------------------------
// Create GAME_ENGINE global (singleton) object and pointer
//-----------------------------------------------------------------
GameEngine myGameEngine;
GameEngine* GAME_ENGINE{ &myGameEngine };

//-----------------------------------------------------------------
// Main Function
//-----------------------------------------------------------------
int APIENTRY wWinMain(_In_ HINSTANCE hInstance, _In_opt_ HINSTANCE hPrevInstance, _In_ LPWSTR lpCmdLine, _In_ int nCmdShow)
{
    if (AllocConsole())                          // Allocate a new console for the application
    {
        FILE* fp;                                // Redirect STDOUT to the console
        freopen_s(&fp, "CONOUT$", "w", stdout);
        setvbuf(stdout, NULL, _IONBF, 0);        // Disable buffering for stdout

        freopen_s(&fp, "CONOUT$", "w", stderr);  // Redirect STDERR to the console
        setvbuf(stderr, NULL, _IONBF, 0);        // Disable buffering for stderr

        freopen_s(&fp, "CONIN$", "r", stdin);    // Redirect STDIN to the console
        setvbuf(stdin, NULL, _IONBF, 0);         // Disable buffering for stdin

        std::ios::sync_with_stdio(true);         // Sync C++ streams with the console
    }


	GAME_ENGINE->SetGame(new Game());					// any class that implements AbstractGame

	return GAME_ENGINE->Run(hInstance, nCmdShow);		// here we go
}

