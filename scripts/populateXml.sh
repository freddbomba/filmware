#!/usr/bin/env bash

targetdir="../"
extension=".mov"
outfile=$targetdir"out.xml"
COUNTER=0
echo $targetdir " " $outfile
# Write the opening tag(s):
cat > $outfile <<DELIM

<?xml version="1.0" encoding="UTF-8" standalone="no"?>
#<!DOCTYPE filmware [
#<!ENTITY nbsp "&#xA0;">
#<!ENTITY director "Directed by: Lucas Van Woerkum">
#<!ENTITY writer "Writer: Federico Bonelli">
#<!ENTITY copyright "Copyright: Symphonic Cinema.">
#]>"

<filmware>
<filmwareName>NAME YOUR FILMWARE HERE</filmwareName>
<filmwareLocation>ABSOLUTE PATH TO YOUR FILES</filmwareLocation>
<numberofatoms>NUMBER OF ATOMS</numberofatoms>
<atomizer>
DELIM

# Loop through the matching files, writing entries for each one:
for f in "$targetdir/"*"$extension"; do
	echo "
	<atom>
	<number> $COUNTER </number>
   		<clip>  ${f#*'//'*} </clip>
		<file> ${f#*'//'*} </file> " >> $outfile
	  	duration=`mdls -name kMDItemDurationSeconds "$f" | cut -d "=" -f 2 `
		echo "       	<duration>$duration </duration>">>$outfile
    echo "       	<marker>
   			<MarkName>MARKER NAME HERE</MarkName>
        	<MarkTime>MARKER TIME HERE</MarkTime>
    	</marker>
		<next> 
			<transition>_cut</transition>
		</next>
		<notes>YOUR ANNOTATIONS HERE</notes>
	</atom>" >>$outfile
	let COUNTER=COUNTER+1
done

# Write the closing tag(s):
echo "</atomizer>
</filmware>">>$outfile
echo "DOUBLE CHECK AND REPLACE ON TOP:" $COUNTER >>$outfile