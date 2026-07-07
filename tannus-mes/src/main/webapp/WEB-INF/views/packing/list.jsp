<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 지시 목록</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --green: #16a34a;
            --green-dark: #15803d;
            --orange: #f59e0b;
            --red: #dc2626;
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
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(22, 163, 74, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 1280px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .page-hero {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            margin-bottom: 20px;
            padding: 28px 30px;
            border-radius: 26px;
            color: white;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--blue), var(--blue-dark));
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
        }

        .page-hero:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .page-hero > div {
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

        h2 {
            margin: 0;
            color: white;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.7px;
        }

        .page-hero p {
            margin: 9px 0 0;
            color: rgba(255,255,255,0.86);
            font-size: 14px;
            line-height: 1.6;
        }

        .action-group {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 9px;
            flex-wrap: wrap;
        }

        .btn {
            border: none;
            border-radius: 13px;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            color: white;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn-outline-primary,
        .btn-outline-secondary {
            background: rgba(255,255,255,0.94);
            color: var(--blue-dark);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn-primary {
            background: var(--blue);
        }

        .btn-success {
            background: var(--green);
        }

        .btn-danger {
            background: var(--red);
        }

        .btn-secondary {
            background: #cbd5e1;
            color: #64748b;
            cursor: not-allowed;
        }

        .month-panel {
            display: none;
            margin-bottom: 18px;
        }

        .month-panel.show {
            display: block;
        }

        .month-card,
        .table-card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            overflow: hidden;
        }

        .card-body {
            padding: 22px;
        }

        .panel-title {
            margin: 0 0 14px;
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
        }

        .month-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .month-btn {
            min-width: 92px;
            padding: 9px 13px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 900;
            text-align: center;
            text-decoration: none;
        }

        .month-btn.active {
            background: var(--blue);
            color: white;
            border: 1px solid var(--blue);
        }

        .month-btn.normal {
            background: white;
            color: #334155;
            border: 1px solid rgba(37,99,235,0.22);
        }

        .muted {
            color: var(--muted);
            font-weight: 700;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 980px;
        }

        .table-card {
            overflow-x: auto;
        }

        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #e5e7eb;
            text-align: center;
            font-size: 14px;
            vertical-align: middle;
        }

        th {
            background: #f8fafc;
            color: #334155;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            color: #475569;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .badge,
        .day-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 74px;
            height: 29px;
            padding: 0 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            color: white;
            white-space: nowrap;
        }

        .bg-secondary { background: #64748b; }
        .bg-warning { background: var(--orange); }
        .bg-primary { background: var(--blue); }
        .bg-success { background: var(--green); }
        .bg-danger { background: var(--red); }
        .bg-dark { background: #334155; }
        .bg-info { background: #38bdf8; }
        .text-dark { color: #1f2937 !important; }

        .detail-actions {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 7px;
            flex-wrap: wrap;
        }

        .fixed-btn {
            width: 88px;
            height: 34px;
            padding: 0;
            font-size: 12px;
        }

        .empty-row {
            padding: 42px 0;
            color: #94a3b8;
            font-weight: 900;
        }

        @media (max-width: 900px) {
            .page-hero {
                flex-direction: column;
                align-items: flex-start;
            }

            .action-group {
                justify-content: flex-start;
            }
        }

        @media (max-width: 600px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            h2 {
                font-size: 26px;
            }
        }

        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .table-card {
            -webkit-overflow-scrolling: touch;
        }

        .table-card::-webkit-scrollbar {
            height: 8px;
        }

        .table-card::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .table-card::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        .action-group .btn {
            min-height: 40px;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 28px 18px 44px;
            }

            .order-table {
                min-width: 940px;
            }

            .card-body {
                padding: 18px;
            }
        }

        @media (max-width: 768px) {
            .page-hero {
                padding: 24px 22px;
                border-radius: 22px;
            }

            .action-group {
                width: 100%;
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 8px;
            }

            .action-group .btn {
                width: 100%;
                padding: 10px 8px;
                font-size: 13px;
            }

            .table-card {
                border-radius: 20px;
            }

            .card-body {
                padding: 16px;
            }

            th, td {
                padding: 12px 10px;
                font-size: 13px;
            }

            .fixed-btn {
                width: 82px;
                height: 34px;
                font-size: 12px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 20px 12px 34px;
            }

            .page-hero {
                padding: 22px 18px;
                margin-bottom: 16px;
            }

            h2 {
                font-size: 24px;
                line-height: 1.25;
            }

            .page-hero p {
                font-size: 13px;
            }

            .page-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .action-group {
                grid-template-columns: 1fr;
            }

            .month-card,
            .table-card {
                border-radius: 18px;
            }

            .month-list {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 8px;
            }

            .month-btn {
                width: 100%;
                min-width: 0;
            }

            .order-table {
                min-width: 880px;
            }

            .detail-actions {
                flex-wrap: nowrap;
                gap: 6px;
            }

            .fixed-btn {
                width: 78px;
                min-width: 78px;
                padding: 0;
            }
        }

    </style>

</head>
<body>
<div class="wrap">

    <div class="page-hero">
        <div>
            <div class="page-badge">📦 PACKING LIST</div>
            <h2>포장 지시 목록</h2>
            <p>
                <c:choose>
                    <c:when test="${not empty selectedMonth}">
                        ${selectedMonth} 월 포장 지시 목록입니다.
                    </c:when>
                    <c:otherwise>
                        전체 포장 지시 목록입니다.
                    </c:otherwise>
                </c:choose>
            </p>
        </div>

        <div class="action-group">
            <button type="button"
                    class="btn btn-outline-primary"
                    onclick="toggleMonthPanel()">
                월별 보기
            </button>

            <a href="${pageContext.request.contextPath}/packing/list"
               class="btn btn-outline-secondary">
                전체 보기
            </a>

            <a href="${pageContext.request.contextPath}/packing/dashboard"
               class="btn btn-outline-secondary">
                대시보드로
            </a>
        </div>
    </div>

    <div id="monthPanel"
         class="month-card month-panel ${not empty selectedMonth ? 'show' : ''}">
        <div class="card-body">
            <h6 class="panel-title">월별 보기</h6>

            <div class="month-list">
                <c:forEach var="month" items="${monthList}">
                    <a href="${pageContext.request.contextPath}/packing/list?month=${month}"
                       class="month-btn ${selectedMonth eq month ? 'active' : 'normal'}">
                            ${month}
                    </a>
                </c:forEach>

                <c:if test="${empty monthList}">
                    <span class="muted">등록된 월별 데이터가 없습니다.</span>
                </c:if>
            </div>
        </div>
    </div>

    <div class="table-card">
        <div class="card-body">

            <table class="order-table">
                <thead>
                <tr>
                    <th style="width: 70px;">번호</th>
                    <th style="width: 140px;">요청일</th>
                    <th style="width: 120px;">D-Day</th>
                    <th style="width: 190px;">등록일</th>
                    <th style="width: 140px;">상태</th>
                    <th style="width: 360px;">상세</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td>${order.id}</td>

                        <td class="request-date">
                            <c:choose>
                                <c:when test="${empty order.requestDate}">-</c:when>
                                <c:otherwise>${order.requestDate}</c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <span class="day-badge badge bg-secondary">계산중</span>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${empty order.createdAt}">-</c:when>
                                <c:otherwise>${order.createdAt}</c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${order.status eq 'REQUESTED'}">
                                    <span class="badge bg-secondary">포장요청</span>
                                </c:when>

                                <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                    <span class="badge bg-warning text-dark">포장완료</span>
                                </c:when>

                                <c:when test="${order.status eq 'SHIPPED'}">
                                    <span class="badge bg-primary">출고완료</span>
                                </c:when>

                                <c:when test="${order.status eq 'RECEIVED'}">
                                    <span class="badge bg-success">물류수령</span>
                                </c:when>

                                <c:when test="${order.status eq 'CANCELLED' || order.status eq 'CANCELED'}">
                                    <span class="badge bg-danger">주문취소</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="badge bg-dark">${order.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <div class="detail-actions">

                                <c:choose>
                                    <c:when test="${order.status eq 'CANCELLED' || order.status eq 'CANCELED'}">
                                        <button type="button"
                                                class="btn btn-secondary fixed-btn"
                                                disabled>
                                            상세불가
                                        </button>

                                        <button type="button"
                                                class="btn btn-secondary fixed-btn"
                                                disabled>
                                            출력불가
                                        </button>

                                        <button type="button"
                                                class="btn btn-secondary fixed-btn"
                                                disabled>
                                            수정불가
                                        </button>
                                    </c:when>

                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/packing/detail/${order.id}"
                                           class="btn btn-primary fixed-btn">
                                            상세보기
                                        </a>

                                        <a href="${pageContext.request.contextPath}/packing/work-order/${order.id}"
                                           class="btn btn-success fixed-btn"
                                           target="_blank">
                                            A4출력
                                        </a>

                                        <c:choose>
                                            <c:when test="${pendingChangeOrderIds.contains(order.id)}">
                                                <button type="button"
                                                        class="btn btn-danger fixed-btn"
                                                        disabled>
                                                    요청중
                                                </button>
                                            </c:when>

                                            <c:when test="${order.status eq 'SHIPPED'
                                || order.status eq 'RECEIVED'}">
                                                <button type="button"
                                                        class="btn btn-secondary fixed-btn"
                                                        disabled>
                                                    수정불가
                                                </button>
                                            </c:when>

                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/packing/change-request/${order.id}"
                                                   class="btn btn-outline-primary fixed-btn">
                                                    수정요청
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>

                            </div>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty orderList}">
                    <tr>
                        <td colspan="6" class="empty-row">포장 지시가 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

        </div>
    </div>

</div>

<script>
    function toggleMonthPanel() {
        const panel = document.getElementById("monthPanel");
        panel.classList.toggle("show");
    }

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
                badge.className = "day-badge badge bg-secondary";
                return;
            }

            const requestDate = new Date(dateText);
            requestDate.setHours(0, 0, 0, 0);

            const diff = Math.floor((requestDate - today) / (1000 * 60 * 60 * 24));

            if (diff > 0) {
                badge.innerText = "D-" + diff;
                badge.className = "day-badge badge bg-info text-dark";
            } else if (diff === 0) {
                badge.innerText = "D-DAY";
                badge.className = "day-badge badge bg-danger";
            } else {
                badge.innerText = "D+" + Math.abs(diff);
                badge.className = "day-badge badge bg-dark";
            }
        });
    }

    calculateDDay();
</script>


</body>
</html>
