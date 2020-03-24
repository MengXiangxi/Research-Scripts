import pydicom
import matplotlib.pyplot as plt
import os

def export_png(dcmimg, filepath):
    plt.axis('off')
    plt.imsave(os.path.join(filepath, dcmimg.SeriesDescription+'.png'), dcmimg.pixel_array)

def export_png_MIP(dcmimg, filepath):
    plt.axis('off')
    plt.imsave(os.path.join(filepath, dcmimg.SeriesDescription+'.png'), dcmimg.pixel_array, cmap ='gray_r')

for root, dirs, files in os.walk(os.getcwd()):
    for fname in files:
        try:
            dcmimg = pydicom.dcmread(os.path.join(root, fname))
            if ('MIP' in dcmimg.SeriesDescription):
                export_png_MIP(dcmimg, root)
            else:
                export_png(dcmimg, root)
            print(fname)
        except:
            pass