function [frm_4d, dt, general_info] =  dcm3d2map4d(fpath)
%DCM3D2MAP4D Read dynamic 3D dicom files into a 4d matrix
%
% Input
%    - fpath    The file path to the 3D dicom folder.
%
% Output
%    - frm_4d   The 4d matrix.
%    - dt       The frame start and frame end times (Nx2 matrix).
%    - general_info The dicom info of the first file.

dirInput = dir(fpath);
dirInput(ismember({dirInput.name},{'.','..'})) = []; % remove hidden folder
fileNames = {dirInput.name}';
fileNames_sort = natsort(fileNames); 
general_info = dicominfo(fullfile(fpath,fileNames_sort{1}));

if general_info.Units ~= "BQML"
    error('DicomUnitError: must be BQML.')
end

imgsize = double([general_info.Rows, general_info.Columns, ...
    general_info.NumberOfFrames]);
total_frame = general_info.NumberOfTimeSlices;

dt = zeros(total_frame, 2);
frm_4d_temp = zeros(total_frame, imgsize(1), imgsize(2), imgsize(3));

h=waitbar(0,'please wait');
for frame_index=1:total_frame
    frame_info = dicominfo(fullfile(fpath, fileNames_sort{frame_index}));
    dt(frame_index, 1) = (frame_info.FrameReferenceTime)/1000;
    dt(frame_index, 2) = (frame_info.ActualFrameDuration)/1000;
    % FrameReferenceTime is defined to be in msec by the DICOM standard
    frm_4d_temp(frame_index,:,:,:) = ...
        double(dicomread(fullfile(fpath, fileNames_sort{frame_index})));
    waitbar(double(frame_index)/double(total_frame), h, ...
        sprintf("Loading 3D DICOM file %d/%d",frame_index, total_frame))
end
delete(h)

frm_4d = frm_4d_temp; %.* general_info.RescaleSlope;
% According to the DICOM specification, bq/mL is obtained by multiplication
% of the pixel value with the RescaleSlope.

end

