clear;
load("c_string.mat");
load('Fig_3k.mat');

suffix = [1,5,8];
Dissipation = [4.6875e-3, 4.702e-3, 5.4095e-3];
L_select = 0.4*pi;
T = 20;

fig = figure();
hold on
for i = 1: length(suffix)
    % load(['..\..\Filipo_Guido_data\25monopole_240705\S3_120frames_0.8pi\StrucFun_3rd_f2.5e1_t5_ang_',num2str(suffix(i)),'_16_long_0.8pi.mat']);

    plot(r/1,(dlll_full - dlll_mean)./Dissipation(i)./1,'linewidth',1);
    % plot(r/pi,(dlll_full)./Dissipation(i)./pi,'linewidth',0.8);

end

colororder({c_string{5}{1},c_string{6}{3},c_string{51}{4}});

axis([0 1.5 -0.15 0.25]);

xlb = xlabel('r/W');
ylb = ylabel('S_3/2\nu\OmegaW');

set(gca,'FontName','Arial',...
    'FontSize',7,...
    'FontUnits','Points',...
    'Units','centimeters',...
    'Position',[1.5,1.5,4,4],...
    'YDir','normal',...
    'Box','on',...
    'Units','centimeters',...
    'looseInset',[0,0,0,0]...
    );
ax = gca;
ax.YTick = -0.1:0.1:0.2;
ax.PlotBoxAspectRatio = [4,3,1];

