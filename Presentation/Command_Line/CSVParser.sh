
while read Row ;
do
		if [[ $Row =~ ^# ]];
		then
			echo -n
		else
			number_of_commas=`echo ${Row} | grep -o ',' | wc -l`
			number_of_columns=$(($number_of_commas + 1))
	
			#echo Row $Row
			Pratham=1
			for ((current_column=1; current_column<=number_of_columns; current_column++))
			do
				for Column in "`echo ${Row} |cut -d, -f$current_column`"
				do
					link=`echo $Column | grep '#link'| wc -w`
					if [[ $link -gt 0 ]]
					then
						Column=${Column//'#link'/','}
						Column=`echo $Column | cut -d, -f1`
					fi

					Column=${Column//')^('/','}
					Column=${Column//';'/'\n\t'}
					Column=`echo $Column| sed -e 's/^[\s]*//'`
					
					if [[ $Pratham -eq 1 ]]
					then
						#echo -ne $'\E[1;37m' $Column $'\E[0m' "\n\t"
						echo -ne $'\E[1;34m' $Column $'\E[0m' "\n\t"
						Pratham=2
					else
						echo -ne $'\E[1;37m' $Column $'\E[0m' "\n\t"
						#echo -ne $'\E[1;34m' $Column $'\E[0m' "\n\t"
					fi
				done
			done
		fi
		echo
done < $1 ;
