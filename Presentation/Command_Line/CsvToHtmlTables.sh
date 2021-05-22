
TABLE='<table border="2" bordercolor="#1298A3">'
TABLE_END='</table>'

echo "$TABLE"

while read Row ;
do
	# If Line is Blank
	# Start a New Table
	if [[ $Row =~ ^$ ]]
	then
		echo "$TABLE_END </br> $TABLE"
	else
		echo "<tr>";
		number_of_commas=`echo ${Row} | grep -o ',' | wc -l`
		number_of_columns=$(($number_of_commas + 1))
	
		#echo Row $Row
		for ((current_column=1; current_column<=number_of_columns; current_column++))
		do
			for Column in "`echo ${Row} |cut -d, -f$current_column`"
			do
				# If Column starts with #, Treat it as Table Header
				if [[ $Column =~ ^# ]];
				then
					open='<th>'
					close='</th>'
					Column=${Column//'#'/''}
				else
					open='<td>'
					close='</td>'
				fi

				link=`echo $Column | grep '#link'| wc -w`
				if [[ $link -gt 0 ]]
				then
					Column=${Column//'#link'/','}
					Column=`echo $Column | awk -F',' '{print "<a href="$2"> "$1" </a>" }'`
				fi

				
				Column=${Column//')^('/','}
				Column=${Column//';'/'</br>'}
				Column=`echo $Column| sed -e 's/^[\s]*//'`
				echo "$open $Column $close"
			done
		done
	echo "</tr>"
	fi

done < $1 ;

echo $TABLE_END
