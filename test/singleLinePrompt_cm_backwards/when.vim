:let g:terminal_command_motion_prompt_matcher = "prompt \\$"
:call terminalCommandMotion#AddMappings()

:normal G$
:normal CM
:normal rA

:cd %:p:h
:w! actual.txt
:q!
