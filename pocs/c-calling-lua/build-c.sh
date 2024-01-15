#!/bin/bash

#gcc doscript.c -o main -lm -llua 
cc doscript.c -o main -I /usr/local/include -L /usr/local/lib/lua/5.4/ -L /usr/local/lib/ -llua5.4
#cc doscript.c -o doscript -I /usr/local/include -L /usr/local/lib
#-I /usr/include/lua5.4/ -llua 
