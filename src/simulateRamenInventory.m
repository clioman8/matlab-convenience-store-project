function inventoryHistory = simulateRamenInventory(initialStock, printProgress)
%SIMULATERAMENINVENTORY while-loop으로 라면 재고 소진 과정을 모의실험합니다.
%   매 거래마다 1~5개가 무작위로 판매되며, 남은 재고보다 많이
%   판매되지 않도록 판매량을 조정합니다.
%
%   inventoryHistory = simulateRamenInventory(20, true)
%
%   반환 테이블의 열
%       Transaction    : 거래 순번
%       RamenSold      : 해당 거래의 판매량
%       RemainingStock : 거래 후 남은 재고

    if nargin < 1 || isempty(initialStock)
        initialStock = 20;
    end
    if nargin < 2 || isempty(printProgress)
        printProgress = true;
    end

    validateattributes(initialStock, {'numeric'}, ...
        {'real', 'scalar', 'integer', 'positive'}, mfilename, 'initialStock');
    validateattributes(printProgress, {'logical', 'numeric'}, ...
        {'scalar'}, mfilename, 'printProgress');

    ramenStock = initialStock;

    % 한 번에 최소 1개씩 팔리므로 거래 횟수의 최댓값은 initialStock입니다.
    history = zeros(initialStock, 3);
    transaction = 0;

    while ramenStock > 0
        ramenSold = randi([1, 5]);
        ramenSold = min(ramenSold, ramenStock);

        ramenStock = ramenStock - ramenSold;
        transaction = transaction + 1;
        history(transaction, :) = [transaction, ramenSold, ramenStock];

        if logical(printProgress)
            fprintf('판매된 라면 개수: %d, 남은 재고: %d\n', ...
                ramenSold, ramenStock);
        end
    end

    if logical(printProgress)
        fprintf('라면 재고가 모두 소진되었습니다.\n');
    end

    history = history(1:transaction, :);
    inventoryHistory = array2table(history, ...
        'VariableNames', {'Transaction', 'RamenSold', 'RemainingStock'});
end
