[m, n] = size(loc);
a = [0 0 m m 0];
b = [0 n n 0 0];
plot(a, b, 'k');
for i = 1:1:size(objects,1)
    x = objects(i,1);
    y = objects(i,2);
    a = [x x x+1 x+1 x];
    b = [y y+1 y+1 y y];
    hold on
    plot(a, b, 'k');
end
hold on
plot(out.pos1.Data(:,1), out.pos1.Data(:,2), 'g');
hold on
plot(out.pos2.Data(:,1), out.pos2.Data(:,2), 'r');
hold on
plot(out.pos3.Data(:,1), out.pos3.Data(:,2), 'b');
hold on
plot(out.pos4.Data(:,1), out.pos4.Data(:,2), 'k');



