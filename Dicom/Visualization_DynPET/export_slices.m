function export_slices(imgMat, window, cMap, folder, fileNameStem, filetype)
%EXPORT_SLICES Save matrix slices to a series of image files
%
%    Input
%      - imgMat    The 3d matrix.
%      - window    The caxis threshold.
%      - cMap      The colormap.
%      - folder    The output folder
%      - fileNameStep The prefix of the file names.
%      - filetype  The format of the images.

[~, ~, num_of_files] = size(imgMat);

h=waitbar(0, "Please wait");
for ii = 1:num_of_files
    fig = figure();
    set(fig,'visible','off')
    imagesc(imgMat(:,:,ii))
    colormap(cMap)
    caxis(window)
    axis equal
    axis off
    fname = fullfile(folder, sprintf('%s%03d.%s', ...
        fileNameStem, ii, filetype));
    % exportgraphics(fig, fname, 'BackgroundColor','current')
    export_fig(fname, '-native')
    waitbar(double(ii)/double(num_of_files), h, ...
        sprintf("Export in progress %d/%d",ii, num_of_files))
end
delete(h)

end

