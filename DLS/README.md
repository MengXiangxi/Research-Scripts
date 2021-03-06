Many labs own Malvern ZetaSizer products, but the data export is always a problem. Nobody loves the low-resolution original output images and the built-in tool to automatically export the data is generates terrible results.The general method of exportation can be found in the user manual, and it is described in Chapter 11. You can follow [this](http://www.biophysics.bioc.cam.ac.uk/files/Zetasizer_Nano_user_manual_Man0317-1.1.pdf) link to obtain a full text.

However, for size measurement, you can actually export a "size/volume/intensity distribution table" every time you conduct a measurement.  Albeit the terrible format it produces, this is the most favorable practice in the labs that I have worked in. To view it, you first need to turn on the panel/tab in **Tool>>Setting>>Configure Workspace>>Size**, and in the tab **Report Pages**, check **Number Stats Table (M)**. Then after each measurement, just drag/copy the table to a .txt file and save it to your flash disk. Remember, one measurement in each file.

The file looks like this:
![](https://3.bp.blogspot.com/-goiLo0hoCUE/WMxHm8kQ3AI/AAAAAAAAAFM/CZaTQV-TaUU6LA10nEiew_rIYfoEWkGjQCLcB/s1600/dls1.png)

It seems to be a poorly formatted, tab separated file which is extremely unfriendly to the graph editing software.

I used to manually cut and paste and use Excel as well as some more specific data analysis software to visualize the data. Recently I am generating a large number of results, so I decided to write a script to process them.

Here is the Python-Gnuplot script. To run it on Windows, you need to first install python (for some reason, I am still using Python 2.7, but I believe it is also compatible with Python 3), Gnuplot and add their directory in %PATH%. Just check "add to %PATH%" options  when you install these softwares.

Then, put all the .txt files in the same directory, download [this](https://github.com/MengXiangxi/Research-Scripts/blob/master/DLS/NanoSizer_dist_visualize.py) script file to the same directory and run it. A png figure will be generated for each .txt file in this directory, and it looks just like this one:
![](https://3.bp.blogspot.com/-X9_E6HFreq4/WMxNBn4yNtI/AAAAAAAAAFk/DmC7M9tN4x4YpMMi8xgXiB_gKOHMXNXgACLcB/s1600/filename.png)

In the meantime, another .csv file is generated. You can import this file into other software for a further analysis.
