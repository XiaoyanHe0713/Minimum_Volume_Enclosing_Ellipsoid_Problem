function [P, A, c] = Khachiyan(N, d, tolerance)
    % initializations
    P = rand(d, N)*2 - 1;
    [d, N] = size(P);
    Q = zeros(d+1,N);
    Q(1:d,:) = P(1:d,1:N);
    Q(d+1,:) = ones(1,N);   

    count = 1;
    err = 1;
    u = (1/N) * ones(N, 1);

    % Khachiyan Algorithm
    while err > tolerance
        X = Q * diag(u) * Q';
        M = diag(Q' * inv(X) * Q);
        [maximum, j] = max(M);
        step_size = (maximum - d - 1)/((d+1)*(maximum - 1));
        new_u = (1 - step_size)*u;
        new_u(j) = new_u(j) + step_size;
        count = count + 1;
        err = norm(new_u - u);
        u = new_u;
    end

    % computing the ellipsoid parameters
    U = diag(u);

    A = (1/d) * inv(P * U * P' - (P * u)*(P*u)' );

    c = P * u;
end