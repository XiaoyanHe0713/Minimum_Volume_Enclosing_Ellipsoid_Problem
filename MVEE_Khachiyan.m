N = 20; % number of the points
d = 3; % dimension of the points
tolerance = 0.001;

[P , A, center] = Khachiyan(N, d, tolerance);

% plot the points
scatter3(P(1,:), P(2,:), P(3,:), 'filled');
hold on;
Ellipse_plot(A, center);
