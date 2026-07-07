<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장팀 대시보드</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --green: #16a34a;
            --green-dark: #15803d;
            --orange: #f59e0b;
            --purple: #7c3aed;
            --gray: #334155;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
        }

        * {
            box-sizing: border-box;
        }

        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            margin: 0;
            min-height: 100vh;
            overflow-x: hidden;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            color: var(--text);
            background:
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(22, 163, 74, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            width: 100%;
            max-width: 1120px;
            margin: 0 auto;
            padding: 44px 22px 52px;
        }

        .hero {
            position: relative;
            overflow: hidden;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--blue), var(--blue-dark));
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
            word-break: keep-all;
        }

        .hero-user-box {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .user-badge {
            background: rgba(255,255,255,.18);
            padding: 10px 14px;
            border-radius: 14px;
            font-size: 13px;
            font-weight: 900;
            border: 1px solid rgba(255,255,255,.25);
            white-space: nowrap;
        }

        .logout-btn {
            text-decoration: none;
            background: #fff;
            color: #2563eb;
            padding: 10px 16px;
            border-radius: 14px;
            font-weight: 900;
            font-size: 13px;
            box-shadow: 0 10px 20px rgba(0,0,0,.12);
            white-space: nowrap;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 20px;
        }

        .card {
            position: relative;
            overflow: hidden;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 22px 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            min-height: 132px;
        }

        .card:after {
            content: "";
            position: absolute;
            right: -28px;
            top: -28px;
            width: 96px;
            height: 96px;
            border-radius: 50%;
            background: rgba(37,99,235,0.10);
        }

        .card:nth-child(2):after {
            background: rgba(245,158,11,0.12);
        }

        .card:nth-child(3):after {
            background: rgba(22,163,74,0.12);
        }

        .card:nth-child(4):after {
            background: rgba(124,58,237,0.12);
        }

        .card h3 {
            position: relative;
            z-index: 1;
            margin: 0 0 16px;
            font-size: 15px;
            color: var(--muted);
            font-weight: 900;
        }

        .count {
            position: relative;
            z-index: 1;
            font-size: 36px;
            font-weight: 900;
            text-align: right;
            color: var(--blue-dark);
            letter-spacing: -0.8px;
        }

        .card:nth-child(2) .count {
            color: var(--orange);
        }

        .card:nth-child(3) .count {
            color: var(--green-dark);
        }

        .card:nth-child(4) .count {
            color: var(--purple);
        }

        .quick-card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 26px 28px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            margin-bottom: 20px;
        }

        .quick-card h3 {
            margin: 0 0 18px;
            font-size: 20px;
            font-weight: 900;
            color: #0f172a;
        }

        .quick-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            background: var(--blue);
            color: white;
            padding: 11px 18px;
            border-radius: 13px;
            font-weight: 900;
            font-size: 14px;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
            min-height: 42px;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn-outline {
            background: white;
            color: var(--blue-dark);
            border: 1px solid rgba(37,99,235,0.24);
        }

        .btn-dark {
            background: var(--gray);
        }

        .btn-dark:hover {
            background: #1e293b;
        }

        @media (max-width: 900px) {
            .wrap {
                padding: 30px 16px 42px;
            }

            .grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .hero-inner {
                flex-direction: column;
            }

            .hero-user-box {
                width: 100%;
                justify-content: flex-start;
                flex-wrap: wrap;
            }
        }

        @media (max-width: 600px) {
            .wrap {
                padding: 20px 12px 34px;
            }

            .grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .hero {
                padding: 26px 20px;
                border-radius: 22px;
            }

            .hero h1 {
                font-size: 27px;
            }

            .hero p {
                font-size: 14px;
            }

            .hero-user-box {
                display: grid;
                grid-template-columns: 1fr;
            }

            .user-badge,
            .logout-btn {
                width: 100%;
                text-align: center;
                justify-content: center;
            }

            .card {
                padding: 20px;
                border-radius: 20px;
                min-height: 118px;
            }

            .count {
                font-size: 34px;
            }

            .quick-card {
                padding: 22px 20px;
                border-radius: 20px;
            }

            .quick-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        @media (max-width: 380px) {
            .hero h1 {
                font-size: 24px;
            }

            .hero-badge {
                font-size: 11px;
            }
        }
        /* 클릭 막힘 방지 */
        .hero:before,
        .hero:after,
        .card:after {
            pointer-events: none;
        }

        .quick-card {
            position: relative;
            z-index: 50;
        }

        .quick-actions {
            position: relative;
            z-index: 60;
        }

        .quick-actions a,
        .quick-actions button,
        .btn {
            position: relative;
            z-index: 70;
            pointer-events: auto;
        }

    </style>
</head>
<body>

<div class="wrap">

    <div class="hero">
        <div class="hero-inner">
            <div>
                <div class="hero-badge">📦 PACKING DASHBOARD</div>
                <h1>포장팀 대시보드</h1>
                <p>${loginUser}님 환영합니다. 포장 작업 현황을 확인하세요.</p>
            </div>

            <div class="hero-user-box">
                <div class="user-badge">
                    👤 ${loginUser}
                </div>
                <a href="${pageContext.request.contextPath}/packing/list" class="btn">
                    포장 목록
                </a>

                <a href="${pageContext.request.contextPath}/stock/list" class="btn btn-dark">
                    📦 재고조회
                </a>

                <a href="${pageContext.request.contextPath}/stock/history" class="btn btn-outline">
                    📋 재고히스토리
                </a>


                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                    로그아웃
                </a>
            </div>
        </div>
    </div>

    <div class="grid">
        <div class="card">
            <h3>전체 지시 건수</h3>
            <div class="count">${packingTotalCount}</div>
        </div>

        <div class="card">
            <h3>포장 요청</h3>
            <div class="count">${packingWaitingCount}</div>
        </div>

        <div class="card">
            <h3>포장 완료</h3>
            <div class="count">${packingDoneCount}</div>
        </div>

        <div class="card">
            <h3>출고 완료</h3>
            <div class="count">${shippedCount}</div>
        </div>
    </div>
</div>

</body>
</html>
