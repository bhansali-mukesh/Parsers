
if [ $# -lt 1 ]
then
	echo -e "\n\tPlease Specify Directory Containing information CSVs."
	echo -e "\n\t\tExample \n\t\t\t $0 Git/ > Git.html \n"
	exit
fi

Current_Path=`dirname $0`

TTILE=""

SYMBOLS=$Current_Path/Symbols

if [[ -f $1/title.html ]]
then
	TITLE=`cat $1/title.html`
fi

# Start HTML
echo '<html><head><title> ' "$TITLE" ' </title></head><body>'

if [[ -f $1/header.html ]]
then
        cat $1/header.html
fi

if [[ -f $SYMBOLS  ]]
then
	echo '</br>'
	$Current_Path/CsvToHtmlTables.sh $SYMBOLS
	echo '<hr></br></br>'
fi

# 
for csv in `ls $1/*[cC][Ss][Vv]`
do
	$Current_Path/CsvToHtmlTables.sh $csv
	echo '<hr align="left" width="87%"></br>'
done

if [[ -f $1/footer.html ]]
then
	cat $1/footer.html
fi

# End HTML 
echo '<hr></body></html>'
