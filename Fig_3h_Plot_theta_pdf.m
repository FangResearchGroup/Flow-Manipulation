%
clear;

suffix = [1,5,8];
Dissipation = [4.6875e-3, 4.702e-3, 5.5913e-3];
load('c_string.mat');
load('Fig_3h.mat');

L_scale = 1;

fig = figure();
hold on

for i = 1:length(suffix)

    % load(['..\..\Filipo_Guido_data\25monopole_240705\theta_50frames_0.8pi\theta_f2.5e1_t5_ang_',num2str(suffix(i)),'_16_0.8pi_width_hist.mat']);

    plot(0.5*(edge(1:end-1) + edge(2:end)),N,'-','linewidth',1);

end

colororder({c_string{5}{1},c_string{6}{3},c_string{51}{4}});

xlb = xlabel('\theta^{(L)}/\pi');
ylb = ylabel('pdf');
xlim([0 0.5])

set(gca,'FontName','Arial',...
    'FontSize',7,...
    'FontUnits','Points',...
    'Units','centimeters',...
    'Position',[1,1,4,4],...
    'YDir','normal',...
    'Box','on',...
    'Units','centimeters',...
    'looseInset',[0,0,0,0]...
    );
ax = gca;
ax.PlotBoxAspectRatio = [4,3,1];