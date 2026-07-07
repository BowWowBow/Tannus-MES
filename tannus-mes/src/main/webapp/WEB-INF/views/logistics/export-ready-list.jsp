<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>수출 출고 대기 목록</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --blue-soft: #eff6ff;
            --green: #16a34a;
            --green-dark: #15803d;
            --red: #dc2626;
            --sky: #0ea5e9;
            --gray: #334155;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
            --white: #ffffff;
            --shadow: 0 16px 38px rgba(15, 23, 42, 0.09);
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
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            color: var(--text);
            background:
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(22, 163, 74, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        a {
            color: inherit;
        }

        .wrap {
            width: 100%;
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
                    radial-gradient(circle at 88% 15%, rgba(255, 255, 255, 0.38), transparent 28%),
                    linear-gradient(135deg, var(--blue), var(--blue-dark));
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
        }

        .page-head:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.16);
        }

        .page-head > div,
        .page-head .btn {
            position: relative;
            z-index: 1;
        }

        .page-title:before {
            content: "🚚 EXPORT WAITING";
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.22);
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 0.4px;
            margin-bottom: 10px;
            color: white;
        }

        .page-title h1 {
            margin: 0 0 8px;
            font-size: clamp(25px, 4vw, 32px);
            font-weight: 900;
            color: white;
            letter-spacing: -0.7px;
            line-height: 1.22;
        }

        .page-title p {
            margin: 0;
            color: rgba(255, 255, 255, 0.88);
            font-size: 14px;
            line-height: 1.6;
            font-weight: 700;
        }

        .head-actions {
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
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
            font-family: inherit;
        }

        .btn:hover:not(:disabled) {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15, 23, 42, 0.14);
        }

        .btn:disabled {
            cursor: not-allowed;
            opacity: 0.68;
        }

        .btn-dashboard {
            background: rgba(255, 255, 255, 0.94);
            color: var(--blue-dark);
            border: 1px solid rgba(255, 255, 255, 0.65);
        }

        .btn-primary {
            background: var(--blue);
            color: white;
        }

        .btn-outline-primary {
            background: white;
            color: var(--blue-dark);
            border: 1px solid rgba(37, 99, 235, 0.26);
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
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid rgba(226, 232, 240, 0.95);
            border-radius: 22px;
            box-shadow: 0 14px 34px rgba(15, 23, 42, 0.08);
        }

        .filter-box select {
            height: 40px;
            min-width: 132px;
            padding: 0 12px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            outline: none;
            font-size: 14px;
            color: #334155;
            background: white;
            font-weight: 800;
            font-family: inherit;
        }

        .filter-box select:focus {
            border-color: var(--blue);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
        }

        .card {
            background: rgba(255, 255, 255, 0.96);
            border: 1px solid rgba(226, 232, 240, 0.95);
            border-radius: 24px;
            box-shadow: var(--shadow);
            padding: 0;
            overflow: hidden;
        }

        .table-scroll {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        table {
            width: 100%;
            min-width: 1050px;
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

        @media (max-width: 900px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .page-head {
                flex-direction: column;
                align-items: flex-start;
                padding: 24px 22px;
                border-radius: 22px;
            }

            .head-actions {
                width: 100%;
            }

            .head-actions .btn {
                width: 100%;
            }

            .filter-box {
                justify-content: flex-start;
                flex-wrap: wrap;
                border-radius: 20px;
            }
        }

        @media (max-width: 640px) {
            .wrap {
                padding: 18px 12px 34px;
            }

            .page-head {
                margin-bottom: 14px;
                padding: 22px 18px;
            }

            .page-title:before {
                font-size: 11px;
                padding: 6px 10px;
            }

            .page-title p {
                font-size: 13px;
            }

            .filter-box {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
                padding: 12px;
            }

            .filter-box select {
                grid-column: 1 / -1;
                width: 100%;
                min-width: 0;
            }

            .filter-box .btn {
                width: 100%;
                padding: 0 10px;
            }

            .card {
                background: transparent;
                border: 0;
                box-shadow: none;
                overflow: visible;
            }

            .table-scroll {
                overflow: visible;
            }

            table {
                min-width: 0;
                background: transparent;
            }

            thead {
                display: none;
            }

            table,
            tbody,
            tr,
            td {
                display: block;
                width: 100%;
            }

            tbody tr {
                margin-bottom: 14px;
                padding: 14px;
                border: 1px solid rgba(226, 232, 240, 0.95);
                border-radius: 20px;
                background: rgba(255, 255, 255, 0.97);
                box-shadow: 0 12px 28px rgba(15, 23, 42, 0.08);
            }

            tbody tr:hover {
                background: rgba(255, 255, 255, 0.97);
            }

            td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 14px;
                padding: 10px 2px;
                border-bottom: 1px dashed #e2e8f0;
                text-align: right;
                font-size: 14px;
            }

            td:last-child {
                border-bottom: 0;
                padding-bottom: 0;
            }

            td:before {
                content: attr(data-label);
                flex: 0 0 96px;
                text-align: left;
                color: #64748b;
                font-size: 13px;
                font-weight: 900;
                white-space: nowrap;
            }

            td[data-label="상세"] {
                display: block;
                text-align: left;
            }

            td[data-label="상세"]:before {
                display: block;
                margin-bottom: 10px;
            }

            .action-box {
                display: grid;
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .fixed-btn {
                width: 100%;
                height: 38px;
                min-height: 38px;
            }

            .empty-row {
                display: block;
                height: auto;
                padding: 26px 14px;
                text-align: center;
                border: 1px solid rgba(226, 232, 240, 0.95);
                border-radius: 20px;
                background: white;
            }

            .empty-row:before {
                display: none;
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

        <div class="head-actions">
            <a href="${pageContext.request.contextPath}/logistics/dashboard"
               class="btn btn-dashboard">
                대시보드
            </a>
        </div>
    </div>

    <form method="get"
          action="${pageContext.request.contextPath}/logistics/export/list"
          class="filter-box">

        <select name="month">
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
        <div class="table-scroll">
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
                        <td data-label="번호">${order.id}</td>

                        <td data-label="출고요청일" class="request-date">${order.requestDate}</td>

                        <td data-label="D-Day">
                            <span class="badge bg-secondary day-badge">계산중</span>
                        </td>

                        <td data-label="담당자">${order.workerName}</td>

                        <td data-label="상태">
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

                        <td data-label="상세">
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

</div>

<script>
    function parseLocalDate(dateText) {
        if (!dateText || dateText === "-") {
            return null;
        }

        const onlyDate = dateText.trim().substring(0, 10);
        const parts = onlyDate.split("-");

        if (parts.length !== 3) {
            return null;
        }

        return new Date(Number(parts[0]), Number(parts[1]) - 1, Number(parts[2]));
    }

    function calculateDDay() {
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        document.querySelectorAll("tbody tr").forEach(function(row) {
            const dateCell = row.querySelector(".request-date");
            const badge = row.querySelector(".day-badge");

            if (!dateCell || !badge) return;

            const requestDate = parseLocalDate(dateCell.innerText.trim());

            if (!requestDate) {
                badge.innerText = "-";
                badge.className = "badge bg-secondary day-badge";
                return;
            }

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
