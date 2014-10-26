#!/bin/bash

# version 0.1
# by fredd 2014

echo "Hallo I am happily generating a thumbnail 512 pis wide for all movies in this folder"
echo "if there is no subfolder yet named thumbs please make one"

FILES=*.mov
for f in $FILES
do
  echo "Processing $f file..."
qlmanage -ti  $f -s 512 -o thumbs/
done
