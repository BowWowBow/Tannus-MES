<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 지시 목록</title>


    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", Arial, sans-serif;
            background:
                    radial-gradient(circle at 12% 12%, rgba(59, 130, 246, 0.16), transparent 28%),
                    radial-gradient(circle at 88% 8%, rgba(14, 165, 233, 0.20), transparent 30%),
                    linear-gradient(180deg, #eef7ff 0%, #f8fafc 42%, #f4f6f9 100%);
            color: #0f172a;
        }

        .wrap {
            max-width: 1320px;
            margin: 0 auto;
            padding: 34px 22px 48px;
        }

        .hero {
            position: relative;
            overflow: hidden;
            border-radius: 28px;
            padding: 30px 34px;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            background:
                    radial-gradient(circle at 88% 12%, var(--hero-glow), transparent 36%),
                    linear-gradient(135deg, rgba(255,255,255,0.96), var(--hero-bg));
            border: 1px solid rgba(148, 163, 184, 0.22);
            box-shadow: 0 22px 55px rgba(15, 23, 42, 0.12);
        }

        .hero:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -85px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: var(--hero-circle);
        }

        .hero:after {
            content: "";
            position: absolute;
            right: 120px;
            bottom: -80px;
            width: 170px;
            height: 170px;
            border-radius: 50%;
            background: rgba(255,255,255,0.44);
        }

        .hero-left,
        .hero-actions {
            position: relative;
            z-index: 1;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 0.2px;
            color: var(--main);
            background: var(--badge-bg);
            margin-bottom: 10px;
        }

        .badge:before {
            content: "";
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: var(--main);
            box-shadow: 0 0 0 5px var(--badge-dot);
        }

        h1 {
            margin: 0;
            font-size: 34px;
            line-height: 1.2;
            letter-spacing: -0.8px;
            color: var(--main-dark);
            font-weight: 900;
        }

        .hero p {
            margin: 9px 0 0;
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .btn-group,
        .hero-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            border: none;
            border-radius: 14px;
            min-height: 42px;
            padding: 0 18px;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            color: white;
            background: var(--main);
            box-shadow: 0 12px 24px var(--btn-shadow);
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
            white-space: nowrap;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
        }

        .btn.gray {
            background: #475569;
            box-shadow: 0 12px 24px rgba(71, 85, 105, 0.18);
        }

        .filter-card {
            position: relative;
            background: rgba(255,255,255,0.94);
            border-radius: 24px;
            padding: 22px 24px;
            margin-bottom: 22px;
            border: 1px solid rgba(226, 232, 240, 0.9);
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.09);
        }

        .filter-row {
            display: flex;
            align-items: center;
            gap: 14px;
            flex-wrap: wrap;
        }

        .filter-label {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 15px;
            font-weight: 900;
            color: #0f172a;
        }

        .filter-label:before {
            content: "";
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--main);
            box-shadow: 0 0 0 5px var(--badge-dot);
        }

        .month-select {
            border: 1px solid #cbd5e1;
            border-radius: 14px;
            padding: 0 15px;
            height: 42px;
            font-size: 14px;
            min-width: 230px;
            background: #f8fafc;
            color: #0f172a;
            outline: none;
        }

        .month-select:focus {
            border-color: var(--main);
            box-shadow: 0 0 0 4px var(--focus);
            background: white;
        }

        .table-card {
            background: rgba(255,255,255,0.96);
            border-radius: 26px;
            padding: 24px;
            border: 1px solid rgba(226, 232, 240, 0.92);
            box-shadow: 0 20px 55px rgba(15, 23, 42, 0.10);
        }

        .table-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 14px;
        }

        .table-title {
            margin: 0;
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
        }

        .table-hint {
            color: #64748b;
            font-size: 13px;
            font-weight: 700;
        }

        .table-wrap {
            overflow-x: auto;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            background: white;
        }

        table {
            width: 100%;
            min-width: 920px;
            border-collapse: collapse;
        }

        thead {
            background: linear-gradient(180deg, #f8fafc, #eef2f7);
        }

        th {
            padding: 16px 12px;
            font-size: 13px;
            color: #334155;
            border-bottom: 1px solid #e2e8f0;
            text-align: center;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            padding: 16px 12px;
            text-align: center;
            border-bottom: 1px solid #edf2f7;
            color: #475569;
            font-size: 14px;
            vertical-align: middle;
        }

        tbody tr {
            transition: background 0.14s ease, transform 0.14s ease;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        tbody tr:last-child td {
            border-bottom: 0;
        }

        .order-no {
            font-weight: 900;
            color: var(--main-dark);
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 92px;
            height: 30px;
            padding: 0 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            line-height: 1;
            box-sizing: border-box;
            white-space: nowrap;
        }

        .status-waiting,
        .waiting {
            background: #64748b;
            color: white;
        }

        .status-ready {
            background: #2563eb;
            color: white;
        }

        .status-ready-done {
            background: #67e8f9;
            color: #155e75;
        }

        .status-done {
            background: #16a34a;
            color: white;
        }

        .status-cancelled,
        .cancelled {
            background: #ef4444;
            color: white;
        }

        .status-etc,
        .etc {
            background: #111827;
            color: white;
        }

        .done {
            background: #facc15;
            color: #422006;
        }

        .shipped {
            background: #2563eb;
            color: white;
        }

        .received {
            background: #16a34a;
            color: white;
        }

        .action-group {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            min-height: 38px;
        }

        .detail-btn,
        .edit-btn,
        .edit-btn-disabled {
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 36px;
            min-width: 78px;
            padding: 0 14px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 900;
            line-height: 1;
            box-sizing: border-box;
            color: white;
            transition: transform 0.15s ease, opacity 0.15s ease;
        }

        .detail-btn {
            background: var(--main);
        }

        .edit-btn {
            background: #f59e0b;
        }

        .edit-btn-disabled {
            background: #e2e8f0;
            color: #94a3b8;
            cursor: not-allowed;
            pointer-events: none;
        }

        .detail-btn:hover,
        .edit-btn:hover {
            opacity: 0.92;
            transform: translateY(-1px);
        }

        .empty {
            padding: 68px 0;
            text-align: center;
            color: #94a3b8;
            font-size: 15px;
            font-weight: 800;
        }

        .empty:before {
            content: "등록된 데이터 없음";
            display: block;
            width: fit-content;
            margin: 0 auto 10px;
            padding: 7px 12px;
            border-radius: 999px;
            background: #f1f5f9;
            color: #64748b;
            font-size: 12px;
        }

        .table-wrap::-webkit-scrollbar {
            height: 8px;
        }

        .table-wrap::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .table-wrap::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        @media (max-width: 1024px) {
            .wrap {
                padding: 28px 18px 44px;
            }

            .hero {
                padding: 28px 26px;
            }

            table {
                min-width: 860px;
            }
        }

        @media (max-width: 768px) {
            .wrap {
                padding: 22px 14px 36px;
            }

            .hero {
                padding: 24px 20px;
                align-items: flex-start;
                flex-direction: column;
                border-radius: 22px;
            }

            h1 {
                font-size: 27px;
            }

            .hero p {
                font-size: 13px;
                word-break: keep-all;
            }

            .hero-actions,
            .btn-group {
                width: 100%;
            }

            .hero-actions .btn,
            .btn-group .btn {
                flex: 1;
                min-width: 0;
            }

            .filter-card,
            .table-card {
                padding: 16px;
                border-radius: 22px;
            }

            .filter-row {
                align-items: stretch;
                flex-direction: column;
                gap: 10px;
            }

            .filter-label {
                width: 100%;
            }

            .month-select {
                width: 100%;
                min-width: 0;
            }

            .filter-row .btn {
                width: 100%;
            }

            .table-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .table-hint {
                line-height: 1.5;
                word-break: keep-all;
            }

            .table-wrap {
                border-radius: 16px;
                -webkit-overflow-scrolling: touch;
            }

            th,
            td {
                padding: 13px 10px;
                font-size: 13px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 18px 10px 32px;
            }

            .hero {
                padding: 22px 18px;
            }

            .badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            h1 {
                font-size: 24px;
            }

            .hero-actions {
                display: grid;
                grid-template-columns: 1fr;
            }

            .hero-actions .btn,
            .btn-group .btn,
            .filter-row .btn {
                width: 100%;
                min-height: 44px;
            }

            .table-title {
                font-size: 17px;
            }

            .action-group {
                gap: 6px;
            }

            .detail-btn,
            .edit-btn,
            .edit-btn-disabled {
                min-width: 70px;
                padding: 0 10px;
                font-size: 12px;
            }
        }
    </style>

    <style>
        :root {
            --main: #2563eb;
            --main-dark: #1d4ed8;
            --hero-bg: #eaf4ff;
            --hero-glow: rgba(37, 99, 235, 0.25);
            --hero-circle: rgba(37, 99, 235, 0.12);
            --badge-bg: rgba(37, 99, 235, 0.12);
            --badge-dot: rgba(37, 99, 235, 0.12);
            --btn-shadow: rgba(37, 99, 235, 0.22);
            --focus: rgba(37, 99, 235, 0.14);
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="hero">

        <div class="hero-left">
            <div class="badge">PACKING ORDER</div>
            <h1>포장 지시 목록</h1>
            <p>월별 포장 지시와 작업 진행 상태를 한눈에 확인합니다.</p>
        </div>

        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/admin/packing/new" class="btn">
                신규등록
            </a>

            <a href="${pageContext.request.contextPath}/dashboard" class="btn gray">
                대시보드
            </a>
        </div>

    </div>

    <div class="filter-card">

        <form method="get"
              action="${pageContext.request.contextPath}/admin/packing/list">

            <div class="filter-row">

                <div class="filter-label">요청월</div>

                <select name="month" class="month-select">

                    <option value="">전체 보기</option>

                    <c:forEach var="month" items="${monthList}">
                        <option value="${month}"
                                <c:if test="${selectedMonth eq month}">
                                    selected
                                </c:if>>
                                ${month}
                        </option>
                    </c:forEach>

                </select>

                <button type="submit" class="btn">
                    조회
                </button>

            </div>

        </form>

    </div>

    <div class="table-card">

        <div class="table-top">
            <h2 class="table-title">포장 지시 현황</h2>
            <div class="table-hint">상세보기에서 품목별 수량과 포장 처리 상태를 확인할 수 있습니다.</div>
        </div>

        <div class="table-wrap">
            <table>

                <thead>
                <tr>
                    <th>지시번호</th>
                    <th>요청일</th>
                    <th>지시자</th>
                    <th>상태</th>
                    <th>상세항목수</th>
                    <th>관리</th>
                </tr>
                </thead>

                <tbody>

                <c:choose>

                    <c:when test="${empty orderList}">
                        <tr>
                            <td colspan="6" class="empty">
                                등록된 포장 지시가 없습니다.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>

                        <c:forEach var="order" items="${orderList}">

                            <tr>

                                <td class="order-no">${order.id}</td>

                                <td>${order.requestDate}</td>

                                <td>${order.requestedBy}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${order.status eq 'REQUESTED'}">
                                            <span class="status waiting">포장대기</span>
                                        </c:when>

                                        <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                            <span class="status done">포장완료</span>
                                        </c:when>

                                        <c:when test="${order.status eq 'SHIPPED'}">
                                            <span class="status shipped">물류수령</span>
                                        </c:when>

                                        <c:when test="${order.status eq 'RECEIVED'}">
                                            <span class="status received">출고완료</span>
                                        </c:when>

                                        <c:when test="${order.status eq 'CANCELLED'}">
                                            <span class="status cancelled">주문취소</span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status etc">${order.status}</span>
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
                                    <div class="action-group">

                                        <a href="${pageContext.request.contextPath}/admin/packing/detail/${order.id}"
                                           class="detail-btn">
                                            상세보기
                                        </a>

                                        <c:choose>
                                            <c:when test="${order.status eq 'SHIPPED' or order.status eq 'RECEIVED' or order.status eq 'CANCELLED'}">
                                                <span class="edit-btn-disabled">
                                                    수정
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/admin/packing/edit/${order.id}"
                                                   class="edit-btn">
                                                    수정
                                                </a>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                </td>

                            </tr>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

                </tbody>

            </table>
        </div>

    </div>

</div>

</body>
</html>
