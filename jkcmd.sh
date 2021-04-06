JKCMDPATH="$HOME/.jkcmd"

jkcmd(){
    #if called from a wrapper function stack has 2 accessible elements
    #if called directly function stack has only 0th element
    if [ -z ${FUNCNAME[1]} ]; then stack=0; else stack=1; fi
    if [ $stack -eq 0 ]; then
        usage="Usage: ${FUNCNAME[$stack]} [ (cmd) (key) | add (key) (path) | del (key) ]"
    else
        usage="Usage: ${FUNCNAME[$stack]} (key)"
    fi
    if [ -z $1 ] || [ -z $2 ]; then echo $usage; return; fi
    case $1 in
        add)
            if [ ! -z $2  ] && [ ! -z $3 ]; then
                #find absolute path from relative path and assert existance
                abspath="$(realpath -e $3 2> /dev/null)"
                if [ -n "$abspath" ]; then
                    #update key value file
                    echo "$2 $abspath" >> $JKCMDPATH/jkdb.txt
                    #update autocompletion for each variant
                    complete -W "$(echo `awk '{print $1}' $JKCMDPATH/jkdb.txt | uniq`)" jkcmd
                else
                    print "Could not find directory path $3"
                fi
            else
                echo $usage
            fi
            ;;
        del)
            if [ -n $2  ]; then
                #in-place deletion of line starting with exact key
                sed -i "/^$2 /d" $JKCMDPATH/jkdb.txt
                #update autocompletion for each variant
                complete -W "$(echo `awk '{print $1}' $JKCMDPATH/jkdb.txt | uniq`)" jkcmd
            else
                echo $usage
            fi
            ;;
        *)
            #find key in text file and get path
            line=$(grep "^${!#} " $JKCMDPATH/jkdb.txt)
            path=$(echo $line | awk '{for (i=2; i<=NF; i++) print $i}')
            #execute full command substituting key with corresponding path as last argument
            if [ -n "$path" ]; then ${@:1:$#-1} "$(echo $path)"; fi
            ;;
    esac
}

if [ -f $JKCMDPATH/jkdb.txt ]; then
    #set autocompletion for each variant at shell launch
    complete -W "$(echo `awk '{print $1}' $JKCMDPATH/jkdb.txt | uniq`)" jkcmd
fi
