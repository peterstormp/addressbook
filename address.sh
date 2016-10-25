#!/bin/bash

#set -e

BOOK="book.txt"

view(){
   if [[ -f $BOOK ]]
   then
      echo "====================="
      cat $BOOK
      echo "====================="
   else
      echo "no address book found"
   fi
}

add(){
   echo -n "Enter full name: "
   read name
   echo -n "Enter phone number: "
   read number
   
   # Find number of the last entry
   last=`tail -n1 $BOOK | awk '{print $1}'`
   echo "$(($last+1)) $name $number"  >> $BOOK
}

find(){
   if [[ -f $BOOK ]]
   then
      echo -n "Enter line number or name to search:"
      read line
      echo "====================="
      linenum=`egrep "^$line" $BOOK`
      if [[ $linenum != '' ]]
      then
         echo $linenum
      else
         grep "$line" $BOOK
      fi
      echo "====================="
   else
      echo "no address book found"
   fi
}

del(){
   if [[ -f $BOOK ]]
   then
      echo -n "Enter line you want to delete:"
      read line
      sed -i.bak '/^'$line'/d' $BOOK
   else
      echo "no address book found"
   fi
}

while (true)
do
   echo "Available options:"
   echo "Add : a"
   echo "View : v"
   echo "Find : f"
   echo "Delete : d"
   echo "Exit : q"
   echo -n "Your selection :"
   read action

   if [[ ("$action" == 'v') ]]
   then
       view
   elif [[ "$action" == 'a'  ]]
   then
       add
   elif [[ "$action" == 'f'  ]]
   then
       find
   elif [[ "$action" == 'd'  ]]
   then
       del
   elif [[ "$action" == 'q'  ]]
   then
       echo "exiting"
       exit 0
   else
      echo "Invalid option"
   fi

done
