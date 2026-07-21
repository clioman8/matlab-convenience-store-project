function results = convenience_store_project(projectRoot)
%CONVENIENCE_STORE_PROJECT 편의점 운영 가상 사례 기반의 MATLAB 프로젝트
%   변수, 벡터, 행렬, 테이블, 조건문, 반복문, 함수, 파일 입출력,
%   시각화 및 무작위 재고 시뮬레이션을 하나의 사례로 통합합니다.
%
%   results = convenience_store_project(projectRoot)
%
%   일반적으로 저장소 루트의 run_project 함수를 통해 실행합니다.

    if nargin < 1 || isempty(projectRoot)
        sourceDir = fileparts(mfilename('fullpath'));
        projectRoot = fileparts(sourceDir);
    end

    dataDir = fullfile(projectRoot, 'data');
    resultsDir = fullfile(projectRoot, 'results');

    if ~exist(dataDir, 'dir')
        mkdir(dataDir);
    end
    if ~exist(resultsDir, 'dir')
        mkdir(resultsDir);
    end

    clc;
    fprintf('============================================================\n');
    fprintf(' 편의점 운영 가상 사례 기반의 MATLAB 프로젝트\n');
    fprintf('============================================================\n');

    %% 1. 라면 판매의 기본 손익 계산
    cost_price = 500;       % 라면 원가 (원)
    selling_price = 1000;   % 라면 판매가 (원)
    quantity_sold = 150;    % 판매 개수

    total_revenue = selling_price * quantity_sold;
    total_cost = cost_price * quantity_sold;
    profit = total_revenue - total_cost;

    fprintf('\n[1] 라면 판매 손익\n');
    fprintf('총 매출액: %d원\n', total_revenue);
    fprintf('총 원가: %d원\n', total_cost);
    fprintf('최종 영업 이익: %d원\n', profit);

    assert(profit == 75000, '라면 영업 이익 계산이 예상값과 다릅니다.');

    %% 2. 상품별 일일 판매량과 주간 총판매량
    ramen_sales = [20, 22, 25, 23, 21, 19, 24];
    drink_sales = [30, 32, 35, 33, 31, 29, 34];
    snack_sales = [15, 17, 19, 18, 16, 14, 20];

    total_ramen_sales = sum(ramen_sales);
    total_drink_sales = sum(drink_sales);
    total_snack_sales = sum(snack_sales);
    total_weekly_sales = total_ramen_sales + ...
        total_drink_sales + total_snack_sales;

    productNames = {'라면'; '음료수'; '과자'};
    weeklyQuantities = [total_ramen_sales; total_drink_sales; total_snack_sales];
    weeklySalesTable = table(productNames, weeklyQuantities, ...
        'VariableNames', {'ProductName', 'WeeklyQuantity'});

    fprintf('\n[2] 상품별 주간 총판매량\n');
    disp(weeklySalesTable);
    fprintf('전체 상품의 주간 총판매량: %d개\n', total_weekly_sales);

    assert(total_weekly_sales == 497, ...
        '전체 주간 판매량 계산이 예상값과 다릅니다.');

    %% 3. 일일 매출 계산 및 막대그래프 생성
    ramen_revenue = ramen_sales .* 1000;
    drink_revenue = drink_sales .* 1500;
    snack_revenue = snack_sales .* 800;
    daily_total_revenue = ramen_revenue + drink_revenue + snack_revenue;

    days = {'월'; '화'; '수'; '목'; '금'; '토'; '일'};
    dailyRevenueTable = table(days, ramen_revenue', drink_revenue', ...
        snack_revenue', daily_total_revenue', ...
        'VariableNames', {'Day', 'RamenRevenue', 'DrinkRevenue', ...
        'SnackRevenue', 'DailyTotalRevenue'});

    fprintf('\n[3] 일일 상품별 매출 및 총매출\n');
    disp(dailyRevenueTable);

    chartPath = fullfile(resultsDir, 'daily_total_revenue.png');
    fig = figure('Visible', 'off', 'Name', '일일 총 매출', ...
        'NumberTitle', 'off');
    bar(daily_total_revenue);
    xticks(1:7);
    xticklabels(days);
    xlabel('요일');
    ylabel('매출액 (원)');
    title('일일 총 매출');
    grid on;
    saveas(fig, chartPath);
    close(fig);
    fprintf('막대그래프 저장: %s\n', chartPath);

    %% 4. 상품별 주간 총매출과 매출 비율
    productWeeklyRevenue = [sum(ramen_revenue); ...
        sum(drink_revenue); sum(snack_revenue)];
    total_weekly_revenue = sum(productWeeklyRevenue);
    revenue_ratios = (productWeeklyRevenue ./ total_weekly_revenue) * 100;

    revenueRatioTable = table(productNames, productWeeklyRevenue, ...
        revenue_ratios, 'VariableNames', ...
        {'ProductName', 'WeeklyRevenue', 'RevenueRatioPercent'});

    fprintf('\n[4] 상품별 주간 매출 비율\n');
    disp(revenueRatioTable);
    fprintf('전체 주간 매출: %d원\n', total_weekly_revenue);

    [~, highestRevenueIndex] = max(productWeeklyRevenue);
    fprintf('매출 비중이 가장 큰 상품: %s (%.2f%%)\n', ...
        productNames{highestRevenueIndex}, revenue_ratios(highestRevenueIndex));

    assert(abs(sum(revenue_ratios) - 100) < 1e-10, ...
        '상품별 매출 비율의 합이 100%가 아닙니다.');

    weeklySummaryTable = table(productNames, weeklyQuantities, ...
        productWeeklyRevenue, revenue_ratios, ...
        'VariableNames', {'ProductName', 'WeeklyQuantity', ...
        'WeeklyRevenue', 'RevenueRatioPercent'});
    writetable(weeklySummaryTable, ...
        fullfile(resultsDir, 'weekly_summary.csv'));

    %% 5. 고객별 상품 구매 행렬 구성
    customerNames = {'김민수'; '박지우'; '이정우'; '최유리'; '홍길동'};
    purchaseMatrix = [
        3, 5, 2, 0;
        0, 1, 4, 2;
        1, 0, 0, 3;
        2, 3, 1, 1;
        4, 2, 3, 0
    ];

    customerPurchaseTable = table(customerNames, purchaseMatrix(:, 1), ...
        purchaseMatrix(:, 2), purchaseMatrix(:, 3), purchaseMatrix(:, 4), ...
        'VariableNames', {'CustomerName', 'Ramen', 'Drink', 'Snack', 'IceCream'});

    fprintf('\n[5] 고객 구매 내역 행렬\n');
    disp(purchaseMatrix);
    disp(customerPurchaseTable);

    writetable(customerPurchaseTable, ...
        fullfile(resultsDir, 'customer_purchases.csv'));

    %% 6. 주간 판매 행렬의 수정 및 부분 추출
    % 행: 월요일~금요일, 열: 라면, 음료수, 과자, 아이스크림
    salesData = [
        5, 3, 2, 4;
        6, 2, 5, 3;
        4, 4, 3, 5;
        7, 1, 4, 2;
        3, 5, 2, 1
    ];

    salesData(1, 2) = 10;           % 월요일 음료수 판매량 수정
    wednesdaySales = salesData(3, :);
    monTueSales = salesData(1:2, :);

    fprintf('\n[6] 수정된 주간 판매 데이터\n');
    disp(salesData);
    fprintf('수요일의 모든 상품 판매량:\n');
    disp(wednesdaySales);
    fprintf('월요일과 화요일의 판매 데이터:\n');
    disp(monTueSales);

    %% 7. 상품 테이블 생성, 조건 조회, 할인 적용
    my_products = {'라면', '콜라', '초코바', '사이다', '칩스'};
    my_categories = {'식품', '음료', '식품', '음료', '식품'};
    my_prices = [1000, 1500, 1200, 1500, 800];
    my_stocks = [50, 30, 40, 20, 60];

    % 누락되었던 칩스 판매량 25개를 포함합니다.
    salesQuantity = [30, 15, 20, 10, 25];
    salesAmount = my_prices .* salesQuantity;

    productTable = table(my_products', my_categories', my_prices', ...
        my_stocks', salesQuantity', salesAmount', ...
        'VariableNames', {'ProductName', 'Category', 'Price', 'Stock', ...
        'SalesQuantity', 'SalesAmount'});

    expensiveProducts = productTable(productTable.Price >= 1200, :);
    lowStockProducts = productTable(productTable.Stock <= 30, :);
    colaInfo = productTable(strcmp(productTable.ProductName, '콜라'), :);

    discountRate = 0.10;
    productTable.DiscountedPrice = productTable.Price;
    for i = 1:height(productTable)
        if productTable.Price(i) >= 1200
            productTable.DiscountedPrice(i) = applyDiscount( ...
                productTable.Price(i), discountRate);
        end
    end

    fprintf('\n[7] 상품 데이터 테이블\n');
    disp(productTable);
    fprintf('콜라 정보:\n');
    disp(colaInfo);
    fprintf('가격이 1200원 이상인 상품:\n');
    disp(expensiveProducts);
    fprintf('재고 수량이 30개 이하인 상품:\n');
    disp(lowStockProducts);

    %% 8. CSV 파일 저장 및 다시 불러오기
    csvPath = fullfile(dataDir, 'salesData.csv');
    writetable(productTable, csvPath);
    loadedTable = readtable(csvPath);

    fprintf('\n[8] CSV 파일에서 불러온 상품 판매 데이터\n');
    disp(loadedTable);
    fprintf('CSV 파일 저장 위치: %s\n', csvPath);

    %% 9. 고객 포인트: for-loop와 벡터화 비교
    pointCustomerNames = {'김민수'; '박지우'; '이정우'; '최유리'; '홍길동'};
    purchaseAmounts = [850, 1200, 950, 2000, 300];

    [pointsForLoop, pointsVectorized] = calculateCustomerPoints( ...
        purchaseAmounts, 1000, 100);

    pointsAreEqual = isequal(pointsForLoop, pointsVectorized);
    assert(pointsAreEqual, 'for-loop와 벡터화 방식의 포인트 결과가 다릅니다.');

    customerPointsTable = table(pointCustomerNames, purchaseAmounts', ...
        pointsForLoop', pointsVectorized', ...
        'VariableNames', {'CustomerName', 'PurchaseAmount', ...
        'PointsForLoop', 'PointsVectorized'});

    fprintf('\n[9] 고객 포인트 적립 결과\n');
    disp(customerPointsTable);
    fprintf('두 계산 방법의 결과가 동일한가? %d\n', pointsAreEqual);

    writetable(customerPointsTable, ...
        fullfile(resultsDir, 'customer_points.csv'));

    %% 10. while-loop 기반 라면 재고 소진 시뮬레이션
    fprintf('\n[10] 라면 재고 소진 시뮬레이션\n');
    previousRngState = rng;
    rng(42, 'twister'); % 동일한 예시 결과를 위한 난수 시드
    inventoryHistory = simulateRamenInventory(20, true);
    rng(previousRngState); % 사용자의 기존 난수 상태 복원

    writetable(inventoryHistory, ...
        fullfile(resultsDir, 'ramen_inventory_history.csv'));

    assert(sum(inventoryHistory.RamenSold) == 20, ...
        '시뮬레이션의 총 판매량이 초기 재고와 다릅니다.');
    assert(inventoryHistory.RemainingStock(end) == 0, ...
        '시뮬레이션 종료 후 재고가 0이 아닙니다.');

    %% 11. 실행 결과 구조체 저장
    results = struct();
    results.BasicProfit = profit;
    results.WeeklySales = weeklySalesTable;
    results.DailyRevenue = dailyRevenueTable;
    results.RevenueRatios = revenueRatioTable;
    results.CustomerPurchases = customerPurchaseTable;
    results.ModifiedSalesData = salesData;
    results.WednesdaySales = wednesdaySales;
    results.MondayTuesdaySales = monTueSales;
    results.ProductTable = productTable;
    results.ExpensiveProducts = expensiveProducts;
    results.LowStockProducts = lowStockProducts;
    results.LoadedTable = loadedTable;
    results.CustomerPoints = customerPointsTable;
    results.InventoryHistory = inventoryHistory;

    resultMatPath = fullfile(resultsDir, 'project_results.mat');
    save(resultMatPath, 'results');

    fprintf('\n============================================================\n');
    fprintf(' 프로젝트 실행이 완료되었습니다.\n');
    fprintf(' 결과 폴더: %s\n', resultsDir);
    fprintf(' MAT 결과 파일: %s\n', resultMatPath);
    fprintf('============================================================\n');
end
