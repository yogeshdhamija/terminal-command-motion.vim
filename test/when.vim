:let g:terminal_command_motion_prompt_matcher = "^prompt \\$"
:call terminalCommandMotion#AddMappings()
ggcmiHERE
:w! test/actual.txt
:q!
