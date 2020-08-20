import pydicom
import os
from PIL import Image

numImg = 0
images = []

for root, dirs, files in os.walk(os.getcwd()):
    for name in files:
        try:
            dcmobj = pydicom.dcmread(name)
            numImg += 1
            Im = Image.fromarray(dcmobj.pixel_array**0.7).convert('P') 
            images.append(Im)
        except (pydicom.errors.InvalidDicomError, FileNotFoundError):
            pass
        
images[0].save('animated.gif',
               save_all=True, append_images=images[1:], optimize=False, duration=40, loop=0)