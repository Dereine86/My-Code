function res = siso_residual(x, y_meas, u_meas, ord, sigma_eq, sigma_in, sigma_out)
% res = siso_residual(x, y_meas, u_meas, ord, sigma_eq, sigma_in, sigma_out)
% Calculates the residual function to identify a siso model of the form
% y(t) + a(1)*y(t-1) +...+ a(n)*y(t-n) = b(1)*u(t-1) +...+ b(m)*u(t-n)
% The input arguments are:
% - x is the point where the residual is evaluated. This vector is given by
%   x = [a; b; y; u] (a and b are the vecors containing the model
%   coefficients, while y and u contain the inputs and outputs)
% - y_meas is the vector containing the output measurements
% - u_meas is the vector containing the input measurements
% - ord is the order of the identified system
% - sigma_eq is the LS weight for the equation error
% - sigma_in is the LS weight for the input error
% - sigma_out is the LS weight for the output error
% The elements in the output argument res contain:
% - the weighted equation error
%    (y(t)+a(1)*y(t-1)+...+a(n)*y(t-n)-b(1)*u(t-1)-...-b(m)*u(t-n))/sigma_eq
%   for n=ord+1:length(y_meas)
% - the weighted input error
%    (u_meas(n)-u(n))/sigma_in
%   for n=ord+1:length(u_meas)
% - the weighted output error
%    (y_meas(n)-y(n))/sigma_out
%   for n=ord+1:length(y_meas)

if ~isvector(x) || ~isvector(y_meas) || ~isvector(u_meas)
    error('the first three arguments must be vectors')
end

if length(y_meas)~=length(u_meas)
    error('the second and third arguments must be vectors of the same length')
end

if ord<=0 || rem(ord, 1)~=0
    error('the fourth argument must be an integer greater than zero')
end

if sigma_eq<=0 || sigma_in<=0 || sigma_out<=0
    error('the last three argumets must be positive numbers')
end

% input vectors are transposed if they are row vectors
if isrow(x)
    x = x';
end

if isrow(y_meas)
    y_meas = y_meas';
end

if isrow(u_meas)
    u_meas = u_meas';
end

n = length(y_meas); % number of samples

res = zeros(n-ord+n+n, 1); % residual value

a = x(1:ord)'; % coefficients for the regression term
b = x(ord+1:2*ord)'; % coefficients for the input term

% in the first part of the residual we put the equation errors
for ind=1:n-ord
    y_old = x(2*ord+ind+ord-1:-1:2*ord+ind);
    y = x(2*ord+ind+ord);
    u = x(2*ord+n+ind+ord-1:-1:2*ord+n+ind);
    res(ind)=(y+a*y_old-b*u)/sigma_eq;
end

% in the second part of the residual we put the input errors
res(n-ord+1:n-ord+n) = (u_meas-x(2*ord+n+1:end))/sigma_in;

% in the last part of the residual we put the output errors
res(n-ord+n+1:end) = (y_meas-x(2*ord+1:2*ord+n))/sigma_out;
