% %% load toolbox path
% clear;
% close;
% % addpath(genpath('C:\Users\xinyu\Documents\MATLAB_master\MatLab_Toolbox'));
% addpath(genpath('X:\Xinyu_Si_X\MATLAB_master\MatLab_Toolbox'));
% crtfd = pwd;
% load('c_string.mat');
% color1 = c_string{50}{1};
% color2 = c_string{5}{6};
% 
% mainfolder = 'E:\Xinyu_Si_Post_data\231201\set5';
% addpath(mainfolder);
% filename = 'difftrack_framewise.gdf';
% Frame = 200;
% 
% iqr_cut = 0; % if 1, apply iqr process to remove outliers
% vel_outlier_ratio=3; % drop particles w/ velocity > 3*iqr
% 
% d0 = 12;
% region = [0 0 1600 1600];
% 
% x_grid = region(1):d0:(region(1) + region(3));
% y_grid = region(2):d0:(region(2) + region(4));
% 
% if mod(numel(x_grid),2) % odd number of elements
%     x_grid=x_grid(1:end-1)+d0/2; % be sure to get an even number
%     x = x_grid;
% else
%     x = x_grid;
% end
% 
% if mod(numel(y_grid),2) % odd number of elements
%     y_grid=y_grid(1:end-1)+d0/2; % be sure to get an even number
%     y = y_grid;
% else
%     y = y_grid;
% end
% 
% [x0,y0] = meshgrid(x,y);
% 
% fps = 60;
% ppcm = 140.3;
% [pvx,pvy,px,py,~]=vp(fullfile(mainfolder,filename),Frame,[],0); % in pixel per frame
% 
% if iqr_cut
%     pvv = sqrt(pvx.^2 + pvx.^2); % velocity magnitude of this frame
%     pviqr = iqr(pvv); % interquarter range of pv
%     good = pvv < vel_outlier_ratio * pviqr;
%     if sum(~good)>0
%         disp(['Dropping ' num2str(sum(~good)) ...
%             ' outlier particle(s) from frame ' num2str(Frame) '.'])
%     end
%     pvx_grid = griddata(px(good),py(good),pvx(good),x0,y0,'cubic');
%     pvy_grid = griddata(px(good),py(good),pvy(good),x0,y0,'cubic');
% else
%     pvx_grid = griddata(px,py,pvx,x0,y0,'cubic');
%     pvy_grid = griddata(px,py,pvy,x0,y0,'cubic');
% end
% pvx_grid(isnan(pvx_grid)) = 0;
% pvy_grid(isnan(pvy_grid)) = 0;
% 
% % save pvx and pvy
% u = pvx_grid; % in pix/frame
% v = pvy_grid; 
% 
% %
% L = ppcm*3;
% Wp=2*d0/L;
% sigma = 0.8;
% 
% padding = 0;
% 
% u2=sharpfilt2(u,Wp,sigma,1,padding);
% v2=sharpfilt2(v,Wp,sigma,1,padding);
% 
% [u2x,u2y]=gradient(u2,x,y);
% [v2x,v2y]=gradient(v2,x,y);
% 
% % subgrid stress
% uu5 = sharpfilt2((u - u2).*(u - u2),Wp,sigma,1,padding);
% vv5 = sharpfilt2((v - v2).*(v - v2),Wp,sigma,1,padding);
% uv5 = sharpfilt2((u - u2).*(v - v2),Wp,sigma,1,padding);
% 
% QQ_s = -1 * (uu5.*u2x + vv5.*v2y + uv5.*(u2y+v2x));
% 
% trace_of_stress = 0.5*(uu5)+0.5*(vv5); % mean of trace of stress tensor (tau_ijs)
% 
% % -=- Eigenvalue and Eigenvector of stress tau_ij
% for i = 1:size(QQ_s,1)
%     for j=1:size(QQ_s,2)
%         stress=[uu5(i,j)-trace_of_stress(i,j), uv5(i,j);...
%             uv5(i,j), vv5(i,j)-trace_of_stress(i,j)]; % traceless
%         eigval_stress(i,j)=max(abs(eig(stress)));
% 
%         [V,D] = eig(stress);
%         eig_vec = V(:,diag(D)==max(diag(D)));
%         eigvec_stress(i,j) = atan(eig_vec(2)/eig_vec(1));
%     end
% end
% 
% 
% % region_window = [0 1600 0 1600]; %[left,right,bottom,top]
% region_window = [360 1400 280 1320];
% x_select = x_grid>=region_window(1) & x_grid<=region_window(2);
% y_select = y_grid>=region_window(3) & y_grid<=region_window(4);
% v_cut = v(y_select',x_select);
% u_cut = u(y_select',x_select);
% v2_cut = v2(y_select',x_select);
% u2_cut = u2(y_select',x_select);
% eigvec_stress_cut = eigvec_stress(y_select',x_select);
% 
% x_plot = x(x_select);
% x_plot = x_plot - x_plot(1) + d0/2;
% y_plot = y(y_select);
% y_plot = y_plot - y_plot(1) + d0/2;
% %
% Down_Samp = 1:2:length(x_plot);
% Down_Samp_2 = 1:6:length(x_plot);
% 
% U = sqrt(mean(u_cut.^2 + v_cut.^2,'all'));
% U_unit = U*fps/ppcm;
% 
% %
% MatObj = matfile(fullfile(mainfolder,'vp_int.mat'));
% FrameRange = 10:10:4500;
% mean_u = MatObj.mean_u*fps/ppcm;
% mean_v = MatObj.mean_v*fps/ppcm;
% % u = MatObj.pvx(:,:,FrameRange)*fps/ppcm;
% v_fulldata = MatObj.pvy(:,:,FrameRange)*fps/ppcm;
% mean_v_cut = mean_v(y_select',x_select);
% mean_u_cut = mean_u(y_select',x_select);
% v_fulldata_cut = v_fulldata(y_select',x_select,:);
% v_fulldata_cut = num2cell(v_fulldata_cut,[1,2]);
% v_fulldata_cut = vertcat(v_fulldata_cut{:});

%%
clear;
load('Fig_2c.mat');
L_scale = range(x_plot)/2;
fig = figure(); hold on

yyaxis right

% u2_interp = pvx -  interp2(x0,y0,u2,px,py,'cubic');
% v2_interp = pvy -  interp2(x0,y0,v2,px,py,'cubic');
% 
% x_vel = px(px>region_window(1) & px < region_window(2) & py > region_window(3) & py < region_window(4));
% y_vel = py(px>region_window(1) & px < region_window(2) & py > region_window(3) & py < region_window(4));
% x_vel = x_vel - region_window(1);
% y_vel = y_vel - region_window(3);
% u2_plot = u2_interp(px>region_window(1) & px < region_window(2) & py > region_window(3) & py < region_window(4));
% v2_plot = v2_interp(px>region_window(1) & px < region_window(2) & py > region_window(3) & py < region_window(4));
% rng(3);
% sample_idx = randsample(1:length(x_vel),2000);
% quiver(x_vel(sample_idx)/L_scale,y_vel(sample_idx)/L_scale, ...
%     u2_plot(sample_idx)*0.03,v2_plot(sample_idx)*0.03, ...
%     'off','-','LineWidth',0.5,'color',[1,1,1]*0.3);

quiver(x_plot(Down_Samp)/L_scale,y_plot(Down_Samp)/L_scale,...
    (u_cut(Down_Samp,Down_Samp)/ppcm*fps - u2_cut(Down_Samp,Down_Samp)/ppcm*fps)*0.1,...
    (v_cut(Down_Samp,Down_Samp)/ppcm*fps - v2_cut(Down_Samp,Down_Samp)/ppcm*fps)*0.1,...
    'off','-','LineWidth',0.5,'Color',[1,1,1]*0.3);

quiver(x_plot(Down_Samp_2)/L_scale,y_plot(Down_Samp_2)/L_scale,...
    cos(eigvec_stress_cut(Down_Samp_2,Down_Samp_2))*0.07,...
    sin(eigvec_stress_cut(Down_Samp_2,Down_Samp_2))*0.07,...
    'off','-','LineWidth',0.5,'Color','r');
quiver(x_plot(Down_Samp_2)/L_scale,y_plot(Down_Samp_2)/L_scale,...
    -cos(eigvec_stress_cut(Down_Samp_2,Down_Samp_2))*0.07,...
    -sin(eigvec_stress_cut(Down_Samp_2,Down_Samp_2))*0.07,...
    'off','-','LineWidth',0.5,'Color','r');

axis([0 2 0 2]);
xlb = xlabel('x/W');
ylb = ylabel('y/W');

% % Define the desired x-axis tick locations
% tick_locations = 2:2:10;
% 
% % Set the x-axis tick locations and labels
% xticks(tick_locations);
% xticklabels(arrayfun(@num2str, tick_locations-2, 'UniformOutput', false));
% yticks(tick_locations);
% yticklabels(arrayfun(@num2str, tick_locations-2, 'UniformOutput', false));

% Set the color of the x-axis
ax = gca; % Get current axes
ax.XColor = 'k'; % Set x-axis color to red
% Set the color of the y-axis
ax.YColor = 'k'; % Set y-axis color to green

fillpatch_x = [x_plot,flip(x_plot)];
fillpatch_y = [mean(mean_v_cut)+std(v_fulldata_cut),flip(mean(mean_v_cut)-std(v_fulldata_cut))];
yyaxis left
fill(fillpatch_x/L_scale,fillpatch_y/U_unit,'b','FaceColor',color2,'FaceAlpha',0.4,'EdgeColor','none');
plot(x_plot/L_scale,mean(mean_v_cut)/U_unit,'-','linewidth',0.5,'Color',color2);

% axis([0 2 -1.5 1.5]);
% ylb2 = ylabel('v (cm/s)');

axis([0 2 -2 2]);
ylb2 = ylabel('v/U');

% Set the color of the x-axis
ax = gca; % Get current axes
ax.XColor = 'k'; % Set x-axis color to red
% Set the color of the y-axis
ax.YColor = 'k'; % Set y-axis color to green


% set(gcf,'MenuBar','figure',...
%     'Units','centimeters',...
%     'Position',[10,10,7,6],...
%     'Resize',0,...
%     'PaperUnits','centimeters',...
%     'PaperSize',[5 5]);

ax = gca;
set(gca,'FontName','Arial',...
    'FontUnits','Points',...
    'FontSize',7,...
    'Units','centimeters',...
    'Position',[1,1,4,4],...
    'YDir','normal',...
    'Box','on',...
    'Units','centimeters',...
    'looseInset',[0,0,0,0]...
    );
ax.PlotBoxAspectRatio = [1,1,1];
pos = tightPosition(ax);