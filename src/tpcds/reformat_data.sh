#!/bin/bash
# Replace NULL values in the first field with 0 to convert ^| into 0|.
# Replace NULL values in the middle fields with 0 to convert || into |0|.
# Replace NULL values in the last field with 0 to convert |$ into |0.
for s_f in `ls results/data/*dat`
do
    echo "$s_f"
    i=1
    while [ `egrep '\|\||^\||\|$' $s_f |wc -l` -gt 0 ]
    do 
        echo $i
        sed 's/^|/0|/g;s/||/|0|/g;s/|$/|0/g' -i $s_f
        ((i++))
    done
done

for s_f in item.dat store.dat web_page.dat web_site.dat call_center.dat
do
# Process the first and second date fields whose values are NULL (represented by 0).
sed 's/^\([A-Za-z0-9]*|[A-Za-z0-9]*\)|0|0|\(.*\)/\1|0000-00-00|0000-00-00|\2/' -i $s_f

# Process the second date fields whose values are NULL (represented by 0).
sed 's/^\([0-9A-Za-z]*|[A-Za-z0-9]*|[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}\)|0|\(.*\)/\1|0000-00-00|\2/' -i $s_f

# Process the first date fields whose values are NULL (represented by 0).
sed 's/^\([0-9A-Za-z]*|[A-Za-z0-9]*\)|0|\([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}|.*\)/\1|0000-00-00|\2/' -i $s_f

done