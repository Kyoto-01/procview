#!/bin/bash

PID=$$
REFRESH_TIME=1

# enquanto a caixa de diálogo estiver em execução
while [ $( pgrep -P ${PID} | wc -l ) -gt 1 ]
do
	# salvando informações de processos
	ps aux | tr -s " " | tr -d "<>" | tail -10 > procs.txt

	# guardando informações de processos que serão usadas
	cut -d " " -f 2 procs.txt > pid.txt
	cut -d " " -f 1 procs.txt > usr.txt
	cut -d " " -f 3 procs.txt > cpu.txt
	cut -d " " -f 4 procs.txt > mem.txt
	cut -d " " -f 5 procs.txt > vsz.txt
	cut -d " " -f 6 procs.txt > rss.txt
	cut -d " " -f 8 procs.txt > stt.txt
	cut -d " " -f 11 procs.txt > cmd.txt

	# formatando tabela com as informações de processos que serão usadas
	paste pid.txt usr.txt cpu.txt mem.txt vsz.txt rss.txt stt.txt cmd.txt \
	| tr "\t" "\n" > procs.txt
	
	cat procs.txt

	sleep ${REFRESH_TIME}
	
	echo -e "\f"

done | yad --list 					\
	--title="ProcView - Process Visualizer"		\
	--width=700 --height=700 --center --on-top	\
	--window-icon="icon.ico"			\
	--column="PID":NUM				\
	--column="User":TEXT 				\
	--column="CPU(%)":FLT 				\
	--column="RAM(%)":FLT 				\
	--column="VSZ":SZ				\
	--column="RSS":SZ 				\
	--column="Status":TEXT 				\
	--column="Comand":TEXT 				\
	--button="Filter by user":"ls"			\
	--button="Start process":"ls"			\
	--button="Schedule process":"ls"		\
	--button="Process Graphic":"ls"			\
	--button="Kill:echo oi"				\

# removendo arquivos desnescessários
rm -f pid.txt usr.txt cpu.txt mem.txt vsz.txt rss.txt stt.txt cmd.txt procs.txt

