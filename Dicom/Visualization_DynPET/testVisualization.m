[frm4d, dt, dcminfo] = dcm2map4d("E:\JR11\20210331\Wang Yanhua_F-JR11-PMR-054_082522\Image\pet_abodmen_Dyn0_10");
cmap = CmapDCM;

% Pack info
info.PixelSpacing = dcminfo.PixelSpacing(1);
info.SliceSpacing = dcminfo.SliceThickness;

% Specify rotate
option.rotate = 1;
option.nframe = 300;
option.nT = 25;
option.px = 360;

% Visualize
Tseq = Visualization4D(frm4d, dt, info, option);
imagesc3s(Tseq, 'hot', [0,50000], 1)
close

export_slices(Tseq, [0,50000], cmap.HOT_IRON, 'D:\OneDrive - pku.edu.cn\Research\Conferences\20220112SNMMI2022\Presentation\Figures\DynResult', 'Output_', 'png')

%%% magick convert -delay 10 -loop 0 *.png animated.gif
%---OR---%
%%% ffmpeg -framerate 30 -pattern_type glob -i 'Output_%3d.png' -c:v libx264 -pix_fmt yuv420p out.mp4