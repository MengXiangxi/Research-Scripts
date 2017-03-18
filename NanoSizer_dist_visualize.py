#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""NanoSizer distribution visualizer

A python script to plot the DLS results with Gnuplot. It depends on Gnuplot.
"""
import os
import subprocess # subprocess is used to operate Gnuplot

def transcribe(fname):
	cumul = 0.0 # To calculated the cumulative fraction
	with open(fname,'r') as source,\
		 open(fname[:-4]+'_trans.csv','w') as result:
		content = source.readlines()
		del content[0:2] # The first three lines are useless headers
		for i in range(0,3): # The cols 0:1, 4:5, 8:9, 12:13 are useful
			for j in content: # Traverse the lines
				if len(j.split('\t')[4*i])>0:
				# Delete empty items at the end of the table
					x = j.split('\t')[4*i]
					y = j.split('\t')[4*i+1]
					cumul += float(y)
					result.write(x+','+y+','+str(cumul)+'\n')
					# Write into transcribed file

def plot(fname):
	figtitle = fname[:-10]
	with open(fname,'r') as source:
		dataraw = source.readlines()
	for i in range(0, len(dataraw)-1): # Last line should be empty
		x = float(dataraw[i].strip().split(',')[0])
		y = float(dataraw[i].strip().split(',')[1])
	with open('gpl_temp.plt','w') as gTemp: # gTemp is a Gnuplot script
		gTemp.write("set term png\n") # Set terminal/output format
		gTemp.write("set output \"%s.png\"\n" %fname[:-10])
		gTemp.write("set datafile separator \",\"\n") # To deal with csv
		gTemp.write("set title \"%s\"\n"%figtitle)
		gTemp.write("set xlabel \"D (nm)\"\n")
		gTemp.write("set ylabel \"N%\"\n")
		gTemp.write("set yrange [0:110]\n") # y never larger than 100
		gTemp.write("set grid\n")
		gTemp.write("set logscale x\n") # x in log scale
		gTemp.write("set style fill solid 0.4 border\n") # Formatting the fig.
		gTemp.write("plot \"%s\" using 1:2 \"%%lf,%%lf\" title \"\" with boxes, \"\" using 1:3  title \"\" with line\n"%(fname))
		# Plot the boxes as well as the cumulative curve.
		gTemp.write("set output\n") # Save
	p=subprocess.call("gnuplot gpl_temp.plt")
	# This is used to run the Gnuplot script in Windows


txtdir = os.listdir(os.getcwd())
for i in txtdir: # Traverse the files in the folder
	if i[-4:] == '.txt':
		transcribe(i) # First transcribe them in a better format
		plot(i[:-4]+'_trans.csv') # Then plot them
