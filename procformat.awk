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

	MAIN_FORE_COLOR="white"
}

NR > 1 {
	color=""

	if ( $6 >= MAX ) color=MAX_BCK_COLOR;
	else if ( $6 >= MID ) color=MID_BCK_COLOR;
	else color=LOW_BCK_COLOR;

	print color"\n"$2"\n"$1"\n"$3"\n"$4"\n"$5"\n"$6"\n"$9"\n"$11
}
