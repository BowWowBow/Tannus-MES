<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 출고 완료 목록</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --blue-soft: rgba(37,99,235,0.12);
            --sky: #0ea5e9;
            --green: #16a34a;
            --green-dark: #15803d;
            --gray: #334155;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
        }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            color: var(--text);
            background:
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.14), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(14, 165, 233, 0.12), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 1280px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .page-head {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            margin-bottom: 18px;
            padding: 30px 32px;
            border-radius: 28px;
            color: white;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.40), transparent 28%),
                    linear-gradient(135deg, var(--blue), var(--blue-dark));
            box-shadow: 0 20px 46px rgba(15,23,42,0.20);
        }

        .page-head:before {
            content: "";
            position: absolute;
            right: -75px;
            top: -95px;
            width: 255px;
            height: 255px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .page-head:after {
            content: "";
            position: absolute;
            left: 28px;
            bottom: -58px;
            width: 160px;
            height: 160px;
            border-radius: 50%;
            background: rgba(255,255,255,0.10);
        }

        .page-head > div,
        .page-head .btn {
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
            margin-bottom: 11px;
        }

        .page-title h1 {
            margin: 0 0 8px;
            font-size: 33px;
            font-weight: 900;
            color: white;
            letter-spacing: -0.8px;
        }

        .page-title p {
            margin: 0;
            color: rgba(255,255,255,0.88);
            font-size: 14px;
            line-height: 1.6;
            font-weight: 700;
        }

        .btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
            border-radius: 13px;
            font-weight: 900;
            font-size: 14px;
            min-height: 38px;
            padding: 0 15px;
            color: white;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn-dashboard {
            background: rgba(255,255,255,0.94);
            color: var(--blue-dark);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn-detail {
            background: var(--blue);
        }

        .btn-print {
            background: var(--sky);
        }

        .fixed-btn {
            width: 100px;
            height: 34px;
            min-height: 34px;
            padding: 0;
            font-size: 13px;
        }

        .print-btn {
            width: 122px;
            height: 34px;
            min-height: 34px;
            padding: 0;
            font-size: 13px;
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
            width: 90px;
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

        .summary-card {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-left: 7px solid var(--blue);
            border-radius: 24px;
            padding: 20px 24px;
            margin-bottom: 18px;
            box-shadow: 0 14px 34px rgba(15,23,42,0.08);
        }

        .summary-card:after {
            content: "";
            position: absolute;
            right: -34px;
            top: -34px;
            width: 118px;
            height: 118px;
            border-radius: 50%;
            background: var(--blue-soft);
        }

        .summary-title,
        .summary-count {
            position: relative;
            z-index: 1;
        }

        .summary-title {
            font-size: 15px;
            color: #334155;
            font-weight: 900;
        }

        .summary-count {
            font-size: 28px;
            color: var(--blue-dark);
            font-weight: 900;
            letter-spacing: -0.5px;
        }

        .card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            padding: 0;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 900px;
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

        .badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 82px;
            height: 29px;
            padding: 0 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .bg-done {
            background: #dbeafe;
            color: var(--blue-dark);
            border: 1px solid #bfdbfe;
        }

        .action-box {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .empty-row {
            height: 96px;
            color: #94a3b8;
            font-weight: 900;
        }

        @media (max-width: 760px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .page-head,
            .summary-card {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title h1 {
                font-size: 26px;
            }

            .filter-card,
            .filter-form {
                justify-content: flex-start;
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

        .filter-form .btn,
        .page-head .btn {
            min-height: 40px;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 28px 18px 44px;
            }

            .page-head {
                padding: 26px 26px;
            }

            table {
                min-width: 860px;
            }
        }

        @media (max-width: 768px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .page-head {
                padding: 24px 22px;
                border-radius: 22px;
            }

            .page-head > div:last-child {
                width: 100%;
            }

            .page-head .btn {
                width: 100%;
            }

            .filter-card {
                width: 100%;
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

            .summary-card {
                padding: 18px 20px;
                border-radius: 20px;
            }

            .summary-count {
                font-size: 25px;
            }

            .card {
                border-radius: 20px;
            }

            th, td {
                padding: 12px 10px;
                font-size: 13px;
            }

            .action-box {
                flex-wrap: nowrap;
            }

            .fixed-btn {
                width: 86px;
                min-width: 86px;
            }

            .print-btn {
                width: 112px;
                min-width: 112px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 20px 12px 34px;
            }

            .page-head {
                padding: 22px 18px;
                margin-bottom: 16px;
            }

            .page-title h1 {
                font-size: 24px;
                line-height: 1.25;
            }

            .page-title p {
                font-size: 13px;
            }

            .page-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .filter-form {
                grid-template-columns: 1fr;
            }

            .summary-card {
                gap: 6px;
            }

            table {
                min-width: 780px;
            }

            .action-box {
                gap: 6px;
            }

            .fixed-btn {
                width: 80px;
                min-width: 80px;
                font-size: 12px;
            }

            .print-btn {
                width: 108px;
                min-width: 108px;
                font-size: 12px;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="page-head">
        <div class="page-title">
            <div class="page-badge">✅ EXPORT DONE</div>
            <h1>수출 출고 완료 목록</h1>
            <p>최종 출고 완료 처리된 수출 지시 목록입니다.</p>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/logistics/dashboard"
               class="btn btn-dashboard">
                대시보드로
            </a>
        </div>
    </div>

    <div class="filter-card">
        <form method="get"
              action="${pageContext.request.contextPath}/logistics/export/done-list"
              class="filter-form">

            <select name="month" class="month-select">
                <option value="">전체 월</option>
                <c:forEach var="m" items="${monthList}">
                    <option value="${m}" <c:if test="${selectedMonth == m}">selected</c:if>>
                            ${m}
                    </option>
                </c:forEach>
            </select>

            <button type="submit" class="btn search-btn">
                조회
            </button>

            <a href="${pageContext.request.contextPath}/logistics/export/done-list"
               class="btn reset-btn">
                전체
            </a>

        </form>
    </div>

    <div class="summary-card">
        <div class="summary-title">전체 출고완료 건수</div>
        <div class="summary-count">${orderList.size()} 건</div>
    </div>

    <div class="card">

        <table>
            <thead>
            <tr>
                <th style="width: 80px;">번호</th>
                <th style="width: 150px;">출고요청일</th>
                <th style="width: 180px;">지시자</th>
                <th style="width: 140px;">상태</th>
                <th style="width: 340px;">상세</th>
            </tr>
            </thead>

            <tbody>

            <c:forEach var="order" items="${orderList}">

                <tr>
                    <td>${order.id}</td>

                    <td>
                        <c:choose>
                            <c:when test="${empty order.requestDate}">
                                -
                            </c:when>
                            <c:otherwise>
                                ${order.requestDate}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${empty order.workerName}">
                                -
                            </c:when>
                            <c:otherwise>
                                ${order.workerName}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <span class="badge bg-done">
                            출고완료
                        </span>
                    </td>

                    <td>
                        <div class="action-box">
                            <a href="${pageContext.request.contextPath}/logistics/export/detail/${order.id}"
                               class="btn btn-detail fixed-btn">
                                상세보기
                            </a>

                            <a href="${pageContext.request.contextPath}/logistics/export/product-print/${order.id}"
                               target="_blank"
                               class="btn btn-print print-btn">
                                A4 상품내역
                            </a>
                        </div>
                    </td>
                </tr>

            </c:forEach>

            <c:if test="${empty orderList}">
                <tr>
                    <td colspan="5" class="empty-row">
                        출고 완료 목록이 없습니다.
                    </td>
                </tr>
            </c:if>

            </tbody>
        </table>

    </div>

</div>

</body>
</html>
