close all
clear

% user defined
WL_file = '2020 十二月 31 23_49_52.tif';
WL_range = [0, 30000];
FL_file = '2020 十二月 31 23_46_58.tif';
FL_range = [3000, 10000];
fname = 'Merged';
cmap = hotiron;

% read files
WL = imread(WL_file);
FL = imread(FL_file);

% rotate files, comment if not necessary
WL = imrotate(WL, 180);
FL = imrotate(FL, 180);

% generate a figure in the second monitor
figure('Position', [2000 100 900 900])

% the white light background
ax_WL = axes;
imagesc(WL)
colormap(ax_WL, 'gray')
caxis(ax_WL, WL_range)

% the fluorescence color overlay
ax_FL = axes;
imagesc(ax_FL, FL, 'alphadata', FL>FL_range(1))
colormap(ax_FL, cmap)
ax_FL.Visible = 'off';
caxis(ax_FL, FL_range)
linkprop([ax_WL, ax_FL], 'Position');

axis(ax_FL, 'equal')
axis(ax_WL, 'equal')
axis(ax_FL, 'off')
axis(ax_WL, 'off')
%colorbar

% export
export_fig(sprintf("%s.png",fname), "-transparent", "-native")
