clear;
suffix = -1:1:10;
Dissipation = [5.1877e-3, 4.9242e-3, 4.69e-3, 4.52e-3, 4.47e-3, 4.53e-3,...
    4.702e-3, 4.9316e-3, 5.1807e-3, 5.4e-3, 5.5913e-3, 5.711e-3];
load('c_string.mat');
load('Fig_3j_2.mat');

fig = figure();

hold on

for i = 1:length(suffix)

    % load(['..\..\Filipo_Guido_data\25monopole_240705\Q_50frames_0.8Pi\Q_mean_f2.5e1_t5_ang_',num2str(suffix(i)),'_16_0.8pi_width.mat']);
    % load(['Q_mean_f2.5e1_t5_ang_',num2str(suffix(i)),'_16.mat']);
    mean_QQ = mean(QQ_mean,1);

    QQ_series(i) = mean_QQ(13);

end
plot(suffix/16,QQ_series./Dissipation,'color','k','linewidth',1);

xlb = xlabel('\theta/\pi');
ylb = ylabel('\langle\Pi_S^{(L = 0.8)}\rangle/2\nu\Omega');
axis([-0.1 0.7 -0.12 0.07]);

set(gca,'FontName','Arial',...
    'FontSize',6,...
    'FontUnits','Points',...
    'Units','centimeters',...
    'Position',[1.5,1.5,1.5,1.5],...
    'YDir','normal',...
    'Box','on',...
    'Units','centimeters',...
    'looseInset',[0,0,0,0]...
    );
ax = gca;
% ax.YTick = -0.1:0.05:0.05;
ax.PlotBoxAspectRatio = [4,3,1];