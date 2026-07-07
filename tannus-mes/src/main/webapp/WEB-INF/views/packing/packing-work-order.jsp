<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 작업지시서</title>

    <style>
        * { box-sizing: border-box; }

        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --green: #16a34a;
            --green-dark: #15803d;
            --red: #dc2626;
            --orange: #f59e0b;
            --gray: #334155;
            --line: #cbd5e1;
            --text: #0f172a;
            --muted: #64748b;
        }

        body {
            margin: 0;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            background:
                    radial-gradient(circle at 8% 8%, rgba(37,99,235,0.12), transparent 28%),
                    linear-gradient(180deg, #f8fbff 0%, #eef5fb 100%);
            color: var(--text);
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
            backdrop-filter: blur(10px);
            border-bottom: 1px solid #dde7f0;
            box-shadow: 0 8px 20px rgba(15,23,42,0.06);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 38px;
            padding: 0 17px;
            border-radius: 12px;
            border: none;
            text-decoration: none;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            transition: transform .15s ease, opacity .15s ease, box-shadow .15s ease;
        }

        .btn:hover {
            opacity: .94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn-list {
            background: var(--blue);
            color: white;
        }

        .btn-print {
            background: var(--green);
            color: white;
        }

        .page {
            width: 980px;
            min-height: 1380px;
            margin: 32px auto;
            background: white;
            padding: 44px 52px;
            box-shadow: 0 18px 45px rgba(15,23,42,0.16);
            border-radius: 18px;
            position: relative;
            overflow: hidden;
        }

        .page:before {
            content: "TANNUS MES";
            position: absolute;
            right: 50px;
            top: 28px;
            font-size: 11px;
            letter-spacing: 1.5px;
            color: #94a3b8;
            font-weight: 900;
        }

        .title-area {
            text-align: center;
            margin-bottom: 30px;
            padding: 22px 24px 20px;
            border: 2px solid #0f172a;
            border-radius: 16px;
            background:
                    radial-gradient(circle at 92% 10%, rgba(37,99,235,0.12), transparent 28%),
                    linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
        }

        .title-area h1 {
            margin: 0;
            font-size: 34px;
            letter-spacing: 7px;
            font-weight: 900;
            color: #0f172a;
        }

        .title-area p {
            margin: 8px 0 0;
            font-size: 12px;
            color: var(--muted);
            letter-spacing: 2px;
            font-weight: 900;
        }

        .section {
            margin-bottom: 25px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 900;
            margin-bottom: 10px;
            padding-left: 11px;
            border-left: 6px solid var(--blue);
            color: #0f172a;
            letter-spacing: -0.2px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            background: white;
            overflow: hidden;
        }

        th {
            background: #f1f5f9;
            font-weight: 900;
            color: #0f172a;
        }

        th, td {
            border: 1px solid var(--line);
            padding: 12px 9px;
            font-size: 14px;
            text-align: center;
            vertical-align: middle;
        }

        .info-table {
            border: 1px solid var(--line);
            border-radius: 12px;
            overflow: hidden;
        }

        .info-table th {
            width: 18%;
            color: #334155;
        }

        .info-table td {
            width: 32%;
            font-weight: 800;
            color: #0f172a;
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
        }

        .status-requested { background: #e2e8f0; color: #334155; }
        .status-ready { background: #fef3c7; color: #92400e; }
        .status-shipped { background: #dbeafe; color: #1d4ed8; }
        .status-received { background: #dcfce7; color: #15803d; }
        .status-cancel { background: #fee2e2; color: #b91c1c; }

        .product-table {
            border-radius: 12px;
            overflow: hidden;
        }

        .product-table th:nth-child(1) { width: 10%; }
        .product-table th:nth-child(2) { width: 16%; }
        .product-table th:nth-child(3) { width: 24%; }
        .product-table th:nth-child(4) { width: 14%; }
        .product-table th:nth-child(5) { width: 9%; }
        .product-table th:nth-child(6) { width: 9%; }
        .product-table th:nth-child(7) { width: 9%; }
        .product-table th:nth-child(8) { width: 9%; }

        .product-table tbody tr:nth-child(even) {
            background: #f8fafc;
        }

        .product-table td:last-child b {
            color: var(--blue-dark);
            font-size: 15px;
        }

        .no-wrap {
            white-space: nowrap;
            word-break: keep-all;
        }

        .emergency-label {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 62px;
            height: 28px;
            padding: 0 9px;
            border-radius: 999px;
            background: #fee2e2;
            color: #b91c1c;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .memo-box {
            min-height: 112px;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 17px 18px;
            font-size: 14px;
            line-height: 1.8;
            background: #f8fafc;
            color: #334155;
            font-weight: 700;
        }

        .sign-table {
            border-radius: 12px;
            overflow: hidden;
        }

        .sign-table td {
            height: 86px;
            font-size: 15px;
        }

        .sign-label {
            height: 42px !important;
            background: #f1f5f9;
            font-weight: 900;
            color: #334155;
        }

        .empty {
            height: 90px;
            color: #94a3b8;
            font-weight: 900;
        }


        /* ===== 화면 반응형 보강 ===== */
        .table-scroll {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border-radius: 12px;
        }

        @media screen and (max-width: 1100px) {
            .page {
                width: calc(100% - 28px);
                min-height: auto;
                margin: 24px auto;
                padding: 34px 30px;
            }

            .title-area h1 {
                font-size: 30px;
                letter-spacing: 5px;
            }
        }

        @media screen and (max-width: 768px) {
            .top-actions {
                justify-content: stretch;
                padding: 12px 14px;
            }

            .top-actions .btn {
                flex: 1;
            }

            .page {
                width: calc(100% - 20px);
                margin: 18px auto;
                padding: 24px 18px;
                border-radius: 14px;
            }

            .page:before {
                right: 18px;
                top: 14px;
                font-size: 10px;
            }

            .title-area {
                padding: 18px 14px 16px;
                margin-bottom: 22px;
            }

            .title-area h1 {
                font-size: 25px;
                letter-spacing: 3px;
            }

            .title-area p {
                font-size: 11px;
                letter-spacing: 1.2px;
            }

            .section-title {
                font-size: 16px;
            }

            .info-table,
            .product-table,
            .sign-table {
                min-width: 720px;
            }

            th, td {
                padding: 10px 7px;
                font-size: 13px;
                white-space: nowrap;
            }

            .memo-box {
                font-size: 13px;
                min-height: 96px;
            }
        }

        @media screen and (max-width: 480px) {
            .top-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .page {
                padding: 20px 14px;
            }

            .title-area h1 {
                font-size: 22px;
                letter-spacing: 2px;
            }

            .section {
                margin-bottom: 20px;
            }
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
                padding: 9mm;
                box-shadow: none;
                border-radius: 0;
            }

            .page:before {
                display: none;
            }

            .title-area {
                padding: 12px 14px;
                margin-bottom: 18px;
                border-radius: 0;
            }

            th, td {
                padding: 7px 5px;
                font-size: 11px;
                line-height: 1.25;
            }

            .title-area h1 {
                font-size: 27px;
            }

            .section {
                margin-bottom: 18px;
            }

            .section-title {
                font-size: 15px;
                margin-bottom: 7px;
            }

            .memo-box {
                min-height: 65px;
                padding: 11px;
                font-size: 12px;
                border-radius: 0;
            }

            .sign-table td {
                height: 58px;
            }

            .emergency-label {
                min-width: 50px;
                height: 22px;
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
    <a href="${pageContext.request.contextPath}/packing/list"
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
        <h1>포장 작업지시서</h1>
        <p>PACKING WORK ORDER</p>
    </div>

    <div class="section">
        <div class="section-title">1. 지시 정보</div>

        <div class="table-scroll">
            <table class="info-table">
                <tr>
                    <th>포장지시번호</th>
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
                                <span class="status status-requested">포장요청</span>
                            </c:when>
                            <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                <span class="status status-ready">포장완료</span>
                            </c:when>
                            <c:when test="${order.status eq 'SHIPPED'}">
                                <span class="status status-shipped">출고완료</span>
                            </c:when>
                            <c:when test="${order.status eq 'RECEIVED'}">
                                <span class="status status-received">물류수령</span>
                            </c:when>
                            <c:when test="${order.status eq 'CANCELLED' || order.status eq 'CANCELED'}">
                                <span class="status status-cancel">주문취소</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status status-cancel">${order.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="section">
        <div class="section-title">2. 포장 품목</div>

        <div class="table-scroll">
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
                        <td class="no-wrap">${st.count}</td>
                        <td>${detail.productType}</td>
                        <td>${detail.modelName}</td>
                        <td>${detail.color}</td>
                        <td>${detail.hardness}</td>
                        <td>${detail.boxCount}</td>
                        <td>${detail.eachQty}</td>
                        <td><b>${detail.totalQty}</b></td>
                    </tr>
                </c:forEach>

                <c:forEach var="item" items="${unplannedList}" varStatus="ust">
                    <tr>
                        <td class="no-wrap">
                            <span class="emergency-label">긴급-${ust.count}</span>
                        </td>
                        <td>${item.productType}</td>
                        <td>${item.modelName}</td>
                        <td>${item.color}</td>
                        <td>${item.hardness}</td>
                        <td>${item.boxCount}</td>
                        <td>${item.eachQty}</td>
                        <td><b>${item.totalQty}</b></td>
                    </tr>
                </c:forEach>

                <c:if test="${empty order.detailList and empty unplannedList}">
                    <tr>
                        <td colspan="8" class="empty">
                            등록된 포장 품목이 없습니다.
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div class="section">
        <div class="section-title">3. 작업 메모</div>

        <div class="memo-box">
            포장 작업 전 상품, 모델, 색상, 경도 및 수량을 확인하십시오.<br>
            이상 발생 시 담당자에게 즉시 보고하십시오.
        </div>
    </div>

    <div class="section">
        <div class="section-title">4. 확인</div>

        <div class="table-scroll">
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

</div>

</body>
</html>