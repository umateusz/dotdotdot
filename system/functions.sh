function __run_command_for_file_or_pipe(){
    command=$1
    shift

    local show_names=false
    local OPTIND

    while getopts ":n" opt; do
        case $opt in 
            n) show_names=true ;;
            # :) echo "Missing argument for option -$OPTARG"; exit 1;;
            # \?) echo "Unknown option -$OPTARG"; exit 1;;
        esac
    done
    shift $(( OPTIND - 1 ))

    function run(){
        if  [ "$show_names" = true ]; then
            echo -n "$path ";
        fi

        eval "$command $path";
    }

    # usage command <argument>
    if [ -n "$1" ]; then
        path=$1
        run
        return 0
    fi

    # usage e.g. ls | command
    while read path; do
        run || break
    done;
}


function img-size(){
    command="identify -format \"%wx%h\n\""
    __run_command_for_file_or_pipe "$command" "$@"
}


function img-channels(){
    command="identify -format \"%[channels]\n\""
    __run_command_for_file_or_pipe "$command" "$@"
}


function video-size(){
    command="ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0"
    __run_command_for_file_or_pipe "$command" "$@"
}


function video-codec(){
    command="ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of csv=s=x:p=0"
    __run_command_for_file_or_pipe "$command" "$@"
}


function video-frames(){
    command="ffprobe -v error -select_streams v:0 -show_entries stream=nb_frames -of csv=s=x:p=0"
    __run_command_for_file_or_pipe "$command" "$@"
}


function ls-img(){
    ls $@ | egrep -i '\.jpg$|\.png$|\.jpeg$'
}


function unpack-dir(){
    local dir=$1
    local dir=$(echo $dir | sed "s/^\///;s/\/$//")
    if [ ! -d "$dir" ]; then
        echo "Is not a dir."
        return 0
    fi
    for f in $dir/*
    do
        f=$(basename $f)
	mv $dir/$f "$dir"_"$f"
    done
    rmdir $dir
}

function base64-decode(){
    echo $1 | base64 --decode && echo
}

function base64-encode(){
    echo $1 | base64
}