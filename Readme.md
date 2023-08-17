# Bible verse of the day

This plugin adds a command which shows the verse of the day:

```
:VerseOfTheDay
```

## Install

Install BibleVOTD with your favorite package manager:

### lazy.nvim:

```json
{
    "TheBlckbird/BibleVOTD"
}
```

## How to show the verse of the day after startup:

To show the verse of the day right after startup you have to add the following lines to you `init.lua`:

```lua
local function show_verse_of_the_day()
  require("bible-votd").show_verse_of_the_day()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = show_verse_of_the_day })
```
