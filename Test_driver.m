clc;clear;close all;
%% initializing parameters
results = zeros(5,9);
results(2,:) = 2;

for k = 1:9
    i = k*5+5;
    results(1,k) = i;
    for j = 1:10
        clear global
        ITtmp = ABM_main(50,i,2,0,60);
        tmp_m = ITtmp.tot_m;
        tmp_m(tmp_m==0) = [];
        results(3,k) = results(3,k) + min(tmp_m);
        tmp_p = ITtmp.tot_p;
        tmp_p(tmp_p==0) = [];
        results(4,k) = results(4,k) + min(tmp_p);
        tmp_anti = ITtmp.anti_m;
        tmp_anti(tmp_anti==0) = [];
        if isempty(tmp_anti)~=1
            results(5,k) = results(5,k) + min(tmp_anti);
        end
    end
    results(3,k) = results(3,k)/10;
    results(4,k) = results(4,k)/10;
    results(5,k) = results(4,k)/10;
end

%% plot results
for p = 1:9
    propotion(p) = results(3,p)/results(1,p);
end
plot(results(1,:),propotion,'r^-');
hold on;
plot(results(1,:),results(4,:)/2,'bO-');
hold on;
plot(results(1,:),results(5,:),'g*-');
hold on;
axis('tight')
legend('tot_m/num_m','tot_p/num_p','anti_m')
xlabel('number of monkeys')
ylabel('average number of results')
title('Initial number of parasites = 2')
    
    
    