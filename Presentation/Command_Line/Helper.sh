
if [ $# -lt 1 ]
then
	echo -e "\n\tPlease Specify Directory Containing information CSVs."
	echo -e "\n\t\tExample \n\t\t\t $0 Git/ \n"
	exit
fi

Current_Path=`dirname $0`
$Current_Path/Consoler.sh $1 | less
