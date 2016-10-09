function [xm,fval] = PSOGPU(fitness,myconstraints,LB,UB,D)
	N = 50;
	T = 100;
	
	c1 = 1.49618;
	c2 = 1.49618;
	w = 0.7298;

	MAT1 = gpuarray(repmat((UB-LB),1,N));
	MAT2 = gpuarray(repmat(LB,1,N));
	x = rand(D,N).*MAT1 + MAT2;
	v = rand(D,N).*MAT1 + MAT2;