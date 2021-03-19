function path = path_planner(policy, loc, start_state, goal_state)
% Actions = {N, S, E, W, NW, NE, SW, SE} |A| = 8
actions = [0 1; 0 -1; 1 0; -1 0; -1 1; 1 1; -1 -1; 1 -1]; % direction of Actions in x-y coordination
m = size(loc,1);
n = size(loc,2);
pos = start_state;
s_goal = (goal_state(1)-1)*n + goal_state(2);
s = (pos(1)-1)*n + pos(2);
i = 1;
path = zeros(max(m,n), 2);
path(1,:) = start_state;
fprintf('step %d: position = (%d, %d)\n', i, pos(1), pos(2))
while s ~= s_goal
    pos = pos + actions(policy(s),:);
    s = (pos(1)-1)*n + pos(2);
    i = i + 1;
    fprintf('step %d: position = (%d, %d)\n', i, pos(1), pos(2))
    path(i,:) = pos;
end
    
end

