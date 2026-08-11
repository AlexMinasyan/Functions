#!/bin/bash
path=$1
line=$2
c_flag=false

while [ "$3" != "" ]; do
    case $3 in 
    -c | --Clipboard)
        c_flag=true
        shift ;;
    *)
        c_flag=false;;
    esac
done

if [ $c_flag == false ]; then
    params=$(awk -F'\\|\\|' '{print $1," -- ",$5," -- ",$3," -- ",$4}' '/Users/alex/Documents/Computer/Functions/functions.csv' | fzf)

    name=`awk -F' -- ' '{print $1}' <<< "$params" | tr -d ' '`
    lang=`awk -F' -- ' '{print $2}' <<< "$params" | tr -d ' '`
    desc=`awk -F' -- ' '{print $3}' <<< "$params" | awk '{$1=$1};1'`
    keywords=`awk -F' -- ' '{print $4}' <<< "$params" | tr -d ' '`

    # grep_out=`grep -e "$name||.*||$desc||$keywords||$lang" functions.csv`
    # grep_out=`echo $grep_out | sed -E "s/[\][*]/\x2A/g"`
    # echo "$grep_out"
    temp=`grep -e "$name||.*||$desc||$keywords||$lang" '/Users/alex/Documents/Computer/Functions/functions.csv' | sed -E "s/[\][*]/\x2A/g"`
    code=`awk -F'[|][|]' '{print $2}' <<< "$temp"`
else   
    code=$(pbpaste | xargs echo)
fi

echo "$code" > temp.txt
total_lines=`wc -l < "$path"`

# Instead of Inserting into a line, I cut the code file at the line and stiched the file back together...
sed -n "1,$line p" "$path" > temp.txt
echo "$code" | sed -e 's/&&&&/\n/g' >> temp.txt
sed -n "$(($line + 1)),$total_lines p" "$path" >> temp.txt

cat temp.txt > "$path"
rm -rf temp.txt