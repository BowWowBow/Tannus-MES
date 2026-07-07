<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>물류팀 입고 목록</title>

    <style>
        :root {
            --green: #16a34a;
            --green-dark: #15803d;
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --red: #dc2626;
            --orange: #f59e0b;
            --sky: #0ea5e9;
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

        .page-head {
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

        .page-head:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .page-head > div,
        .page-head .btn {
            position: relative;
            z-index: 1;
        }

        .page-title:before {
            content: "📦 INBOUND LIST";
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

        .page-title h1 {
            margin: 0 0 8px;
            font-size: 32px;
            font-weight: 900;
            color: white;
            letter-spacing: -0.7px;
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

        .btn:hover:not(:disabled) {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn:disabled {
            cursor: not-allowed;
            opacity: 0.7;
        }

        .btn-dashboard {
            background: rgba(255,255,255,0.94);
            color: var(--green-dark);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn-primary {
            background: var(--blue);
            color: white;
        }

        .btn-print {
            background: var(--green);
            color: white;
        }

        .btn-secondary {
            background: #64748b;
            color: white;
        }

        .btn-search {
            background: var(--green);
            color: white;
        }

        .btn-outline-primary {
            background: white;
            color: var(--blue-dark);
            border: 1px solid rgba(37,99,235,0.26);
        }

        .fixed-btn {
            width: 92px;
            height: 34px;
            min-height: 34px;
            padding: 0;
            font-size: 13px;
        }

        .filter-box {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 16px;
            padding: 16px;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 22px;
            box-shadow: 0 14px 34px rgba(15,23,42,0.08);
        }

        .filter-box select {
            height: 40px;
            padding: 0 12px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            outline: none;
            font-size: 14px;
            color: #334155;
            background: white;
            font-weight: 800;
        }

        .filter-box select:focus {
            border-color: var(--green);
            box-shadow: 0 0 0 4px rgba(22,163,74,0.12);
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
            min-width: 1120px;
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
            min-width: 78px;
            height: 29px;
            padding: 0 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .bg-warning { background: #fef3c7; color: #92400e; }
        .bg-primary { background: #dbeafe; color: #1d4ed8; }
        .bg-success { background: #dcfce7; color: #15803d; }
        .bg-info { background: #e0f2fe; color: #0369a1; }
        .bg-dark { background: #334155; color: white; }
        .bg-danger { background: #fee2e2; color: #b91c1c; }
        .bg-secondary { background: #e2e8f0; color: #334155; }

        .day-badge {
            min-width: 76px;
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

        @media (max-width: 900px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .page-head {
                flex-direction: column;
                align-items: flex-start;
                padding: 24px 20px;
                border-radius: 22px;
            }

            .page-title h1 {
                font-size: 26px;
                line-height: 1.25;
            }

            .page-title p {
                font-size: 13px;
            }

            .btn-dashboard {
                width: 100%;
            }

            .filter-box {
                justify-content: flex-start;
                flex-wrap: wrap;
                padding: 14px;
                border-radius: 18px;
            }

            .filter-box select {
                flex: 1 1 100%;
                width: 100%;
            }

            .filter-box .btn {
                flex: 1 1 calc(50% - 5px);
            }

            .card {
                overflow: visible;
                background: transparent;
                border: none;
                box-shadow: none;
            }

            table {
                min-width: 0;
                border-collapse: separate;
                border-spacing: 0 12px;
                background: transparent;
            }

            thead {
                display: none;
            }

            tbody, tr, td {
                display: block;
                width: 100%;
            }

            tbody tr {
                overflow: hidden;
                border: 1px solid rgba(226,232,240,0.95);
                border-radius: 20px;
                background: rgba(255,255,255,0.98);
                box-shadow: 0 12px 28px rgba(15,23,42,0.08);
            }

            tbody tr:hover {
                background: white;
            }

            td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 14px;
                min-height: 48px;
                padding: 12px 16px;
                border-bottom: 1px solid #edf2f7;
                text-align: right;
                font-size: 14px;
                word-break: break-word;
            }

            td:before {
                flex: 0 0 auto;
                color: #64748b;
                font-size: 12px;
                font-weight: 900;
                text-align: left;
                white-space: nowrap;
            }

            td:nth-child(1):before { content: "번호"; }
            td:nth-child(2):before { content: "요청일"; }
            td:nth-child(3):before { content: "D-Day"; }
            td:nth-child(4):before { content: "지시자"; }
            td:nth-child(5):before { content: "상태"; }
            td:nth-child(6):before { content: "상세항목수"; }
            td:nth-child(7):before { content: "관리"; }

            td:last-child {
                border-bottom: none;
            }

            .action-box {
                width: 100%;
                justify-content: flex-end;
            }

            .fixed-btn {
                width: auto;
                min-width: 88px;
                padding: 0 12px;
            }

            .empty-row {
                display: block;
                height: auto;
                padding: 26px 16px;
                text-align: center;
            }

            .empty-row:before {
                content: none;
            }
        }

        @media (max-width: 420px) {
            .page-head {
                padding: 22px 16px;
            }

            .page-title h1 {
                font-size: 23px;
            }

            .btn {
                min-height: 40px;
                font-size: 13px;
                padding: 0 12px;
            }

            td {
                align-items: flex-start;
                flex-direction: column;
                text-align: left;
                gap: 6px;
            }

            .badge {
                min-width: 72px;
            }

            .action-box {
                justify-content: flex-start;
            }

            .fixed-btn {
                flex: 1 1 100%;
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="page-head">
        <div class="page-title">
            <h1>📦 물류팀 입고 목록</h1>
            <p>포장 지시 전체 내역을 확인하고 상세보기 또는 A4 출력할 수 있습니다.</p>
        </div>

        <a href="${pageContext.request.contextPath}/logistics/dashboard"
           class="btn btn-dashboard">
            대시보드
        </a>
    </div>

    <form method="get"
          action="${pageContext.request.contextPath}/logistics/list"
          class="filter-box">

        <select name="month">
            <option value="">전체 월</option>

            <c:forEach var="month" items="${orderMonths}">
                <option value="${month}" ${selectedMonth eq month ? 'selected' : ''}>
                        ${month}
                </option>
            </c:forEach>
        </select>

        <button type="submit" class="btn btn-search">
            조회
        </button>

        <a href="${pageContext.request.contextPath}/logistics/list"
           class="btn btn-secondary">
            전체
        </a>
    </form>

    <div class="card">
        <table>
            <thead>
            <tr>
                <th style="width:80px;">번호</th>
                <th style="width:150px;">요청일</th>
                <th style="width:120px;">D-Day</th>
                <th style="width:160px;">지시자</th>
                <th style="width:130px;">상태</th>
                <th style="width:110px;">상세항목수</th>
                <th style="width:360px;">관리</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="order" items="${orderList}">
                <tr>
                    <td>${order.id}</td>

                    <td class="request-date">${order.requestDate}</td>

                    <td>
                        <span class="badge bg-secondary day-badge">계산중</span>
                    </td>

                    <td>${order.requestedBy}</td>

                    <td>
                        <c:choose>
                            <c:when test="${order.status eq 'REQUESTED'}">
                                <span class="badge bg-info">포장대기</span>
                            </c:when>

                            <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                <span class="badge bg-primary">포장완료</span>
                            </c:when>

                            <c:when test="${order.status eq 'SHIPPED'}">
                                <span class="badge bg-warning">입고대기</span>
                            </c:when>

                            <c:when test="${order.status eq 'RECEIVED'}">
                                <span class="badge bg-success">입고완료</span>
                            </c:when>

                            <c:when test="${order.status eq 'CANCELLED'}">
                                <span class="badge bg-dark">입고취소</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge bg-dark">${order.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <c:choose>
                            <c:when test="${empty order.detailList}">
                                0
                            </c:when>
                            <c:otherwise>
                                ${order.detailList.size()}
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <td>
                        <div class="action-box">

                            <c:choose>
                                <c:when test="${order.status eq 'CANCELLED'}">
                                    <button type="button" class="btn btn-secondary fixed-btn" disabled>
                                        상세불가
                                    </button>

                                    <button type="button" class="btn btn-secondary fixed-btn" disabled>
                                        출력불가
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/logistics/detail/${order.id}"
                                       class="btn btn-primary fixed-btn">
                                        상세보기
                                    </a>

                                    <a href="${pageContext.request.contextPath}/logistics/inbound/work-order/${order.id}"
                                       class="btn btn-print fixed-btn"
                                       target="_blank">
                                        A4출력
                                    </a>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </td>
                </tr>
            </c:forEach>

            <c:if test="${empty orderList}">
                <tr>
                    <td colspan="7" class="empty-row">
                        등록된 입고/포장 지시 내역이 없습니다.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

</div>

<script>
    function calculateDDay() {
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        document.querySelectorAll("tbody tr").forEach(function(row) {
            const dateCell = row.querySelector(".request-date");
            const badge = row.querySelector(".day-badge");

            if (!dateCell || !badge) return;

            const dateText = dateCell.innerText.trim();

            if (!dateText || dateText === "-") {
                badge.innerText = "-";
                badge.className = "badge bg-secondary day-badge";
                return;
            }

            const requestDate = new Date(dateText);
            requestDate.setHours(0, 0, 0, 0);

            const diff = Math.floor((requestDate - today) / (1000 * 60 * 60 * 24));

            if (diff > 0) {
                badge.innerText = "D-" + diff;
                badge.className = "badge bg-info day-badge";
            } else if (diff === 0) {
                badge.innerText = "D-DAY";
                badge.className = "badge bg-danger day-badge";
            } else {
                badge.innerText = "D+" + Math.abs(diff);
                badge.className = "badge bg-dark day-badge";
            }
        });
    }

    calculateDDay();
</script>

</body>
</html>