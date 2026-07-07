<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 지시 상세</title>

    <script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --blue-soft: rgba(37,99,235,0.12);
            --green: #16a34a;
            --green-dark: #15803d;
            --yellow: #f59e0b;
            --red: #dc2626;
            --gray: #334155;
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
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(22, 163, 74, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 1280px;
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
            color: white;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--blue), var(--blue-dark));
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

        .top-box h1,
        .btn-group {
            position: relative;
            z-index: 1;
        }

        .top-box h1 {
            margin: 0;
            color: white;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.7px;
        }

        .top-box h1:before {
            content: "📦 PACKING DETAIL";
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
            color: white;
        }

        .top-box h1 {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .btn-group {
            display: flex;
            gap: 9px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn {
            text-decoration: none;
            border: none;
            background: var(--blue);
            color: white;
            padding: 10px 16px;
            border-radius: 13px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 900;
            cursor: pointer;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
            transform: none;
        }

        .btn.gray {
            background: rgba(255,255,255,0.94);
            color: var(--gray);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn.yellow {
            background: var(--yellow);
            color: #1f2937;
        }

        .btn.green {
            background: var(--green);
        }

        .btn.red {
            background: var(--red);
        }

        .card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }

        .info-box {
            position: relative;
            overflow: hidden;
            background: #f8fbff;
            border: 1px solid #dbeafe;
            border-radius: 18px;
            padding: 16px 18px;
        }

        .info-box:after {
            content: "";
            position: absolute;
            right: -24px;
            top: -24px;
            width: 78px;
            height: 78px;
            border-radius: 50%;
            background: var(--blue-soft);
        }

        .info-label {
            position: relative;
            z-index: 1;
            display: block;
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 7px;
            font-weight: 800;
        }

        .info-value {
            position: relative;
            z-index: 1;
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 29px;
            min-width: 82px;
            padding: 0 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            box-sizing: border-box;
            white-space: nowrap;
        }

        .status.waiting {
            background: #64748b;
            color: white;
        }

        .status.ready {
            background: var(--yellow);
            color: #1f2937;
        }

        .status.done {
            background: var(--blue);
            color: white;
        }

        .status.pending {
            background: var(--red);
            color: white;
        }

        .status.approved {
            background: var(--green);
            color: white;
        }

        .status.reject {
            background: #64748b;
            color: white;
        }

        .status.etc {
            background: #334155;
            color: white;
        }

        .remark-box {
            margin-top: 16px;
            background: #f8fbff;
            border: 1px solid #dbeafe;
            border-radius: 18px;
            padding: 16px 18px;
        }

        .remark-title {
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 7px;
            font-weight: 800;
        }

        .remark-value {
            font-size: 15px;
            color: #0f172a;
            min-height: 24px;
            line-height: 1.6;
            font-weight: 700;
        }

        .section-title {
            margin: 0 0 16px;
            color: #0f172a;
            font-size: 21px;
            font-weight: 900;
            letter-spacing: -0.3px;
        }

        .section-title:before {
            content: "";
            display: inline-block;
            width: 6px;
            height: 20px;
            border-radius: 999px;
            background: var(--blue);
            margin-right: 9px;
            vertical-align: -4px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .product-card {
            background: white;
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 22px;
            padding: 20px;
            box-shadow: 0 12px 28px rgba(15,23,42,0.07);
        }

        .product-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 14px;
        }

        .product-title h3 {
            margin: 0;
            font-size: 21px;
            color: #0f172a;
            font-weight: 900;
            letter-spacing: -0.4px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            overflow: hidden;
        }

        th, td {
            padding: 12px 13px;
            border: 1px solid #e5e7eb;
            font-size: 14px;
            vertical-align: middle;
        }

        th {
            background: #f8fafc;
            text-align: left;
            color: #334155;
            font-weight: 900;
        }

        .info-table th {
            width: 40%;
        }

        .list-table {
            min-width: 1000px;
        }

        .list-table th,
        .list-table td {
            text-align: center;
            white-space: nowrap;
        }

        td {
            color: #475569;
            font-weight: 700;
        }

        .qr-box {
            min-height: 124px;
            border: 1px dashed #cbd5e1;
            border-radius: 16px;
            margin-top: 16px;
            padding: 16px;
            text-align: center;
            background: #f8fafc;
        }

        .bottom-actions {
            margin-top: 24px;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .bottom-actions form {
            margin: 0;
        }

        .empty {
            text-align: center;
            padding: 42px 0;
            color: #94a3b8;
            font-weight: 900;
        }

        .alert {
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #be123c;
            border-radius: 18px;
            padding: 15px 18px;
            margin-bottom: 20px;
            font-size: 14px;
            font-weight: 900;
            box-shadow: 0 10px 24px rgba(15,23,42,0.06);
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 16px;
        }

        .form-box label {
            display: block;
            font-size: 13px;
            margin-bottom: 7px;
            color: #334155;
            font-weight: 900;
        }

        .form-box input,
        .form-box select {
            width: 100%;
            height: 44px;
            border: 1px solid #cbd5e1;
            border-radius: 13px;
            padding: 0 12px;
            box-sizing: border-box;
            background: white;
            outline: none;
            font-size: 14px;
        }

        .form-box input:focus,
        .form-box select:focus {
            border-color: var(--blue);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
        }

        .form-box input:read-only {
            background: #f1f5f9;
            color: #64748b;
        }

        .form-box select:disabled {
            background: #f1f5f9;
            color: #64748b;
        }

        .type-block {
            display: none;
        }

        .row-pending {
            background: #fff1f2;
        }

        .row-approved {
            background: #f0fdf4;
        }

        .row-rejected {
            background: #f8fafc;
        }

        .unplanned-badge {
            display: inline-flex;
            align-items: center;
            margin-left: 6px;
            padding: 5px 9px;
            border-radius: 999px;
            background: #eef2ff;
            color: #3730a3;
            font-size: 11px;
            font-weight: 900;
        }

        @media (max-width: 1100px) {
            .info-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .product-grid {
                grid-template-columns: 1fr;
            }

            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 760px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .info-grid,
            .form-grid {
                grid-template-columns: 1fr;
            }

            .top-box {
                flex-direction: column;
                align-items: flex-start;
                gap: 14px;
            }

            .btn-group {
                justify-content: flex-start;
            }

            .top-box h1 {
                font-size: 26px;
            }

            .card {
                padding: 20px;
            }
        }


        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .table-scroll,
        .detail-scroll {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .table-scroll::-webkit-scrollbar,
        .detail-scroll::-webkit-scrollbar {
            height: 8px;
        }

        .table-scroll::-webkit-scrollbar-thumb,
        .detail-scroll::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .table-scroll::-webkit-scrollbar-track,
        .detail-scroll::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        .product-card {
            min-width: 0;
        }

        .product-title h3 {
            word-break: keep-all;
            overflow-wrap: anywhere;
        }

        .info-value,
        .remark-value,
        td {
            overflow-wrap: anywhere;
        }

        .top-box .btn-group {
            max-width: 100%;
        }

        @media (max-width: 900px) {
            .wrap {
                padding: 26px 16px 44px;
            }

            .top-box {
                padding: 24px 22px;
            }

            .btn-group {
                width: 100%;
                justify-content: flex-start;
            }

            .btn-group .btn {
                flex: 1 1 calc(50% - 9px);
            }

            .bottom-actions {
                justify-content: flex-start;
            }

            .bottom-actions .btn,
            .bottom-actions form {
                flex: 1 1 calc(50% - 10px);
            }

            .bottom-actions form .btn {
                width: 100%;
            }
        }

        @media (max-width: 620px) {
            .wrap {
                padding: 20px 12px 36px;
            }

            .top-box {
                border-radius: 22px;
                padding: 22px 18px;
            }

            .top-box h1 {
                font-size: 24px;
            }

            .top-box h1:before {
                font-size: 11px;
                padding: 6px 10px;
            }

            .card {
                padding: 16px;
                border-radius: 20px;
            }

            .section-title {
                font-size: 18px;
            }

            .info-box,
            .remark-box,
            .product-card {
                border-radius: 16px;
                padding: 14px;
            }

            .product-title {
                align-items: flex-start;
                flex-direction: column;
            }

            .product-title h3 {
                font-size: 18px;
            }

            th, td {
                padding: 10px 9px;
                font-size: 13px;
            }

            .info-table th {
                width: 38%;
            }

            .qr-box {
                min-height: 110px;
                padding: 12px;
            }

            .btn-group .btn,
            .bottom-actions .btn,
            .bottom-actions form {
                flex: 1 1 100%;
                width: 100%;
            }

            .form-box input,
            .form-box select {
                height: 42px;
            }

            .list-table {
                min-width: 980px;
            }
        }

        @media (max-width: 420px) {
            .wrap {
                padding-left: 10px;
                padding-right: 10px;
            }

            .top-box h1 {
                font-size: 22px;
            }

            .info-label,
            .remark-title,
            .form-box label {
                font-size: 12px;
            }

            .info-value {
                font-size: 15px;
            }

            .status {
                min-width: auto;
                height: 28px;
                padding: 0 10px;
                font-size: 11px;
            }
        }

    </style>

</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>포장 지시 상세</h1>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/packing/list" class="btn gray">
                포장 지시 목록
            </a>

            <a href="${pageContext.request.contextPath}/packing/dashboard" class="btn gray">
                대시보드
            </a>

            <a href="${pageContext.request.contextPath}/packing/report/${order.id}"
               target="_blank"
               class="btn green">
                📄 포장내역 출력
            </a>

            <a href="${pageContext.request.contextPath}/packing/print/${order.id}"
               target="_blank"
               class="btn green">
                <c:choose>
                    <c:when test="${order.status eq 'REQUESTED'}">
                        🖨 전체 QR 출력
                    </c:when>
                    <c:otherwise>
                        🖨 스캔완료 QR 재출력
                    </c:otherwise>
                </c:choose>
            </a>
        </div>
    </div>

    <c:if test="${pendingChange}">
        <div class="alert">
            ⚠ 현재 이 포장 지시는 수정요청 처리중입니다.
            수정요청이 승인완료 또는 반려완료되기 전까지 포장 처리를 할 수 없습니다.
        </div>
    </c:if>

    <div class="card">

        <div class="info-grid">

            <div class="info-box">
                <span class="info-label">포장 지시 번호</span>
                <span class="info-value">${order.id}</span>
            </div>

            <div class="info-box">
                <span class="info-label">요청일</span>
                <span class="info-value">${order.requestDate}</span>
            </div>

            <div class="info-box">
                <span class="info-label">지시자</span>
                <span class="info-value">
                <c:choose>
                    <c:when test="${empty order.requestedBy}">
                        -
                    </c:when>
                    <c:otherwise>
                        ${order.requestedBy}
                    </c:otherwise>
                </c:choose>
            </span>
            </div>

            <div class="info-box">
                <span class="info-label">상태</span>
                <span class="info-value">
                <c:choose>
                    <c:when test="${pendingChange}">
                        <span class="status waiting">포장대기</span>
                        <span class="status pending">수정요청중</span>
                    </c:when>

                    <c:when test="${order.status eq 'REQUESTED'}">
                        <span class="status waiting">포장대기</span>
                    </c:when>

                    <c:when test="${order.status eq 'READY_TO_SHIP'}">
                        <span class="status ready">포장완료</span>
                    </c:when>

                    <c:when test="${order.status eq 'SHIPPED'}">
                        <span class="status done">출고완료</span>
                    </c:when>

                    <c:otherwise>
                        <span class="status etc">${order.status}</span>
                    </c:otherwise>
                </c:choose>
            </span>
            </div>

        </div>

        <div class="remark-box">
            <div class="remark-title">비고</div>
            <div class="remark-value">
                <c:choose>
                    <c:when test="${empty order.remark}">
                        -
                    </c:when>
                    <c:otherwise>
                        ${order.remark}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

    </div>

    <div class="card">
        <h2 class="section-title">
            <c:choose>
                <c:when test="${order.status eq 'REQUESTED'}">
                    포장 대상 상품 목록
                </c:when>
                <c:otherwise>
                    실제 포장완료 상품 목록
                </c:otherwise>
            </c:choose>
        </h2>

        <div class="product-grid">

            <c:choose>
                <c:when test="${empty order.detailList}">
                    <div class="empty">
                        포장 대상 상품이 없습니다.
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="detail" items="${order.detailList}" varStatus="st">

                        <c:if test="${order.status eq 'REQUESTED'
                            || detail.packingScanStatus eq 'DONE'}">

                            <div class="product-card">

                                <div class="product-title">
                                    <h3>${detail.productType} / ${detail.modelName}</h3>

                                    <span class="status done">
                                ${detail.totalQty} EA
                            </span>
                                </div>

                                <table class="info-table">
                                    <tr>
                                        <th>종류</th>
                                        <td>${detail.productType}</td>
                                    </tr>

                                    <tr>
                                        <th>모델/사이즈</th>
                                        <td>${detail.modelName}</td>
                                    </tr>

                                    <tr>
                                        <th>색상</th>
                                        <td>${detail.color}</td>
                                    </tr>

                                    <tr>
                                        <th>경도</th>
                                        <td>${detail.hardness}</td>
                                    </tr>

                                    <tr>
                                        <th>박스수</th>
                                        <td>${detail.boxCount}</td>
                                    </tr>

                                    <tr>
                                        <th>낱개수량</th>
                                        <td>${detail.eachQty}</td>
                                    </tr>

                                    <tr>
                                        <th>총수량</th>
                                        <td>${detail.totalQty} EA</td>
                                    </tr>
                                </table>


                                <div id="qr-${st.index}" class="qr-box"></div>

                            </div>

                        </c:if>

                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <c:if test="${order.status eq 'REQUESTED'}">
        <div class="card">
            <h2 class="section-title">무발주 포장 등록</h2>

            <form action="${pageContext.request.contextPath}/packing/unplanned/save/${order.id}"
                  method="post"
                  id="unplannedPackingForm">

                <input type="hidden" id="modelName" name="modelName">

                <div class="form-grid">

                    <div class="form-box">
                        <label>상품종류</label>
                        <select id="productType" name="productType" required>
                            <option value="">선택하세요</option>
                            <option value="TIRE">타이어 (TIRE)</option>
                            <option value="ARMOUR">아머 (ARMOUR)</option>
                            <option value="TUBELESS">튜브리스 (TUBELESS)</option>
                        </select>
                    </div>

                    <div class="form-box">
                        <label>모델/사이즈</label>

                        <select id="modelSelect" required>
                            <option value="">상품종류를 먼저 선택하세요</option>
                        </select>

                    </div>

                    <div class="form-box">
                        <label>색상</label>
                        <select id="color" name="color" required>
                            <option value="">선택</option>
                            <option value="LEMON">LEMON</option>
                            <option value="MELON">MELON</option>
                            <option value="VOLCANO">VOLCANO</option>
                            <option value="AQUAMARINE">AQUAMARINE</option>
                            <option value="COTTON">COTTON</option>
                            <option value="MIDNIGHT">MIDNIGHT</option>
                            <option value="VEGAS">VEGAS</option>
                            <option value="CARROT">CARROT</option>
                            <option value="LOVE">LOVE</option>
                            <option value="MOCHA">MOCHA</option>
                            <option value="CITY">CITY</option>
                            <option value="SAHARA">SAHARA</option>
                            <option value="BLACK">BLACK</option>
                            <option value="RED">RED</option>
                        </select>
                    </div>

                    <div class="form-box">
                        <label>경도</label>
                        <select id="hardness" name="hardness" required>
                            <option value="">선택</option>
                            <option value="H">H</option>
                            <option value="F">F</option>
                            <option value="D">D</option>
                            <option value="B">B</option>
                            <option value="R">R</option>
                        </select>
                    </div>

                    <div class="form-box">
                        <label>기본수량</label>
                        <input type="number" id="baseQty" name="baseQty" readonly>
                    </div>

                    <div class="form-box">
                        <label>박스수</label>
                        <input type="number" id="boxCount" name="boxCount" min="0" value="0" required>
                    </div>

                    <div class="form-box">
                        <label>낱개수량</label>
                        <input type="number" id="eachQty" name="eachQty" min="0" value="0" required>
                    </div>

                    <div class="form-box">
                        <label>총수량</label>
                        <input type="number" id="totalQty" name="totalQty" readonly>
                    </div>

                    <input type="hidden" id="qty" name="qty">

                    <div class="form-box">
                        <label>사유</label>
                        <input type="text"
                               name="reason"
                               placeholder="예: 지시에 없는 추가 포장">
                    </div>

                </div>

                <button type="submit" class="btn red">
                    무발주 포장 등록
                </button>

            </form>
        </div>
    </c:if>

    <div class="card">
        <h2 class="section-title">무발주 포장 목록</h2>

        <div class="table-scroll"><table class="list-table">
            <thead>
            <tr>
                <th>상품종류</th>
                <th>모델/사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>기본수량</th>
                <th>박스수</th>
                <th>낱개수량</th>
                <th>총수량</th>
                <th>사유</th>
                <th>상태</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty unplannedPackingList}">
                    <tr>
                        <td colspan="10" class="empty">
                            등록된 무발주 포장 품목이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="item" items="${unplannedPackingList}">
                        <tr class="${item.status eq 'PENDING'
                            ? 'row-pending'
                            : item.status eq 'APPROVED'
                            ? 'row-approved'
                            : 'row-rejected'}"
                            id="unplanned-packing-row-${item.id}">

                            <td>${item.productType}</td>
                            <td>${item.modelName}</td>
                            <td>${item.color}</td>
                            <td>${item.hardness}</td>
                            <td>${item.baseQty}</td>
                            <td>${item.boxCount}</td>
                            <td>${item.eachQty}</td>
                            <td>${item.totalQty}</td>
                            <td>${item.reason}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.status eq 'PENDING'}">
                                        <span class="status pending">승인대기</span>

                                        <c:if test="${order.status eq 'REQUESTED'}">
                                            <button type="button"
                                                    class="btn gray"
                                                    style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                    onclick="deleteUnplannedPacking(${item.id})">
                                                취소
                                            </button>
                                        </c:if>
                                    </c:when>

                                    <c:when test="${item.status eq 'APPROVED'}">
                                        <span class="status approved">승인완료</span>
                                        <span class="unplanned-badge">무발주</span>

                                        <c:if test="${order.status eq 'REQUESTED'}">
                                            <button type="button"
                                                    class="btn red"
                                                    style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                    onclick="deleteUnplannedPacking(${item.id})">
                                                삭제
                                            </button>
                                        </c:if>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="status reject">반려</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table></div>
    </div>

    <c:set var="hasPendingUnplanned" value="false" />

    <c:forEach var="item" items="${unplannedPackingList}">
        <c:if test="${item.status eq 'PENDING'}">
            <c:set var="hasPendingUnplanned" value="true" />
        </c:if>
    </c:forEach>

    <div class="bottom-actions">

        <c:if test="${pendingChange}">
            <button type="button"
                    class="btn gray"
                    disabled>
                수정요청 처리중
            </button>
        </c:if>

        <c:if test="${not pendingChange && order.status eq 'REQUESTED' && not hasPendingUnplanned}">
            <a href="${pageContext.request.contextPath}/packing/scan/${order.id}"
               class="btn yellow">
                QR 스캔
            </a>
        </c:if>

        <c:if test="${not pendingChange && order.status eq 'REQUESTED' && hasPendingUnplanned}">
            <button type="button"
                    class="btn gray"
                    disabled>
                무발주 승인대기중
            </button>
        </c:if>

        <c:if test="${not pendingChange && order.status eq 'READY_TO_SHIP'}">

            <form method="post"
                  action="${pageContext.request.contextPath}/packing/ship/${order.id}"
                  onsubmit="return confirm('출고 완료 처리하시겠습니까?');">

                <button type="submit" class="btn green">
                    출고 완료
                </button>
            </form>

            <form method="post"
                  action="${pageContext.request.contextPath}/packing/rollback/${order.id}"
                  onsubmit="return confirm('포장대기 상태로 되돌리겠습니까?');">

                <button type="submit" class="btn gray">
                    포장대기로 되돌리기
                </button>
            </form>

        </c:if>

        <c:if test="${not pendingChange && order.status eq 'SHIPPED'}">

            <form method="post"
                  action="${pageContext.request.contextPath}/packing/rollback/${order.id}"
                  onsubmit="return confirm('포장완료 상태로 되돌리겠습니까?');">

                <button type="submit" class="btn gray">
                    포장완료로 되돌리기
                </button>
            </form>

        </c:if>

    </div>

