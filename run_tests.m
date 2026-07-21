function testResults = run_tests()
%RUN_TESTS 프로젝트의 MATLAB 단위 테스트를 실행합니다.

    projectRoot = fileparts(mfilename('fullpath'));
    testDir = fullfile(projectRoot, 'tests');

    testResults = runtests(testDir);
    disp(testResults);
end
