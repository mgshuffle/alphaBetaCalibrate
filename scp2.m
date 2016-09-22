%para setting
fhd = @fitness;
Max_Gen = 5000;
Max_FES = 100000;
Particle_Number = 30;
Dimension = 5;
VRmin = [50 0 50 -10 -10];
VRmax = [80 20 200 10 10];

data = xlsread('LPB9.csv');

[m,~] = size(data);
[uniDateNum,heads] = unique(data(:,5));
tails = [heads(2:end);m];

result = [];

figure

for i = 1:length(heads)
    if tails(i)-heads(i)+1>100
    	varargin = {data(heads(i):tails(i),1:2)};
        [gbest,gbestval,fitcount]= CLPSO_new_func(fhd,Max_Gen,Max_FES,Particle_Number,Dimension,VRmin,VRmax,varargin);
        result = [result; uniDateNum(i) gbest gbestval fitcount];
        clf
        hold on
        plot(varargin(:,1),varargin(:,2),'.')
        plot(varargin(:,1),SD(varargin(:,1),gbest))
    end
end