</div>

<script>

    function deleteUnplannedPacking(id) {
        if (!confirm('무발주 포장 항목을 취소/삭제하시겠습니까?')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/packing/unplanned/delete/' + id, {
            method: 'POST'
        }).then(function () {
            location.reload();
        });
    }

    const dbItems = [
        <c:forEach var="item" items="${itemList}" varStatus="st">
        {
            productType: '${item.productType}',
            modelName: '${item.modelName}',
            color: '${item.color}',
            hardness: '${item.hardness}',
            baseQty: ${empty item.baseQty ? 0 : item.baseQty}
        }<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    (function () {
        const productType = document.getElementById('productType');

        if (!productType) {
            return;
        }

        const modelSelect = document.getElementById('modelSelect');
        const modelName = document.getElementById('modelName');
        const color = document.getElementById('color');
        const hardness = document.getElementById('hardness');
        const baseQty = document.getElementById('baseQty');
        const boxCount = document.getElementById('boxCount');
        const eachQty = document.getElementById('eachQty');
        const totalQty = document.getElementById('totalQty');
        const qty = document.getElementById('qty');
        const form = document.getElementById('unplannedPackingForm');

        function setDefaultOption(select, value) {
            if (!select) {
                return;
            }

            select.value = value;

            if (select.value !== value) {
                const option = document.createElement('option');
                option.value = value;
                option.textContent = value;
                select.appendChild(option);
                select.value = value;
            }
        }

        function applyDefaultByType() {
            const type = productType.value;

            color.disabled = false;
            hardness.disabled = false;

            if (type === 'TIRE') {
                setDefaultOption(color, 'MIDNIGHT');
                setDefaultOption(hardness, 'R');
                color.disabled = false;
                hardness.disabled = false;
            } else if (type === 'ARMOUR') {
                setDefaultOption(color, 'RED');
                setDefaultOption(hardness, 'R');
                color.disabled = true;
                hardness.disabled = true;
            } else if (type === 'TUBELESS') {
                setDefaultOption(color, 'BLACK');
                setDefaultOption(hardness, 'R');
                color.disabled = true;
                hardness.disabled = true;
            } else {
                color.value = '';
                hardness.value = '';
                color.disabled = false;
                hardness.disabled = false;
            }
        }

        function enableDisabledBeforeSubmit() {
            color.disabled = false;
            hardness.disabled = false;
        }

        function updateQty() {
            const base = Number(baseQty.value || 0);
            const box = Number(boxCount.value || 0);
            const each = Number(eachQty.value || 0);

            const total = (base * box) + each;

            totalQty.value = total;
            qty.value = total;
        }

        function updateModelOptions() {
            const type = productType.value;

            modelSelect.innerHTML = '<option value="">선택하세요</option>';

            modelName.value = '';
            baseQty.value = '';
            updateQty();
            applyDefaultByType();

            if (!type) {
                modelSelect.innerHTML = '<option value="">상품종류를 먼저 선택하세요</option>';
                return;
            }

            const filteredItems = dbItems.filter(function (item, index, self) {
                return item.productType === type
                    && index === self.findIndex(function (x) {
                        return x.productType === item.productType
                            && x.modelName === item.modelName;
                    });
            });

            filteredItems.forEach(function (item) {
                const option = document.createElement('option');
                option.value = item.modelName;
                option.textContent = item.modelName;
                option.dataset.baseQty = item.baseQty || 0;
                modelSelect.appendChild(option);
            });
        }

        function updateSelectedModel() {
            const selected = modelSelect.options[modelSelect.selectedIndex];

            if (!selected || !selected.value) {
                modelName.value = '';
                baseQty.value = '';
                updateQty();
                return;
            }

            modelName.value = selected.value;
            baseQty.value = selected.dataset.baseQty || 0;
            updateQty();
        }

        productType.addEventListener('change', updateModelOptions);
        modelSelect.addEventListener('change', updateSelectedModel);
        boxCount.addEventListener('input', updateQty);
        eachQty.addEventListener('input', updateQty);

        form.addEventListener('submit', function (e) {
            enableDisabledBeforeSubmit();

            if (!productType.value) {
                alert('상품종류를 선택하세요.');
                e.preventDefault();
                applyDefaultByType();
                return;
            }

            if (!modelName.value) {
                alert('모델/사이즈를 선택하세요.');
                e.preventDefault();
                applyDefaultByType();
                return;
            }

            if (!color.value) {
                alert('색상을 선택하세요.');
                e.preventDefault();
                applyDefaultByType();
                return;
            }

            if (!hardness.value) {
                alert('경도를 선택하세요.');
                e.preventDefault();
                applyDefaultByType();
                return;
            }

            if (Number(totalQty.value || 0) <= 0) {
                alert('박스수 또는 낱개수량을 입력하세요.');
                e.preventDefault();
                applyDefaultByType();
            }
        });

        updateModelOptions();
    })();
</script>

</body>
</html>