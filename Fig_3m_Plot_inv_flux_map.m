%
% clear;
% % addpath(genpath('C:\Users\xinyu\Documents\MATLAB_master\MatLab_Toolbox'));
% % load('redblue.mat');
% load('c_string.mat');
% color1 = c_string{18}{5};
% 
% load('..\..\Filipo_Guido_data\25monopole_240705\Data_f2.5e1_t5_ang_1_16.mat');
% Dissipation_series = [5.1877e-3, 4.9242e-3, 4.69e-3, 4.52e-3, 4.47e-3, 4.53e-3,...
%     4.702e-3, 4.9316e-3, 5.1807e-3, 5.4e-3, 5.5913e-3, 5.711e-3];
% Dissipation = Dissipation_series(3);
% 
% Frame_select = 13;
% u = u_save(:,:,Frame_select);
% v = v_save(:,:,Frame_select);
% 
% %
% d0 = mean(diff(x));
% L = pi*0.26;
% Wp=2*d0/L;
% sigma = 0.4;
% 
% padding = 0;
% 
% u2=sharpfilt2(u,Wp,sigma,1,padding);
% v2=sharpfilt2(v,Wp,sigma,1,padding);
% 
% % subgrid stress
% uu5 = sharpfilt2((u - u2).*(u - u2),Wp,sigma,1,padding);
% vv5 = sharpfilt2((v - v2).*(v - v2),Wp,sigma,1,padding);
% uv5 = sharpfilt2((u - u2).*(v - v2),Wp,sigma,1,padding);
% 
% [u2x,u2y]=gradient(u2,x,y);
% [v2x,v2y]=gradient(v2,x,y);
% 
% QQ_s = -1 * (uu5.*u2x + vv5.*v2y + uv5.*(u2y+v2x));
%%
clear;
load('Fig_3m.mat');
% plotting
fig = figure();
hold on

select_region = 1:512;
imagesc(x(select_region)/pi,y(select_region)/pi,QQ_s(select_region,select_region)/Dissipation);
% RedBlue = redblue_v2(384,0.5);
colormap(RedBlue);
% clb = colorbar;
clim([-0.6 0.6]);

select_2 = 1:6:512;
quiver(x(select_2)/pi,y(select_2)/pi,u(select_2,select_2)*0.1,v(select_2,select_2)*0.1,...
    'off','color',color1,'LineWidth',0.25);

hold off

% axis([0 2 0 2]);
axis([0.6 1.4 0.6 1.4]);
% xlb = xlabel('$x/\pi$');
% ylb = ylabel('$y/\pi$');
% ttl = title(['Energy flux (filter a quarter domain size) for index ',num2str(Current_Index)]);
% set([xlb,ylb],'interpreter','latex');

ax = gca;

set(gca,'xtick',[], ...
    'ytick',[], ...
    'xticklabel',[], ...
    'yticklabel',[]);

set(gca,'FontName','Arial',...
    'FontUnits','Points',...
    'FontSize',7,... 
    'Units','centimeters',...
    'Position',[1,1,2.5,2.5],...
    'Visible','on',...
    'YDir','normal',...
    'Box','on',...
    'linewidth',0.3,...
    'Units','centimeters',...
    'looseInset',[0,0,0,0]...
    );
ax.PlotBoxAspectRatio = [1,1,1];
pos = tightPosition(ax);
pos_out = ax.OuterPosition;