function fitVal = fitness(pos,varargin)

	data = cell2mat(varargin{:});

	K = data(:,1);
	V = data(:,2);

	fitVal = mae(SD(K,pos) - V);
end