:let g:terminal_command_motion_prompt_matcher = "^prompt\\nsecondline \\$"
:call terminalCommandMotion#AddMappings()

ggcmcmyacmGp

:cd %:p:h
:w! actual.txt
:q!
