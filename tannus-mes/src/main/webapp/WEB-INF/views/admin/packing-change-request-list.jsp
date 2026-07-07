<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 수정요청 목록</title>

    <style>
        :root {
            --accent: #2563eb;
            --accent-dark: #1d4ed8;
            --accent-soft: rgba(37, 99, 235, 0.12);
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
            --card: #ffffff;
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
                    radial-gradient(circle at 8% 8%, var(--accent-soft), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(14, 165, 233, 0.12), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 1400px;
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
            margin-bottom: 20px;
            padding: 28px 30px;
            border-radius: 26px;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--accent), var(--accent-dark));
            color: white;
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
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

        .top-box:after {
            content: "";
            position: absolute;
            left: 28px;
            bottom: -52px;
            width: 150px;
            height: 150px;
            border-radius: 50%;
            background: rgba(255,255,255,0.10);
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
            margin: 0;
            color: white;
            font-size: 32px;
            font-weight: 900;
            letter-spacing: -0.7px;
        }

        .top-desc {
            margin-top: 9px;
            color: rgba(255,255,255,0.86);
            font-size: 14px;
            line-height: 1.6;
        }

        .top-actions {
            position: relative;
            z-index: 1;
            display: flex;
            gap: 10px;
            align-items: center;
            flex-wrap: wrap;
            justify-content: flex-end;
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
            background: var(--accent);
            white-space: nowrap;
            box-shadow: 0 8px 18px rgba(15,23,42,0.12);
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(15,23,42,0.16);
        }

        .btn.gray {
            background: #334155;
        }

        .btn.small {
            padding: 8px 13px;
            font-size: 13px;
            background: var(--accent);
            box-shadow: none;
        }

        .btn.outline {
            background: rgba(255,255,255,0.92);
            color: var(--accent-dark);
            border: 1px solid rgba(255,255,255,0.65);
            box-shadow: none;
        }

        .month-panel {
            display: none;
            background: rgba(255,255,255,0.94);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 22px;
            padding: 20px 22px;
            box-shadow: 0 14px 35px rgba(15,23,42,0.08);
            margin-bottom: 18px;
        }

        .month-panel.show {
            display: block;
        }

        .month-title {
            font-weight: 900;
            margin-bottom: 13px;
            color: #0f172a;
        }

        .month-list {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .month-btn {
            min-width: 94px;
            padding: 9px 13px;
            border-radius: 999px;
            font-size: 13px;
            font-weight: 900;
            text-align: center;
            text-decoration: none;
            border: 1px solid rgba(37,99,235,0.22);
            background: #fff;
            color: #334155;
            cursor: pointer;
        }

        .month-btn.active {
            background: var(--accent);
            border-color: var(--accent);
            color: white;
        }

        .summary-box {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 18px;
        }

        .summary-card {
            position: relative;
            overflow: hidden;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.9);
            border-radius: 22px;
            padding: 18px 20px;
            box-shadow: 0 14px 35px rgba(15,23,42,0.08);
        }

        .summary-card:after {
            content: "";
            position: absolute;
            right: -22px;
            top: -22px;
            width: 84px;
            height: 84px;
            border-radius: 50%;
            background: var(--accent-soft);
        }

        .summary-label {
            position: relative;
            z-index: 1;
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 8px;
            font-weight: 800;
        }

        .summary-value {
            position: relative;
            z-index: 1;
            font-size: 30px;
            font-weight: 900;
            color: var(--accent-dark);
        }

        .card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.9);
            border-radius: 24px;
            padding: 22px;
            box-shadow: 0 18px 42px rgba(15,23,42,0.10);
        }

        .order-group {
            border: 1px solid var(--line);
            border-radius: 20px;
            margin-bottom: 14px;
            overflow: hidden;
            background: white;
            box-shadow: 0 8px 22px rgba(15,23,42,0.05);
        }

        .order-head {
            width: 100%;
            border: none;
            background:
                    linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            cursor: pointer;
            text-align: left;
        }

        .order-head:hover {
            background:
                    linear-gradient(135deg, #ffffff 0%, #eef6ff 100%);
        }

        .order-title {
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 6px;
        }

        .order-sub {
            font-size: 13px;
            color: #64748b;
        }

        .order-right {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .request-body {
            display: none;
            padding: 0;
            background: white;
            overflow-x: auto;
            border-top: 1px solid var(--line);
        }

        .request-body.show {
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 950px;
        }

        thead {
            background: #f8fafc;
        }

        th, td {
            padding: 15px 13px;
            border-bottom: 1px solid #e5e7eb;
            text-align: center;
            font-size: 14px;
        }

        th {
            color: #334155;
            white-space: nowrap;
            font-weight: 900;
        }

        td {
            color: #475569;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 82px;
            height: 29px;
            padding: 0 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            color: white;
        }

        .status.waiting {
            background: #ef4444;
        }

        .status.checking {
            background: #f59e0b;
            color: #1f2937;
        }

        .status.approved {
            background: #16a34a;
        }

        .status.rejected {
            background: #64748b;
        }

        .status.done {
            background: #475569;
        }

        .content-preview {
            max-width: 280px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin: 0 auto;
            color: #334155;
        }

        .empty {
            padding: 54px 0;
            text-align: center;
            color: #94a3b8;
            font-weight: 800;
        }

        .arrow {
            font-size: 15px;
            font-weight: 900;
            color: #475569;
        }

        @media (max-width: 900px) {
            .wrap {
                padding: 22px 14px 38px;
            }

            .top-box {
                flex-direction: column;
                align-items: flex-start;
                padding: 24px 22px;
            }

            .top-actions {
                justify-content: flex-start;
            }

            .summary-box {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 560px) {
            .summary-box {
                grid-template-columns: 1fr;
            }

            .top-box h1 {
                font-size: 26px;
            }
        }


        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        .request-body {
            -webkit-overflow-scrolling: touch;
        }

        .request-body::-webkit-scrollbar {
            height: 8px;
        }

        .request-body::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        @media (max-width: 1100px) {
            .wrap {
                max-width: 100%;
            }

            .top-box {
                align-items: flex-start;
            }

            .summary-box {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 768px) {
            body {
                background:
                        radial-gradient(circle at 0% 0%, var(--accent-soft), transparent 30%),
                        linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            }

            .wrap {
                padding: 20px 12px 34px;
            }

            .top-box {
                padding: 23px 20px;
                border-radius: 22px;
                flex-direction: column;
                align-items: stretch;
            }

            .top-box h1 {
                font-size: 26px;
                line-height: 1.25;
            }

            .top-desc {
                font-size: 13px;
            }

            .top-actions {
                width: 100%;
                display: grid;
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .top-actions .btn {
                width: 100%;
            }

            .month-panel {
                padding: 17px;
                border-radius: 18px;
            }

            .month-list {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .month-btn {
                width: 100%;
                min-width: 0;
            }

            .summary-box {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 10px;
            }

            .summary-card {
                padding: 16px;
                border-radius: 18px;
            }

            .summary-label {
                font-size: 12px;
            }

            .summary-value {
                font-size: 26px;
            }

            .card {
                padding: 14px;
                border-radius: 20px;
            }

            .order-head {
                padding: 16px;
                flex-direction: column;
                align-items: stretch;
            }

            .order-title {
                font-size: 16px;
            }

            .order-sub {
                line-height: 1.5;
                word-break: keep-all;
            }

            .order-right {
                justify-content: space-between;
                width: 100%;
            }

            table {
                min-width: 860px;
            }

            th, td {
                padding: 13px 10px;
                font-size: 13px;
            }

            .content-preview {
                max-width: 220px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 16px 10px 30px;
            }

            .page-badge {
                font-size: 11px;
            }

            .top-box {
                padding: 21px 18px;
                border-radius: 20px;
            }

            .top-box h1 {
                font-size: 24px;
            }

            .summary-box {
                grid-template-columns: 1fr;
            }

            .month-list {
                grid-template-columns: 1fr;
            }

            .btn {
                min-height: 42px;
                padding: 10px 13px;
                font-size: 13px;
            }

            .order-group {
                border-radius: 17px;
            }

            .empty {
                padding: 42px 10px;
                font-size: 13px;
            }
        }

    </style>
</head>

<body>
<div class="wrap">

    <div class="top-box">
        <div>
            <div class="page-badge">📦 PACKING CHANGE</div>
            <h1>포장 수정요청 목록</h1>
            <div class="top-desc" id="pageDesc">포장 지시 변경 요청을 지시번호별로 묶어서 확인합니다.</div>
        </div>

        <div class="top-actions">
            <button type="button" class="btn outline" onclick="toggleMonthPanel()">
                월별 보기
            </button>

            <button type="button" class="btn outline" onclick="filterByMonth('')">
                전체 보기
            </button>

            <a href="${pageContext.request.contextPath}/dashboard" class="btn gray">
                관리자 대시보드
            </a>
        </div>
    </div>

    <div id="monthPanel" class="month-panel">
        <div class="month-title">월별 보기</div>
        <div id="monthList" class="month-list"></div>
    </div>

    <div class="summary-box">
        <div class="summary-card">
            <div class="summary-label">전체 건수</div>
            <div class="summary-value" id="totalCount">0</div>
        </div>
        <div class="summary-card">
            <div class="summary-label">승인대기</div>
            <div class="summary-value" id="waitingCount">0</div>
        </div>
        <div class="summary-card">
            <div class="summary-label">승인완료</div>
            <div class="summary-value" id="approvedCount">0</div>
        </div>
        <div class="summary-card">
            <div class="summary-label">반려완료</div>
            <div class="summary-value" id="rejectedCount">0</div>
        </div>
    </div>

    <div class="card">

        <c:choose>
        <c:when test="${empty requestList}">
            <div class="empty">등록된 포장 수정요청이 없습니다.</div>
        </c:when>

        <c:otherwise>

        <c:set var="prevOrderId" value="-1" />
        <c:set var="opened" value="false" />

        <c:forEach var="req" items="${requestList}" varStatus="st">

        <c:if test="${prevOrderId ne req.packingOrderId}">

        <c:if test="${opened}">
        </tbody>
        </table>
    </div>
</div>
</c:if>

<div class="order-group" data-order-group="true">
    <button type="button"
            class="order-head"
            onclick="toggleGroup('group-${req.packingOrderId}', this)">

        <div>
            <div class="order-title">포장지시번호 ${req.packingOrderId}</div>
            <div class="order-sub">
                최근 요청번호 ${req.id} · 최근 요청일 ${req.createdAt}
            </div>
        </div>

        <div class="order-right">
            <c:choose>
                <c:when test="${req.status eq 'WAITING'}">
                    <span class="status waiting">확인대기</span>
                </c:when>
                <c:when test="${req.status eq 'CHECKING'}">
                    <span class="status checking">확인중</span>
                </c:when>
                <c:when test="${req.status eq 'APPROVED'}">
                    <span class="status approved">승인완료</span>
                </c:when>
                <c:when test="${req.status eq 'REJECTED'}">
                    <span class="status rejected">반려완료</span>
                </c:when>
                <c:otherwise>
                    <span class="status done">${req.status}</span>
                </c:otherwise>
            </c:choose>

            <span class="arrow">▼</span>
        </div>
    </button>

    <div id="group-${req.packingOrderId}" class="request-body">
        <table>
            <thead>
            <tr>
                <th>요청번호</th>
                <th>요청자</th>
                <th>요청사유</th>
                <th>요청내용</th>
                <th>상태</th>
                <th>요청일</th>
                <th>관리</th>
            </tr>
            </thead>
            <tbody>

            <c:set var="prevOrderId" value="${req.packingOrderId}" />
            <c:set var="opened" value="true" />

            </c:if>

            <tr data-status="${req.status}" data-created-at="${req.createdAt}">
                <td>${req.id}</td>
                <td>${req.requestUser}</td>

                <td>
                    <div class="content-preview" title="${req.requestReason}">
                            ${req.requestReason}
                    </div>
                </td>

                <td>
                    <div class="content-preview" title="${req.requestContent}">
                            ${req.requestContent}
                    </div>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${req.status eq 'WAITING'}">
                            <span class="status waiting">확인대기</span>
                        </c:when>
                        <c:when test="${req.status eq 'CHECKING'}">
                            <span class="status checking">확인중</span>
                        </c:when>
                        <c:when test="${req.status eq 'APPROVED'}">
                            <span class="status approved">승인완료</span>
                        </c:when>
                        <c:when test="${req.status eq 'REJECTED'}">
                            <span class="status rejected">반려완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status done">${req.status}</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>${req.createdAt}</td>

                <td>
                    <a href="${pageContext.request.contextPath}/admin/packing/change-request/detail/${req.id}"
                       class="btn small">
                        상세보기
                    </a>
                </td>
            </tr>

            <c:if test="${st.last}">
            </tbody>
        </table>
    </div>
</div>
</c:if>

</c:forEach>

</c:otherwise>
</c:choose>

</div>
</div>

<script>
    function toggleMonthPanel() {
        document.getElementById("monthPanel").classList.toggle("show");
    }

    function toggleGroup(id, button) {
        const body = document.getElementById(id);
        const arrow = button.querySelector(".arrow");

        if (!body) return;

        body.classList.toggle("show");
        arrow.innerText = body.classList.contains("show") ? "▲" : "▼";
    }

    function getRowMonth(row) {
        const dateText = row.getAttribute("data-created-at") || "";
        return dateText.substring(0, 7);
    }

    function buildMonthButtons() {
        const rows = document.querySelectorAll("tr[data-created-at]");
        const monthSet = new Set();

        rows.forEach(function(row) {
            const month = getRowMonth(row);
            if (month) {
                monthSet.add(month);
            }
        });

        const monthList = document.getElementById("monthList");
        monthList.innerHTML = "";

        const months = Array.from(monthSet).sort().reverse();

        if (months.length === 0) {
            monthList.innerHTML = '<span style="color:#888;">등록된 월별 데이터가 없습니다.</span>';
            return;
        }

        months.forEach(function(month) {
            const button = document.createElement("button");
            button.type = "button";
            button.className = "month-btn";
            button.innerText = month;
            button.onclick = function() {
                filterByMonth(month);
            };
            monthList.appendChild(button);
        });
    }

    function filterByMonth(month) {
        const groups = document.querySelectorAll("[data-order-group]");
        const monthButtons = document.querySelectorAll(".month-btn");

        monthButtons.forEach(function(btn) {
            btn.classList.toggle("active", btn.innerText === month);
        });

        groups.forEach(function(group) {
            const rows = group.querySelectorAll("tr[data-status]");
            let hasVisibleRow = false;

            rows.forEach(function(row) {
                const rowMonth = getRowMonth(row);
                const visible = !month || rowMonth === month;
                row.style.display = visible ? "" : "none";

                if (visible) {
                    hasVisibleRow = true;
                }
            });

            group.style.display = hasVisibleRow ? "" : "none";
        });

        const desc = document.getElementById("pageDesc");
        desc.innerText = month ? month + " 월 포장 수정요청 이력입니다." : "전체 포장 수정요청 이력입니다.";

        updateSummary();
    }

    function updateSummary() {
        const rows = document.querySelectorAll("tr[data-status]");

        let total = 0;
        let waiting = 0;
        let approved = 0;
        let rejected = 0;

        rows.forEach(function(row) {
            if (row.style.display === "none") return;

            total++;

            const status = row.getAttribute("data-status");

            if (status === "WAITING") {
                waiting++;
            } else if (status === "APPROVED") {
                approved++;
            } else if (status === "REJECTED") {
                rejected++;
            }
        });

        document.getElementById("totalCount").innerText = total;
        document.getElementById("waitingCount").innerText = waiting;
        document.getElementById("approvedCount").innerText = approved;
        document.getElementById("rejectedCount").innerText = rejected;
    }

    buildMonthButtons();
    updateSummary();
</script>

</body>
</html>