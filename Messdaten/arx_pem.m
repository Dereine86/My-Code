function [a, b] = arx_pem(y, u, n)
% [a, b] = arx_pem(y, u, n)
% Calculates the coefficients of an ARX model using least squares fitting
% y: vector containing the output signal
% u: vector containing the input signal
% n: order of the ARX model
% The ARX model identified is of the form
% y(t) + a(1)*y(t-1) +...+ a(n)*y(t-n) = b(1)*u(t-1) +...+ b(m)*u(t-n)

if ~isvector(y) || ~isvector(u) || (length(y)~=length(u))
    error('the first two inputs must be vectors of the same length')
end

if n>length(y)-1
    error('the value of the third parameter is too high')
end

% if necessary y and u are transposed such that they are two column vectors
if size(y,1)==1
    y = y';
end

if size(u,1)==1
    u = u';
end

n_samples = length(y); % number of total samples

J = zeros(n_samples-n, 2*n); % LS coefficient matrix

for ind = 1:size(J,1)
    J(ind,:) = [-y(ind+n-1:-1:ind)' u(ind+n-1:-1:ind)'];
end

phi = y(n+1:end);

Theta = pinv(J'*J)*J'*phi; % calculation of the coefficients

a = Theta(1:n)';
b = Theta(n+1:end)';