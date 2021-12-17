#!/bin/bash

PID=$$
REFRESH_TIME=3

update_procs(){
	# salvando informações de processos
	ps aux | tr -s " " | tr -d "<>" > procs.bkp.txt

	# guardando informações de processos que serão usadas
	cat procs.bkp.txt | awk 'NR > 1 { print $2"\n"$1"\n"$3"\n"$4"\n"$5"\n"$6"\n"$8"\n"$11 }' > procs.txt

	cat procs.txt	
}

update_screen(){
	update_num=0
	COLS_PER_UPDATE=224

	while [ $( pgrep -P ${PID} | wc -l ) -gt 1 ]
	do
		# se for o primeiro update
		if [ ${update_num} -eq 0 ]
		then
			echo -e "\f"
			update_procs > /dev/null
			update_num=$(( ${update_num} + 1 ))
			continue

		# se for o último update
		elif [ $( cat procs.txt | wc -l ) -lt $(( 224 * ( ${update_num} - 1 ) + 1 )) ]
		then
			update_num=0
			continue

		else
			cat procs.txt | tail -n +$(( 224 * ( ${update_num} - 1 ) + 1 )) | head -224
			update_num=$(( ${update_num} + 1 ))
		fi

		sleep ${REFRESH_TIME}
	done
}

# enquanto a caixa de diálogo estiver em execução
update_screen | yad --list --add-on-top  					\
	--title="ProcView - Process Visualizer"		\
	--width=700 --height=700 --center --on-top	\
	--window-icon="icon.ico"			\
	--tail						\
	--column="PID":NUM				\
	--column="User":TEXT 				\
	--column="CPU(%)":FLT 				\
	--column="RAM(%)":FLT 				\
	--column="VSZ":SZ				\
	--column="RSS":SZ 				\
	--column="Status":TEXT 				\
	--column="Comand":TEXT 				\
	--button="Filter by user":"ls"			\
	--button="Start process":"ls"    			\
	--button="Schedule process":"ls"		\
	--button="Process Graphic":"ls"			\
	--button="Kill:echo oi"				\

# removendo arquivos desnescessários
rm -f procs.txt

