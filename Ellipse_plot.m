function Ellipse_plot(A, C, varargin)
    N = 20; % Default value for grid
    if nargin > 2
 	    N = varargin{1};
    end
    % check the dimension of the inputs: 2D or 3D

    if length(C) == 3
        Type = '3D';
    elseif length(C) == 2
        Type = '2D';
    else
        display('Cannot plot an ellipse with more than 3 dimensions!!');
        return
    end

    [U D V] = svd(A);
    if strcmp(Type, '2D')
        a = 1/sqrt(D(1,1));
        b = 1/sqrt(D(2,2));
        theta = [0:1/N:2*pi+1/N];
   
        state(1,:) = a*cos(theta); 
        state(2,:) = b*sin(theta);
        % Coordinate transform 
        X = V * state;
        X(1,:) = X(1,:) + C(1);
        X(2,:) = X(2,:) + C(2);
    
    elseif strcmp(Type,'3D')
        a = 1/sqrt(D(1,1));
        b = 1/sqrt(D(2,2));
        c = 1/sqrt(D(3,3));
        [X,Y,Z] = ellipsoid(0,0,0,a,b,c,N);
    
        %  rotate and center the ellipsoid to the actual center point
        XX = zeros(N+1,N+1);
        YY = zeros(N+1,N+1);
        ZZ = zeros(N+1,N+1);
        for k = 1:length(X)
            for j = 1:length(X)
                point = [X(k,j) Y(k,j) Z(k,j)]';
                P = V * point;
                XX(k,j) = P(1)+C(1);
                YY(k,j) = P(2)+C(2);
                ZZ(k,j) = P(3)+C(3);
            end
        end
    end

    % Plot the ellipse
    if strcmp(Type,'2D')
        plot(X(1,:),X(2,:));
        hold on;
        plot(C(1),C(2),'r*');
        axis equal, grid
    else
        mesh(XX,YY,ZZ);
        axis equal
        hidden off
    end