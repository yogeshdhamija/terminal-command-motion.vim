function! s:configurationExists() abort
    if(!exists("g:terminal_command_motion_prompt_matcher"))
        echom "Terminal Command Motion won't work without setting g:terminal_command_motion_prompt_matcher"
        return 0
    endif
    return 1
endfunction

function! terminalCommandMotion#PreviousPrompt() abort
    if(!s:configurationExists())
        return
    endif

    let l:oldWrapscan = &wrapscan
    let l:oldSearch = @/

    set nowrapscan
    let @/ = g:terminal_command_motion_prompt_matcher

    let l:oldPosition = getcurpos()
    silent! execute 'normal! '.v:count1.'N'
    if(getcurpos() == l:oldPosition)
        silent! normal! gg0
    endif

    let @/ = l:oldSearch
    let &wrapscan = l:oldWrapscan
endfunction

function! terminalCommandMotion#NextPrompt() abort
    if(!s:configurationExists())
        return
    endif

    let l:oldWrapscan = &wrapscan
    let l:oldSearch = @/
    let l:endOfFile = 0

    set nowrapscan
    let @/ = g:terminal_command_motion_prompt_matcher

    let l:oldPosition = getcurpos()
    silent! execute 'normal! '.v:count1.'n'
    if(getcurpos() == l:oldPosition)
        silent! normal! G$
        let l:endOfFile = 1
    endif

    let @/ = l:oldSearch
    let &wrapscan = l:oldWrapscan
    return l:endOfFile
endfunction

function! terminalCommandMotion#SelectAllCommand() abort
    if(!s:configurationExists())
        return
    endif

    " In case you're at the beginning of a prompt already
    " let's move you to the end of the line, so finding 
    " the previous prompt will result in your current one, and 
    " not the one before
    silent! normal! o$o$

    silent! normal! o
    call terminalCommandMotion#PreviousPrompt()
    silent! normal! o

    let l:endOfFile = terminalCommandMotion#NextPrompt()

    " So the first character of the next prompt
    " is not included in the selection
    if(!l:endOfFile)
        silent! normal! k$
    endif
endfunction

function! s:isOnPromptLine() abort
    let l:oldWrapscan = &wrapscan
    let l:oldSearch = @/
    let l:oldPosition = getcurpos()

    set nowrapscan
    let @/ = g:terminal_command_motion_prompt_matcher

    " In case you're at the beginning of a prompt already
    " let's move you to the end of the line, so finding 
    " the previous prompt will result in your current one, and 
    " not the one before
    silent! normal $N
    let l:promptStartPosition = getcurpos()
    let l:promptEndLine = search(@/, 'cenW')

    let l:isOnPrompt = 0
    if(l:oldPosition[1] != 1 && l:oldPosition[1] >= l:promptStartPosition[1] && l:oldPosition[1] <= l:promptEndLine)
        let l:isOnPrompt = 1
    endif

    call setpos('.', l:oldPosition)
    let @/ = l:oldSearch
    let &wrapscan = l:oldWrapscan

    return l:isOnPrompt
endfunction

function! terminalCommandMotion#SelectInnerCommand() abort
    if(!s:configurationExists())
        return
    endif

    let l:oldWrapscan = &wrapscan
    let l:oldSearch = @/
    let l:oldPosition = getcurpos()

    set nowrapscan
    let @/ = g:terminal_command_motion_prompt_matcher

    if(s:isOnPromptLine())
        silent! normal! $N
        silent! normal! o$N
        call search(@/, 'ceW')
        silent! normal! $
    else
        call terminalCommandMotion#SelectAllCommand()
        silent! normal! o

        if(s:isOnPromptLine())
            call search(@/, 'ceW')
            silent! normal! j0
        endif

        silent! normal! o
    endif

    let @/ = l:oldSearch
    let &wrapscan = l:oldWrapscan
endfunction

function! terminalCommandMotion#AddMappings() abort
    nnoremap <buffer> cm  <Cmd>call    terminalCommandMotion#NextPrompt()<CR>
    nnoremap <buffer> CM  <Cmd>call    terminalCommandMotion#PreviousPrompt()<CR>
    xnoremap <buffer> cm  <Cmd>call    terminalCommandMotion#NextPrompt()<CR>
    xnoremap <buffer> CM  <Cmd>call    terminalCommandMotion#PreviousPrompt()<CR>

    xnoremap <buffer> acm <Cmd>call    terminalCommandMotion#SelectAllCommand()<CR>
    xnoremap <buffer> icm <Cmd>call    terminalCommandMotion#SelectInnerCommand()<CR>

    omap     <buffer> acm <Cmd>silent! normal vacm<CR>
    omap     <buffer> icm <Cmd>silent! normal vicm<CR>
endfunction
