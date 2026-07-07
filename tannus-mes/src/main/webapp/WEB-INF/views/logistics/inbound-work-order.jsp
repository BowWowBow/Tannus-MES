<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>물류 입고 작업지시서</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            color: #0f172a;
            background:
                    radial-gradient(circle at 10% 0%, rgba(22,163,74,0.14), transparent 30%),
                    radial-gradient(circle at 90% 8%, rgba(37,99,235,0.10), transparent 28%),
                    linear-gradient(180deg, #eef5ff 0%, #f7f9fc 48%, #f4f6f9 100%);
        }

        .top-actions {
            position: sticky;
            top: 0;
            z-index: 10;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            padding: 14px 24px;
            background: rgba(255,255,255,0.92);
            border-bottom: 1px solid rgba(203,213,225,0.72);
            backdrop-filter: blur(10px);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 38px;
            padding: 0 16px;
            border-radius: 12px;
            border: none;
            text-decoration: none;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            color: white;
            box-shadow: 0 8px 18px rgba(15,23,42,0.12);
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(15,23,42,0.16);
        }

        .btn-list {
            background: linear-gradient(135deg, #2563eb, #22c55e);
        }

        .btn-print {
            background: linear-gradient(135deg, #16a34a, #22c55e);
        }

        .page {
            width: 980px;
            min-height: 1380px;
            margin: 32px auto;
            background: rgba(255,255,255,0.96);
            padding: 46px 54px;
            box-shadow: 0 18px 45px rgba(15,23,42,0.14);
            border-radius: 22px;
            border: 1px solid rgba(203,213,225,0.72);
        }

        .title-area {
            position: relative;
            overflow: hidden;
            text-align: center;
            margin-bottom: 32px;
            padding: 28px 24px;
            border-radius: 22px;
            color: white;
            background:
                    radial-gradient(circle at 86% 18%, rgba(255,255,255,0.35), transparent 28%),
                    linear-gradient(135deg, #15803d, #22c55e);
            box-shadow: 0 14px 30px rgba(37,99,235,0.18);
        }

        .title-area:after {
            content: "";
            position: absolute;
            right: -50px;
            bottom: -70px;
            width: 210px;
            height: 210px;
            border-radius: 50%;
            background: rgba(255,255,255,0.13);
        }

        .title-area h1 {
            position: relative;
            z-index: 1;
            margin: 0;
            font-size: 34px;
            letter-spacing: 5px;
            font-weight: 900;
        }

        .title-area p {
            position: relative;
            z-index: 1;
            margin: 9px 0 0;
            font-size: 12px;
            color: rgba(255,255,255,0.86);
            letter-spacing: 2px;
            font-weight: 800;
        }

        .section {
            margin-bottom: 26px;
            page-break-inside: avoid;
        }

        .section-title {
            position: relative;
            margin: 0 0 12px;
            padding-left: 13px;
            color: #15803d;
            font-size: 18px;
            font-weight: 900;
            letter-spacing: -0.3px;
        }

        .section-title:before {
            content: "";
            position: absolute;
            left: 0;
            top: 4px;
            width: 5px;
            height: 20px;
            border-radius: 999px;
            background: #22c55e;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            table-layout: fixed;
            overflow: hidden;
            border: 1px solid #cfd8e3;
            border-radius: 14px;
            background: white;
        }

        th {
            background: linear-gradient(180deg, #f8fbff, #eef6ff);
            font-weight: 900;
            color: #1e3a8a;
        }

        th, td {
            border-right: 1px solid #dbe4ef;
            border-bottom: 1px solid #dbe4ef;
            padding: 13px 10px;
            font-size: 14px;
            text-align: center;
            vertical-align: middle;
            line-height: 1.35;
        }

        tr:last-child td {
            border-bottom: none;
        }

        th:last-child,
        td:last-child {
            border-right: none;
        }

        .info-table th {
            width: 18%;
        }

        .info-table td {
            width: 32%;
            font-weight: 700;
            color: #1e293b;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 90px;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .status-waiting,
        .status-shipped {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        .status-ready,
        .status-requested {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .status-readydone {
            background: #e0f2fe;
            color: #0369a1;
            border: 1px solid #bae6fd;
        }

        .status-done,
        .status-received {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .status-cancel {
            background: #e5e7eb;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .product-table th:nth-child(1) { width: 10%; }
        .product-table th:nth-child(2) { width: 16%; }
        .product-table th:nth-child(3) { width: 24%; }
        .product-table th:nth-child(4) { width: 14%; }
        .product-table th:nth-child(5) { width: 9%; }
        .product-table th:nth-child(6) { width: 9%; }
        .product-table th:nth-child(7) { width: 9%; }
        .product-table th:nth-child(8) { width: 9%; }

        .no-wrap {
            white-space: nowrap;
            word-break: keep-all;
        }

        .emergency-label {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 58px;
            height: 28px;
            padding: 0 8px;
            border-radius: 999px;
            background: #fff7ed;
            color: #c2410c;
            border: 1px solid #fed7aa;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .memo-box {
            min-height: 112px;
            border: 1px solid #cfd8e3;
            border-radius: 14px;
            padding: 18px;
            font-size: 14px;
            line-height: 1.8;
            background: linear-gradient(180deg, #fbfdff, #f8fafc);
            color: #334155;
            font-weight: 700;
        }

        .sign-table td {
            height: 90px;
            font-size: 15px;
        }

        .sign-label {
            height: 42px !important;
            background: linear-gradient(180deg, #f8fbff, #eef6ff);
            font-weight: 900;
            color: #1e3a8a;
        }

        .empty {
            height: 90px;
            color: #64748b;
            font-weight: 800;
        }


        @media (max-width: 1024px) {
            body {
                background: linear-gradient(180deg, #eef5ff 0%, #f8fafc 100%);
            }

            .top-actions {
                justify-content: center;
                flex-wrap: wrap;
                padding: 12px 14px;
            }

            .btn {
                flex: 1 1 140px;
                max-width: 220px;
            }

            .page {
                width: auto;
                min-height: auto;
                margin: 20px 14px 34px;
                padding: 24px 18px;
                border-radius: 20px;
            }

            .title-area {
                margin-bottom: 24px;
                padding: 24px 16px;
            }

            .title-area h1 {
                font-size: 28px;
                letter-spacing: 2px;
            }
        }

        @media (max-width: 720px) {
            .page {
                margin: 14px 10px 28px;
                padding: 18px 12px;
                border-radius: 18px;
            }

            .title-area {
                border-radius: 18px;
                padding: 22px 14px;
            }

            .title-area h1 {
                font-size: 24px;
                letter-spacing: -0.5px;
                word-break: keep-all;
            }

            .title-area p {
                font-size: 11px;
                letter-spacing: 1px;
            }

            .section {
                margin-bottom: 22px;
            }

            .section-title {
                font-size: 16px;
            }

            .info-table,
            .info-table tbody,
            .info-table tr,
            .info-table th,
            .info-table td {
                display: block;
                width: 100% !important;
            }

            .info-table tr {
                border-bottom: 1px solid #dbe4ef;
            }

            .info-table tr:last-child {
                border-bottom: none;
            }

            .info-table th {
                border-right: none;
                border-bottom: 1px solid #e5edf6;
                padding: 10px 12px 6px;
                text-align: left;
                background: #f8fbff;
                font-size: 12px;
            }

            .info-table td {
                border-right: none;
                padding: 8px 12px 12px;
                text-align: left;
                font-size: 14px;
            }

            .product-table {
                border: none;
                background: transparent;
            }

            .product-table thead {
                display: none;
            }

            .product-table,
            .product-table tbody,
            .product-table tr,
            .product-table td {
                display: block;
                width: 100%;
            }

            .product-table tr {
                margin-bottom: 12px;
                overflow: hidden;
                border: 1px solid #dbe4ef;
                border-radius: 16px;
                background: white;
                box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            }

            .product-table td {
                position: relative;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 14px;
                min-height: 42px;
                padding: 10px 12px;
                border-right: none;
                border-bottom: 1px solid #edf2f7;
                text-align: right;
                word-break: break-word;
            }

            .product-table td:last-child {
                border-bottom: none;
            }

            .product-table td:before {
                content: attr(data-label);
                flex: 0 0 92px;
                color: #15803d;
                font-size: 12px;
                font-weight: 900;
                text-align: left;
                white-space: nowrap;
            }

            .memo-box {
                min-height: auto;
                padding: 14px;
                font-size: 13px;
            }

            .sign-table,
            .sign-table tbody,
            .sign-table tr,
            .sign-table td {
                display: block;
                width: 100%;
            }

            .sign-table tr:first-child {
                display: none;
            }

            .sign-table tr:last-child td {
                position: relative;
                height: 68px;
                padding-top: 32px;
                border-right: none;
            }

            .sign-table tr:last-child td:before {
                position: absolute;
                left: 12px;
                top: 10px;
                color: #1e3a8a;
                font-size: 12px;
                font-weight: 900;
            }

            .sign-table tr:last-child td:nth-child(1):before { content: "작업자"; }
            .sign-table tr:last-child td:nth-child(2):before { content: "검수자"; }
            .sign-table tr:last-child td:nth-child(3):before { content: "확인자"; }
        }

        @media print {
            body {
                background: white;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .top-actions {
                display: none;
            }

            .page {
                width: 190mm;
                min-height: auto;
                margin: 0 auto;
                padding: 8mm;
                box-shadow: none;
                border-radius: 0;
                border: none;
            }

            .title-area {
                margin-bottom: 16px;
                padding: 16px 12px;
                border-radius: 12px;
                box-shadow: none;
            }

            .title-area h1 {
                font-size: 27px;
                letter-spacing: 4px;
            }

            .title-area p {
                font-size: 10px;
            }

            .section {
                margin-bottom: 14px;
            }

            .section-title {
                font-size: 14px;
                margin-bottom: 7px;
            }

            th, td {
                padding: 7px 5px;
                font-size: 10.5px;
                line-height: 1.25;
            }

            .status {
                min-width: 70px;
                padding: 4px 6px;
                font-size: 10px;
            }

            .memo-box {
                min-height: 58px;
                padding: 10px;
                font-size: 11px;
            }

            .sign-table td {
                height: 52px;
            }

            .emergency-label {
                min-width: 48px;
                height: 21px;
                font-size: 10px;
                padding: 0 4px;
            }

            @page {
                size: A4;
                margin: 8mm;
            }
        }
    </style>
</head>

<body>

<div class="top-actions">
    <a href="${pageContext.request.contextPath}/logistics/list"
       class="btn btn-list">
        상세목록
    </a>

    <button type="button"
            onclick="window.print()"
            class="btn btn-print">
        A4 출력
    </button>
</div>

<div class="page">

    <div class="title-area">
        <h1>물류 입고 작업지시서</h1>
        <p>INBOUND WORK ORDER</p>
    </div>

    <div class="section">
        <div class="section-title">1. 지시 정보</div>

        <table class="info-table">
            <tr>
                <th>입고지시번호</th>
                <td>${order.id}</td>
                <th>요청일</th>
                <td>${order.requestDate}</td>
            </tr>
            <tr>
                <th>지시자</th>
                <td>${order.requestedBy}</td>
                <th>상태</th>
                <td>
                    <c:choose>
                        <c:when test="${order.status eq 'REQUESTED'}">
                            <span class="status status-requested">포장대기</span>
                        </c:when>
                        <c:when test="${order.status eq 'READY_TO_SHIP'}">
                            <span class="status status-ready">포장완료</span>
                        </c:when>
                        <c:when test="${order.status eq 'SHIPPED'}">
                            <span class="status status-shipped">입고대기</span>
                        </c:when>
                        <c:when test="${order.status eq 'RECEIVED'}">
                            <span class="status status-received">입고완료</span>
                        </c:when>
                        <c:when test="${order.status eq 'CANCELLED'}">
                            <span class="status status-cancel">입고취소</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status status-cancel">${order.status}</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </div>

    <div class="section">
        <div class="section-title">2. 입고 품목</div>

        <table class="product-table">
            <thead>
            <tr>
                <th>번호</th>
                <th>상품종류</th>
                <th>모델 / 사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>BOX</th>
                <th>EACH</th>
                <th>총수량</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="detail" items="${order.detailList}" varStatus="st">
                <tr>
                    <td class="no-wrap" data-label="번호">${st.count}</td>
                    <td data-label="상품종류">${detail.productType}</td>
                    <td data-label="모델 / 사이즈">${detail.modelName}</td>
                    <td data-label="색상">${detail.color}</td>
                    <td data-label="경도">${detail.hardness}</td>
                    <td data-label="BOX">${detail.boxCount}</td>
                    <td data-label="EACH">${detail.eachQty}</td>
                    <td data-label="총수량"><b>${detail.totalQty}</b></td>
                </tr>
            </c:forEach>

            <c:forEach var="item" items="${unplannedList}" varStatus="ust">
                <tr>
                    <td class="no-wrap" data-label="번호">
                        <span class="emergency-label">긴급-${ust.count}</span>
                    </td>
                    <td data-label="상품종류">${item.productType}</td>
                    <td data-label="모델 / 사이즈">${item.modelName}</td>
                    <td data-label="색상">${item.color}</td>
                    <td data-label="경도">${item.hardness}</td>
                    <td data-label="BOX">${item.boxCount}</td>
                    <td data-label="EACH">${item.eachQty}</td>
                    <td data-label="총수량"><b>${item.totalQty}</b></td>
                </tr>
            </c:forEach>

            <c:if test="${empty order.detailList and empty unplannedList}">
                <tr>
                    <td colspan="8" class="empty" data-label="안내">
                        등록된 입고 품목이 없습니다.
                    </td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <div class="section">
        <div class="section-title">3. 작업 메모</div>

        <div class="memo-box">
            입고 작업 전 상품, 모델, 색상, 경도 및 수량을 확인하십시오.<br>
            이상 발생 시 담당자에게 즉시 보고하십시오.
        </div>
    </div>

    <div class="section">
        <div class="section-title">4. 확인</div>

        <table class="sign-table">
            <tr>
                <td class="sign-label">작업자</td>
                <td class="sign-label">검수자</td>
                <td class="sign-label">확인자</td>
            </tr>
            <tr>
                <td>서명</td>
                <td>서명</td>
                <td>서명</td>
            </tr>
        </table>
    </div>

</div>

</body>
</html>