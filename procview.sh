#!/bin/bash

# salvando informações de processos
ps aux | tr -s " " | tail -n +2 > procs.txt

# guardando informações de processos que serão usadas
pid=$( cut -d " " -f 2 procs.txt )
usr=$( cut -d " " -f 1 procs.txt ) 
cpu=$( cut -d " " -f 3 procs.txt )
mem=$( cut -d " " -f 4 procs.txt )
vsz=$( cut -d " " -f 5 procs.txt )
rss=$( cut -d " " -f 6 procs.txt )
stt=$( cut -d " " -f 8 procs.txt )
cmd=$( cut -d " " -f 11 procs.txt )

# criando GUI
FORM=$(
	yad --center					\
	--title="ProcView - Process Visualizer"		\
	--width=700 --height=700			\
	--window-icon="icon.ico"			\
	--list						\
	--column="PID":text "${pid}"			\
	--column="User":text "${usr}"			\
	--column="CPU":txt "${cpu}"			\
	--column="RAM":txt "${mem}"			\
	--column="VSZ":txt "${vsz}"			\
	--column="RSS":txt "${rss}"			\
	--column="Status":txt "${stt}"			\
	--column="Comand":txt "${cmd}"			\
	--focus-field=1					\
)

