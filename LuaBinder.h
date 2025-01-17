#ifndef LUA_BINDER_H
#define LUA_BINDER_H

#include <sol/sol.hpp>
#include "GameEngine.h" // Include the file where your classes are defined


class LuaBinder {

public:
    // Static function to bind all classes to the Lua state
    static void BindEngine(sol::state& lua) {

        lua.new_usertype<Bitmap>("Bitmap",
            sol::constructors<Bitmap(const tstring&, bool)>(),
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
                sol::resolve<void(int, int ,int)>(&GameEngine::SetColor),
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
            //"FillOval", sol::overload(
            //    sol::resolve<bool(int, int, int, int)>(&GameEngine::FillOval,
            //    sol::resolve<bool(int, int, int, int, int)>(&GameEngine::FillOval)
            //),
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
        lua.new_enum<HitRegion::Shape>("Shape",
            { {"Ellipse", HitRegion::Shape::Ellipse},
              {"Rectangle", HitRegion::Shape::Rectangle}
            });

        lua.new_usertype<HitRegion>("HitRegion",
            sol::constructors<HitRegion(HitRegion::Shape, int, int, int, int)>(),
            sol::constructors<HitRegion(const POINT*, int)>(),
            sol::constructors<HitRegion(const Bitmap*, COLORREF, COLORREF)>(),
            "Move", &HitRegion::Move,
            "HitTest", sol::overload(
                sol::resolve<bool(int, int) const>(&HitRegion::HitTest),
                sol::resolve<bool(const HitRegion*) const>(&HitRegion::HitTest) 
            ),
            "CollisionTest", &HitRegion::CollisionTest,
            "GetBounds", &HitRegion::GetBounds,
            "Exists", &HitRegion::Exists,
            "GetHandle", &HitRegion::GetHandle
        );


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

        lua.set("GameEngine", GAME_ENGINE);
        //lua.set("Bitmap", Bitmap);
    }
};

#endif // LUA_BINDER_H
