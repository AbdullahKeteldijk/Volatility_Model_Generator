
function [NW_std_errors] = NeweyWest_stderror_like_EViews ( mX, vResiduals  ) 

iT = size(mX,1);
iK = size(mX,2);

iM = ceil( 4*(iT/100)^(2/9) );

vIota_T   = ones(iT,1);
vOne_to_T = (1:iT)';

mAbs_i_minus_j = abs(vIota_T * vOne_to_T' - vOne_to_T * vIota_T');
mW = ( ones(iT,iT) - mAbs_i_minus_j*(1/(iM)) ) .* (mAbs_i_minus_j <= iM);
mOmega_hat = (vResiduals * vResiduals') .* mW;

mInv_XX = inv(mX'*mX);
cov_matrix_OLS_estimator = (iT/(iT-iK)) * mInv_XX * (mX'*mOmega_hat*mX) * mInv_XX;

NW_std_errors = sqrt( diag(cov_matrix_OLS_estimator)' );



% Note:
% This code is far from optimized.
% For example: For T > 5000, there may not be enough memory.


% Note: with test set 
%
% residuen = [1,2,3, -1-2,-3]'; 
% 
% X = [1,1,1,1,1,1]';
% 
% this gives EXACTLY the same answer as EViews 7
% with 'default' HAC standard error.



