%% plot results in a series
clear;

suffix = [1,5,8];
Dissipation = [4.6875e-3, 4.702e-3, 5.4095e-3];
load('c_string.mat');
load('Fig_3j.mat');

L_scale = 1;

fig = figure();
hold on

for i = 1:length(suffix)

    load(['..\..\Filipo_Guido_data\25monopole_240705\Q_120frames_0.8Pi\Q_mean_f2.5e1_t5_ang_',num2str(suffix(i)),'_16_0.8pi_width_long.mat']);

    QQ_mean_save(i,:) = mean(QQ_mean,1)/Dissipation(i);

    plot(L_all/L_scale,mean(QQ_mean,1)/Dissipation(i),'linewidth',1);

end

colororder({c_string{5}{1},c_string{6}{3},c_string{51}{4}});

xlb = xlabel('L/W');
ylb = ylabel('\langle\Pi_S^{(L)}\rangle/2\nu\Omega');
axis([0 1.5 -0.12 0.07]);

% lgd = legend('\theta = \pi/16',...
%     '\theta = 5\pi/16',...
%     '\theta = 9\pi/16',...
%     'location','east');
% legend boxoff

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
ax.YTick = -0.1:0.05:0.05;
ax.PlotBoxAspectRatio = [4,3,1];








