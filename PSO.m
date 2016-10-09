function [xm,fval] = PSO(fitness,LB,UB,D,myconstraints)
N = 50;
T = 100;

c1 = 1.49618;
c2 = 1.49618;
w = 0.7298;

format long;

%------��ʼ����Ⱥ�ĸ���------------

% MAT1 = repmat((UB-LB),1,N);
% MAT2 = repmat(LB,1,N);
% x = rand(D,N).*MAT1 + MAT2;
% v = rand(D,N).*MAT1 + MAT2;

x = rand(D,N);
v = rand(D,N);

%��ֹ���ֲ����ϲ�����Լ���Ľ�
for k = 1:N
    b = myconstraints(UnNormalize(x(:,k),LB,UB));
    while (~isempty(b(b>0)))
        x(:,k) = rand(D,1);
    end
end

p = zeros(1,N);
y = zeros(D,N);
%------�ȼ���������ӵ���Ӧ�ȣ�����ʼ��Pi��Pg----------------------

for i=1:N
    p(i) = fitness(x(:,i));
    y(:,i) = x(:,i);
end

gbest = min(p);
idxs = find(p==gbest);
gx = y(:,idxs(1));


%------������Ҫѭ�������չ�ʽ���ε���------------



for t=1:T
    display(t);
    v = w*v + c1*rand(D,N).*(y-x) + c2*rand(D,N).*(repmat(gx,1,N)-x);
    x = x + v;
    
    %     temp = find(x(2,:)<0);
    %     x(2,temp)=rand(1,length(temp));
    
    %     %λ������ ��ֹ�ٶ�̫��Խ��
    %     xx = reshape(x,D*N,1);
    %     seq2 = repmat(LB,N,1);
    %     idx2 = find(xx<seq2);
    %     xx(idx2) = seq2(idx2);
    %     seq3 = repmat(UB,N,1);
    %     idx3 = find(xx>seq3);
    %     xx(idx3) = seq3(idx3);
    %     x = reshape(xx,D,N);
    
    
    
    for i=1:N
        checkBound = x(:,i).*(x(:,i)-1);
        b = myconstraints(x(:,i));
        if isempty(b(b>0)) && isempty(checkBound(checkBound>0))
            a = fitness(UnNormalize(x(:,i),LB,UB));
        else
            %a = Inf;
        end
        if (a<p(i))
            p(i) = a;
            y(:,i)=x(:,i);
        end
    end
    gbest = min(p);
    idxs = find(p==gbest);
    gx = y(:,idxs(1));
    
    display(gbest);
    display(gx);
end
xm = gx;
fval = gbest;
end

function y = UnNormalize(x, lb, ub)
y = (ub-lb).*x + lb;
end