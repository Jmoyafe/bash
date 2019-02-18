#!/bin/bash
# Carga variables de entorno ORACLE

servicios=($(grep -v '#' /etc/oratab | grep -ve '^$' | cut -f 1 -d ':'))
orahomes=($(grep -v '#' /etc/oratab | grep -ve '^$' | cut -f 2 -d ':'))
mostrar_servicios()
{
	clear
	long=68
	printf -v line "%*s" "$long"
	lineah=$(echo ${line// /-})
	echo "+${lineah}+"
	printf "|%-2sSID%2s|%-19sORACLE_HOME%19s|%-2sSTATUS%2s|\n"
	echo "+${lineah}+"
	for (( sid=0; sid<${#servicios[*]}; sid++ ))
	do
		service="ora_pmon_${servicios[sid]}"
		ps -ef | grep -v grep | grep ${service} > /dev/null
		result=$?
		if [ "${result}" -eq "0" ]; then
			status="UP"
		else
			status="DOWN"
		fi
		printf "|%-7s|%-49s|%-10s|\n" ${servicios[sid]} ${orahomes[sid]} ${status}
	done
	echo "+${lineah}+"
}

while :
	do
		mostrar_servicios
		read -p "Intruduce SID: " ORACLE_SID
		if [[ " ${servicios[*]} " == *"$ORACLE_SID"* ]]; then
			for i in "${!servicios[@]}"
			do
				if [[ "${servicios[$i]}" = "${ORACLE_SID}" ]] 
				then
					ORACLE_HOME=${orahomes[$i]}
				fi
			done
			PATH=$PATH:${ORACLE_HOME}/bin
			LD_LIBRARY_PATH=${ORACLE_HOME}/lib:${LD_LIBRARY_PATH}
			export ORACLE_SID ORACLE_HOME PATH LD_LIBRARY_PATH
			break
		else
			read -p "El SID no existe. Pulsa <ENTER>"
		fi
	done





