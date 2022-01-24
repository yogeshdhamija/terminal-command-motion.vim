if(exists("g:loaded_terminal_command_motion"))
    finish
endif
let g:loaded_terminal_command_motion = 1

nnoremap cm <Cmd>call terminalCommandMotion#NextPrompt()<CR>
nnoremap CM <Cmd>call terminalCommandMotion#PreviousPrompt()<CR>

vnoremap cm <Cmd>call terminalCommandMotion#NextPrompt()<CR>
vnoremap CM <Cmd>call terminalCommandMotion#PreviousPrompt()<CR>

vnoremap acm <Cmd>call terminalCommandMotion#SelectAllCommand()<CR>
vnoremap icm <Cmd>call terminalCommandMotion#SelectInnerCommand()<CR>

omap acm <Cmd>silent! normal vacm<CR>
omap icm <Cmd>silent! normal vicm<CR>
