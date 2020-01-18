# run with: gdb -tui -c start.gdb executable-to-debug.elf

target extended-remote | openocd -c "gdb_port pipe" -f gdb.cfg
set remote hardware-breakpoint-limit 4
set remote hardware-watchpoint-limit 2
set mem inaccessible-by-default off

