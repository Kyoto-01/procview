# o arquivo passado deve ser um arquivo de atualização
# de processos pré-formatado criado pelo script procview.sh
# na função update_procs()

# segue as mesmas colunas do comando ps, sendo:
# $6 --> RSS

BEGIN{
	MAX=102400  # 1 KB
	MID=51200  # 50 KB

	MAX_BCK_COLOR="red"
	MID_BCK_COLOR="yellow"
	LOW_BCK_COLOR="green"

	CLEAN_FORE_COLOR="white"
	DARK_FORE_COLOR="black"
}

NR > 1 {
	bck_color=""
	fore_color=CLEAN_FORE_COLOR

	if ( $6 >= MAX ){
		 bck_color=MAX_BCK_COLOR;
	}
	else if ( $6 >= MID ){
		bck_color=MID_BCK_COLOR;
		fore_color=DARK_FORE_COLOR
	}
	else{
		bck_color=LOW_BCK_COLOR;
	}

	print fore_color"\n"bck_color"\n"$2"\n"$1"\n"$3"\n"$4"\n"$5"\n"$6"\n"$9"\n"$11
}
