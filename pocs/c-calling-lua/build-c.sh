#!/bin/bash

cc doscript.c -o main -I /usr/local/include -L /usr/local/lib/lua/5.4/ -L /usr/local/lib/ -llua5.4
