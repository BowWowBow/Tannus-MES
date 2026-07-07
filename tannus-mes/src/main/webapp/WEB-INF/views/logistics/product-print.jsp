<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>수출 출고 상품내역서</title>

    <style>
        @page { size: A4; margin: 10mm; }

        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            background:
                    radial-gradient(circle at 12% 10%, rgba(37, 99, 235, 0.13), transparent 30%),
                    radial-gradient(circle at 92% 2%, rgba(14, 165, 233, 0.14), transparent 28%),
                    linear-gradient(180deg, #eef5ff 0%, #f7f9fc 52%, #f4f6f9 100%);
            color: #0f172a;
        }

        .top-actions {
            position: sticky;
            top: 0;
            z-index: 20;
            width: 190mm;
            margin: 0 auto;
            padding: 14px 0;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn {
            border: none;
            min-height: 38px;
            padding: 0 16px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            box-shadow: 0 10px 22px rgba(37, 99, 235, 0.20);
        }

        .btn-blue { background: linear-gradient(135deg, #2563eb, #0ea5e9); }
        .btn-gray { background: #334155; }

        .page {
            width: 190mm;
            min-height: 277mm;
            margin: 0 auto 32px;
            padding: 12mm;
            background: rgba(255, 255, 255, 0.97);
            border-radius: 18px;
            box-shadow: 0 20px 44px rgba(15, 23, 42, 0.14);
        }

        .title-area {
            position: relative;
            overflow: hidden;
            padding: 22px 24px;
            border-radius: 20px;
            margin-bottom: 18px;
            background:
                    radial-gradient(circle at 88% 12%, rgba(255,255,255,0.28), transparent 28%),
                    linear-gradient(135deg, #1d4ed8, #2563eb 58%, #0ea5e9);
            color: white;
        }

        .title-area::before {
            content: "";
            position: absolute;
            right: -60px;
            top: -70px;
            width: 210px;
            height: 210px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .title-area h1 {
            position: relative;
            margin: 0 0 7px;
            padding-left: 15px;
            font-size: 26px;
            line-height: 1.2;
            letter-spacing: -0.5px;
            font-weight: 900;
        }

        .title-area h1::before {
            content: "";
            position: absolute;
            left: 0;
            top: 3px;
            width: 5px;
            height: 28px;
            border-radius: 999px;
            background: #bfdbfe;
        }

        .title-area p {
            position: relative;
            margin: 0;
            color: rgba(255, 255, 255, 0.86);
            font-size: 12px;
            font-weight: 800;
            letter-spacing: 1.5px;
        }

        .print-date {
            position: absolute;
            right: 24px;
            bottom: 22px;
            z-index: 1;
            font-size: 12px;
            font-weight: 900;
            color: rgba(255, 255, 255, 0.92);
        }

        .section {
            position: relative;
            overflow: hidden;
            background: #ffffff;
            border: 1px solid #dbeafe;
            border-radius: 18px;
            padding: 16px;
            margin-bottom: 16px;
            box-shadow: 0 10px 24px rgba(15, 23, 42, 0.06);
        }

        .section::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #2563eb, #38bdf8);
        }

        .section-title {
            position: relative;
            margin: 0 0 12px;
            padding-left: 12px;
            color: #1d4ed8;
            font-size: 16px;
            font-weight: 900;
            letter-spacing: -0.3px;
        }

        .section-title::before {
            content: "";
            position: absolute;
            left: 0;
            top: 3px;
            width: 5px;
            height: 18px;
            border-radius: 999px;
            background: #38bdf8;
        }

        .section-desc {
            margin: -6px 0 12px;
            color: #64748b;
            font-size: 11px;
            font-weight: 800;
            line-height: 1.45;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            table-layout: fixed;
            border: 1px solid #dbe3ef;
            border-radius: 14px;
            background: white;
        }

        th, td {
            border-bottom: 1px solid #e5e7eb;
            border-right: 1px solid #e5e7eb;
            padding: 8px 6px;
            font-size: 10.5px;
            line-height: 1.25;
            text-align: center;
            vertical-align: middle;
            word-break: keep-all;
            overflow-wrap: normal;
        }

        th:last-child, td:last-child { border-right: none; }
        tbody tr:last-child td { border-bottom: none; }

        th {
            background: linear-gradient(180deg, #eff6ff, #e0f2fe);
            color: #1e3a8a;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            color: #334155;
            font-weight: 700;
        }

        .info-table th {
            width: 18%;
            background: #f1f5f9;
            color: #334155;
        }

        .info-table td {
            width: 32%;
            font-size: 12px;
            font-weight: 900;
            text-align: left;
            padding-left: 12px;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 74px;
            min-height: 25px;
            padding: 4px 10px;
            border-radius: 999px;
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .emergency-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 48px;
            height: 22px;
            padding: 0;
            border-radius: 999px;
            background: #fff7ed;
            color: #c2410c;
            border: 1px solid #fed7aa;
            font-size: 9px;
            font-weight: 900;
            white-space: nowrap;
            letter-spacing: -0.4px;
        }

        .product-table .col-no { width: 8%; }
        .product-table .col-type { width: 12%; }
        .product-table .col-model { width: 21%; }
        .product-table .col-color { width: 16%; }
        .product-table .col-hardness { width: 8%; }
        .product-table .col-base { width: 10%; }
        .product-table .col-box { width: 8%; }
        .product-table .col-each { width: 9%; }
        .product-table .col-total { width: 8%; }

        .emergency-table .col-no { width: 10%; }
        .emergency-table .col-type { width: 10%; }
        .emergency-table .col-model { width: 18%; }
        .emergency-table .col-color { width: 13%; }
        .emergency-table .col-hardness { width: 7%; }
        .emergency-table .col-base { width: 8%; }
        .emergency-table .col-box { width: 7%; }
        .emergency-table .col-each { width: 8%; }
        .emergency-table .col-total { width: 8%; }
        .emergency-table .col-reason { width: 11%; }

        .emergency-table th,
        .emergency-table td {
            padding: 7px 4px;
            font-size: 9.5px;
            letter-spacing: -0.3px;
        }

        .emergency-table th {
            font-size: 9px;
        }

        .reason-cell {
            white-space: normal;
            word-break: keep-all;
            overflow-wrap: break-word;
            line-height: 1.25;
            color: #92400e;
            font-size: 9px;
            font-weight: 900;
            letter-spacing: -0.4px;
        }

        .empty {
            padding: 28px 0;
            color: #64748b;
            font-weight: 900;
        }

        .memo-box {
            border: 1px solid #dbe3ef;
            border-radius: 14px;
            background: #f8fbff;
            padding: 13px 15px;
            color: #475569;
            font-size: 12px;
            line-height: 1.7;
            font-weight: 800;
        }

        .sign-table td {
            height: 54px;
            font-size: 12px;
        }

        .sign-table .sign-label {
            height: 34px;
            background: #f1f5f9;
            font-weight: 900;
            color: #334155;
        }

        .footer {
            margin-top: 18px;
            padding-top: 10px;
            border-top: 1px dashed #cbd5e1;
            color: #64748b;
            font-size: 11px;
            font-weight: 800;
            text-align: right;
        }


        @media screen and (max-width: 760px) {
            @page { size: auto; margin: 0; }

            body {
                background:
                        radial-gradient(circle at 10% 4%, rgba(37, 99, 235, 0.16), transparent 34%),
                        linear-gradient(180deg, #eef5ff 0%, #f7f9fc 100%);
            }

            .top-actions {
                position: sticky;
                top: 0;
                width: 100%;
                padding: 12px 14px;
                justify-content: center;
                background: rgba(255,255,255,0.94);
                border-bottom: 1px solid #e2e8f0;
                backdrop-filter: blur(10px);
            }

            .top-actions .btn {
                flex: 1;
                max-width: 180px;
                min-height: 42px;
            }

            .page {
                width: auto;
                min-height: auto;
                margin: 14px 12px 30px;
                padding: 14px;
                border-radius: 20px;
            }

            .title-area {
                padding: 22px 18px 54px;
                border-radius: 18px;
            }

            .title-area h1 {
                font-size: 24px;
                line-height: 1.25;
                padding-left: 12px;
            }

            .title-area p {
                font-size: 11px;
                letter-spacing: 0.8px;
            }

            .print-date {
                left: 18px;
                right: auto;
                bottom: 20px;
                font-size: 11px;
            }

            .section {
                padding: 14px;
                border-radius: 18px;
                margin-bottom: 14px;
            }

            .section-title {
                font-size: 15px;
            }

            .section-desc {
                font-size: 11px;
            }

            .info-table,
            .info-table tbody,
            .info-table tr,
            .info-table th,
            .info-table td {
                display: block;
                width: 100% !important;
            }

            .info-table {
                border: none;
                background: transparent;
                border-radius: 0;
            }

            .info-table tr {
                margin-bottom: 10px;
                border: 1px solid #dbe3ef;
                border-radius: 14px;
                overflow: hidden;
                background: white;
            }

            .info-table th,
            .info-table td {
                border-right: none;
                text-align: left;
            }

            .info-table th {
                padding: 9px 12px;
                font-size: 12px;
                background: #eff6ff;
            }

            .info-table td {
                padding: 10px 12px;
                font-size: 13px;
                border-bottom: 1px solid #e5e7eb;
            }

            .product-table,
            .product-table thead,
            .product-table tbody,
            .product-table tr,
            .product-table th,
            .product-table td {
                display: block;
                width: 100% !important;
            }

            .product-table {
                border: none;
                background: transparent;
                border-radius: 0;
            }

            .product-table thead {
                display: none;
            }

            .product-table tbody tr {
                margin-bottom: 12px;
                border: 1px solid #dbe3ef;
                border-radius: 16px;
                overflow: hidden;
                background: white;
                box-shadow: 0 8px 18px rgba(15,23,42,0.06);
            }

            .product-table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 14px;
                min-height: 42px;
                padding: 10px 12px;
                border-right: none;
                border-bottom: 1px solid #e5e7eb;
                text-align: right;
                font-size: 13px;
                line-height: 1.35;
                white-space: normal;
                word-break: keep-all;
                overflow-wrap: anywhere;
            }

            .product-table td::before {
                flex: 0 0 auto;
                color: #475569;
                font-size: 12px;
                font-weight: 900;
                text-align: left;
                white-space: nowrap;
            }

            .product-table:not(.emergency-table) td:nth-child(1)::before { content: "번호"; }
            .product-table:not(.emergency-table) td:nth-child(2)::before { content: "상품종류"; }
            .product-table:not(.emergency-table) td:nth-child(3)::before { content: "모델/사이즈"; }
            .product-table:not(.emergency-table) td:nth-child(4)::before { content: "색상"; }
            .product-table:not(.emergency-table) td:nth-child(5)::before { content: "경도"; }
            .product-table:not(.emergency-table) td:nth-child(6)::before { content: "기본수량"; }
            .product-table:not(.emergency-table) td:nth-child(7)::before { content: "박스수"; }
            .product-table:not(.emergency-table) td:nth-child(8)::before { content: "낱개수량"; }
            .product-table:not(.emergency-table) td:nth-child(9)::before { content: "총수량"; }

            .emergency-table td:nth-child(1)::before { content: "번호"; }
            .emergency-table td:nth-child(2)::before { content: "상품종류"; }
            .emergency-table td:nth-child(3)::before { content: "모델/사이즈"; }
            .emergency-table td:nth-child(4)::before { content: "색상"; }
            .emergency-table td:nth-child(5)::before { content: "경도"; }
            .emergency-table td:nth-child(6)::before { content: "기본수량"; }
            .emergency-table td:nth-child(7)::before { content: "박스수"; }
            .emergency-table td:nth-child(8)::before { content: "낱개수량"; }
            .emergency-table td:nth-child(9)::before { content: "총수량"; }
            .emergency-table td:nth-child(10)::before { content: "사유"; }

            .emergency-table td {
                font-size: 13px;
                letter-spacing: 0;
                padding: 10px 12px;
            }

            .reason-cell {
                font-size: 12px;
                line-height: 1.45;
                text-align: right;
            }

            .empty {
                display: block !important;
                padding: 24px 10px !important;
                text-align: center !important;
            }

            .empty::before {
                content: none !important;
            }

            .memo-box {
                font-size: 12px;
                line-height: 1.65;
                padding: 13px;
            }

            .sign-table,
            .sign-table tbody,
            .sign-table tr {
                display: table;
                width: 100%;
            }

            .sign-table tr {
                display: table-row;
            }

            .sign-table td {
                display: table-cell;
                width: 33.333% !important;
                font-size: 11px;
                height: 46px;
            }

            .footer {
                text-align: center;
                font-size: 10px;
            }
        }

        @media print {
            body {
                background: white;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }

            .top-actions { display: none; }

            .page {
                width: auto;
                min-height: auto;
                margin: 0;
                padding: 0;
                border-radius: 0;
                box-shadow: none;
            }

            .title-area {
                padding: 18px 20px;
                margin-bottom: 12px;
            }

            .title-area h1 { font-size: 23px; }

            .print-date {
                right: 20px;
                bottom: 18px;
            }

            .section {
                padding: 12px;
                margin-bottom: 10px;
                box-shadow: none;
                border-radius: 14px;
                break-inside: avoid;
            }

            .section-title {
                font-size: 14px;
                margin-bottom: 8px;
            }

            .section-desc {
                font-size: 10px;
                margin-bottom: 8px;
            }

            th, td {
                padding: 6px 4px;
                font-size: 9px;
                line-height: 1.2;
            }

            .info-table td { font-size: 10.5px; }
            .emergency-table th,
            .emergency-table td { font-size: 8.5px; padding: 5px 3px; }
            .emergency-badge { width: 42px; height: 19px; font-size: 8px; }
            .reason-cell { font-size: 8px; line-height: 1.2; }

            .memo-box {
                padding: 10px;
                font-size: 10.5px;
                line-height: 1.55;
            }

            .sign-table td { height: 42px; }
        }
    </style>
</head>

<body>

<div class="top-actions">
    <a href="${pageContext.request.contextPath}/logistics/export/done-list"
       class="btn btn-gray">
        목록으로
    </a>

    <button type="button"
            class="btn btn-blue"
            onclick="window.print()">
        A4 출력
    </button>
</div>

<div class="page">

    <div class="title-area">
        <h1>수출 출고 상품내역서</h1>
        <p>TANNUS MES EXPORT PRODUCT LIST</p>

        <div class="print-date">
            출력일:
            <script>
                document.write(new Date().toISOString().slice(0, 10));
            </script>
        </div>
    </div>

    <div class="section">
        <h2 class="section-title">1. 지시 정보</h2>

        <table class="info-table">
            <tr>
                <th>수출 지시번호</th>
                <td>${order.id}</td>

                <th>출고요청일</th>
                <td>
                    <c:choose>
                        <c:when test="${empty order.requestDate}">-</c:when>
                        <c:otherwise>${order.requestDate}</c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <tr>
                <th>지시자</th>
                <td>
                    <c:choose>
                        <c:when test="${empty order.workerName}">-</c:when>
                        <c:otherwise>${order.workerName}</c:otherwise>
                    </c:choose>
                </td>

                <th>상태</th>
                <td>
                    <span class="badge">출고완료</span>
                </td>
            </tr>

            <tr>
                <th>비고</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${empty order.remark}">-</c:when>
                        <c:otherwise>${order.remark}</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>
    </div>

    <div class="section">
        <h2 class="section-title">2. 일반 출고 상품</h2>
        <div class="section-desc">
            관리자 수출 지시에 포함된 기본 출고 품목입니다.
        </div>

        <table class="product-table">
            <colgroup>
                <col class="col-no">
                <col class="col-type">
                <col class="col-model">
                <col class="col-color">
                <col class="col-hardness">
                <col class="col-base">
                <col class="col-box">
                <col class="col-each">
                <col class="col-total">
            </colgroup>

            <thead>
            <tr>
                <th>번호</th>
                <th>상품종류</th>
                <th>모델/사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>기본수량</th>
                <th>박스수</th>
                <th>낱개수량</th>
                <th>총수량</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty order.detailList}">
                    <tr>
                        <td colspan="9" class="empty">
                            일반 출고 상품이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="detail" items="${order.detailList}" varStatus="st">
                        <tr>
                            <td>${st.count}</td>
                            <td>${detail.type}</td>
                            <td>${detail.model}</td>
                            <td>${detail.color}</td>
                            <td>${detail.hardness}</td>
                            <td>${detail.baseQty}</td>
                            <td>${detail.boxCount}</td>
                            <td>${detail.eachQty}</td>
                            <td><b>${detail.totalQty} EA</b></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="section">
        <h2 class="section-title">3. 긴급 / 무발주 출고 상품</h2>
        <div class="section-desc">
            수출 출고 중 추가로 승인된 긴급 출고 품목입니다.
        </div>

        <table class="product-table emergency-table">
            <colgroup>
                <col class="col-no">
                <col class="col-type">
                <col class="col-model">
                <col class="col-color">
                <col class="col-hardness">
                <col class="col-base">
                <col class="col-box">
                <col class="col-each">
                <col class="col-total">
                <col class="col-reason">
            </colgroup>

            <thead>
            <tr>
                <th>번호</th>
                <th>상품종류</th>
                <th>모델/사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>기본수량</th>
                <th>박스수</th>
                <th>낱개수량</th>
                <th>총수량</th>
                <th>사유</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty unplannedExportList}">
                    <tr>
                        <td colspan="10" class="empty">
                            무발주 출고 상품이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="item" items="${unplannedExportList}" varStatus="st">
                        <tr>
                            <td>
                                <span class="emergency-badge">긴급-${st.count}</span>
                            </td>
                            <td>${item.productType}</td>
                            <td>${item.modelName}</td>
                            <td>${item.color}</td>
                            <td>${item.hardness}</td>
                            <td>${item.baseQty}</td>
                            <td>${item.boxCount}</td>
                            <td>${item.eachQty}</td>
                            <td><b>${item.totalQty} EA</b></td>
                            <td class="reason-cell">
                                <c:choose>
                                    <c:when test="${empty item.reason}">-</c:when>
                                    <c:otherwise>${item.reason}</c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="section">
        <h2 class="section-title">4. 작업 메모</h2>

        <div class="memo-box">
            출고 완료된 일반 상품과 긴급/무발주 출고 상품을 함께 확인하는 상품내역서입니다.<br>
            상품종류, 모델/사이즈, 색상, 경도 및 최종 출고 수량을 검수 후 보관하십시오.
        </div>
    </div>

    <div class="section">
        <h2 class="section-title">5. 확인</h2>

        <table class="sign-table">
            <tr>
                <td class="sign-label">출고 담당자</td>
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

    <div class="footer">
        Tannus MES / 수출 출고 상품내역서
    </div>

</div>

</body>
</html>
