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
V(goal_state(1), goal_state(2)) = 1000; % Reward
iter = 0;
delta_old = 0;
while iter < maxIter
    delta = 0;
    for x = 1:m
        for y = 1:n
            s = (y-1)*m + x;
            v = V(x,y);
            for a = 1:numActions
                %R = -norm(actions(a,:));
                pos = [x y] + actions(a,:);
                R = -norm(pos - goal_state) + norm([x y] - goal_state);
                if pos(1) < 1 || pos(1) > m || pos(2) < 1 || pos(2) > n || loc(round(pos(1)), round(pos(2))) == 1
                    Q(s,a) = -1000;
                else
                    if x == goal_state(1) && y == goal_state(2)
                        R = 1000;
                    end
                    Q(s,a) = (1-alpha)*Q(s,a) + alpha*(R + gama*Pi(s,a)*V(pos(1), pos(2)));
                end
            end
            V(x,y) = max(Q(s,:));
            delta = max(delta, abs(v-V(x,y)));
            Pi(s,:) = Q(s,:) - min(Q(s,:));
            Pi(s,:) = Pi(s,:) / sum(Pi(s,:));
        end
    end
    
    if delta - delta_old < stop_rate
        break
    end
    delta_old = delta;
    iter = iter + 1;
    fprintf('iter %d: delta = %d\n', iter, delta);
end

[~, I] = max(Pi,[],2,'linear');
policy = ceil(I/(m*n));
policy = reshape(policy, m, n);

path = zeros(m*n,2);
s = start_state;
i = 2;
path(1,:) = s;
while s(1) ~= goal_state(1) || s(2) ~= goal_state(2)
    disp(s);
    s = s + actions(round(policy(s(1), s(2))),:);
    path(i,:) = s;
    i = i + 1;
    if i > m + n
        break
    end
end

[x, ~] = find(path==0);
path = path(1: x(1)-1,:);

