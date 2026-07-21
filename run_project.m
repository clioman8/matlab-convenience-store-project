function results = run_project()
%RUN_PROJECT 편의점 운영 가상 사례 기반 MATLAB 프로젝트 실행 파일
%   저장소 루트 폴더에서 다음 명령으로 실행합니다.
%       results = run_project();

    projectRoot = fileparts(mfilename('fullpath'));
    sourceDir = fullfile(projectRoot, 'src');

    addpath(sourceDir);
    cleanupObj = onCleanup(@() rmpath(sourceDir)); %#ok<NASGU>

    results = convenience_store_project(projectRoot);
end
