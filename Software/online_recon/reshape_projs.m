function [RXmag_projs,RXphase_projs,shift_projs,angle_projs] = reshape_projs(RXmag,RXphase,shift,angles,num_proj,bidirectional_shift, cw)
%reshape Summary of this function goes here
%   Detailed explanation goes here

input_size = size(RXmag);
readouts_per_image = input_size(1,2);
num_pts = readouts_per_image/num_proj;
disp(num_pts);
RXmag_projs = zeros(num_pts,num_proj);
RXphase_projs = zeros(num_pts,num_proj);
shift_projs = zeros(num_pts,num_proj);
angle_projs = zeros(num_pts,num_proj);


for p = 1:num_proj
    tempstart = (p-1)*num_pts+1;
    tempstop = p*num_pts;
    
    RXmag_projs(:,p) = RXmag(tempstart:tempstop);
    RXphase_projs(:,p) = RXphase(tempstart:tempstop);
    shift_projs(:,p) = shift(tempstart:tempstop);
    angle_projs(:,p) = angles(tempstart:tempstop);
    
    shift_slope = shift_projs(end,p)-shift_projs(1,p);
    if bidirectional_shift == 1 && shift_slope > 0
        RXmag_projs(:,p) = flip(RXmag_projs(:,p));
        RXphase_projs(:,p) = flip(RXphase_projs(:,p));
    end
    
    
end

if cw == 1 && bidirectional_shift == 1
    RXmag_projs = flipud(RXmag_projs);
    RXphase_projs = flipud(RXphase_projs);
end
end

