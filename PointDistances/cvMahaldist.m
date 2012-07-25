function [d,norm_cov_A] = cvMahaldist(X, Y)
% cvMahaldist - Mahalanobis distance
%
% Synopsis
%   [d] = cvMahaldist(X, Y)
%
% Description
%   Compute mahalanobis distance between X and Y.  
%
% Inputs ([]s are optional)
%   (matrix) X        D x N matrix where D is the dimension of vectors
%                     and N is the number of vectors.
%   (matrix) Y        D x P matrix where D is the dimension of vectors
%                     and P is the number of vectors.
%
% Outputs ([]s are optional)
%   (matrix) d        N x P matrix where d(n,p) represents the mahalanobis
%                     distance between X(:,n) and Y(:,p).
%
% Examples
%   X = [1 2
%        1 2];
%   Y = [1 2 3
%        1 2 3];
%   d = cvMahaldist(X, Y)
%
% See also
%   cvEucdist, pdist (statistics Toolbox), mahal (statistics toolbox)

% References
%   [1] http://en.wikipedia.org/wiki/Mahalanobis_distance
%
% Authors
%   Naotoshi Seo <sonots(at)sonots.com>
%
% License
%   The program is free to use for non-commercial academic purposes,
%   but for course works, you must understand what is going inside to use.
%   The program can be used, modified, or re-distributed for any purposes
%   if you or one of your group understand codes (the one must come to
%   court if court cases occur.) Please contact the authors if you are
%   interested in using the program without meeting the above conditions.
%
% Changes
%   06/2006  First Edition
[D N] = size(X);
[D P] = size(Y);
A = [X Y];
A_cov = cov(A');
norm_cov_A = norm(A_cov(:));
%norm_cov_A = norm(cov(A'));
invcov = inv(cov(A'));
for i=1:N
    diff = repmat(X(:,i), 1, P) - Y;
    dsq(i,:) = sum((invcov*diff).*diff , 1);
end
d = sqrt(dsq);
%% Use pdist.m (Statistics Toolbox). This becomes slow. 
% [D N] = size(X);
% [D P] = size(Y);
% A = [X Y];
% % calculation of distance between X(i, :) and X(j, :) is wortheless, though
% d = squareform(pdist(A.', 'mahalanobis'));
% d = d(1:N, N+1:end); 
