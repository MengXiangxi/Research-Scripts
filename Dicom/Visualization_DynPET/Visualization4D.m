function [stack, Tframe] = Visualization4D(frm4d, dt, info, option)
% Export consecutive MIPs from 4D dynamic PET
%
% stack - A 3D matrix via stacking the consecutive MIPs
% Tframe - Time point at each layer of MIP
%
% frm4d - The 4D dynamic imaging data
% dt - The frame time and duration array in seconds [frame middle time,
% duration]
% info - A struct
% info.PixelSpacing - Pixel spacing between pixels in the same layer
% info.SliceSpacing - Slice thickness of the original 4D data
% option - visualization options
% option.rotate - How many times the patient rotates during the period of
% visualization, default 0.
% option.nframe - How many frames will it be in the final stack, default
% 300.
% option.nT - Number of original time points in dt used to visualize, 0 for
% default value of using all time points in dt.
% option.px - The pixels in the height direction of the output serious,
% determining the image resolution, 0 for defualt value which is the same
% as the input image.

% On optional variable
if nargin<4
    option.rotate = 0;
    option.nframe = 300;
    option.nT = 0;
    option.px = 0;
end

% Unpack struct info
pixel_spacing = info.PixelSpacing;
slice_spacing = info.SliceSpacing;

% Unpack struct option
rotate = option.rotate;
nframe = option.nframe;
nT = option.nT;
px_height = option.px;

% Default value processing for nT and px_height
if nT == 0
    nT = length(dt)-1;
end
if px_height == 0
    px_height = size(frm4d,4);
end

% Processing the output time points
Tmax = dt(nT,1)+0.5*dt(nT,2);
Tframe = (1:Tmax/nframe:Tmax)'-1;

% Processing the various dimensions
row = size(frm4d,2);
column = size(frm4d,3);
height = size(frm4d,4);
% The max width when rotating the volume is generated at the diagonal.
diagonal = ceil(sqrt(row^2+column^2));
% px_height = output height, px_width = output width
% aspect ratio is adjusted according to pixel spacing and slice thickness
px_width = ...
    round((px_height*diagonal*pixel_spacing)/(height*slice_spacing));

% Print information
fprintf("Now the dynamic PET movie is being prepared...\n");
fprintf("The original dimension is %d x %d x %d, ", column, row, height);
fprintf("and the original number of frames is %d.\n",size(frm4d,1));
fprintf("The full duration is %.0f s, ", dt(end,1)+0.5*dt(end,2));
fprintf("and the first %.0f s are to be visualized.\n", Tmax);
fprintf("The output dimension will be %d x %d, ", px_width, px_height);
fprintf("and there will be a total of %.0f frames.\n", nframe);
fprintf("The duration between two output frames is %.2f s.\n",...
    Tmax/nframe);
if rotate == 0
    fprintf("The MIP will not rotate during the process.\n")
else
    fprintf("The MIP will rotate %d rounds during the process.\n", rotate)
end
% Interpolate the original image into the time points specified
disp("Interpolation in progress...")
tic
frmInterp = interpn(dt(:,1), frm4d, Tframe);
toc

% Preliminary output matrix
mipInterp = zeros(nframe, px_height, px_width);

% MIP generation
h=waitbar(0,'please wait');
for ii = 1:size(frmInterp,1)
    rotate_frame = 360*rotate*ii/nframe; % rotate parameter
    mip_frame = MIPz(squeeze(frmInterp(ii,:,:,:)), rotate_frame, 1);
    % Pad smaller images so that all images are in the same width
    mip_padded = superpadding(mip_frame, [height, diagonal]);
    mipInterp(ii,:,:) = imresize(mip_padded, [px_height, px_width]);
    waitbar(ii/size(frmInterp,1), h, ...
        sprintf("MIP generation in progress %d/%d",ii, size(frmInterp,1)))
end
delete(h)

% Alter the order of indices
stack = permute(mipInterp,[2,3,1]);
disp("MIP generation done!")
end

function padded = superpadding(original, newsize)
% Zero pad the original image into a new size
oldsize = size(original);
padsize = ceil((newsize-oldsize)./2);
padded_temp = padarray(original, padsize);
% crop the upper left corner, if needed
padded = padded_temp(1:newsize(1),1:newsize(2));
end