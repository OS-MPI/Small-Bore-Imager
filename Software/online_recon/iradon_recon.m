function [IR_crop, proj_mag_crop_bc] = iradon_recon(cropramppts,num_proj,RXmag,RXphase,angles,LPF_cut,enable_2nd_bc)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% deg = 180;
% theta = 0:deg/(num_proj-1):deg;
theta = mean(angles);
% theta = theta + 180;

a = cropramppts;
b = cropramppts;
projections_mag_crop = RXmag(1+a:end-b,:); 
projections_phase_crop = RXphase(1+a:end-b,:); 

% Old Moving average Filter definition
% filter_width = ones(1, 10)/10;

% Filter raw data
%projections_mag_crop = filter(filter_width, 1, projections_mag_crop);
%projections_phase_crop = filter(filter_width, 1, projections_phase_crop);

projections_complex_crop = projections_mag_crop.*exp(1i*projections_phase_crop);

baseline_correction = mean(mean(projections_complex_crop(1:4,:)));
%baseline_correction = 0+1i*0;

proj_mag_crop_bc  = abs(projections_complex_crop-baseline_correction);

% Filter baseline corrected data
%proj_mag_crop_bc = filter(filter_width, 1, proj_mag_crop_bc);
proj_mag_crop_bc = LPF(proj_mag_crop_bc,100,LPF_cut);

if enable_2nd_bc ==1
    %Second baseline corretion
    xmax = length(proj_mag_crop_bc(:,1));
    m = proj_mag_crop_bc(end,:)/xmax;
    x = linspace(0,xmax-1,xmax);
    m = repmat(m,xmax,1);
    x = repmat(x,num_proj,1);
    bc2 = (m.*x');
    proj_mag_crop_bc = (proj_mag_crop_bc - bc2);
end;

IR_crop = iradon(proj_mag_crop_bc,theta,'linear',...
    'Ram-Lak',1,length(proj_mag_crop_bc(:,1)));

end

