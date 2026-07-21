[README.md](https://github.com/user-attachments/files/30228049/README.md)
# matlab-convenience-store-project
A MATLAB-based convenience store operations simulation covering sales analysis, profit calculation, visualization, discounts, customer points, CSV I/O, inventory control, and testing.
# 편의점 운영 가상 사례 기반의 MATLAB 프로젝트 수행

편의점의 상품·판매·고객·재고 데이터를 하나의 가상 운영 사례로 통합한 MATLAB 학습 프로젝트이다. 기초 변수 계산에서 시작하여 벡터와 행렬, 테이블, 논리 인덱싱, 조건문과 반복문, 사용자 정의 함수, CSV 입출력, 그래프 작성, 무작위 재고 시뮬레이션, 단위 테스트까지 단계적으로 다룬다.

## 프로젝트에서 구현한 기능

1. 라면의 원가·판매가·판매량을 이용한 총매출, 총원가, 영업이익 계산
2. 라면·음료수·과자의 일일 판매량 벡터와 주간 총판매량 계산
3. 상품별 일일 매출 및 일일 총매출 계산과 막대그래프 저장
4. 상품별 주간 매출액과 전체 매출 비율 계산
5. 고객별 구매 내역을 행렬과 테이블로 구성
6. 주간 판매 행렬의 특정 원소 수정, 특정 행 및 부분 행렬 추출
7. 상품 테이블 생성, 콜라 조회, 고가 상품·저재고 상품 필터링
8. `applyDiscount` 함수를 이용한 조건부 10% 할인 적용
9. 상품 판매 테이블을 CSV로 저장하고 다시 불러오기
10. 고객 포인트를 for-loop와 벡터화 방식으로 각각 계산하고 결과 비교
11. while-loop와 `randi`를 이용한 라면 재고 소진 시뮬레이션
12. 핵심 함수의 MATLAB 단위 테스트

## 폴더 구조

```text
matlab-convenience-store-project/
├── README.md
├── LICENSE
├── .gitignore
├── run_project.m
├── run_tests.m
├── src/
│   ├── convenience_store_project.m
│   ├── applyDiscount.m
│   ├── calculateCustomerPoints.m
│   └── simulateRamenInventory.m
├── data/
│   └── salesData.csv
├── results/
│   └── 실행 시 결과 파일 생성
└── tests/
    └── testConvenienceStoreProject.m
```

## 실행 환경

- MATLAB R2020a 이상 권장
- 별도의 툴박스는 필요하지 않음

## 실행 방법

MATLAB에서 저장소의 루트 폴더를 현재 폴더로 지정한 뒤 다음 명령을 실행한다.

```matlab
results = run_project();
```

`results` 구조체에는 주요 계산 결과와 테이블이 저장된다.

```matlab
results.BasicProfit
results.WeeklySales
results.DailyRevenue
results.ProductTable
results.CustomerPoints
results.InventoryHistory
```

## 테스트 실행

```matlab
testResults = run_tests();
```

테스트는 다음 사항을 확인한다.

- 10% 할인 계산의 정확성
- for-loop와 벡터화 포인트 결과의 일치
- 재고 시뮬레이션에서 총판매량이 초기 재고와 같고 최종 재고가 0인지 여부

## 핵심 예상 결과

| 항목 | 결과 |
|---|---:|
| 라면 영업이익 | 75,000원 |
| 라면 주간 판매량 | 154개 |
| 음료수 주간 판매량 | 224개 |
| 과자 주간 판매량 | 119개 |
| 전체 주간 판매량 | 497개 |
| 전체 주간 매출 | 585,200원 |
| 가장 큰 매출 비중 | 음료수, 약 57.42% |
| 고객 포인트 | `[0, 12, 0, 20, 0]` |

10% 할인 적용 후 가격은 다음과 같다.

| 상품 | 기존 가격 | 할인 가격 |
|---|---:|---:|
| 라면 | 1,000원 | 1,000원 |
| 콜라 | 1,500원 | 1,350원 |
| 초코바 | 1,200원 | 1,080원 |
| 사이다 | 1,500원 | 1,350원 |
| 칩스 | 800원 | 800원 |

## 실행 후 생성되는 파일

- `data/salesData.csv`: 상품 판매 및 할인 데이터
- `results/daily_total_revenue.png`: 일일 총매출 막대그래프
- `results/weekly_summary.csv`: 상품별 주간 판매량·매출·비율
- `results/customer_purchases.csv`: 고객별 상품 구매 내역
- `results/customer_points.csv`: 고객별 포인트 계산 결과
- `results/ramen_inventory_history.csv`: 거래별 라면 판매량과 잔여 재고
- `results/project_results.mat`: 주요 결과를 묶은 MATLAB 구조체

## 주요 MATLAB 문법

```matlab
% 요소별 곱셈
salesAmount = prices .* quantities;

% 논리적 인덱싱
expensiveProducts = productTable(productTable.Price >= 1200, :);

% 부분 행렬 추출
wednesdaySales = salesData(3, :);
monTueSales = salesData(1:2, :);

% 테이블 CSV 저장 및 불러오기
writetable(productTable, 'salesData.csv');
loadedTable = readtable('salesData.csv');
```

## 확장 아이디어

- 안전재고 이하 상품에 대한 자동 발주 알림
- 상품별 원가를 추가한 실제 영업이익 분석
- 월별·분기별 매출 추세와 이동평균 분석
- App Designer를 이용한 편의점 운영 대시보드
- 데이터베이스 또는 외부 POS 데이터와의 연동

## GitHub 저장소로 등록하는 예시

프로젝트 폴더에서 다음 명령을 실행한다. `<YOUR_REPOSITORY_URL>`은 GitHub에서 만든 빈 저장소 주소로 바꾼다.

```bash
git init
git add .
git commit -m "Complete MATLAB convenience store project"
git branch -M main
git remote add origin <YOUR_REPOSITORY_URL>
git push -u origin main
```
