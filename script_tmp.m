clear
load('data.mat')
%data=data(data(:,5)==20,:);
save('data2Clibrate');

 x = particleswarm(@fitness2,5,[50 0 50 -10 -10],[80 20 200 10 10]);
 disp(x);
 gbestval = fitness2(x);
 disp(gbestval);

 figure
 hold on
 plot(data(:,1),data(:,2),'.')
 %plot(data(:,1),SD(data(:,1),x),'x')
 
 kmin=0;
 kmax=max(data(:,1));
 k=linspace(kmin,kmax,1e+5);
 plot(k,SD(k,x))
 plot(k,SD(k,x)+gbestval);
 plot(k,SD(k,x)-gbestval);