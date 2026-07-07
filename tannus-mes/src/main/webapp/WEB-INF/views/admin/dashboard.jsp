<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 대시보드</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        * {
            box-sizing: border-box;
        }

        html {
            width: 100%;
            overflow-x: hidden;
        }

        body {
            margin: 0;
            width: 100%;
            min-height: 100vh;
            overflow-x: hidden;
            font-family: "Malgun Gothic", sans-serif;
            color: #1f2937;
            background:
                    radial-gradient(circle at top left, rgba(30, 136, 229, 0.18), transparent 34%),
                    radial-gradient(circle at top right, rgba(46, 125, 50, 0.12), transparent 28%),
                    linear-gradient(180deg, #f7faff 0%, #eef2f7 100%);
        }

        a {
            color: inherit;
        }

        .wrap {
            max-width: 1320px;
            margin: 0 auto;
            padding: 28px 22px 42px;
        }

        .top-box {
            position: relative;
            overflow: hidden;
            background:
                    linear-gradient(135deg, rgba(21, 101, 192, 0.98), rgba(30, 136, 229, 0.94)),
                    radial-gradient(circle at 85% 20%, rgba(255,255,255,0.35), transparent 28%);
            color: white;
            padding: 28px 32px;
            border-radius: 24px;
            margin-bottom: 22px;
            box-shadow: 0 18px 45px rgba(21, 101, 192, 0.22);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
        }

        .top-box:after {
            content: "";
            position: absolute;
            right: -55px;
            bottom: -70px;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: rgba(255,255,255,0.12);
        }

        .top-title {
            position: relative;
            z-index: 1;
        }

        .top-box h1 {
            margin: 0 0 8px;
            font-size: 30px;
            letter-spacing: -1px;
        }

        .top-box p {
            margin: 0;
            opacity: 0.92;
            font-size: 14px;
            line-height: 1.7;
        }

        .top-right {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .login-user {
            font-size: 13px;
            font-weight: 800;
            background: rgba(255,255,255,0.18);
            border: 1px solid rgba(255,255,255,0.22);
            padding: 10px 14px;
            border-radius: 999px;
            backdrop-filter: blur(8px);
        }

        .logout-btn {
            text-decoration: none;
            background: white;
            color: #1565c0;
            padding: 10px 15px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 900;
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }

        .section-title {
            margin: 6px 0 12px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .section-title h2 {
            margin: 0;
            font-size: 18px;
            color: #111827;
            letter-spacing: -0.4px;
        }

        .section-title span {
            font-size: 12px;
            color: #64748b;
            font-weight: 700;
        }

        .menu-row {
            display: grid;
            grid-template-columns: repeat(7, minmax(0, 1fr));
            gap: 14px;
            margin-bottom: 22px;
        }

        .menu-card {
            position: relative;
            overflow: hidden;
            background: rgba(255,255,255,0.92);
            border: 1px solid rgba(226,232,240,0.9);
            border-radius: 22px;
            padding: 18px 16px 16px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.07);
            min-height: 164px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.18s ease, box-shadow 0.18s ease;
        }

        .menu-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 38px rgba(15, 23, 42, 0.12);
        }

        .menu-card:before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #1e88e5, #64b5f6);
        }

        .menu-card.green:before {
            background: linear-gradient(90deg, #2e7d32, #66bb6a);
        }

        .menu-card.orange:before {
            background: linear-gradient(90deg, #fb8c00, #ffb74d);
        }

        .menu-card.pink:before {
            background: linear-gradient(90deg, #d81b60, #f06292);
        }

        .menu-card.purple:before {
            background: linear-gradient(90deg, #6a1b9a, #ab47bc);
        }

        .menu-card.gray:before {
            background: linear-gradient(90deg, #455a64, #78909c);
        }

        .menu-card h3 {
            margin: 0;
            font-size: 15px;
            color: #111827;
            letter-spacing: -0.4px;
        }

        .menu-card .count {
            font-size: 30px;
            line-height: 1;
            font-weight: 900;
            color: #1565c0;
            margin: 12px 0 8px;
        }

        .menu-card.green .count {
            color: #2e7d32;
        }

        .menu-card.purple .count {
            color: #6a1b9a;
        }

        .menu-card.gray .count {
            color: #455a64;
        }

        .menu-card .desc {
            font-size: 12px;
            color: #64748b;
            margin-bottom: 12px;
            line-height: 1.55;
            min-height: 38px;
            word-break: keep-all;
        }

        .mini-count {
            display: flex;
            gap: 7px;
            margin: 12px 0 10px;
        }

        .mini-count span {
            flex: 1;
            background: #f1f5f9;
            border-radius: 12px;
            padding: 8px 5px;
            font-size: 11px;
            font-weight: 900;
            text-align: center;
            color: #1565c0;
            white-space: nowrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            text-decoration: none;
            min-height: 36px;
            padding: 9px 10px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 900;
            background: #1e88e5;
            color: white;
            border: none;
            box-shadow: 0 7px 16px rgba(30, 136, 229, 0.20);
        }

        .btn:hover {
            opacity: 0.93;
        }

        .btn-green {
            background: #2e7d32;
            box-shadow: 0 7px 16px rgba(46, 125, 50, 0.20);
        }

        .btn-orange {
            background: #fb8c00;
            box-shadow: 0 7px 16px rgba(251, 140, 0, 0.20);
        }

        .btn-purple {
            background: #6a1b9a;
            box-shadow: 0 7px 16px rgba(106, 27, 154, 0.20);
        }

        .btn-gray {
            background: #455a64;
            box-shadow: 0 7px 16px rgba(69, 90, 100, 0.20);
        }

        .btn-pink {
            background: #d81b60;
            box-shadow: 0 7px 16px rgba(216, 27, 96, 0.20);
        }

        .btn-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
        }

        .chart-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .chart-card {
            background: rgba(255,255,255,0.95);
            border: 1px solid rgba(226,232,240,0.9);
            border-radius: 24px;
            padding: 22px;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.08);
        }

        .chart-card h3 {
            margin: 0 0 6px;
            font-size: 20px;
            color: #111827;
            letter-spacing: -0.5px;
        }

        .chart-card p {
            margin: 0 0 18px;
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        .chart-content {
            display: grid;
            grid-template-columns: 210px 1fr;
            gap: 20px;
            align-items: center;
        }

        .donut-box {
            width: 210px;
            height: 210px;
            margin: 0 auto;
            background: #f8fafc;
            border-radius: 50%;
            padding: 5px;
        }

        .donut-box canvas {
            width: 100% !important;
            height: 100% !important;
        }

        .rate-box {
            margin-bottom: 16px;
        }

        .rate-item {
            background: linear-gradient(180deg, #f8fafc, #eef4ff);
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 20px;
        }

        .rate-item span {
            display: block;
            font-size: 13px;
            color: #64748b;
            margin-bottom: 7px;
            font-weight: 800;
        }

        .rate-item strong {
            font-size: 38px;
            color: #1565c0;
            letter-spacing: -1px;
        }

        .chart-card.export .rate-item strong {
            color: #2e7d32;
        }

        .chart-btn-box {
            margin-top: 14px;
        }

        .chart-btn-box .btn {
            min-width: 130px;
        }

        .deadline-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-top: 18px;
        }

        .deadline-card {
            background: rgba(255,255,255,0.95);
            border: 1px solid rgba(226,232,240,0.9);
            border-radius: 24px;
            padding: 20px 22px;
            box-shadow: 0 12px 30px rgba(15, 23, 42, 0.08);
        }

        .deadline-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 16px;
        }

        .deadline-head h3 {
            margin: 0 0 6px;
            font-size: 20px;
            color: #111827;
            letter-spacing: -0.5px;
        }

        .deadline-head p {
            margin: 0;
            color: #64748b;
            font-size: 13px;
            line-height: 1.6;
        }

        .deadline-head span {
            background: #eef4ff;
            color: #1565c0;
            padding: 8px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .deadline-row {
            display: grid;
            grid-template-columns: repeat(5, minmax(0, 1fr));
            gap: 9px;
        }

        .deadline-item {
            border-radius: 18px;
            padding: 14px 8px;
            text-align: center;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
        }

        .deadline-item span {
            display: block;
            font-size: 13px;
            font-weight: 900;
            margin-bottom: 7px;
        }

        .deadline-item strong {
            display: block;
            font-size: 30px;
            line-height: 1;
            font-weight: 900;
            margin-bottom: 6px;
        }

        .deadline-item em {
            font-style: normal;
            font-size: 11px;
            color: #64748b;
            word-break: keep-all;
        }

        .deadline-item.blue strong,
        .deadline-item.blue span {
            color: #1565c0;
        }

        .deadline-item.sky strong,
        .deadline-item.sky span {
            color: #039be5;
        }

        .deadline-item.green strong,
        .deadline-item.green span {
            color: #2e7d32;
        }

        .deadline-item.orange strong,
        .deadline-item.orange span {
            color: #fb8c00;
        }

        .deadline-item.red strong,
        .deadline-item.red span {
            color: #e53935;
        }

        @media (max-width: 1200px) {
            .menu-row {
                grid-template-columns: repeat(4, minmax(0, 1fr));
            }

            .deadline-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 1024px) {
            .wrap {
                padding: 24px 18px 36px;
            }

            .top-box {
                padding: 26px 26px;
                align-items: flex-start;
            }

            .top-box h1 {
                font-size: 28px;
            }

            .menu-row {
                grid-template-columns: repeat(3, minmax(0, 1fr));
            }

            .chart-row {
                grid-template-columns: 1fr;
            }

            .chart-content {
                grid-template-columns: 220px 1fr;
            }
        }

        @media (max-width: 768px) {
            .wrap {
                padding: 18px 14px 32px;
            }

            .top-box {
                display: flex;
                flex-direction: column;
                padding: 24px 20px;
                border-radius: 22px;
            }

            .top-box h1 {
                font-size: 25px;
                line-height: 1.25;
            }

            .top-box p {
                font-size: 13px;
                word-break: keep-all;
            }

            .top-right {
                width: 100%;
                margin-top: 4px;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
            }

            .login-user,
            .logout-btn {
                width: 100%;
                text-align: center;
            }

            .section-title {
                align-items: flex-start;
                gap: 4px;
                flex-direction: column;
                margin-top: 16px;
            }

            .menu-row {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 12px;
            }

            .menu-card {
                min-height: 150px;
                padding: 17px 15px 15px;
                border-radius: 20px;
            }

            .menu-card .count {
                font-size: 28px;
            }

            .mini-count {
                grid-template-columns: 1fr;
            }

            .chart-card,
            .deadline-card {
                padding: 18px 16px;
                border-radius: 22px;
            }

            .chart-card h3,
            .deadline-head h3 {
                font-size: 18px;
            }

            .chart-content {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .donut-box {
                width: 190px;
                height: 190px;
            }

            .rate-item {
                padding: 18px;
                text-align: center;
            }

            .rate-item strong {
                font-size: 34px;
            }

            .chart-btn-box .btn {
                width: 100%;
            }

            .deadline-head {
                flex-direction: column;
                align-items: stretch;
            }

            .deadline-head span {
                width: fit-content;
            }

            .deadline-row {
                grid-template-columns: repeat(5, minmax(82px, 1fr));
                overflow-x: auto;
                padding-bottom: 4px;
            }

            .deadline-item {
                min-width: 82px;
            }
        }

        @media (max-width: 560px) {
            .wrap {
                padding: 14px 10px 28px;
            }

            .top-box {
                padding: 22px 16px;
                border-radius: 20px;
                margin-bottom: 18px;
            }

            .top-box h1 {
                font-size: 23px;
            }

            .top-right {
                grid-template-columns: 1fr;
            }

            .menu-row {
                grid-template-columns: 1fr;
            }

            .menu-card {
                min-height: auto;
            }

            .btn-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
            }

            .btn {
                width: 100%;
                min-height: 38px;
            }

            .chart-row,
            .deadline-grid {
                gap: 14px;
            }

            .donut-box {
                width: 170px;
                height: 170px;
            }

            .deadline-row {
                grid-template-columns: repeat(5, minmax(78px, 1fr));
                gap: 8px;
            }

            .deadline-item {
                min-width: 78px;
                padding: 12px 6px;
            }

            .deadline-item strong {
                font-size: 26px;
            }

            .deadline-item em {
                font-size: 10px;
            }
        }

        @media (max-width: 380px) {
            .btn-row {
                grid-template-columns: 1fr;
            }

            .mini-count {
                display: grid;
                grid-template-columns: 1fr;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <div class="top-title">
            <h1>관리자 대시보드</h1>
            <p>포장 지시, 수출 지시, 수정 요청, 상품 관리, 재고 현황을 한눈에 확인합니다.</p>
        </div>

        <div class="top-right">
            <div class="login-user">${loginUser} 님</div>
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">로그아웃</a>
        </div>
    </div>

    <div class="section-title">
        <h2>주요 업무 메뉴</h2>
        <span>관리자 전용</span>
    </div>

    <div class="menu-row">

        <div class="menu-card">
            <div>
                <h3>포장 지시</h3>
                <div class="count">${packingTotalCount}</div>
                <div class="desc">포장팀 작업 지시 관리</div>
            </div>
            <a class="btn" href="${pageContext.request.contextPath}/admin/packing/list">상세보기</a>
        </div>

        <div class="menu-card green">
            <div>
                <h3>수출 지시</h3>
                <div class="count">${exportTotalCount}</div>
                <div class="desc">물류팀 출고 지시 관리</div>
            </div>
            <a class="btn btn-green" href="${pageContext.request.contextPath}/admin/export/list">상세보기</a>
        </div>

        <div class="menu-card orange">
            <div>
                <h3>지시 수정 요청</h3>

                <div class="mini-count">
                    <span>포장 ${empty packingChangeCount ? 0 : packingChangeCount}건</span>
                    <span>수출 ${empty exportChangeCount ? 0 : exportChangeCount}건</span>
                </div>

                <div class="desc">
                    포장팀 / 물류팀<br>
                    지시 수정 요청 확인
                </div>
            </div>

            <div class="btn-row">
                <a class="btn btn-orange"
                   href="${pageContext.request.contextPath}/admin/packing/change-request/list">
                    포장팀
                </a>

                <a class="btn btn-orange"
                   href="${pageContext.request.contextPath}/admin/export/change-request/list">
                    수출팀
                </a>
            </div>
        </div>

        <div class="menu-card orange">
            <div>
                <h3>무발주 수정 요청</h3>

                <div class="mini-count">
                    <span>포장 ${empty unplannedPackingCount ? 0 : unplannedPackingCount}건</span>
                    <span>물류 ${empty unplannedLogisticsCount ? 0 : unplannedLogisticsCount}건</span>
                </div>

                <div class="desc">
                    포장팀 / 물류팀<br>
                    무발주 매입 요청 확인
                </div>
            </div>

            <div class="btn-row">
                <a class="btn btn-orange"
                   href="${pageContext.request.contextPath}/admin/unplanned/list?requestUser=포장팀">
                    포장팀
                </a>

                <a class="btn btn-orange"
                   href="${pageContext.request.contextPath}/admin/unplanned/list?requestUser=물류팀">
                    물류팀
                </a>
            </div>
        </div>

        <div class="menu-card pink">

            <div>
                <h3>상품 관리</h3>

                <div class="mini-count">
                    <span>상품 등록</span>
                    <span>기본수량 수정</span>
                </div>

                <div class="desc">
                    신규 상품 등록<br>
                    기본수량 변경
                </div>
            </div>

            <div class="btn-row">

                <a class="btn btn-pink"
                   href="${pageContext.request.contextPath}/admin/item/new">
                    등록
                </a>

                <a class="btn btn-pink"
                   href="${pageContext.request.contextPath}/admin/item/base-qty/edit">
                    수정
                </a>

            </div>

        </div>


        <div class="menu-card purple">
            <div>
                <h3>재고 조회</h3>
                <div class="count">${stockTotalCount}</div>
                <div class="desc">현재 재고 확인 / 관리자 재고 조정</div>
            </div>
            <a class="btn btn-purple" href="${pageContext.request.contextPath}/stock/list">조회하기</a>
        </div>

        <div class="menu-card gray">
            <div>
                <h3>재고 히스토리</h3>
                <div class="count">LOG</div>
                <div class="desc">상품별 입고/출고/조정 이력</div>
            </div>
            <a class="btn btn-gray" href="${pageContext.request.contextPath}/stock/history">보기</a>
        </div>

    </div>

    <div class="section-title">
        <h2>올해 처리 현황</h2>
        <span>${year}년 기준</span>
    </div>

    <div class="chart-row">

        <div class="chart-card">
            <h3>올해 포장 처리율</h3>
            <p>${year}년 포장 지시 대비 포장완료 + 주문취소 처리율입니다.</p>

            <div class="chart-content">
                <div class="donut-box">
                    <canvas id="packingChart"></canvas>
                </div>

                <div>
                    <div class="rate-box">
                        <div class="rate-item">
                            <span>올해 전체 처리율</span>
                            <strong>${yearPackingRate}%</strong>
                        </div>
                    </div>

                    <div class="chart-btn-box">
                        <a class="btn" href="${pageContext.request.contextPath}/admin/stats/packing">
                            자세히 보기
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="chart-card export">
            <h3>올해 물류 출고율</h3>
            <p>${year}년 수출 지시 대비 출고 완료율입니다.</p>

            <div class="chart-content">
                <div class="donut-box">
                    <canvas id="exportChart"></canvas>
                </div>

                <div>
                    <div class="rate-box">
                        <div class="rate-item">
                            <span>올해 전체 출고율</span>
                            <strong>${yearExportRate}%</strong>
                        </div>
                    </div>

                    <div class="chart-btn-box">
                        <a class="btn btn-green" href="${pageContext.request.contextPath}/admin/stats/export">
                            자세히 보기
                        </a>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="deadline-grid">

        <div class="deadline-card">

            <div class="deadline-head">
                <div>
                    <h3>포장 납기 현황</h3>
                    <p>요청일 대비 아직 처리되지 않은 포장대기 건수입니다.</p>
                </div>
                <span>요청일 기준</span>
            </div>

            <div class="deadline-row">

                <div class="deadline-item blue">
                    <span>D-2</span>
                    <strong>${dMinus2Count}</strong>
                    <em>2일 남음</em>
                </div>

                <div class="deadline-item sky">
                    <span>D-1</span>
                    <strong>${dMinus1Count}</strong>
                    <em>1일 남음</em>
                </div>

                <div class="deadline-item green">
                    <span>D-Day</span>
                    <strong>${dDayCount}</strong>
                    <em>오늘 요청</em>
                </div>

                <div class="deadline-item orange">
                    <span>+1</span>
                    <strong>${dPlus1Count}</strong>
                    <em>1일 지남</em>
                </div>

                <div class="deadline-item red">
                    <span>+2 이상</span>
                    <strong>${dPlus2Count}</strong>
                    <em>2일 이상 지남</em>
                </div>

            </div>

        </div>

        <div class="deadline-card">

            <div class="deadline-head">
                <div>
                    <h3>수출 납기 현황</h3>
                    <p>요청일 대비 아직 출고 완료되지 않은 수출대기 건수입니다.</p>
                </div>
                <span>요청일 기준</span>
            </div>

            <div class="deadline-row">

                <div class="deadline-item blue">
                    <span>D-2</span>
                    <strong>${exportDMinus2Count}</strong>
                    <em>2일 남음</em>
                </div>

                <div class="deadline-item sky">
                    <span>D-1</span>
                    <strong>${exportDMinus1Count}</strong>
                    <em>1일 남음</em>
                </div>

                <div class="deadline-item green">
                    <span>D-Day</span>
                    <strong>${exportDDayCount}</strong>
                    <em>오늘 요청</em>
                </div>

                <div class="deadline-item orange">
                    <span>+1</span>
                    <strong>${exportDPlus1Count}</strong>
                    <em>1일 지남</em>
                </div>

                <div class="deadline-item red">
                    <span>+2 이상</span>
                    <strong>${exportDPlus2Count}</strong>
                    <em>2일 이상 지남</em>
                </div>

            </div>

        </div>

    </div>

</div>

<script>
    window.addEventListener("pageshow", function(event) {
        if (event.persisted) {
            window.location.reload();
        }
    });

    const yearPackingRate = Number("${yearPackingRate}" || 0);
    const yearExportRate = Number("${yearExportRate}" || 0);

    new Chart(document.getElementById("packingChart"), {
        type: "doughnut",
        data: {
            labels: ["처리완료", "미완료"],
            datasets: [{
                data: [yearPackingRate, 100 - yearPackingRate],
                backgroundColor: ["#1565c0", "#e5e7eb"],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: "68%",
            plugins: {
                legend: {
                    position: "bottom"
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            if (context.label === "처리완료") {
                                return "처리완료(포장완료/출고/입고/주문취소): " + context.raw + "%";
                            }
                            return "미완료: " + context.raw + "%";
                        }
                    }
                }
            }
        }
    });

    new Chart(document.getElementById("exportChart"), {
        type: "doughnut",
        data: {
            labels: ["출고완료", "미출고"],
            datasets: [{
                data: [yearExportRate, 100 - yearExportRate],
                backgroundColor: ["#2e7d32", "#e5e7eb"],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: "68%",
            plugins: {
                legend: {
                    position: "bottom"
                }
            }
        }
    });
</script>

</body>
</html>
