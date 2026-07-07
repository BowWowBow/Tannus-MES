<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>입고완료 목록</title>

    <style>
        :root {
            --green: #16a34a;
            --green-dark: #15803d;
            --blue: #2563eb;
            --gray: #334155;
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
            max-width: 1280px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .top-box {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            margin-bottom: 18px;
            padding: 28px 30px;
            border-radius: 26px;
            color: white;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--green), var(--green-dark));
            box-shadow: 0 18px 42px rgba(15,23,42,0.18);
        }

        .top-box:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .top-box > div {
            position: relative;
            z-index: 1;
        }

        .page-badge {
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
            margin-bottom: 10px;
        }

        .top-box h1 {
            margin: 0 0 8px;
            font-size: 32px;
            font-weight: 900;
            color: white;
            letter-spacing: -0.7px;
        }

        .top-box p {
            margin: 0;
            font-size: 14px;
            opacity: 0.9;
            line-height: 1.6;
            font-weight: 700;
        }

        .btn-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn {
            text-decoration: none;
            border: none;
            background: var(--green);
            color: white;
            min-height: 38px;
            padding: 0 15px;
            border-radius: 13px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            cursor: pointer;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn.gray {
            background: rgba(255,255,255,0.94);
            color: var(--green-dark);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .filter-card {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 22px;
            padding: 12px 12px;
            margin-bottom: 18px;
            box-shadow: 0 14px 34px rgba(15,23,42,0.08);
        }

        .filter-form {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .month-select {
            width: 102px;
            height: 38px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            padding: 0 10px;
            background: white;
            color: #0f172a;
            font-weight: 900;
            outline: none;
        }

        .search-btn {
            height: 38px;
            min-height: 38px;
            background: var(--green);
        }

        .search-btn:hover {
            background: var(--green-dark);
        }

        .reset-btn {
            height: 38px;
            min-height: 38px;
            background: #64748b;
        }

        .summary-box {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-left: 7px solid var(--green);
            border-radius: 24px;
            padding: 20px 24px;
            margin-bottom: 18px;
            box-shadow: 0 14px 34px rgba(15,23,42,0.08);
        }

        .summary-box:after {
            content: "";
            position: absolute;
            right: -34px;
            top: -34px;
            width: 118px;
            height: 118px;
            border-radius: 50%;
            background: rgba(22,163,74,0.12);
        }

        .summary-title {
            position: relative;
            z-index: 1;
            font-size: 15px;
            font-weight: 900;
            color: #166534;
        }

        .summary-count {
            position: relative;
            z-index: 1;
            font-size: 30px;
            font-weight: 900;
            color: var(--green-dark);
            letter-spacing: -0.5px;
        }

        .card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 0;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1000px;
            border-collapse: collapse;
            text-align: center;
            background: white;
        }

        th {
            background: #f8fafc;
            font-weight: 900;
            color: #334155;
            border-bottom: 1px solid var(--line);
            padding: 15px 10px;
            white-space: nowrap;
            font-size: 14px;
        }

        td {
            border-bottom: 1px solid #e5e7eb;
            padding: 14px 10px;
            vertical-align: middle;
            color: #475569;
            font-weight: 700;
            font-size: 14px;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 29px;
            min-width: 86px;
            padding: 0 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            box-sizing: border-box;
            white-space: nowrap;
        }

        .status.done {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .empty {
            text-align: center;
            padding: 46px 0;
            color: #94a3b8;
            font-weight: 900;
        }

        .detail-btn {
            background: var(--blue);
        }

        @media (max-width: 800px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .top-box,
            .summary-box {
                flex-direction: column;
                align-items: flex-start;
            }

            .btn-group,
            .filter-card,
            .filter-form {
                justify-content: flex-start;
            }

            .top-box h1 {
                font-size: 27px;
            }
        }

        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .card {
            -webkit-overflow-scrolling: touch;
        }

        .card::-webkit-scrollbar {
            height: 8px;
        }

        .card::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .card::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        .btn-group .btn,
        .filter-form .btn {
            min-height: 40px;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 28px 18px 44px;
            }

            .top-box {
                padding: 26px 24px;
            }

            table {
                min-width: 940px;
            }
        }

        @media (max-width: 768px) {
            .top-box {
                padding: 24px 22px;
                border-radius: 22px;
            }

            .btn-group {
                width: 100%;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
            }

            .btn-group .btn {
                width: 100%;
            }

            .filter-card {
                justify-content: stretch;
                padding: 14px;
            }

            .filter-form {
                width: 100%;
                display: grid;
                grid-template-columns: 1fr 1fr 1fr;
                gap: 8px;
            }

            .month-select,
            .filter-form .btn {
                width: 100%;
            }

            .summary-box {
                padding: 18px 20px;
                border-radius: 22px;
                gap: 8px;
            }

            .summary-count {
                font-size: 27px;
            }

            th,
            td {
                padding: 12px 10px;
                font-size: 13px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 20px 12px 34px;
            }

            .top-box {
                padding: 22px 18px;
                margin-bottom: 16px;
            }

            .page-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .top-box h1 {
                font-size: 24px;
                line-height: 1.25;
            }

            .top-box p {
                font-size: 13px;
            }

            .btn-group,
            .filter-form {
                grid-template-columns: 1fr;
            }

            .filter-card,
            .summary-box,
            .card {
                border-radius: 18px;
            }

            table {
                min-width: 860px;
            }

            .detail-btn {
                min-width: 84px;
                padding: 0 12px;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <div>
            <div class="page-badge">✅ INBOUND DONE</div>
            <h1>입고완료 목록</h1>
            <p>최종 입고 확정이 완료된 지시 목록입니다.</p>
        </div>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/logistics/dashboard" class="btn gray">
                대시보드
            </a>

            <a href="${pageContext.request.contextPath}/logistics/list" class="btn gray">
                입고대기 목록
            </a>
        </div>
    </div>

    <div class="filter-card">
        <form method="get"
              action="${pageContext.request.contextPath}/logistics/done-list"
              class="filter-form">

            <select name="month" class="month-select">
                <option value="">전체 월</option>

                <c:forEach var="m" items="${orderMonths}">
                    <option value="${m}" <c:if test="${selectedMonth == m}">selected</c:if>>
                            ${m}
                    </option>
                </c:forEach>
            </select>

            <button type="submit" class="btn search-btn">
                조회
            </button>

            <a href="${pageContext.request.contextPath}/logistics/done-list"
               class="btn reset-btn">
                전체
            </a>

        </form>
    </div>

    <div class="summary-box">
        <div class="summary-title">전체 입고완료 건수</div>
        <div class="summary-count">${orderList.size()} 건</div>
    </div>

    <div class="card">

        <table>
            <thead>
            <tr>
                <th>지시번호</th>
                <th>요청일</th>
                <th>지시자</th>
                <th>대상팀</th>
                <th>상태</th>
                <th>비고</th>
                <th>상세</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty orderList}">
                    <tr>
                        <td colspan="7" class="empty">
                            입고완료된 지시가 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="order" items="${orderList}">
                        <tr>
                            <td>${order.id}</td>
                            <td>${order.requestDate}</td>
                            <td>${order.requestedBy}</td>
                            <td>${order.targetTeam}</td>
                            <td>
                                <span class="status done">입고완료</span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${empty order.remark}">
                                        -
                                    </c:when>
                                    <c:otherwise>
                                        ${order.remark}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/logistics/detail/${order.id}"
                                   class="btn detail-btn">
                                    상세보기
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

    </div>

</div>

</body>
</html>
