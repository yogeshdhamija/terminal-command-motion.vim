# terminal-command-motion.vim

[![CI](https://github.com/yogeshdhamija/terminal-command-motion.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/yogeshdhamija/terminal-command-motion.vim/actions/workflows/ci.yml) -> status for latest vim  
[![CI](https://github.com/yogeshdhamija/terminal-command-motion.vim/actions/workflows/ci.yml/badge.svg)](https://github.com/yogeshdhamija/terminal-command-motion.vim/actions/workflows/ci.yml) -> status for latest neovim

![gif](https://user-images.githubusercontent.com/4468354/150797271-0293d84c-a9e7-4c89-a3e8-4b0a4e68ecca.gif)

## To Install
Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'yogeshdhamija/terminal-command-motion.vim'
```

Works in both [vim](https://www.vim.org/), and [neovim](https://neovim.io/).

## Usage
This plugin adds a "terminal command" motion to vim.

`yacm` to (Y)ank (A)ll of a (C)o(m)mand in a terminal buffer

...and associated commands like `3cm`, `2CM`, `yicm`, etc.

See `:h terminal-command-motion.txt` for details (or check the `/doc` folder).

**Required step** for this to work: you must set `g:terminal_command_motion_prompt_matcher`. See `:h g:terminal_command_motion_prompt_matcher`. Example:

```
let g:terminal_command_motion_prompt_matcher = 'prompt\$'
```

## To Test
Locally, run:
```
./test.sh
```
In docker, run:
```
docker build . -t testing_terminal-command-motion.vim && docker run testing_terminal-command-motion.vim
```
