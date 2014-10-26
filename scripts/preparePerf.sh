#!/usr/bin/env bash

# first make thumbnails
# version 0.1
# by fredd 2014

echo "Hallo I am happily generating a thumbnail 512 pis wide for all movies in this folder"
echo "if there is no subfolder yet named thumbs please make one"
targetdir="../"
extension=".mov"

FILES=*.mov
for f in "$targetdir/"*"$extension";
do
  echo "Processing $f file..."
qlmanage -ti  $f -s 512 -o ../thumbs/
done

# then populate XML file
echo "=============================="
echo "Populate XML v.03 --- STARTING"
echo "=============================="

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
echo "XML populated. Open and check"
echo "REMEMBER to put in XML file out.xml /path_of_files/folder_with_ending_slash/"
echo "Have fun editing the .xml file!"
