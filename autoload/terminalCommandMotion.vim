function! s:configurationExists() abort
    if(!exists("g:terminal_command_motion_prompt_matcher"))
        echom "Terminal Command Motion won't work without setting g:terminal_command_motion_prompt_matcher"
        return 0
    endif
    echo "GOOD"
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

    let l:oldPosition = getpos(".")
    silent! execute 'normal! '.v:count1.'N'
    if(getpos(".") == l:oldPosition)
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

    let l:oldPosition = getpos(".")
    silent! execute 'normal! '.v:count1.'n'
    if(getpos(".") == l:oldPosition)
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

function! s:isOnPrompt() abort
    let l:lineContents = getline('.')
    return match(l:lineContents, g:terminal_command_motion_prompt_matcher) != -1
endfunction

function! terminalCommandMotion#SelectInnerCommand() abort
    if(!s:configurationExists())
        return
    endif

    if(s:isOnPrompt())
        silent! normal! 0o$
    else
        call terminalCommandMotion#SelectAllCommand()
        silent! normal! o

        if(s:isOnPrompt())
            silent! normal! j
        endif

        silent! normal! o
    endif
endfunction
