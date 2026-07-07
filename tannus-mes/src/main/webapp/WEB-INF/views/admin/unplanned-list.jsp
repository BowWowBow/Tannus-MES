<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle}</title>

    <style>
        :root {
            --accent: #2563eb;
            --accent-dark: #1d4ed8;
            --accent-green: #16a34a;
            --accent-red: #dc2626;
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
            background:
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(22, 163, 74, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            color: var(--text);
        }

        .wrap {
            max-width: 1440px;
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
                    linear-gradient(135deg, #2563eb, #1d4ed8);
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
            white-space: nowrap;
            box-sizing: border-box;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
        }

        .btn.gray {
            background: #334155;
            box-shadow: 0 8px 18px rgba(15,23,42,0.14);
        }

        .btn.outline {
            background: rgba(255,255,255,0.92);
            color: var(--accent-dark);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn.approve {
            background: var(--accent-green);
            padding: 8px 12px;
            font-size: 13px;
        }

        .btn.reject {
            background: var(--accent-red);
            padding: 8px 12px;
            font-size: 13px;
        }

        .btn.detail {
            background: var(--accent);
            min-width: 82px;
            height: 34px;
            padding: 0 14px;
            font-size: 13px;
        }

        .month-panel {
            display: none;
            background: rgba(255,255,255,0.96);
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
        }

        .month-btn.active {
            background: var(--accent);
            color: white;
            border: 1px solid var(--accent);
        }

        .month-btn.normal {
            background: white;
            color: #334155;
            border: 1px solid rgba(37,99,235,0.22);
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

        .order-card {
            border: 1px solid var(--line);
            border-radius: 20px;
            margin-bottom: 14px;
            overflow: hidden;
            background: white;
            box-shadow: 0 8px 22px rgba(15,23,42,0.05);
        }

        .order-head {
            background:
                    linear-gradient(135deg, #ffffff 0%, #f8fafc 100%);
            padding: 18px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            cursor: pointer;
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

        .arrow {
            font-size: 15px;
            font-weight: 900;
            color: #475569;
        }

        .order-body {
            display: none;
            padding: 0;
            background: white;
            overflow-x: auto;
            border-top: 1px solid var(--line);
        }

        .order-body.show {
            display: block;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 1180px;
        }

        thead {
            background: #f8fafc;
        }

        th, td {
            padding: 15px 10px;
            border-bottom: 1px solid #e5e7eb;
            text-align: center;
            font-size: 13px;
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

        tr.pending {
            background: #fff7f7;
        }

        tr.approved {
            background: #f0fdf4;
        }

        tr.rejected {
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
            white-space: nowrap;
        }

        .status.pending {
            background: #ef4444;
        }

        .status.approved {
            background: #16a34a;
        }

        .status.rejected {
            background: #64748b;
        }

        .status.etc {
            background: #475569;
        }

        .reason {
            max-width: 170px;
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

        .action-box {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            min-width: 90px;
        }

        form {
            margin: 0;
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


        /* ===== Responsive Add-on ===== */
        .order-body::-webkit-scrollbar {
            height: 8px;
        }

        .order-body::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 28px 18px 44px;
            }

            table {
                min-width: 1100px;
            }

            .top-box {
                align-items: flex-start;
            }

            .top-actions {
                max-width: 420px;
            }
        }

        @media (max-width: 768px) {
            body {
                background:
                        radial-gradient(circle at 0% 0%, rgba(37, 99, 235, 0.15), transparent 30%),
                        linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            }

            .wrap {
                padding: 22px 14px 38px;
            }

            .top-box {
                flex-direction: column;
                align-items: stretch;
                padding: 24px 20px;
                border-radius: 22px;
            }

            .top-box h1 {
                font-size: 27px;
                line-height: 1.25;
            }

            .top-desc {
                font-size: 13px;
            }

            .top-actions {
                width: 100%;
                max-width: none;
                display: grid;
                grid-template-columns: 1fr;
                gap: 9px;
            }

            .top-actions .btn {
                width: 100%;
            }

            .month-panel {
                padding: 18px 16px;
                border-radius: 20px;
            }

            .month-list {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .month-btn {
                min-width: 0;
                width: 100%;
            }

            .summary-box {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 10px;
            }

            .summary-card {
                padding: 16px;
                border-radius: 18px;
            }

            .summary-value {
                font-size: 26px;
            }

            .card {
                padding: 14px;
                border-radius: 20px;
            }

            .order-head {
                flex-direction: column;
                align-items: flex-start;
                padding: 16px;
            }

            .order-right {
                width: 100%;
                justify-content: space-between;
            }

            .order-title {
                font-size: 16px;
            }

            .order-sub {
                font-size: 12px;
                line-height: 1.5;
            }

            .order-body {
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            table {
                min-width: 1080px;
            }

            th, td {
                padding: 13px 9px;
                font-size: 12px;
            }

            .action-box {
                flex-direction: column;
                gap: 6px;
            }

            .action-box form,
            .action-box .btn {
                width: 100%;
            }

            .btn.approve,
            .btn.reject,
            .btn.detail {
                width: 100%;
                min-width: 74px;
            }
        }

        @media (max-width: 480px) {
            .wrap {
                padding: 18px 10px 32px;
            }

            .top-box {
                padding: 22px 16px;
            }

            .top-box h1 {
                font-size: 24px;
            }

            .page-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .summary-box {
                grid-template-columns: 1fr;
            }

            .month-list {
                grid-template-columns: 1fr;
            }

            .summary-card {
                padding: 15px;
            }

            .summary-label {
                font-size: 12px;
            }

            .summary-value {
                font-size: 24px;
            }

            .order-head {
                padding: 15px 14px;
            }

            .status {
                min-width: 74px;
                height: 27px;
                font-size: 11px;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <div>
            <div class="page-badge">📌 UNPLANNED REQUEST</div>
            <h1>${pageTitle}</h1>

            <div class="top-desc">
                <c:choose>
                    <c:when test="${not empty selectedMonth}">
                        ${selectedMonth} 월 ${pageDescText}
                    </c:when>
                    <c:otherwise>
                        전체 ${pageDescText}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="top-actions">
            <button type="button" class="btn outline" onclick="toggleMonthPanel()">월별 보기</button>

            <a href="${pageContext.request.contextPath}/admin/unplanned/list?requestUser=${requestUser}"
               class="btn outline">
                전체 보기
            </a>

            <a href="${pageContext.request.contextPath}/dashboard" class="btn gray">관리자 대시보드</a>
        </div>
    </div>


    <div id="monthPanel" class="month-panel ${not empty selectedMonth ? 'show' : ''}">
        <div class="month-title">월별 보기</div>

        <div class="month-list">
            <c:forEach var="month" items="${monthList}">
                <a href="${pageContext.request.contextPath}/admin/unplanned/list?requestUser=${requestUser}&month=${month}"
                   class="month-btn ${selectedMonth eq month ? 'active' : 'normal'}">
                        ${month}
                </a>
            </c:forEach>

            <c:if test="${empty monthList}">
                <span style="color:#888;">등록된 월별 데이터가 없습니다.</span>
            </c:if>
        </div>
    </div>

    <div class="summary-box">
        <div class="summary-card"><div class="summary-label">전체 건수</div><div class="summary-value" id="totalCount">0</div></div>
        <div class="summary-card"><div class="summary-label">승인대기</div><div class="summary-value" id="pendingCount">0</div></div>
        <div class="summary-card"><div class="summary-label">승인완료</div><div class="summary-value" id="approvedCount">0</div></div>
        <div class="summary-card"><div class="summary-label">반려완료</div><div class="summary-value" id="rejectedCount">0</div></div>
    </div>

    <div class="card">

        <c:choose>
        <c:when test="${empty unplannedList}">
            <div class="empty">무발주 요청 이력이 없습니다.</div>
        </c:when>

        <c:otherwise>

        <c:set var="currentOrderId" value="" />

        <c:forEach var="item" items="${unplannedList}" varStatus="st">

        <c:set var="groupOrderId" value="${mode eq 'EXPORT' ? item.exportOrderId : item.packingOrderId}" />

        <c:if test="${currentOrderId ne groupOrderId}">

        <c:if test="${not st.first}">
        </tbody>
        </table>
    </div>
</div>
</c:if>

<c:set var="currentOrderId" value="${groupOrderId}" />

<div class="order-card">
    <div class="order-head" onclick="toggleOrder('order-${groupOrderId}', this)">
        <div>
            <div class="order-title">
                <c:choose>
                    <c:when test="${mode eq 'EXPORT'}">
                        수출지시번호 ${groupOrderId}
                    </c:when>
                    <c:otherwise>
                        포장지시번호 ${groupOrderId}
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="order-sub">
                요청번호 ${item.id} · 요청일
                <c:choose>
                    <c:when test="${empty item.createdAt}">-</c:when>
                    <c:otherwise>${item.createdAt}</c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="order-right">
            <c:choose>
                <c:when test="${item.status eq 'PENDING'}">
                    <span class="status pending">승인대기</span>
                </c:when>
                <c:when test="${item.status eq 'APPROVED'}">
                    <span class="status approved">승인완료</span>
                </c:when>
                <c:when test="${item.status eq 'REJECTED'}">
                    <span class="status rejected">반려완료</span>
                </c:when>
                <c:otherwise>
                    <span class="status etc">${item.status}</span>
                </c:otherwise>
            </c:choose>

            <span class="arrow">▼</span>
        </div>
    </div>

    <div id="order-${groupOrderId}" class="order-body">
        <table>
            <thead>
            <tr>
                <th>번호</th>
                <th>지시번호</th>
                <th>상품종류</th>
                <th>모델/사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>기본수량</th>
                <th>박스수</th>
                <th>낱개수량</th>
                <th>총수량</th>
                <th>요청자</th>
                <th>사유</th>
                <th>요청일</th>
                <th>처리자</th>
                <th>처리일</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
            </thead>

            <tbody>
            </c:if>

            <tr class="${item.status eq 'PENDING' ? 'pending' : item.status eq 'APPROVED' ? 'approved' : item.status eq 'REJECTED' ? 'rejected' : ''}"
                data-status="${item.status}">

                <td>${item.id}</td>

                <td>
                    <c:choose>
                        <c:when test="${mode eq 'EXPORT'}">
                            <a href="${pageContext.request.contextPath}/admin/export/detail/${item.exportOrderId}"
                               style="color:#0d6efd; font-weight:bold; text-decoration:none;">
                                    ${item.exportOrderId}
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/admin/packing/detail/${item.packingOrderId}"
                               style="color:#0d6efd; font-weight:bold; text-decoration:none;">
                                    ${item.packingOrderId}
                            </a>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>${item.productType}</td>
                <td>${item.modelName}</td>
                <td>${item.color}</td>
                <td>${item.hardness}</td>
                <td>${item.baseQty}</td>
                <td>${item.boxCount}</td>
                <td>${item.eachQty}</td>
                <td>${item.totalQty}</td>

                <td>
                    <c:choose>
                        <c:when test="${mode eq 'EXPORT'}">물류팀</c:when>
                        <c:otherwise>${item.requestUser}</c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <div class="reason" title="${item.reason}">
                        <c:choose>
                            <c:when test="${empty item.reason}">-</c:when>
                            <c:otherwise>${item.reason}</c:otherwise>
                        </c:choose>
                    </div>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${empty item.createdAt}">-</c:when>
                        <c:otherwise>${item.createdAt}</c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${mode eq 'EXPORT'}">-</c:when>
                        <c:when test="${empty item.approvedBy}">-</c:when>
                        <c:otherwise>${item.approvedBy}</c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${mode eq 'EXPORT' and empty item.checkedAt}">-</c:when>
                        <c:when test="${mode eq 'EXPORT'}">${item.checkedAt}</c:when>
                        <c:when test="${empty item.approvedAt}">-</c:when>
                        <c:otherwise>${item.approvedAt}</c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${item.status eq 'PENDING'}">
                            <span class="status pending">승인대기</span>
                        </c:when>
                        <c:when test="${item.status eq 'APPROVED'}">
                            <span class="status approved">승인완료</span>
                        </c:when>
                        <c:when test="${item.status eq 'REJECTED'}">
                            <span class="status rejected">반려완료</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status etc">${item.status}</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <div class="action-box">
                        <c:choose>
                            <c:when test="${item.status eq 'PENDING'}">
                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/unplanned/approve/${item.id}">
                                    <input type="hidden" name="requestUser" value="${requestUser}">
                                    <c:if test="${not empty selectedMonth}">
                                        <input type="hidden" name="month" value="${selectedMonth}">
                                    </c:if>

                                    <button type="submit"
                                            class="btn approve"
                                            onclick="return confirm('이 무발주 요청을 승인하시겠습니까?');">
                                        승인
                                    </button>
                                </form>

                                <form method="post"
                                      action="${pageContext.request.contextPath}/admin/unplanned/reject/${item.id}">
                                    <input type="hidden" name="requestUser" value="${requestUser}">
                                    <c:if test="${not empty selectedMonth}">
                                        <input type="hidden" name="month" value="${selectedMonth}">
                                    </c:if>

                                    <button type="submit"
                                            class="btn reject"
                                            onclick="return confirm('이 무발주 요청을 반려하시겠습니까?');">
                                        반려
                                    </button>
                                </form>
                            </c:when>

                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${mode eq 'EXPORT'}">
                                        <a class="btn detail"
                                           href="${pageContext.request.contextPath}/admin/export/detail/${item.exportOrderId}">
                                            상세보기
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn detail"
                                           href="${pageContext.request.contextPath}/admin/packing/detail/${item.packingOrderId}">
                                            상세보기
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
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
        const panel = document.getElementById("monthPanel");
        panel.classList.toggle("show");
    }

    function toggleOrder(id, head) {
        const body = document.getElementById(id);
        const arrow = head.querySelector(".arrow");

        body.classList.toggle("show");

        if (body.classList.contains("show")) {
            arrow.innerText = "▲";
        } else {
            arrow.innerText = "▼";
        }
    }

    function updateSummary() {
        const rows = document.querySelectorAll("tbody tr[data-status]");

        let total = 0;
        let pending = 0;
        let approved = 0;
        let rejected = 0;

        rows.forEach(function(row) {
            total++;

            const status = row.getAttribute("data-status");

            if (status === "PENDING") {
                pending++;
            } else if (status === "APPROVED") {
                approved++;
            } else if (status === "REJECTED") {
                rejected++;
            }
        });

        document.getElementById("totalCount").innerText = total;
        document.getElementById("pendingCount").innerText = pending;
        document.getElementById("approvedCount").innerText = approved;
        document.getElementById("rejectedCount").innerText = rejected;
    }

    updateSummary();
</script>

</body>
</html>
