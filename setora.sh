#!/bin/bash
# Inicialiación del entorno ORACLE

grep -v '#' /etc/oratab | grep -ve '^$' | cut -f 1 -d ':'

mostrar_servicios()
{
	clear
	tput cup 3 10
	echo """+------------------------------+
			|  Servicios ORACLE definidos  |
			+------------------------------+
			|                              |
		"""
	for SID in grep -v '#' /etc/oratab | grep -ve '^$' | cut -f 1 -d ':'
	do
		echo "|    $SID    |"
	done
}

mostrar_servicios	