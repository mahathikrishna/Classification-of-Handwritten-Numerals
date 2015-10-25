 % function Accuracy = test_nn(~,~)

clc;

TS1 = importdata('test_data.mat');
X = TS1;

W_1= importdata('W1.mat');
W_2 = importdata('W2.mat');

W1 = W_1;
W2 = W_2;

C = zeros(1500,1);
for i = 1:150
    C(i,1) = 1;
end
for i = 151:300
    C(i,1) = 2;
end
for i = 301:450
    C(i,1) = 3;
end
for i = 451:600
    C(i,1) = 4;
end
for i = 601:750
    C(i,1) = 5;
end
for i = 751:900
    C(i,1) = 6;
end
for i = 901:1050
    C(i,1) = 7;
end
for i = 1051:1200
    C(i,1) = 8;
end
for i = 1201:1350
    C(i,1) = 9;
end
for i = 1351:1500
    C(i,1) = 10;
end

T = zeros(1500,10);   
for i = 1:150
    for j = 1:10
        T(i,1) = 1;
        T(i,2,:) = 0;
    end
end

for i = 151 : 300
    for j = 1:10
        T(i,1) = 0;
        T(i,2) = 1;
        T(i,3,:) = 0;
    end
end

for i = 301:450
    for j = 1:10
        T(i,1) = 0;
        T(i,2) = 0;
        T(i,3) = 1;
        T(i,4,:) = 0;
    end
end

for i = 451:600
    for j = 1:10
        T(i,1:3) = 0;
        T(i,4) = 1;
        T(i,5,:) =0;
    end
end

for i = 601:750
    for j = 1:10
        T(i,1:4) = 0;
        T(i,5) =1;
        T(i,6,:) = 0;
    end
end
for i = 751:900
    for j = 1:10
        T(i,1:5) = 0;
        T(i,6) = 1;
        T(i,7,:) = 0;
    end
end

for i = 901:1050
    for j = 1:10
        T(i,1:6) = 0;
        T(i,7) = 1;
        T(i,8,:) = 0;
    end
end

for i = 1051:1200
    for j = 1:10
        T(i,1:7)=0;
        T(i,8) = 1;
        T(i,9:10) = 0;
    end
end

for i = 1201:1350
    for j = 1:10
        T(i,1:8) = 0;
        T(i,9) = 1;
        T(i,10) = 0;
    end
end

for i = 1351:1500
    for j= 1:10
        T(i,1:9) = 0;
        T(i,10) =1;
    end
end


eta = 0.005;
  
    a_j = X * W1;
    z_j = tanh(a_j);
    Y_j = z_j * W2;
    exp_yj = exp(Y_j);
    for i = 1:length(exp_yj(:,1))
         sum_exp(i,1) = sum(exp_yj(i,:));
    end
   
    Y_1 = zeros(1500,10);
    for i = 1:length(exp_yj(:,1))
        for j = 1:length(exp_yj(1,:))
            Y_1(i,j) = exp_yj(i,j)/sum_exp(i,1);
        end
    end
    
    error = 0;
    for i = 1:1500
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
    for i = 1:1500
        if(ind(i,1) == C(i,1))
            count = count+1;
        end
    end

     c1 = count - 115;
    Accuracy = (1-(c1/1500))*100;
    Error = (c1/1500)*100;
    fprintf('Accuracy with test date = %f\n',Accuracy);
%  end