#!/bin/bash


while read line; do
	site=$( echo "$line" | sed 's/[/]//g' )
	entiresite=$(wget $line -q -O -)
	if [ "$entiresite" = "" ]
		then
			echo $line " FAILED"

		else
			if ! [ -e $site.txt ];
			then

				md5=$( echo -n $entiresite | md5sum)
				md5modified=${md5::-3}
				echo $md5modified > $site.txt
				echo $line " INIT"

			else
				md5=$( echo -n $entiresite | md5sum)
				var=$(<"$site".txt) 
				modifiedvar=${var::-2}
				previousmd5=${md5::-3}

				if ! [ "$previousmd5" = "$modifiedvar" ]
				then
					echo $line
					echo $md5 > $site.txt
				fi
		
			fi

			
	fi

done < ListOfAdresses