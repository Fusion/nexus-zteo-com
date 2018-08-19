#!/bin/bash

for bit in $(grep -Eoi '\(http://nexus.zteo.com/.+?(jpg|gif|png)\)' content/posts/*); do
    bit2=$(echo ${bit#*:} | sed -e 's/(\|)//g'); bit3=$(echo ${bit2##*/}); filename="content/images/$bit3";
    if [ ! -f $filename ]; then echo "Retrieving $bit2"; curl -sS -o $filename $bit2; fi
done

#for filename in content/posts/*; do
#    echo "Converting $filename"; sed -i.bak 's/(http\:\/\/nexus.zteo.com\/.*\/\(.*\.\(jpg\|png\|gif\)\))/(\/images\/\1)/g' $filename
#done
#rm -f content/posts/*.bak

for bit in $(grep -Eoi '\(/static/.+?(jpg|gif|png)\)' content/posts/*); do
    bit2=$(echo ${bit#*:} | sed -e 's/(\|)//g'); bit3=$(echo ${bit2##*/}); filename="content/images/$bit3";
    if [ ! -f $filename ]; then echo "Retrieving $bit2"; curl -sS -o $filename "http://nexus.zteo.com$bit2"; fi
done

#for filename in content/posts/*; do
#    echo "Converting $filename"; sed -i.bak 's/(\/static\/.*\/\(.*\.\(jpg\|png\|gif\)\))/(\/images\/\1)/g' $filename
#done
#rm -f content/posts/*.bak

for filename in $(grep -l 'Page not found' content/images/*); do
    echo "Missing image: ${filename}"
done
