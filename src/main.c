#define AIL_TYPES_IMPL
#include "ail.h"
#include "raylib.h"
#include <stdio.h>

int main(void)
{
	// building in debug mode automatically defines DEBUG and _DEBUG
#ifdef DEBUG
	printf("Debug\n");
#else
	printf("Release\n");
#endif
	return 0;
}