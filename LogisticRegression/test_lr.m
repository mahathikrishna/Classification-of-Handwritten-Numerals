%function Accuracy = test_lr(~,~)

clc;

TS1 = importdata('test_data.mat');
X = TS1;

W = importdata('W.mat');

W_tr = W;

a = X * W_tr;
 exp_a = exp(a);

for i = 1:length(exp_a(:,1))
     sum_exp(i,1) = sum(exp_a(i,:));
end

for i = 1:length(exp_a(:,1))
    for j = 1:length(exp_a(1,:))
        Y_log(i,j) = exp_a(i,j)/sum_exp(i,1);
    end
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


    
    error = transpose(X)*(Y_log - T);

    eta = 0.0001;
    W1 = W_tr - eta*error;
    a1 = X*W1;
     exp_a1 = exp(a1);
    for i = 1:length(exp_a1(:,1))
         sum_exp(i,1) = sum(exp_a1(i,:));
    end

    for i = 1:length(exp_a1(:,1))
        for k = 1:length(exp_a1(1,:))
            Y1(i,k) = exp_a1(i,k)/sum_exp(i,1);
        end
    end
    
    error = transpose(X)*(Y1 - T);
    CR_err = (-sum(sum(T.*log(Y1))));
     count= 0 ; 
     [mx,ind] = max(Y1, [], 2);     
     for i= 1:1500
         if(ind(i,1)==X(i,1))
           count = count+1;
         end
     end
      ac1=count/1500; 
      Accuracy = (1-ac1) *100;
      Error = 100-Accuracy;
fprintf('Accuracy = %f\n',Accuracy);
%end
