clear;
addpath(genpath('X:\Xinyu_Si_X\MATLAB_master\MatLab_Toolbox'));
crtfd = pwd;
load('c_string.mat');
load('Fig_3b.mat');

mainfolder = {'E:\Xinyu_Si_Post_data\231201\set1',...
    'E:\Xinyu_Si_Post_data\231201\set3',...
    'E:\Xinyu_Si_Post_data\231201\set8',...
    'E:\Xinyu_Si_Post_data\231201\set6',...
    'E:\Xinyu_Si_Post_data\231201\set12',...
    'E:\Xinyu_Si_Post_data\231201\set9',...
    };

load('Dissipation_240624.mat');  % from nu*omege^2, in folder order [ 1 3 8 6 12 9];

fig = figure();
hold on

fps = 60;
ppcm = 140.3;
L_select = 3 * ppcm;

T = 6; % the period of rod movement (unit in second)

linetype_all = {'--','-.',':','-','-','-'};

for i = 1: length(mainfolder)
    % load(fullfile(mainfolder{i},'FST_avg.mat'));
    % [~,L_loc{i}] = min(abs(L - L_select));
    % Q_select{i} = Q_s_mean_save;
    if i == 2 || i == 3 || i == 1
        Q_select = Q_select(1:15:end,:);
        plot((1:size(Q_select{i},1))/(fps/150)/T,Q_select{i}(:,L_loc{i})./Dissipation(i)/2,linetype_all{i},'linewidth',1);
    else
        plot((1:size(Q_select{i},1))/(fps/10)/T,Q_select{i}(:,L_loc{i})./Dissipation(i)/2,linetype_all{i},'linewidth',1);
    end
end

colororder({'#b3b3b3','#b3b3b3','#b3b3b3',c_string{51}{4},c_string{6}{3},c_string{5}{1}});

axis([0 12 -0.2 0.3]);

xlb = xlabel('t/T');
ylb = ylabel('\Pi_S^{(L)}/2\nu\Omega');


% set(gcf,'MenuBar','figure',...
%     'Units','centimeters',...
%     'Position',[5,5,6,6],...
%     'Resize',0,...
%     'PaperUnits','centimeters',...
%     'PaperSize',[6 6]);

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
ax.XTick = 0:4:12;
ax.PlotBoxAspectRatio = [4,3,1];
pos = tightPosition(ax);
pos_out = ax.OuterPosition;