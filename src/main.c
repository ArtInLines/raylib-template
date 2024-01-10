#include "raylib.h"

int main(void)
{
	// building in debug mode automatically defines DEBUG and _DEBUG

    InitWindow(800, 450, "raylib [core] example - basic window");

    while (!WindowShouldClose())
    {
        BeginDrawing();
            ClearBackground(BLACK);
			#ifdef DEBUG
			DrawText("Running in Debug-Mode", 190, 200, 20, LIGHTGRAY);
			#else
			DrawText("Running in Release-Mode", 190, 200, 20, LIGHTGRAY);
			#endif
        EndDrawing();
    }

    CloseWindow();

    return 0;
}