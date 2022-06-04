:let g:terminal_command_motion_prompt_matcher = "^prompt\\nsecondline \\$"
:call terminalCommandMotion#AddMappings()

G$CMiMARK1llCMiMARK22CMiMARK3

:cd %:p:h
:w! actual.txt
:q!
