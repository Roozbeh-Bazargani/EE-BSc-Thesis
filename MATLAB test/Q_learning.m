function [Q, policy, value] = Q_learning(loc, start_state, goal_state, numEpisodes)
% parameters
alpha = 0.9;
gama = 0.9;

% Actions = {N, S, E, W, NW, NE, SW, SE} |A| = 8
actions = [0 1; 0 -1; 1 0; -1 0; -1 1; 1 1; -1 -1; 1 -1]; % direction of Actions in x-y coordination
numActions = size(actions,1);
m = size(loc,1);
n = size(loc,2);
s_goal = (goal_state(2)-1)*m + goal_state(1);
Q = zeros(m*n, numActions);
% Pi = ones(m*n, numActions) / numActions;
% Q(s_goal,:) = 10;
for episode = 1:numEpisodes
    pos = start_state;
%     fprintf('%d, %d\n', pos(1), pos(2))
    s = (pos(2)-1)*m + pos(1);
    while s ~= s_goal
        Terminate = false;
        a = randi(numActions);
        pos = pos + actions(a,:);
        if pos(1) < 1 || pos(1) > m || pos(2) < 1 || pos(2) > n
            Q(s,a) = -10;
            %pos = [floor(s/n) + 1, mod(s,n)];
            %fprintf('while%d, s = %d, a = %d, pos = (%d,%d)\n', episode, s, a, pos(1), pos(2))
            break
        end
        sp = (pos(2)-1)*m + pos(1);
        R = -norm(actions(a,:));
        if loc(round(pos(1)), round(pos(2))) == 1
            R = -10;
            Q(s,:) = -10;
            Terminate = true;
        elseif sp == s_goal
            R = 10;
            Terminate = true;
        end
%         fprintf('s = %d, sp = %d\n', s, sp);
        Q(s,a) = Q(s,a) + alpha*(R + gama*max(Q(sp,:)) - Q(s,a));
        s = sp;
        if Terminate
            break
        end
    end
end


[value, policy] = max(Q, [], 2, 'linear');
policy = floor((policy - 1) / size(Q,1)) + 1;
policy = reshape(policy, m, n);
value = reshape(value, m, n);

end

