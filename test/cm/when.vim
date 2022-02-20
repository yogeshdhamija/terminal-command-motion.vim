:let g:terminal_command_motion_prompt_matcher = "^prompt \\$"
:call terminalCommandMotion#AddMappings()

ggcmiHERE

:cd %:p:h
:w! actual.txt
:q!
