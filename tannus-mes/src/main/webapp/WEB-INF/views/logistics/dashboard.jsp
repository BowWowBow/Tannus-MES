<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>물류팀 대시보드</title>

    <style>
        :root {
            --green: #16a34a;
            --green-dark: #15803d;
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --gray: #334155;
            --purple: #7c3aed;
            --orange: #f59e0b;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            color: var(--text);
            background:
                    radial-gradient(circle at 8% 8%, rgba(22, 163, 74, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(37, 99, 235, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 1120px;
            margin: 0 auto;
            padding: 44px 22px 52px;
        }

        .hero {
            position: relative;
            overflow: hidden;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--green), var(--green-dark));
            color: white;
            border-radius: 28px;
            padding: 34px 36px;
            margin-bottom: 24px;
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
        }

        .hero:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .hero:after {
            content: "";
            position: absolute;
            left: 30px;
            bottom: -58px;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255,255,255,0.10);
        }

        .hero-inner {
            position: relative;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 20px;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            border-radius: 999px;
            background: rgba(255,255,255,0.18);
            border: 1px solid rgba(255,255,255,0.22);
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 0.4px;
            margin-bottom: 12px;
        }

        .hero h1 {
            margin: 0 0 10px;
            font-size: 34px;
            font-weight: 900;
            letter-spacing: -0.8px;
        }

        .hero p {
            margin: 0;
            opacity: 0.9;
            font-size: 15px;
            line-height: 1.6;
        }

        .user-panel {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .user-chip {
            background: rgba(255,255,255,0.18);
            padding: 10px 14px;
            border-radius: 14px;
            font-size: 13px;
            font-weight: 900;
            border: 1px solid rgba(255,255,255,0.25);
            line-height: 1.5;
            text-align: right;
        }

        .logout-btn {
            text-decoration: none;
            background: white;
            color: var(--green-dark);
            padding: 10px 16px;
            border-radius: 14px;
            font-weight: 900;
            font-size: 13px;
            box-shadow: 0 10px 20px rgba(0,0,0,.12);
            white-space: nowrap;
        }

        .card-row {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }

        .card {
            position: relative;
            overflow: hidden;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            min-height: 185px;
        }

        .card:after {
            content: "";
            position: absolute;
            right: -28px;
            top: -28px;
            width: 96px;
            height: 96px;
            border-radius: 50%;
            background: rgba(22,163,74,0.12);
        }

        .card.export-card:after {
            background: rgba(37,99,235,0.12);
        }

        .card.done-card:after {
            background: rgba(100,116,139,0.12);
        }

        .card.ready-card:after {
            background: rgba(124,58,237,0.12);
        }

        .card h2 {
            position: relative;
            z-index: 1;
            margin: 0 0 10px;
            font-size: 21px;
            color: #0f172a;
            font-weight: 900;
            letter-spacing: -0.4px;
        }

        .desc {
            position: relative;
            z-index: 1;
            color: var(--muted);
            font-size: 14px;
            margin-bottom: 18px;
            line-height: 1.55;
            font-weight: 700;
            min-height: 42px;
        }

        .count {
            position: relative;
            z-index: 1;
            font-size: 38px;
            font-weight: 900;
            color: var(--green-dark);
            margin-bottom: 18px;
            text-align: right;
            letter-spacing: -0.9px;
        }

        .count.export {
            color: var(--blue-dark);
        }

        .count.gray-count {
            color: var(--gray);
        }

        .count.ready-count {
            color: var(--purple);
        }

        .btn {
            position: relative;
            z-index: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            background: var(--green);
            color: white;
            padding: 11px 18px;
            border-radius: 13px;
            font-weight: 900;
            font-size: 14px;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn.blue {
            background: var(--blue);
        }

        .btn.gray {
            background: var(--gray);
        }
        .btn.orange {
            background: var(--gray);
        }

        .btn.orange:hover {
            background: #1e293b;
        }

        .wide-card {
            grid-column: span 2;
        }

        .wide-card .count {
            text-align: left;
        }

        @media (max-width: 800px) {
            .wrap {
                padding-top: 30px;
            }

            .hero-inner {
                flex-direction: column;
            }

            .user-panel {
                width: 100%;
                justify-content: flex-start;
                flex-wrap: wrap;
            }

            .user-chip {
                text-align: left;
            }

            .card-row {
                grid-template-columns: 1fr;
            }

            .wide-card {
                grid-column: span 1;
            }
        }

        @media (max-width: 560px) {
            .hero {
                padding: 28px 24px;
            }

            .hero h1 {
                font-size: 28px;
            }

            .btn {
                width: 100%;
            }
        }

        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .logout-btn,
        .btn {
            min-height: 42px;
            box-sizing: border-box;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 34px 18px 46px;
            }

            .hero {
                padding: 32px 30px;
            }
        }

        @media (max-width: 800px) {
            .hero {
                border-radius: 24px;
            }

            .card {
                min-height: auto;
            }
        }

        @media (max-width: 560px) {
            .wrap {
                padding: 24px 14px 38px;
            }

            .hero {
                padding: 26px 22px;
                border-radius: 22px;
                margin-bottom: 18px;
            }

            .hero-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .hero h1 {
                font-size: 27px;
                line-height: 1.25;
            }

            .hero p {
                font-size: 14px;
            }

            .user-panel {
                display: grid;
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .user-chip,
            .logout-btn {
                width: 100%;
                text-align: center;
            }

            .card {
                padding: 22px 20px;
                border-radius: 22px;
            }

            .card h2 {
                font-size: 20px;
            }

            .desc {
                min-height: 0;
                font-size: 13px;
            }

            .count {
                font-size: 34px;
                text-align: left;
            }
        }

        @media (max-width: 380px) {
            .wrap {
                padding-left: 10px;
                padding-right: 10px;
            }

            .hero {
                padding: 22px 18px;
            }

            .hero h1 {
                font-size: 24px;
            }

            .card {
                padding: 20px 16px;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="hero">
        <div class="hero-inner">
            <div>
                <div class="hero-badge">🚚 LOGISTICS DASHBOARD</div>
                <h1>물류팀 대시보드</h1>
                <p>입고 처리와 수출 출고 처리를 한눈에 확인하고 진행합니다.</p>
            </div>

            <div class="user-panel">
                <div class="user-chip">
                    👤 ${loginUser}<br>
                </div>
                <a href="${pageContext.request.contextPath}/stock/list" class="btn orange">
                    📦 재고조회
                </a>

                <a href="${pageContext.request.contextPath}/stock/history"
                   class="btn blue"
                   style="margin-left:0px;">
                    📋 재고히스토리
                </a>

                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    로그아웃
                </a>
            </div>
        </div>
    </div>

    <div class="card-row">

        <div class="card">
            <h2>입고 대기</h2>
            <div class="desc">포장팀에서 출고완료 처리한 건입니다.</div>
            <div class="count">${inboundWaitingCount}</div>
            <a href="${pageContext.request.contextPath}/logistics/list" class="btn">
                입고대기 목록
            </a>
        </div>

        <div class="card done-card">
            <h2>입고 완료</h2>
            <div class="desc">물류팀이 최종 입고 확정한 건입니다.</div>
            <div class="count gray-count">${inboundDoneCount}</div>
            <a href="${pageContext.request.contextPath}/logistics/done-list" class="btn gray">
                입고완료 목록
            </a>
        </div>

        <div class="card export-card">
            <h2>출고 대기</h2>
            <div class="desc">관리자가 등록한 수출 지시 건입니다.</div>
            <div class="count export">${exportWaitingCount}</div>
            <a href="${pageContext.request.contextPath}/logistics/export/list" class="btn blue">
                출고대기 목록
            </a>
        </div>

        <div class="card ready-card">
            <h2>출고 준비 완료</h2>
            <div class="desc">EXPORT QR 생성 후 스캔 대기중인 건입니다.</div>
            <div class="count ready-count">${exportReadyCount}</div>
            <a href="${pageContext.request.contextPath}/logistics/export/ready-list" class="btn blue">
                스캔대기 목록
            </a>
        </div>

        <div class="card export-card wide-card">
            <h2>출고 완료</h2>
            <div class="desc">물류팀이 최종 출고 처리한 건입니다.</div>
            <div class="count export">${exportDoneCount}</div>
            <a href="${pageContext.request.contextPath}/logistics/export/done-list" class="btn gray">
                출고완료 목록
            </a>
        </div>

    </div>

</div>

</body>
</html>