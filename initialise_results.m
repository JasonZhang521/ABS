function initialise_results(nm,np,na,nsteps)

 global  IT_STATS  
 
%set up data structure to record statistics for each model iteration
%IT_STATS  -  is data structure containing statistics on model at each
%iteration (number of agents etc)
%ENV_DATA - data structure representing the environment 


IT_STATS=struct('died_m',[zeros(1,nsteps+1)],...			%no. agents dying per iteration
    'died_p',[zeros(1,nsteps+1)],...
    'anti_m',[zeros(1,nsteps+1)],...              %no. monkey anti per iteration
    'tot',[zeros(1,nsteps+1)],...				%total no. agents in model per iteration
    'tot_m',[zeros(1,nsteps+1)],...              % total no. people
    'tot_p',[zeros(1,nsteps+1)]);      % total no. parasites    
 
 IT_STATS.anti_m(1)=na;
 IT_STATS.tot(1)=nm+np;
 IT_STATS.tot_m(1)=nm;
 IT_STATS.tot_p(1)=np;
 
