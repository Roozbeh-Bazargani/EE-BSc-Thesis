function [Q, policy, V, path] = Q_learning_p(loc, start_state, goal_state, stop_rate, maxIter)
% parameters
alpha = 0.9;
gama = 0.9;

% Actions = {N, S, E, W, NW, NE, SW, SE} |A| = 8
actions = [0 1; 0 -1; 1 0; -1 0; -1 1; 1 1; -1 -1; 1 -1]; % direction of Actions in x-y coordination
numActions = size(actions,1);
m = size(loc,1);
n = size(loc,2);
Q = zeros(m*n, numActions);
Pi = ones(m*n, numActions) / numActions;
V = zeros(m, n);
V(goal_state(1), goal_state(2)) = 0; % Reward
iter = 0;
while iter < maxIter
    delta = 0;
    for x = 1:m
        for y = 1:n
            s = (y-1)*m + x;
            v = V(x,y);
            for a = 1:numActions
                pos = [x y] + actions(a,:);
                %R = -norm(pos - goal_state)/1000 + norm([x y] - goal_state)/1000;
                %R = -1;
                R = -norm(actions(a,:));
                %R = -norm(pos - goal_state)/1000;
                if pos(1) < 1 || pos(1) > m || pos(2) < 1 || pos(2) > n || loc(round(pos(1)), round(pos(2))) == 1
                    Q(s,a) = -10;
                else
                    if pos(1) == goal_state(1) && pos(2) == goal_state(2)
                        R = 10;
                    end
                    Q(s,a) = (1-alpha)*Q(s,a) + alpha*(R + gama*V(pos(1), pos(2)));
                end
            end
            V(x,y) = max(Q(s,:));
            delta = max(delta, abs(v-V(x,y)));
            Pi(s,:) = Q(s,:) - min(Q(s,:));
            Pi(s,:) = Pi(s,:) / sum(Pi(s,:));
        end
    end
  
    if delta < stop_rate
        break
    end
    fprintf('iter %d: delta = %d\n', iter, delta);
    iter = iter + 1;
    
end

[~, I] = max(Pi,[],2,'linear');
policy = ceil(I/(m*n));
policy = reshape(policy, m, n);

path = zeros(m*n,2);
s = start_state;
i = 2;
path(1,:) = s;
while s(1) ~= goal_state(1) || s(2) ~= goal_state(2)
    s = s + actions(round(policy(s(1), s(2))),:);
    path(i,:) = s;
    i = i + 1;
    if i > m + n
        break
    end
end

[x, ~] = find(path==0);
path = path(1: x(1)-1,:);

