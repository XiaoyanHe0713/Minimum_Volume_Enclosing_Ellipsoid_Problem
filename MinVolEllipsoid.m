function [P, center, X] = MinVolEllipsoid(N, d)
    % N is the number of points
    % d is the dimension of the space
    % P is the matrix of the ellipsoid
    % center is the center of the ellipsoid

    % randomly generate N points in d-dimensional space
    X = rand(d, N)*2 - 1;

    % solve the SVEE problem by using SeDuMi
    K.s = (d+1)*ones(1, N+1);
    K.s(N + 1) = d;

    % the vector b has the size d(d+1)/2 + d
    b = zeros(d*(d+1)/2 + d, 1);

    j = 1;
    for i = 1:d
        b(j) = -1;
        j = j + d - i + 1;
    end

    % the matrix c_i has the size (d+1) by (d+1)
    % convert c_i to vector and concatenate them together
    c = [];
    for i = 1:N
        c_temp = zeros(d+1);
        for j = 1:d
            c_temp(j,d+1) = X(j,i);
            c_temp(d+1,j) = X(j,i);
            c_temp(d+1,d+1) = 1;
        end
        c_temp = reshape(c_temp, [1, (d+1)^2]);
        c = [c c_temp];
    end
    c = [c zeros(1, d^2)];

    % the matrix A_i has the size (d+1) by (d+1)
    % convert A_i to vector and vertically concatenate them together
    A_v = [];
    t = d;
    s = 1;
    r = 0;
    for i = 1:(d*(d+1)/2)
        A_temp = zeros(d+1);
        j = (mod(i-r,d) + s - 1);
        if i < t
            A_temp(s, j) = -1;
            A_temp(j ,s) = -1;
        else if i == t
                A_temp(s, d) = -1;
                A_temp(d, s) = -1;
                s = s + 1;
                r = t;
                t = t + d - s + 1;
            end
        end
        A_temp = reshape(A_temp, [1, (d+1)^2]);
        A_v = [A_v; A_temp];
    end

    for i = (d*(d+1)/2+1):(d*(d+1)/2+d)
        A_temp = zeros(d+1);
        A_temp(d+1, i-d*(d+1)/2) = 1;
        A_temp(i-d*(d+1)/2, d+1) = 1;
        A_temp = reshape(A_temp, [1, (d+1)^2]);
        A_v = [A_v; A_temp];
    end

    % horizontally concatenate A_v n times
    A = [];
    for i = 1:N
        A = [A A_v];
    end

    A_v = [];
    t = d;
    s = 1;
    r = 0;
    for i = 1:(d*(d+1)/2)
        A_temp = zeros(d);
        j = (mod(i-r,d) + s - 1);
        if i < t
            A_temp(s, j) = -1;
            A_temp(j ,s) = -1;
        else if i == t
                A_temp(s, d) = -1;
                A_temp(d, s) = -1;
                s = s + 1;
                r = t;
                t = t + d - s + 1;
            end
        end
        A_temp = reshape(A_temp, [1, d^2]);
        A_v = [A_v; A_temp];
    end

    for i = (d*(d+1)/2+1):(d*(d+1)/2+d)
        A_temp = zeros(d);
        A_temp = reshape(A_temp, [1, d^2]);
        A_v = [A_v; A_temp];
    end

    A = [A A_v];

    % solve the SVEE problem
    [x, y, info] = sedumi(A, b, c, K);

    % y is the final solution
    % the first d*(d+1)/2 elements of y are the elements of matrix P
    P = zeros(d+1);
    A = A(1:d*(d+1)/2,1:(d+1)^2);
    for i = 1:(d*(d+1)/2)
        A_temp = reshape(A(i,:), [d+1, d+1]);
        P = P + y(i)*A_temp;
    end
    P = P(1:d,1:d) * (-1);

    % the last d elements of y are the elements of vector center
    center = y((d*(d+1)/2)+1:end);
end