:let g:terminal_command_motion_prompt_matcher = "^prompt \\$"
:call terminalCommandMotion#AddMappings()
:call terminalCommandMotion#NextPrompt()

ggcmiMARK12cmiMARK2cmaMARK3

:cd %:p:h
:w! actual.txt
:q!
