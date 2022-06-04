:let g:terminal_command_motion_prompt_matcher = "^prompt\\nsecondline \\$"
:call terminalCommandMotion#AddMappings()

ggcmiMARK12cmiMARK2cmaMARK3

:cd %:p:h
:w! actual.txt
:q!
