clear all
clc
viz = Visualizer2D;
viz.showTrajectory = false;
load exampleMap
p = zeros(40,50);
p(1,:) = ones(1, size(p,2));
p(size(p,1),:) = ones(1, size(p,2));
p(:,1) = ones(size(p,1),1);
p(:,size(p,2)) = ones(size(p,1),1);
%p(:,13) = [1; 0; 0; 0; 0; 0; 0; ones(20,1)];
%raw_objects = [20 25; 20 24; 20 23; 20 22; 20 21; 20 20; 20 19];
%objects = [20 25; 20 24; 20 23; 20 22; 20 21; 20 20; 20 19];
objects = [1 1; 1 1];
loc = zeros(size(p,2), size(p,1));
loc(1,:) = ones(1, size(loc,2));
loc(size(loc,1),:) = ones(1, size(loc,2));
loc(:,1) = ones(size(loc,1),1);
loc(:,size(loc,2)) = ones(size(loc,1),1);

%objects = zeros(size(p,1)*size(p,2), 2);
% neighbours = {N, S, E, W, NW, NE, SW, SE, 0} |neigbours| = 9
%neighbours = [0 1; 0 -1; 1 0; -1 0; -1 1; 1 1; -1 -1; 1 -1; 0 0]; % direction of neigbours in x-y coordination
%numNeighbours = 9;
%k = 1;
% for i = 1:1:size(raw_objects,1)
%     p(size(p,1) - raw_objects(i,2) + 1, raw_objects(i,1) + 1) = 1;
%     for j = 1:1:numNeighbours
%         objects(k,:) = raw_objects(i,:) + neighbours(j,:);
%         k = k + 1;
%     end
% end
% [x, ~] = find(objects==0);
% objects = objects(1:x(1) - 1,:);

for i = 1:1:size(objects,1)
    p(size(p,1) - objects(i,2) + 1, objects(i,1) + 1) = 1;
    loc(objects(i,1), objects(i,2)) = 1;
end

mapRooz = binaryOccupancyMap(p, 1);
viz.mapName = 'mapRooz';
pose = [3; 4; 0];
viz(pose)