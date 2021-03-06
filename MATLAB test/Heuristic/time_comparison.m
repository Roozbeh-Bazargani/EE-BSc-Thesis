clear all
clc
%% Initializing
numPoints = 4;
A_star_time = zeros(1,numPoints); 
Greedy_best_time = zeros(1,numPoints);
BFS_time = zeros(1,numPoints);
Q_time = zeros(1,numPoints);
x = 10:15:15*(numPoints-1) + 10;
%% Constructing map (loc)
for size = 15:20:20*(numPoints-1) + 15
    loc = zeros(size);
    numObj = floor(0.1*size^2);
    for i = 1:numObj
        loc(randi(size), randi(size)) = 1;
    end
    %% running algorithms
    [A_star_time(ceil(size/20)), Greedy_best_time(ceil(size/20)), BFS_time(ceil(size/20)), Q_time(ceil(size/20))] = ...
        Heuristic_time(loc, 100);
end
%% plot
figure()
plot(x.^2, A_star_time*1000, x.^2, Greedy_best_time*1000, 'g', x.^2, BFS_time*1000, 'm', x.^2, Q_time*1000, 'r')
title('time comparison of BFS, Greedy best-first search, A* and Q-learning')
xlabel('Number of nodes')
ylabel('time (ms)')
legend('A*', 'Greedy best-first search', 'BFS', 'Q-learning')