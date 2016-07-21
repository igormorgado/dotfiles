#!/bin/bash

#number of seconds to give lowest level children before killing them
KILLDELAY=5400

#string to grep ps for the originating pid
SEARCHSTRING="latest"

push() {
eval ${1}[\$\{#${1}[*]\}]=${2}
}

anum() {
echo $(eval echo \$\{#${1}[*]\})
}

numchildren() {
echo $(ps --ppid ${2} -f|tail -n +2|tr -s " " " "|cut -d " " -f 2|wc -l)
}

delete() {
eval num=$(anum $1)
c=$2
while [ $c -lt $num ]
do
eval ${1}[${c}]=\$\{${1}[$((c + 1))]\}
(( c++ ))
done
unset ${1}[$((num - 1))]
}

swap() {
eval temp\=\$\{${1}[${2}]\}
eval ${1}[${2}]=\$\{${1}[${3}]\}
eval ${1}[${3}]=${temp}
}

culldead() {
c=0
for x in $(eval echo \$\{${1}[@]\})
do
if [ ! -d /proc/${x} ]
then
delete ${1} ${c}
if [ ! -z $2 ]
then
delete ${2} ${c}
fi
else
(( c++ ))
fi
done
}

qsort() {
local low high l r pivot

if [ -z $2 ]
then
low=0
high=$(anum $1)
else
low=$2
high=$3
fi

eval pivot=\$\{${1}[${low}]\}

l=$((low + 1))
r=$high
while [ $l -lt $r ]
do
eval c=\$\{${1}[${l}]\}
if [ $c -le $pivot ]
then
(( l++ ))
else
(( r-- ))
swap $1 $l $r
fi
done

(( l-- ))
swap $1 $low $l

if [ $(( l - low )) -gt 1 ]
then
qsort $1 $low $l
fi
if [ $(( high - r )) -gt 1 ]
then
qsort $1 $r $high
fi
}

insert() {
local i x

i=$3
for ((x = $(anum $1) - 1; x >= i; x--))
do
eval ${1}[$((x + 1))]=\$\{${1}[${x}]\}
done
eval ${1}[${i}]=$2
}

sort_insert() {
local i low high

low=0
high=$(anum $1)

while [ $low -lt $high ]
do
middle=$(((low + high) / 2))
eval c=\$\{${1}[${middle}]\}

last=0
if [ $c -eq $2 ]
then
return -1
elif [ $2 -lt $c ]
then
high=$((middle - 1))
else
low=$((middle + 1))
fi
done

[ $high -lt $low ] && low=$high
if [ $low -lt $(anum $1) ]
then
eval v=\$\{${1}[${low}]\}
[ $v -lt $2 ] && i=$((low + 1)) || i=$low
else
i=$low
fi

insert $1 $2 $i

return $i
}

sort_merge() {
for x in $(eval echo \$\{${2}[@]\})
do
sort_insert $1 $x
i=$?
if [ ! -z $3 ] && [ $i -ne -1 ]
then
insert $3 0 $i
fi
done
}

getchildren() {
[ -z $3 ] && push $1 $2

local x
for x in $(ps --ppid ${2} -f|tail -n +2|tr -s " " " "|cut -d " " -f 2)
do
push $1 $x
getchildren $1 $x 1
done
}

unset originpid
while [ -z $originpid ]
do
originpid=$(ps aux|grep $SEARCHSTRING|grep -v grep|tr -s " " " "|cut -d " " -f 2)
sleep 10s
done

getchildren stack $originpid
qsort stack

while [ $(anum stack) -gt 0 ]
do
for ((x=0; x<${#stack[@]}; x++))
do
if [ $(numchildren ${stack[$x]}) -lt 1 ]
then
if [ -z ${stack_times[$x]} ] || [ ${stack_times[$x]} -eq 0 ]
then
stack_times[$x]=$(date +%s)
elif [ $(( $(date +%s) - ${stack_times[$x]} )) -gt $KILLDELAY ]
then
if ps --pid ${stack[$x]}|tail -n1|tr -s " " " "|cut -d" " -f4|grep -E "(rpm)|(up2date)" &> /dev/null
then
rm -rf /var/lib/rpm/__db*
fi
c=0
kill -13 ${stack[$x]}
while [ $? -eq 1 ] && [ $((c++)) -lt 10 ]
do
sleep 2s
kill -9 ${stack[$x]}
done
fi
else
unset temp
getchildren temp ${stack[$x]}
sort_merge stack temp stack_times
fi
done

sleep 30s
culldead stack stack_times
done 
