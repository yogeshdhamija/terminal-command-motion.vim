augroup terminal_command_motion
    autocmd!
    if(has('nvim'))
        autocmd TermOpen * call terminalCommandMotion#AddMappings()
    else
        autocmd TerminalWinOpen * call terminalCommandMotion#AddMappings()
    endif
augroup END
