#!/bin/bash


es_numero='^-?[0-9]+([.][0-9]+)?$'
PSQL="psql -X --username=postgres --dbname=periodic_table --no-align --tuples-only -c"




# SI ESTA VACIO
if [[ -z $1  ]]
then
    echo -e "Please provide an element as an argument."
    
    
    #   SI ES NUMERO
elif [[  $1 =~ $es_numero ]]
then
    atomic_number=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1;")



    if [[ -z $atomic_number  ]]
    then
        echo -e "I could not find that element in the database."
        else
                    atomic_number=$($PSQL "select atomic_number from elements where atomic_number='$1'")
         symbol=$($PSQL "select symbol from elements where atomic_number='$1'")
            name=$($PSQL "select name from elements where atomic_number='$1'")
            type_id=$($PSQL "select type_id from properties where atomic_number='$atomic_number'")
            atomic_mass=$($PSQL "select atomic_mass from properties where atomic_number='$atomic_number'")
            melting_point_celsius=$($PSQL "select melting_point_celsius from properties where atomic_number='$atomic_number'")
            boiling_point_celsius=$($PSQL "select boiling_point_celsius from properties where atomic_number='$atomic_number'")
            type=$($PSQL "select type from types where type_id='$type_id'")

            echo -e "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
       
    fi
    # SI ES CADENA
elif [[  $1 != $es_numero ]]
then
    
    largo=${#1}
    if [[ $largo  < 3 ]]
    then
        symbol=$($PSQL "select symbol from elements where symbol='$1'")
        if [[ -z $symbol   ]]
        then
            echo -e "I could not find that element in the database."
            else
             symbol=$($PSQL "select symbol from elements where symbol='$1'")
            name=$($PSQL "select name from elements where symbol='$1'")
            atomic_number=$($PSQL "select atomic_number from elements where symbol='$1'")
            type_id=$($PSQL "select type_id from properties where atomic_number='$atomic_number'")
            atomic_mass=$($PSQL "select atomic_mass from properties where atomic_number='$atomic_number'")
            melting_point_celsius=$($PSQL "select melting_point_celsius from properties where atomic_number='$atomic_number'")
            boiling_point_celsius=$($PSQL "select boiling_point_celsius from properties where atomic_number='$atomic_number'")
            type=$($PSQL "select type from types where type_id='$type_id'")

            echo -e "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
       
        fi
    else
        name=$($PSQL "select name from elements where name='$1'")
        
        if [[ -z $name ]]
        then
            echo -e "I could not find that element in the database."
        else
            name=$($PSQL "select name from elements where name='$1'")
            atomic_number=$($PSQL "select atomic_number from elements where name='$1'")
            symbol=$($PSQL "select symbol from elements where name='$1'")
            type_id=$($PSQL "select type_id from properties where atomic_number='$atomic_number'")
            atomic_mass=$($PSQL "select atomic_mass from properties where atomic_number='$atomic_number'")
            melting_point_celsius=$($PSQL "select melting_point_celsius from properties where atomic_number='$atomic_number'")
            boiling_point_celsius=$($PSQL "select boiling_point_celsius from properties where atomic_number='$atomic_number'")
            type=$($PSQL "select type from types where type_id='$type_id'")
            
            echo -e "The element with atomic number $atomic_number is $name ($symbol). It's a $type, with a mass of $atomic_mass amu. $name has a melting point of $melting_point_celsius celsius and a boiling point of $boiling_point_celsius celsius."
       
        fi
    fi
fi