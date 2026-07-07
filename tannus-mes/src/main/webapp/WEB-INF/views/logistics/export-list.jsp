<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 출고 대기 목록</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --green: #16a34a;
            --green-dark: #15803d;
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

        .page-title:before {
            content: "🚚 EXPORT ORDER LIST";
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

        .btn:hover:not(:disabled) {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn:disabled {
            cursor: not-allowed;
            opacity: 0.72;
        }

        .btn-dashboard {
            background: rgba(255,255,255,0.94);
            color: var(--blue-dark);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn-primary {
            background: var(--blue);
            color: white;
        }

        .btn-outline-primary {
            background: white;
            color: var(--blue-dark);
            border: 1px solid rgba(37,99,235,0.26);
        }

        .btn-danger {
            background: var(--red);
            color: white;
        }

        .btn-secondary {
            background: #64748b;
            color: white;
        }

        .btn-print {
            background: var(--green);
            color: white;
        }

        .btn-print:hover {
            background: var(--green-dark);
        }

        .fixed-btn {
            width: 92px;
            height: 34px;
            min-height: 34px;
            padding: 0;
            font-size: 13px;
        }

        form[method="get"] {
            display: flex !important;
            gap: 10px !important;
            justify-content: flex-end !important;
            align-items: center;
            margin-bottom: 16px !important;
            padding: 16px;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 22px;
            box-shadow: 0 14px 34px rgba(15,23,42,0.08);
        }

        form[method="get"]:before {
            content: "월별 조회";
            margin-right: auto;
            color: #334155;
            font-weight: 900;
            font-size: 14px;
        }

        form[method="get"] select {
            height: 40px !important;
            padding: 0 12px !important;
            border: 1px solid #cbd5e1 !important;
            border-radius: 12px !important;
            outline: none;
            font-size: 14px;
            color: #334155;
            background: white;
            font-weight: 800;
        }

        form[method="get"] select:focus {
            border-color: var(--blue) !important;
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
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
            min-width: 1080px;
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

        .bg-warning { background: #fef3c7; color: #92400e; }
        .bg-primary { background: #dbeafe; color: #1d4ed8; }
        .bg-info { background: #e0f2fe; color: #0369a1; }
        .bg-success { background: #dcfce7; color: #15803d; }
        .bg-secondary { background: #e2e8f0; color: #334155; }
        .bg-dark { background: #334155; color: white; }
        .bg-danger { background: #fee2e2; color: #b91c1c; }

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

        @media (max-width: 760px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .page-head {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title h1 {
                font-size: 26px;
            }

            form[method="get"] {
                justify-content: flex-start !important;
                flex-wrap: wrap;
            }

            form[method="get"]:before {
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

        .page-head > div:last-child {
            flex-shrink: 0;
        }

        form[method="get"] .btn {
            min-width: 74px;
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
                min-width: 1040px;
            }
        }

        @media (max-width: 768px) {
            .page-head {
                padding: 24px 22px;
                border-radius: 24px;
            }

            .page-title h1 {
                font-size: 26px;
                line-height: 1.25;
            }

            .page-title p {
                font-size: 13px;
            }

            .page-title:before {
                font-size: 11px;
                padding: 6px 10px;
            }

            .page-head > div:last-child,
            .page-head > div:last-child .btn {
                width: 100%;
            }

            form[method="get"] {
                display: grid !important;
                grid-template-columns: 1fr 1fr;
                gap: 8px !important;
                padding: 14px;
            }

            form[method="get"]:before {
                grid-column: 1 / -1;
                width: 100%;
                margin-right: 0;
            }

            form[method="get"] select {
                width: 100%;
            }

            form[method="get"] .btn {
                width: 100%;
            }

            th, td {
                padding: 12px 9px;
                font-size: 13px;
            }

            .fixed-btn {
                width: 86px;
                min-width: 86px;
                font-size: 12px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 20px 12px 34px;
            }

            .page-head {
                padding: 22px 18px;
                margin-bottom: 16px;
                border-radius: 22px;
            }

            .page-title h1 {
                font-size: 23px;
            }

            form[method="get"] {
                grid-template-columns: 1fr;
                border-radius: 18px;
            }

            .card {
                border-radius: 20px;
            }

            table {
                min-width: 980px;
            }

            .action-box {
                flex-wrap: nowrap;
                gap: 6px;
            }

            .fixed-btn {
                width: 78px;
                min-width: 78px;
                height: 34px;
                font-size: 12px;
            }
        }

    </style>
</head>

<body>
<div class="wrap">

    <div class="page-head">
        <div class="page-title">
            <h1>🚚 수출 출고 대기 목록</h1>
            <p>관리자가 등록한 수출 지시 목록입니다.</p>
        </div>

        <div style="display:flex; gap:10px;">

            <a href="${pageContext.request.contextPath}/logistics/dashboard"
               class="btn btn-dashboard">
                대시보드
            </a>

        </div>
    </div>

    <form method="get"
          action="${pageContext.request.contextPath}/logistics/export/list"
          style="display:flex; gap:10px; justify-content:flex-end; margin-bottom:14px;">

        <select name="month"
                style="height:34px; padding:0 10px; border:1px solid #ced4da; border-radius:7px;">
            <option value="">전체 월</option>

            <c:forEach var="month" items="${orderMonths}">
                <option value="${month}" ${selectedMonth eq month ? 'selected' : ''}>
                        ${month}
                </option>
            </c:forEach>
        </select>

        <button type="submit" class="btn btn-primary">
            조회
        </button>

        <a href="${pageContext.request.contextPath}/logistics/export/list"
           class="btn btn-secondary">
            전체
        </a>
    </form>

    <div class="card">
        <table>
            <thead>
            <tr>
                <th style="width:80px;">번호</th>
                <th style="width:150px;">출고요청일</th>
                <th style="width:120px;">D-Day</th>
                <th style="width:180px;">담당자</th>
                <th style="width:140px;">상태</th>
                <th style="width:360px;">상세</th>
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

                    <td>${order.workerName}</td>

                    <td>
                        <c:choose>
                            <c:when test="${order.status eq 'WAITING'}">
                                <span class="badge bg-warning">출고대기</span>
                            </c:when>
                            <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                <span class="badge bg-primary">출고준비</span>
                            </c:when>
                            <c:when test="${order.status eq 'READY_DONE'}">
                                <span class="badge bg-info">출고준비완료</span>
                            </c:when>
                            <c:when test="${order.status eq 'DONE'}">
                                <span class="badge bg-success">출고완료</span>
                            </c:when>
                            <c:when test="${order.status eq 'CANCELLED'}">
                                <span class="badge bg-dark">수출취소</span>
                            </c:when>
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

                                    <button type="button" class="btn btn-secondary fixed-btn" disabled>
                                        수정불가
                                    </button>
                                </c:when>

                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/logistics/export/detail/${order.id}"
                                       class="btn btn-primary fixed-btn">
                                        상세보기
                                    </a>

                                    <a href="${pageContext.request.contextPath}/logistics/export/work-order/${order.id}"
                                       class="btn btn-print fixed-btn"
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

                                        <c:when test="${order.status eq 'DONE'}">
                                            <button type="button"
                                                    class="btn btn-secondary fixed-btn"
                                                    disabled>
                                                수정불가
                                            </button>
                                        </c:when>

                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/logistics/export/change-request/${order.id}"
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
                    <td colspan="6" class="empty-row">출고 대기 목록이 없습니다.</td>
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