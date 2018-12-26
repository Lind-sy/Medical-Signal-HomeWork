function [ idx ] = mp_lessson_version( X, D, n_iter )
% MATCHING PURSUIT - naive implementation by Gundars
% Dictionary MUST BE NORMALIZED!!!
    idx = [];
    x = zeros(n_iter,1);
    r = X;
    for ii = 1:n_iter        
        cprod = D*r';
        cprod(idx) = 0;
        [~,I] = max((cprod));
        idx = [idx, I];
        r = r - D(I,:)*cprod(I);
        sqrt(sum(r.^2))
    end
end