function [nagent,nn]=agnt_solve(monkey_num,agent)

%sequence of functions called to apply agent rules to current agent population.
%%%%%%%%%%%%
%[nagent,nn]=agnt_solve(agent)
%%%%%%%%%%%
%agent - list of existing agent structures
%nagent - list of updated agent structures
%nn - total number of live agents at end of update

%Created by Dawn Walker 3/4/08 

global ENV_DATA

n=length(agent);    %current no. of agents
n_new=0;    %no. new agents
prev_n=n;   %remember current agent number at the start of this iteration

mature_age = 5; % mature age for parasite
bm_size=ENV_DATA.bm_size;

%execute existing agent update loop
for cn=1:n
	% switch the current agent
    curr=agent{cn}; 
    
    % change parameters of agents based on 
    if (isa(curr,'monkey')) % monkey migrate 
        curr.pos = (bm_size-1)*rand(1,2)+1; %migrate to a new place randomly
    elseif(isa(curr,'parasite')) 
        %parasite growing up
        curr.time = curr.time + 1; % age + 1
        if curr.time >= mature_age
            curr.state = 1; % 1 means parasite can infect monkeys
        end     
    end
    
    %up date cell array with modified agent data structure
    agent{cn}=curr;                          
end

% loop 2 change parasite position
for cn=(monkey_num + 1):n
    curr=agent{cn};
    if (isa(curr,'parasite'))  % if parasite still alive
        curr.pos = agent{curr.m_index}.pos; % according to patients' position
    end
    agent{cn}=curr;
end

% loop 3: the process of 1)infect other monkeys and 2) patient immunity or die
for cn=(monkey_num + 1):n
    % switch the current parasite agent
    curr=agent{cn};
    if (isa(curr,'parasite'))  % if parasite still alive
        if curr.state == 1
            % step 1: search nearby monkey to infect at a random probability
            for dn = 1:monkey_num
                % switch the aim monkey agent
                aim = agent{dn};
                if isempty(aim) == 0 % if monkey not dead
                    r = pdist([curr.pos;aim.pos],'euclidean'); % consider distance as radius
                    if r < 20 && r > 10 && r ~=0 % condition 1: if aim agent in a circle of r around curr agent
                        if aim.state == 0 % condition 2: if healthy without immunity
                            p = rand(1); % condition 3: random probablity to infect
                            if p > 0.70
                                aim.state = 1; % infect success
                                agent{end + 1} = parasite(dn,aim.pos,0,0); % creat new parasite agent
                                n_new = n_new + 1; % agent number + 1
                            end
                        end
                    elseif r<10 && r>5 && r~=0
                         if aim.state == 0 % condition 2: if healthy without immunity
                            p = rand(1); % condition 3: random probablity to infect
                            if p > 0.5
                                aim.state = 1; % infect success
                                agent{end + 1} = parasite(dn,aim.pos,0,0); % creat new parasite agent
                                n_new = n_new + 1; % agent number + 1
                            end
                         end
                    elseif r<5 && r~=0
                         if aim.state == 0 % condition 2: if healthy without immunity
                            p = rand(1); % condition 3: random probablity to infect
                            if p > 0.20
                                aim.state = 1; % infect success
                                agent{end + 1} = parasite(dn,aim.pos,0,0); % creat new parasite agent
                                n_new = n_new + 1; % agent number + 1
                            end
                         end
                    end
                end
                agent{dn} = aim;
            end
            
            % step 2: obtain immunity or not
            %         curr_m = agent{curr.m_index}; % choose the patient
            % immunity or die randomly
            p2 = rand(1);
            if p2 > 0.5
                agent{curr.m_index}.state = -1; % patient monkey obtains immunity
                curr = {}; % parasite dead
            else
                agent{curr.m_index} = {}; % patient monkey dead
                curr = {}; % parasite dead
            end
            
            % step 3: update agents
            %         agent{curr.m_index} = curr_m;
            agent{cn}=curr;
        end
    end
end

temp_n=n+n_new; %new agent number (before accounting for agent deaths)
[nagent,nn]=update_messages(agent,prev_n,temp_n);   %function which update message list and 'kills off' dead agents.

