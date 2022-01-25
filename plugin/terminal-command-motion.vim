augroup terminal_command_motion
    autocmd!
    autocmd TermOpen * nnoremap <buffer> cm  <Cmd>call    terminalCommandMotion#NextPrompt()<CR>
    autocmd TermOpen * nnoremap <buffer> CM  <Cmd>call    terminalCommandMotion#PreviousPrompt()<CR>
    autocmd TermOpen * xnoremap <buffer> cm  <Cmd>call    terminalCommandMotion#NextPrompt()<CR>
    autocmd TermOpen * xnoremap <buffer> CM  <Cmd>call    terminalCommandMotion#PreviousPrompt()<CR>

    autocmd TermOpen * xnoremap <buffer> acm <Cmd>call    terminalCommandMotion#SelectAllCommand()<CR>
    autocmd TermOpen * xnoremap <buffer> icm <Cmd>call    terminalCommandMotion#SelectInnerCommand()<CR>

    autocmd TermOpen * omap     <buffer> acm <Cmd>silent! normal vacm<CR>
    autocmd TermOpen * omap     <buffer> icm <Cmd>silent! normal vicm<CR>
augroup END
