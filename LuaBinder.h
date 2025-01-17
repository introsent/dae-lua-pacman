#ifndef LUA_BINDER_H
#define LUA_BINDER_H

#include <sol/sol.hpp>
#include "GameEngine.h" // Include the file where your classes are defined

class LuaBinder {
public:

    // Static function to bind all classes to the Lua state
    static void Bind(sol::state& lua) {

        lua.new_usertype<GameEngine>("GameEngine",
            sol::constructors<GameEngine()>(),
            "SetWindowPosition", &GameEngine::SetWindowPosition,
            "SetWidth", &GameEngine::SetWidth,
            "SetHeight", &GameEngine::SetHeight,
            "SetFrameRate", &GameEngine::SetFrameRate,
            "Run", &GameEngine::Run,
            "Quit", &GameEngine::Quit,
            "IsKeyDown", &GameEngine::IsKeyDown,
            "SetColor", &GameEngine::SetColor,
            "SetFont", &GameEngine::SetFont,
            "DrawString", &GameEngine::DrawString,
            "GetTitle", &GameEngine::GetTitle,
            "GetWidth", &GameEngine::GetWidth,
            "GetHeihgt", &GameEngine::GetHeight,
            "GetFrameRate", &GameEngine::GetFrameRate,
            "DrawLine", &GameEngine::DrawLine,
            "DrawRect", &GameEngine::DrawRect,
            "FillRect", &GameEngine::FillRect,
            "DrawRoundRect", &GameEngine::DrawRoundRect,
            "FillRoundRect", &GameEngine::FillRoundRect,
            "DrawOval", &GameEngine::DrawOval,
            "FillOval", &GameEngine::FillOval,
            "DrawArc", &GameEngine::DrawArc,
            "FillArc", &GameEngine::FillArc
            );

        lua.new_usertype<Bitmap>("Bitmap",
            "new", sol::constructors<Bitmap(const tstring& filename, bool createAlphaChannel)>(),
            "SetTransparencyColor" , &Bitmap::SetTransparencyColor,
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

        lua["Shape"] = lua.create_table_with(
            "Ellipse", HitRegion::Shape::Ellipse,
            "Rectangle", HitRegion::Shape::Rectangle
        );
        lua.new_usertype<HitRegion>("HitRegion",
            "new", sol::constructors<HitRegion(Shape, int, int, int, int)>(),
            "newWithPoints", sol::constructors<HitRegion(const POINT* pointsArr, int numberOfPoints)>(),
            "newFromBitmap", sol::constructors<HitRegion(const Bitmap* bmpPtr, COLORREF cTransparent = RGB(255, 0, 255), COLORREF cTolerance = 0)>(),
            "Move", &HitRegion::Move,
        
        )


        // Caller bindings
        lua.new_usertype<Caller>("Caller",
            "GetType", &Caller::GetType,
            "AddActionListener", &Caller::AddActionListener,
            "RemoveActionListener", &Caller::RemoveActionListener
        );

        lua["Caller_Type"] = lua.create_table_with(
            "TextBox", Caller::Type::TextBox,
            "Button", Caller::Type::Button,
            "Timer", Caller::Type::Timer,
            "Audio", Caller::Type::Audio,
            "Video", Caller::Type::Video
        );

        // Callable bindings
        lua.new_usertype<Callable>("Callable",
            "CallAction", &Callable::CallAction
        );

        // Audio bindings
        lua.new_usertype<Audio>("Audio",
            sol::constructors<Audio(const tstring&)>(),
            "Play", &Audio::Play,
            "Pause", &Audio::Pause,
            "Stop", &Audio::Stop,
            "SetVolume", &Audio::SetVolume,
            "SetRepeat", &Audio::SetRepeat,
            "GetName", &Audio::GetName,
            "GetDuration", &Audio::GetDuration
        );
    }
};

#endif // LUA_BINDER_H
