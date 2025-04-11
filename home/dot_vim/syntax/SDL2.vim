" Highlight deprected functions as regular functions
"    let sdl_enable_deprecated = 1
" Warn on use deprecated functions highlighted as errors
"    let sdl_deprecated_errors = 1

syn keyword SDL_Function SDL_Init SDL_InitSubSystem SDL_Quit SDL_QuitSubSystem SDL_SetMainReady SDL_WasInit SDL_WinRTRunApp SDL_CreateWindow SDL_CreateRenderer SDL_Log SDL_LogInfo SDL_LogDebug SDL_LogError

syn keyword SDL_Typedef SDL_AudioDeviceID SDL_AudioSpec
syn keyword SDL_Struct  SDL_Window
syn keyword SDL_Union SDL_Event
syn keyword SDL_Enum  SDL_LOG_CATEGORY_APPLICATION
syn keyword SDL_UserFunction NONEE

syn keyword SDL_Define NONEE
syn keyword SDL_Constant NONEE
syn keyword SDL_Macro SDL_INIT_VIDEO SDL_INIT_AUDIO SDL_INIT_TIMER SDL_INIT_JOYSTICK SDL_INIT_HAPTIC SDL_INIT_GAMECONTROLLER SDL_INIT_EVENTS SDL_INIT_EVERYTHING SDL_INIT_NOPARACHUTE SDL_WINDOW_SHOWN SDL_WINDOW_RESIZABLE SDL_RENDERER_ACCELERATED SDL_RENDERER_PRESENTVSYNC 


syn keyword SDL_DeprecatedFunction SDL_QueueAudio

hi def link SDL_Function Function
hi def link SDL_Typedef Type
hi def link SDL_Struct Type
hi def link SDL_Union Type
hi def link SDL_Enum Type
hi def link SDL_UserFunction Type
hi def link SDL_Macro Macro
hi def link SDL_Constant Constant
hi def link SDL_Define Constant

if exists("sdl_deprecated_errors")
    hi def link SDL_DeprecatedFunction Error
elseif exists("sdl_enable_deprecated")
    hi def link SDL_DeprecatedFunction Function
endif

