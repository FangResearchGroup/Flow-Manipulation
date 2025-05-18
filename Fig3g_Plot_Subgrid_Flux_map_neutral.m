% clear;
% 
% % mainfolder = 'X:\Xinyu_Si_X\231201\set12';
% mainfolder = 'E:\Xinyu_Si_Post_data\231201\set12';
% load([mainfolder,'\FST_3cm.mat']);
% load('redblue.mat');
% load('c_string.mat');
% color1 = c_string{18}{5};
% 
% load('Dissipation_240624.mat');
% 
% ppcm = 140.3;
%
clear;
load("Fig_3g.mat");
fig = figure();
hold on

select_region = 25:111;
imagesc(x(select_region)/ppcm,y(select_region)/ppcm,Q_s_record(select_region,select_region,15)/2/Dissipation(5));
colormap(RedBlue);colormap(RedBlue);

FrameNum = 150;
    
% [pvx,pvy,px,py,~]=vp(fullfile(mainfolder,'difftrack_framewise.gdf'),FrameNum,[],0);

good = randsample(length(pvx),5000);
quiver(px(good)/ppcm,py(good)/ppcm,pvx(good)*0.12,pvy(good)*0.12,'off','color',color1,'LineWidth',0.25);

hold off

% clb = colorbar;
% clim([-0.04 0.04]);

RedBlue = redblue_v2(384,0.5);
% RedBlue = redblue(384,0.5);
colormap(RedBlue);
clb = colorbar;
% clim([-0.04 0.04]);
clim([-0.6 0.6]);
clb.Ticks = -0.6:0.3:0.6;
clb.Location = 'southoutside';
clb.Box = 'off';

axis([x(select_region(1))/ppcm x(select_region(end))/ppcm y(select_region(1))/ppcm y(select_region(end))/ppcm]);

ax = gca;

set(gca,'xtick',[], ...
    'ytick',[], ...
    'xticklabel',[], ...
    'yticklabel',[]);

set(gca,'FontName','Arial',...
    'FontUnits','Points',...
    'FontSize',7,... 
    'Units','centimeters',...
    'Position',[1,1.5,2.5,2.5],...
    'Visible','on',...
    'YDir','normal',...
    'Box','on',...
    'linewidth',0.3,...
    'Units','centimeters',...
    'looseInset',[0,0,0,0]...
    );
ax.PlotBoxAspectRatio = [1,1,1];
pos = tightPosition(ax);