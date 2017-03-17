#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import subprocess

def transcribe(fname):
	cumul = 0.0
	with open(fname,'r') as source,\
		 open(fname[:-4]+'_trans.csv','w') as result:
		content = source.readlines()
		del content[0:2]
		for i in range(0,3):
			for j in content:
				if len(j.split('\t')[4*i])>0:
					x = j.split('\t')[4*i]
					y = j.split('\t')[4*i+1]
					cumul += float(y)
					result.write(x+','+y+','+str(cumul)+'\n')

def plot(fname):
	figtitle = fname[:-10]
	with open(fname,'r') as source:
		dataraw = source.readlines()
	for i in range(0, len(dataraw)-1):
		x = float(dataraw[i].strip().split(',')[0])
		y = float(dataraw[i].strip().split(',')[1])
	with open('gpl_temp.plt','w') as gTemp:
		gTemp.write("set term png\n")
		gTemp.write("set output \"%s.png\"\n" %fname[:-10])
		gTemp.write("set datafile separator \",\"\n")
		gTemp.write("set title \"%s\"\n"%figtitle)
		gTemp.write("set xlabel \"D (nm)\"\n")
		gTemp.write("set ylabel \"N%\"\n")
		gTemp.write("set yrange [0:110]\n")
		gTemp.write("set grid\n")
		gTemp.write("set logscale x\n")
		gTemp.write("set style fill solid 0.4 border\n")
		#gTemp.write("set multiplot\n")
		gTemp.write("plot \"%s\" using 1:2 \"%%lf,%%lf\" title \"\" with boxes, \"\" using 1:3  title \"\" with line\n"%(fname))
		#gTemp.write("replot \"%s\" using 1:3 title \"\" with line\n"%(fname))
		gTemp.write("set output\n")
	p=subprocess.call("gnuplot gpl_temp.plt")


txtdir = os.listdir(os.getcwd())
for i in txtdir:
	if i[-4:] == '.txt':
		transcribe(i)
		plot(i[:-4]+'_trans.csv')
