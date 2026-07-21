function tests = testConvenienceStoreProject
%TESTCONVENIENCESTOREPROJECT 핵심 계산 함수의 단위 테스트
    tests = functiontests(localfunctions);
end

function setupOnce(testCase)
    testFile = mfilename('fullpath');
    testDir = fileparts(testFile);
    projectRoot = fileparts(testDir);
    sourceDir = fullfile(projectRoot, 'src');

    addpath(sourceDir);
    testCase.TestData.SourceDir = sourceDir;
end

function teardownOnce(testCase)
    rmpath(testCase.TestData.SourceDir);
end

function testApplyDiscount(testCase)
    actual = applyDiscount([1000, 1500, 1200], 0.10);
    expected = [900, 1350, 1080];
    verifyEqual(testCase, actual, expected, 'AbsTol', 1e-12);
end

function testCustomerPoints(testCase)
    purchaseAmounts = [850, 1200, 950, 2000, 300];
    [loopPoints, vectorPoints] = calculateCustomerPoints( ...
        purchaseAmounts, 1000, 100);

    expected = [0, 12, 0, 20, 0];
    verifyEqual(testCase, loopPoints, expected);
    verifyEqual(testCase, vectorPoints, expected);
    verifyEqual(testCase, loopPoints, vectorPoints);
end

function testInventorySimulation(testCase)
    previousRngState = rng;
    rng(1, 'twister');
    history = simulateRamenInventory(20, false);
    rng(previousRngState);

    verifyEqual(testCase, sum(history.RamenSold), 20);
    verifyEqual(testCase, history.RemainingStock(end), 0);
    verifyGreaterThanOrEqual(testCase, min(history.RamenSold), 1);
    verifyLessThanOrEqual(testCase, max(history.RamenSold), 5);
    verifyGreaterThanOrEqual(testCase, min(history.RemainingStock), 0);
end
