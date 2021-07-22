import zipfile
import os

def walk(top, maxdepth):
    dirs, nondirs = [], []
    for name in os.listdir(top):
        (dirs if os.path.isdir(os.path.join(top, name)) else nondirs).append(name)
    yield top, dirs, nondirs
    if maxdepth > 1:
        for name in dirs:
            for x in walk(os.path.join(top, name), maxdepth-1):
                yield x


def zipDir(dirpath, outFullName):
    """
    压缩指定文件夹
    :param dirpath: 目标文件夹路径
    :param outFullName: 压缩文件保存路径+xxxx.zip
    :return: 无
    """
    zip = zipfile.ZipFile(outFullName, "w", zipfile.ZIP_DEFLATED)
    for path, dirnames, filenames in os.walk(dirpath):
        # 去掉目标跟路径，只对目标文件夹下边的文件及文件夹进行压缩
        fpath = path.replace(dirpath, '')
 
        for filename in filenames:
            zip.write(os.path.join(path, filename), os.path.join(fpath, filename))

for seqs in walk("./", 2):
    if (len(seqs[0])>2):
        for seq in seqs[1]:
            source = os.path.join(seqs[0], seq)
            destin = './'+seq+'.zip'
            zipDir(source, destin)