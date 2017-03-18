import os
import subprocess
#p = subprocess.Popen("gnuplot test.plt", shell = True)
#os.waitpid(p.pid, 0)

def transcribe(fname):
    with open(fname+'.csv','r') as fin,\
        open(fname+'_trans.dat','w') as fout:
        for i in range(1,18):
            fin.readline()
        fout.write(fin.read())

def plot(fname):
    #figtitle = raw_input('The title for file '+fname+'\n')
    figtitle = fname.split('-')[1][:-10]
    xlist = []
    ylist = []
    peakx = 0.0
    peaky = 0.0
    source = open(fname)
    dataraw = source.readlines()
    for i in range(0, len(dataraw)-1):
        try:
            x = float(dataraw[i].strip().split(',')[0])
        except:
            xlist = []
            ylist = []
            peakx = 0.0
            peaky = 0.0
            continue
        y = float(dataraw[i].strip().split(',')[1])
        if (y > peaky and x<1550):
            peaky = y
            peakx = x
        xlist.append(x)
        ylist.append(y)
    with open("gpl_temp.plt",'w') as gTemp:
        gTemp.write("set term png\n")
        gTemp.write("set output \"%s.png\"\n" %fname[:-10])
        gTemp.write("set datafile separator \",\"\n")
        gTemp.write("set title \"%s\"\n"%figtitle)
        gTemp.write("set xlabel \"Wavelength (nm)\"\n")
        gTemp.write("set ylabel \"Intensity (A.U.)\"\n")
        ymin = peaky*-0.15
        gTemp.write("set yrange [%f:]\n"%ymin)
        gTemp.write("set grid\n")
        gTemp.write("set xtic 100\n")
        peakxlabel = str(peakx)
        peakylabel = str(peaky)
        gTemp.write("set label \"(%s,%s)\" at %f,%f offset 1,-1\n"%(peakxlabel,peakylabel,peakx,0))
        gTemp.write("set arrow 1 from %f,0 to %f,%f nohead lc rgb \"blue\"\n"%(peakx,peakx,peaky))
        gTemp.write("plot \"%s\" title \"\" with line\n"%(fname))
        gTemp.write("set output\n")
    #p = subprocess.Popen("gnuplot gpl_temp.plt", shell = True)
    p=subprocess.call("gnuplot gpl_temp.plt")
    with open('record.txt','a') as rec:
        rec.write(fname.split('-')[1][:-10]+','+peakxlabel+','+peakylabel+'\n')
    print('Figure generated.')


# Traverse all the files in the folder
currentdir = os.getcwd()
directory =  os.listdir(currentdir)

with open('record.txt','w') as rec:
    print("Record cleared.")

for filename in directory:
    if filename[-3:] == 'csv':
        transcribe(filename[:-4])
        plot(filename[:-4]+'_trans.dat')
