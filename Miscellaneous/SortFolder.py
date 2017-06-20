import os
import shutil

currentdir = os.getcwd()
directory =  os.listdir(currentdir)
folderlist = []
for filename in directory:
    if filename[-4:] == 'tiff':
        folder = filename.split('_')[0]
        if folder not in folderlist:
            os.mkdir(folder)
            folderlist.append(folder)
        else:
            pass
        shutil.move(filename, folder+'\\'+filename)
