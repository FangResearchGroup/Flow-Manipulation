%
clear;
load("c_string.mat");
load('Fig_3i.mat');

suffix = [1,5,8];
Dissipation = [4.6875e-3, 4.702e-3, 5.4095e-3];
L_select = 0.8;
T = 20;

fig = figure();
hold on
for i = 1:length(suffix)

    load(['..\..\Filipo_Guido_data\25monopole_240705\Q_120frames_0.8Pi\Q_mean_f2.5e1_t5_ang_',num2str(suffix(i)),'_16_0.8pi_width_long.mat']);
    [~,L_loc] = min(abs(L_all - L_select));
    Q_select = QQ_mean(:,L_loc);

    plot((1:size(Q_select,1))/T,Q_select(1:end)./Dissipation(i),'linewidth',1);

end

colororder({c_string{5}{1},c_string{6}{3},c_string{51}{4}});

axis([0 6 -0.2 0.15]);

xlb = xlabel('t/T');
ylb = ylabel('\Pi_S^{(L)}/2\nu\Omega');

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
ax.XTick = 0:2:6;
ax.YTick = -0.2:0.1:0.1;
ax.PlotBoxAspectRatio = [4,3,1];