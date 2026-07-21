function discountedPrice = applyDiscount(originalPrice, discountRate)
%APPLYDISCOUNT 원래 가격에 할인율을 적용하여 할인 가격을 반환합니다.
%   discountedPrice = applyDiscount(originalPrice, discountRate)
%
%   입력값
%       originalPrice : 0 이상의 숫자 스칼라 또는 배열
%       discountRate  : 0 이상 1 이하의 할인율 스칼라
%
%   예시
%       applyDiscount(1500, 0.10)   % 결과: 1350

    validateattributes(originalPrice, {'numeric'}, ...
        {'real', 'nonnegative'}, mfilename, 'originalPrice');
    validateattributes(discountRate, {'numeric'}, ...
        {'real', 'scalar', '>=', 0, '<=', 1}, mfilename, 'discountRate');

    discountedPrice = originalPrice .* (1 - discountRate);
end
