N = 20; % number of points
d = 3; % dimension of the points

[P, center, X] = MinVolEllipsoid(N, d);

% plot the points
scatter3(X(1,:), X(2,:), X(3,:), 'filled');
hold on;

P_inv = inv(P);
Ellipse_plot(P_inv, center);