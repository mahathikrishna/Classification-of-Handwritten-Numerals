%function Error = train_lr(~,~)

clc;

TR1 = importdata('train_data.mat');
X = TR1;

W = zeros(513,10);  



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



eta1 = 0.001; 
iter1 = zeros(100,1);
Error = zeros(100,1);
for j = 1: 100
     iter1(j,1) = j;
     a1 = X * W;   
    exp_a1 = exp(a1);
    for i = 1:length(exp_a1(:,1))
         sum_exp(i,1) = sum(exp_a1(i,:));
    end

    for i = 1:length(exp_a1(:,1))
        for k = 1:length(exp_a1(1,:))
            Y1(i,k) = exp_a1(i,k)/sum_exp(i,1);
        end
    end
     error1 = X'*(Y1 - T);
     W = W - eta1*error1;
     CR = (-sum(sum(T.*log(Y1))));
     count1= 0 ; 
     [m,ind] = max(Y1, [], 2); 
     
     for i= 1:20000
         if(ind(i,1)==X(i,1))
           count1 = count1+1;
         end
     end
     ac1=count1/20000;
     Error(j,1) = (1-ac1) *100;  
     accuracylr_train = (1-ac1) * 100;


end
fprintf('The error for Logistic regression = %f\n',errorlr_train);

figure(1)
plot(iter1,Error);
xlabel('Iterations');
ylabel('Error');

