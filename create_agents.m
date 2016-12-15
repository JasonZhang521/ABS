function [agent]=create_agents(nm,np,na)

 %creates the objects representing each agent
 
%agent - cell array containing list of objects representing agents
%nr - number of people
%nf - number of parasites

%global parameters
%ENV_DATA - data structure representing the environment (initialised in
%create_environment.m)
%MESSAGES is a data structure containing information that agents need to
%broadcast to each other
%PARAM - structure containing values of all parameters governing agent
%behaviour for the current simulation
 
global ENV_DATA MESSAGES  
  
bm_size=ENV_DATA.bm_size;
mloc=(bm_size-1)*rand(nm,2)+1;      %generate random initial positions for monkey
%ploc=(bm_size-1)*rand(np,2)+1;      %generate random initial positions for parasites

state_set = [-1,0,1,2];% 0 is healthy, 1 is can infect, -1 is with antibody, 2 is with parasite
% state_len = length(state_set);

% number of monkeys in different states 
para_num = np;
anti_num = na;
hea_num = nm-para_num-anti_num;

nm_index_rand = randperm(nm);
para_index_set = nm_index_rand(1:np);
anti_index_set = nm_index_rand((np+1):(np+anti_num));
hea_index_set = nm_index_rand((np+anti_num+1):nm);

%generate all monkey agents and record their positions in ENV_MAT_R

for m=1:nm
    pos=mloc(m,:);  
    if any(para_index_set(:)==m) ~= 0
        state = 1;
    elseif any(anti_index_set(:)==m) ~= 0
        state = -1;
    else
        state = 0;
    end
    agent{m} = monkey(pos,state);
end

ploc = zeros(np,2);

for p= 1:np
    m_index = para_index_set(p); % on which monkey
    ploc(p,:) = mloc(m_index,:);
    pos = ploc(p,:);
    state = 0;
    time = 0;
    agent{p+nm} = parasite(m_index,pos,state,time);
%     agent{m_index}.state = 2; % 2 means with parasite so can not be infected by another parasite
end

 MESSAGES.pos = [mloc;ploc];

