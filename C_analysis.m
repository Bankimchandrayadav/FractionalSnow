%% Reading landsat and modis files into vectors

img_ls = imread('landsat_320x320_frac.tif');
img_mod = imread('modis_320x320_index.tif');

% scf vector will contain landsat values
% ind vector will contain modis values

scf = zeros(102400,1);
j = 1;
for i = 1:320
    scf(j:j+319) = img_ls(i,1:320);
    j = j+320;
end

ind = zeros(102400,1);
k = 1;
for i = 1:320
    ind(k:k+319) = img_mod(i,1:320);
    k = k+320;
end

%Eliminate NaN values (ind may contain NaN values)
pos= find(isnan(ind));
ind(pos) = [];
scf(pos) = [];

corrcoef(ind,scf)

% Reducing vector size
ind = ind(1:20:end);
scf = scf(1:20:end);


%% Fitting different functions for plot b/w scf and ind

%vof1 contains the names of all fitting functions used
% vof1 = {'poly1','poly2','poly3','poly4','poly5','exp1','exp2','fourier1',...
%     'fourier2','sin1','sin2','sin3','rat31','rat32','rat33','gauss1','gauss2','gauss3'}';
vof1 = {'poly1','poly5','exp2','sin3','rat32','gauss2'}';


%tab1 will contain goodness of fit parameters(6 parameters) of each fit 
%tab2 will contain correlation between scf_theoretical and scf_actual for
%all the fit functions

tab1 = zeros(size(vof1,1),6); % 16x6 size
tab2 = zeros(size(vof1,1),1); % 16x1 size

for i = 1:size(vof1,1)
    [f,g] = fit(ind,scf,vof1{i});
    scf_th = f(ind);
    cr = corrcoef(scf_th,scf);
    tab2(i) = cr(1,2);    
    tab1(i,1:6) = [i,g.rsquare,g.rmse,g.sse,g.dfe,g.adjrsquare];
    
    %Plotting the graphs
    
%     figure(i)
%     s = scatter(scf_th,scf);
%     axis([0 1 0 1]);
%     title('Correlation between theoretical and actual SCF values');
%     xlabel('SCF Theoretical');
%     ylabel('SCF Actual');
    end

%Vieweing the results
tab1,tab2 

%NOTE: tab1 may appear to contain rounded off values. For exact values view
%the tab1 variable in workspace.

