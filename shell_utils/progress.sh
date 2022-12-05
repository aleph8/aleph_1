##########################################################################
### aleph8                                                             ###
###--------------------------------------------------------------------###
### Description                                                        ###
###                                                                    ###
### A set of functions to make the waiting process more visible;       ###
### you can import the file from your script in the following way:     ###
###                                                                    ###
### source <path_to_script>/progress.sh                                ###
###                                                                    ###
###--------------------------------------------------------------------###
###                                                                    ###
##########################################################################

logpath="/dev/null"

slash(){
  tput civis
  stty -echo
  $1 &> $logpath  & pid=$(echo $!)
  #echo $pid
  chars="\ | / -"
  num=$((${#2}+3))
  reload=$(printf '\\b%.0s' $(seq 1 $num))

  while kill -0 "$pid" 2> /dev/null ; do

    for i in $chars
    do
      sleep 0.5
      echo -ne $reload"["$i"]"$2
    done

  done

  echo -e $3
  tput cnorm
  stty echo

}

upper(){

  tput civis
  stty -echo
  $1 &> $logpath & pid=$(echo $!)
  #echo $pid
  num=$((${#2}+3))
  reload=$(printf '\\b%.0s' $(seq 1 $num))

  while kill -0 "$pid" 2> /dev/null ; do

     for i in $(seq 0 $num)
     do
       char=${2:$i:1}
       sleep 0.1
       echo -ne $reload"[!]"${2:0:$((0+$i))}${char^^}${2:$(($i+1)):$num}
     done

   done

  echo -e $3
  tput cnorm
  stty echo
}
