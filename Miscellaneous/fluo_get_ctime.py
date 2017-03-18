#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

def createTime(fname):
    time = os.path.getctime(fname)-os.path.getctime("A14O0154_20170315160953-115 ^oC.csv")
    with open('ctime.txt', 'a') as ctime:
        ctime.write(fname+','+str(time)+'\n')
# Traverse all the files in the folder
currentdir = os.getcwd()
directory =  os.listdir(currentdir)

with open('ctime.txt','w') as ctime:
    print "Record cleared."

for filename in directory:
    if filename[-3:] == 'csv':
        createTime(filename)
#raw_input('')
