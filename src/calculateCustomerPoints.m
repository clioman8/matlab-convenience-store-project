function [pointsForLoop, pointsVectorized] = calculateCustomerPoints( ...
    purchaseAmounts, minimumPurchase, amountPerPoint)
%CALCULATECUSTOMERPOINTS for-loop과 벡터화 방식으로 고객 포인트를 계산합니다.
%   구매 금액이 minimumPurchase 이상일 때 amountPerPoint원당 1포인트를
%   적립하며, 나머지 금액은 버립니다.
%
%   예시
%       amounts = [850, 1200, 950, 2000, 300];
%       [loopPoints, vectorPoints] = ...
%           calculateCustomerPoints(amounts, 1000, 100);

    if nargin < 2 || isempty(minimumPurchase)
        minimumPurchase = 1000;
    end
    if nargin < 3 || isempty(amountPerPoint)
        amountPerPoint = 100;
    end

    validateattributes(purchaseAmounts, {'numeric'}, ...
        {'real', 'vector', 'nonnegative'}, mfilename, 'purchaseAmounts');
    validateattributes(minimumPurchase, {'numeric'}, ...
        {'real', 'scalar', 'nonnegative'}, mfilename, 'minimumPurchase');
    validateattributes(amountPerPoint, {'numeric'}, ...
        {'real', 'scalar', 'positive'}, mfilename, 'amountPerPoint');

    % 방법 1: for-loop
    pointsForLoop = zeros(size(purchaseAmounts));
    for i = 1:numel(purchaseAmounts)
        if purchaseAmounts(i) >= minimumPurchase
            pointsForLoop(i) = floor(purchaseAmounts(i) / amountPerPoint);
        end
    end

    % 방법 2: 벡터화
    pointsVectorized = floor(purchaseAmounts ./ amountPerPoint);
    belowMinimum = purchaseAmounts < minimumPurchase;
    pointsVectorized(belowMinimum) = 0;
end
