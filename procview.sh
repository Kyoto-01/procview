#!/bin/bash

procs=()

# salvando informações de processos
ps aux | tr -s " " | tr -d "<>" | tail -n +2 > procs.txt

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

# passando dados da tabela em texto para um array
while read line
do
	procs=( ${procs[@]} ${line} )
done < procs.txt

# removendo arquivos desnescessários
rm -f pid.txt usr.txt cpu.txt mem.txt vsz.txt rss.txt stt.txt cmd.txt procs.txt

# criando GUI
FORM=$(
	yad --center					\
	--title="ProcView - Process Visualizer"		\
	--width=700 --height=700			\
	--window-icon="icon.ico"			\
	--list						\
	--column="PID":NUM				\
	--column="User":TEXT 				\
	--column="CPU(%)":FLT 				\
	--column="RAM(%)":FLT 				\
	--column="VSZ(KB)":NUM 				\
	--column="RSS(KB)":NUM 				\
	--column="Status":TEXT 				\
	--column="Comand":TEXT 				\
	"${procs[@]}"					\
	--button="Filter by user":"ls"			\
	--button="Start process":"ls"			\
	--button="Schedule process":"ls"		\
	--button="Process Graphic":"ls"			\
	--button="Kill":"ls"				\
)

