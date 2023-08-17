" Title:        Bible Verse of the Day
" Description:  A plugin to show the verse of the day on startup
" Last Change:  14 August 2023
" Maintainer:   TheBlckbird <https://github.com/theblckbird>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_biblevotd")
    finish
endif
let g:loaded_biblevotd= 1

" Defines a package path for Lua. This facilitates importing the
" Lua modules from the plugin's dependency directory.
let s:lua_rocks_deps_loc =  expand("<sfile>:h:r") . "/../lua/bible-votd/deps"
exe "lua package.path = package.path .. ';" . s:lua_rocks_deps_loc . "/lua-?/init.lua'"

" Exposes the plugin's functions for use as commands in Neovim.
command! -nargs=0 VerseOfTheDay lua require("bible-votd").show_verse_of_the_day()
