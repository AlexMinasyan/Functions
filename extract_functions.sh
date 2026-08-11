# Takes the csv and outputs it as name - language - description - keywords and allows one to fuzzy search through it.
# awk -F'\\|\\|' '{print $1," - ",$5," - ",$3, " - ",$4}'  functions.csv | fzf

# Arguments are PATH, flag
c_flag=false


while [ "$1" != "" ]; do
    case $1 in
    -c | --Clipboard)
        echo "Clipboard"
        shift 
        c_flag=true
        pbpaste | xargs echo ;;
    *)
        path=$1
        shift
        echo "$path"
        l1=$1
        shift
        echo "$l1"
        l2=$1
        shift
        echo "$l2"
        echo "Line Range: $l1 - $l2" ;;
    esac
done

# Since extracting lines with `sed` does not preserve the new lines properly, the alternative was to write the important 
# lines into a file and replace the newlines with '&&&&'. These '&&&&' will then be replaced with return characters when output.
touch temp.txt

if [ c_flag == false ]; then
    line_count=`cat "$path" | wc -l | tr -d ' '`
    function_block=$(sed -n "${l1},${l2}p" "$path")

    for i in $(seq 0 $line_count); do
        if [ $i -ge $l1 -a $i -le $l2 ]; then
            echo $(sed -n "${i}p" "$path") >> temp.txt
        fi
    done

    # Since `awk` cannot use '\\n' within its ORS parameter, I am using &&&& as the separator for lines.
    function_block=`awk 1 ORS="&&&&" "temp.txt"`

else
    pbpaste | xargs echo > temp.txt
    function_block=`awk 1 ORS="&&&&" "temp.txt"`
    echo "$function_block"
fi

rm -rf temp.txt

lang=''
case $path in
    *.py)
        lang='python' ;;
    *.cpp)
        lang='c++' ;;
    *)
        echo 'Language: '
        read lang ;;
esac

echo "Language: $lang"

name=''
case $lang in
    'python')
        name=$(echo $function_block | sed -e 's/def //' | sed -e 's/(.*//') ;;
    *)
        echo "Name: "
        read name ;;
esac

echo "Name: $name"

echo "Description: "
read description

echo "Keywords? (separate by ','): "
read keywords

echo "${name}||${function_block}||${description}||${keywords}||${lang}" >> "/Users/alex/Documents/Computer/Functions/functions.csv"