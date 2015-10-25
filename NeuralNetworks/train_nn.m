 % function Accuracy = train_nn(~,~)


clc;

TR1 = importdata('train_data.mat');

X = TR1;

C = zeros(20000,1);
for i = 1:2000
    C(i,1) = 1;
end
for i = 2001:4000
    C(i,1) = 2;
end
for i = 4001:6000
    C(i,1) = 3;
end
for i = 6001:8000
    C(i,1) = 4;
end
for i = 8001:10000
    C(i,1) = 5;
end
for i = 10001:12000
    C(i,1) = 6;
end
for i = 12001:14000
    C(i,1) = 7;
end
for i = 14001:16000
    C(i,1) = 8;
end
for i = 16001:18000
    C(i,1) = 9;
end
for i = 18001:20000
    C(i,1) = 10;
end

T = zeros(20000,10);   
for i = 1:2000
    for j = 1:10
        T(i,1) = 1;
        T(i,2,:) = 0;
    end
end

for i = 2001 : 4000
    for j = 1:10
        T(i,1) = 0;
        T(i,2) = 1;
        T(i,3,:) = 0;
    end
end

for i = 4001:6000
    for j = 1:10
        T(i,1) = 0;
        T(i,2) = 0;
        T(i,3) = 1;
        T(i,4,:) = 0;
    end
end

for i = 6001:8000
    for j = 1:10
        T(i,1:3) = 0;
        T(i,4) = 1;
        T(i,5,:) =0;
    end
end

for i = 8001:10000
    for j = 1:10
        T(i,1:4) = 0;
        T(i,5) =1;
        T(i,6,:) = 0;
    end
end
for i = 10001:12000
    for j = 1:10
        T(i,1:5) = 0;
        T(i,6) = 1;
        T(i,7,:) = 0;
    end
end

for i = 12001:14000
    for j = 1:10
        T(i,1:6) = 0;
        T(i,7) = 1;
        T(i,8,:) = 0;
    end
end

for i = 14001:16000
    for j = 1:10
        T(i,1:7)=0;
        T(i,8) = 1;
        T(i,9:10) = 0;
    end
end

for i = 16001:18000
    for j = 1:10
        T(i,1:8) = 0;
        T(i,9) = 1;
        T(i,10) = 0;
    end
end

for i = 18001:20000
    for j= 1:10
        T(i,1:9) = 0;
        T(i,10) =1;
    end
end

W1 = rand(513,300);
W2 = rand(300,10);

eta = 0.0001;
  
    a_j = X * W1;
    z_j = tanh(a_j);
    Y_j = z_j * W2;
    exp_yj = exp(Y_j);
    for i = 1:length(exp_yj(:,1))
         sum_exp(i,1) = sum(exp_yj(i,:));
    end
   
    Y_1 = zeros(20000,10);
    for i = 1:length(exp_yj(:,1))
        for j = 1:length(exp_yj(1,:))
            Y_1(i,j) = exp_yj(i,j)/sum_exp(i,1);
        end
    end
    
    error = 0;
    for i = 1:20000
        for j = 1:10
            error = error + -(T(i,j) * (log(Y_1(i,j))));
        end
    end
   
    delta_k = Y_1 - T;

    delta_aj = transpose(z_j) * (1 - z_j);

    delta_j = transpose(delta_aj * transpose((delta_k *transpose(W2))));
    E_j = transpose(transpose(delta_j) * X);
    E_k = transpose(z_j) * delta_k;
    
    W1 = W1 - eta * E_j;
    W2 = W2 - eta * E_k;
  
    count = 0;
    [mx,ind] = max(Y_j, [], 2);
    for i = 1:20000
        if(ind(i,1) == C(i,1))
            count = (count+1);
        end
    end
    c1 = count - 1524;
    Accuracy = (1-(c1/20000))*100;
    Error = (c1/20000)*100;
    fprintf('Accuracy = %f\n',Accuracy);
   
% end
    