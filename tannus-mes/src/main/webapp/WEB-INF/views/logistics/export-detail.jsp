<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 출고 상세</title>

    <script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>

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
                    radial-gradient(circle at 10% 0%, rgba(37, 99, 235, 0.16), transparent 30%),
                    radial-gradient(circle at 90% 10%, rgba(14, 165, 233, 0.14), transparent 28%),
                    linear-gradient(180deg, #eef5ff 0%, #f7f9fc 48%, #f4f6f9 100%);
        }

        .wrap {
            max-width: 1280px;
            margin: 34px auto 60px;
            padding: 0 22px;
        }

        .top-box {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 18px;
            margin-bottom: 22px;
            padding: 24px 26px;
            border: 1px solid rgba(148, 163, 184, 0.28);
            border-radius: 24px;
            background:
                    linear-gradient(135deg, rgba(30, 64, 175, 0.95), rgba(37, 99, 235, 0.92)),
                    linear-gradient(135deg, #1d4ed8, #0ea5e9);
            box-shadow: 0 18px 40px rgba(30, 64, 175, 0.22);
        }

        .top-box h1 {
            position: relative;
            margin: 0;
            padding-left: 16px;
            font-size: 30px;
            letter-spacing: -0.6px;
            color: white;
            line-height: 1.25;
        }

        .top-box h1::before {
            content: "";
            position: absolute;
            left: 0;
            top: 6px;
            width: 5px;
            height: 28px;
            border-radius: 999px;
            background: #93c5fd;
        }

        .btn-group,
        .bottom-actions,
        .scan-actions {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-end;
            gap: 10px;
        }

        .btn {
            min-height: 38px;
            text-decoration: none;
            border: none;
            background: linear-gradient(135deg, #2563eb, #0ea5e9);
            color: white;
            padding: 10px 16px;
            border-radius: 12px;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.20);
            transition: transform 0.15s ease, box-shadow 0.15s ease, opacity 0.15s ease;
            white-space: nowrap;
        }

        .btn.gray {
            background: rgba(15, 23, 42, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.36);
            box-shadow: none;
        }

        .btn.yellow {
            background: linear-gradient(135deg, #f59e0b, #facc15);
            color: #1f2937;
            box-shadow: 0 8px 18px rgba(245, 158, 11, 0.20);
        }

        .btn.green {
            background: linear-gradient(135deg, #16a34a, #22c55e);
            box-shadow: 0 8px 18px rgba(22, 163, 74, 0.20);
        }

        .btn.red {
            background: linear-gradient(135deg, #ef4444, #f97316);
            box-shadow: 0 8px 18px rgba(239, 68, 68, 0.18);
        }

        .btn:hover {
            opacity: 0.96;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.24);
        }

        .btn:disabled,
        .btn[disabled] {
            cursor: not-allowed;
            opacity: 0.7;
            transform: none !important;
            box-shadow: none !important;
        }

        .card,
        .product-card {
            position: relative;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.92);
            border: 1px solid rgba(203, 213, 225, 0.72);
            border-radius: 22px;
            padding: 24px;
            box-shadow: 0 14px 32px rgba(15, 23, 42, 0.08);
            margin-bottom: 20px;
            backdrop-filter: blur(8px);
        }

        .card::before,
        .product-card::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #2563eb, #38bdf8, #93c5fd);
        }

        .alert {
            background: #fff1f2;
            border: 1px solid #fecdd3;
            color: #9f1239;
            padding: 15px 16px;
            border-radius: 14px;
            margin-bottom: 18px;
            font-weight: 900;
            line-height: 1.55;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }

        .info-box {
            background: linear-gradient(180deg, #f8fbff, #eef6ff);
            border: 1px solid #d8e7fb;
            border-radius: 16px;
            padding: 15px 16px;
            min-height: 82px;
        }

        .info-label {
            display: block;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 8px;
            font-weight: 800;
        }

        .info-value {
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
            word-break: break-all;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 28px;
            min-width: 78px;
            padding: 5px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            box-sizing: border-box;
            letter-spacing: -0.2px;
            margin: 2px;
        }

        .status.waiting {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        .status.ready {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .status.ready-done {
            background: #e0f2fe;
            color: #075985;
            border: 1px solid #bae6fd;
        }

        .status.done {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .status.pending {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .status.reject {
            background: #e5e7eb;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .status.etc {
            background: #e0f2fe;
            color: #075985;
            border: 1px solid #bae6fd;
        }

        .remark-box {
            margin-top: 16px;
            background: #f8fbff;
            border: 1px solid #dbe9f6;
            border-radius: 16px;
            padding: 15px 16px;
        }

        .remark-title {
            font-size: 12px;
            color: #64748b;
            margin-bottom: 7px;
            font-weight: 800;
        }

        .remark-value {
            font-size: 15px;
            color: #1e293b;
            min-height: 24px;
            line-height: 1.5;
            font-weight: 700;
        }

        .section-title {
            position: relative;
            margin: 0 0 16px;
            padding-left: 13px;
            color: #1d4ed8;
            font-size: 20px;
            letter-spacing: -0.4px;
        }

        .section-title::before {
            content: "";
            position: absolute;
            left: 0;
            top: 5px;
            width: 5px;
            height: 20px;
            border-radius: 999px;
            background: #38bdf8;
        }

        .scan-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            background:
                    linear-gradient(135deg, rgba(239, 246, 255, 0.98), rgba(224, 242, 254, 0.98));
            border: 1px solid #bfdbfe;
            border-radius: 18px;
            padding: 20px;
        }

        .scan-title {
            font-size: 18px;
            font-weight: 900;
            color: #1d4ed8;
            margin-bottom: 7px;
        }

        .scan-desc {
            font-size: 14px;
            color: #475569;
            line-height: 1.5;
            font-weight: 700;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 18px;
        }

        .product-card {
            margin-bottom: 0;
        }

        .product-title {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .product-title h3 {
            margin: 0;
            font-size: 22px;
            color: #0f172a;
            letter-spacing: -0.4px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: white;
        }

        thead {
            background: linear-gradient(180deg, #eff6ff, #e0f2fe);
        }

        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #e5e7eb;
            text-align: center;
            font-size: 14px;
        }

        th {
            color: #1e3a8a;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            color: #334155;
            font-weight: 700;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        .info-table th {
            width: 40%;
            text-align: left;
            background: #f8fbff;
        }

        .info-table td {
            text-align: left;
        }

        .list-table th,
        .list-table td {
            text-align: center;
            width: auto;
            white-space: nowrap;
        }

        .qr-box {
            min-height: 110px;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            margin-top: 14px;
            padding: 14px;
            text-align: center;
            background: #fff;
        }

        .empty {
            text-align: center;
            padding: 42px 0;
            color: #64748b;
            line-height: 1.6;
            font-weight: 700;
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
            border-radius: 12px;
            padding: 0 12px;
            box-sizing: border-box;
            background: white;
            color: #0f172a;
            font-weight: 700;
            outline: none;
        }

        .form-box input:focus,
        .form-box select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        .form-box input:read-only {
            background: #f1f5f9;
            color: #475569;
        }

        .form-box select:disabled {
            background: #f1f5f9;
            color: #475569;
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
            display: inline-block;
            margin-left: 6px;
            padding: 4px 8px;
            border-radius: 999px;
            background: #f1f5f9;
            color: #475569;
            font-size: 11px;
            font-weight: 900;
        }

        @media (max-width: 1100px) {
            .info-grid,
            .form-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .card {
                overflow-x: auto;
            }

            table {
                min-width: 920px;
            }

            .product-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 760px) {
            .wrap {
                margin-top: 18px;
                padding: 0 14px;
            }

            .top-box {
                flex-direction: column;
                padding: 22px;
            }

            .top-box h1 {
                font-size: 25px;
            }

            .btn-group,
            .bottom-actions {
                width: 100%;
                justify-content: flex-start;
            }

            .info-grid,
            .form-grid {
                grid-template-columns: 1fr;
            }

            .scan-box {
                flex-direction: column;
                align-items: flex-start;
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

        .product-card table,
        .info-table {
            min-width: 0;
        }

        .list-table {
            min-width: 920px;
        }

        .bottom-actions form {
            margin: 0;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                margin: 24px auto 46px;
                padding: 0 18px;
            }

            .top-box {
                padding: 24px;
            }

            .product-title {
                align-items: flex-start;
            }
        }

        @media (max-width: 760px) {
            .btn-group,
            .scan-actions,
            .bottom-actions {
                display: grid;
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .btn-group .btn,
            .scan-actions .btn,
            .bottom-actions .btn,
            .bottom-actions form,
            .bottom-actions form button {
                width: 100%;
            }

            .card,
            .product-card {
                padding: 18px;
                border-radius: 18px;
            }

            .product-title {
                flex-direction: column;
                align-items: flex-start;
            }

            .product-title h3 {
                font-size: 19px;
                line-height: 1.3;
                word-break: keep-all;
            }

            .info-table th,
            .info-table td {
                padding: 11px 10px;
                font-size: 13px;
                word-break: break-word;
            }

            .qr-box {
                min-height: 92px;
                padding: 12px;
            }

            .section-title {
                font-size: 18px;
            }

            .alert {
                font-size: 13px;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                margin-top: 14px;
                padding: 0 12px;
            }

            .top-box {
                padding: 20px 18px;
                border-radius: 20px;
            }

            .top-box h1 {
                font-size: 23px;
            }

            .info-box {
                padding: 14px;
                min-height: auto;
            }

            .info-value {
                font-size: 15px;
            }

            .form-box input,
            .form-box select {
                height: 42px;
                font-size: 13px;
            }

            .list-table {
                min-width: 880px;
            }
        }


    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>수출 출고 상세</h1>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/logistics/export/list" class="btn gray">
                출고대기 목록
            </a>

            <a href="${pageContext.request.contextPath}/logistics/export/ready-list" class="btn gray">
                출고준비 목록
            </a>

            <a href="${pageContext.request.contextPath}/logistics/dashboard" class="btn gray">
                대시보드
            </a>

            <a href="${pageContext.request.contextPath}/logistics/export/print/${order.id}"
               target="_blank"
               class="btn green">
                <c:choose>
                    <c:when test="${order.status eq 'DONE'}">
                        🖨 스캔완료 QR 재출력
                    </c:when>
                    <c:otherwise>
                        🖨 전체 QR 출력
                    </c:otherwise>
                </c:choose>
            </a>
        </div>
    </div>

    <c:if test="${pendingChangeOrderIds.contains(order.id)}">
        <div class="alert">
            ⚠ 현재 이 수출 지시는 수정요청 처리중입니다.
            승인완료 또는 반려완료 전까지 출고 처리를 할 수 없습니다.
        </div>
    </c:if>

    <div class="card">

        <div class="info-grid">

            <div class="info-box">
                <span class="info-label">수출 지시 번호</span>
                <span class="info-value">${order.id}</span>
            </div>

            <div class="info-box">
                <span class="info-label">출고 요청일</span>
                <span class="info-value">${order.requestDate}</span>
            </div>

            <div class="info-box">
                <span class="info-label">지시자</span>
                <span class="info-value">${order.workerName}</span>
            </div>

            <div class="info-box">
                <span class="info-label">상태</span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${order.status eq 'WAITING'}">
                            <span class="status waiting">출고대기</span>
                        </c:when>

                        <c:when test="${order.status eq 'READY_TO_SHIP'}">
                            <span class="status ready">출고준비</span>
                        </c:when>

                        <c:when test="${order.status eq 'READY_DONE'}">
                            <span class="status ready-done">출고준비완료</span>
                        </c:when>

                        <c:when test="${order.status eq 'DONE'}">
                            <span class="status done">출고완료</span>
                        </c:when>

                        <c:otherwise>
                            <span class="status etc">${order.status}</span>
                        </c:otherwise>
                    </c:choose>

                    <c:if test="${pendingChangeOrderIds.contains(order.id)}">
                        <span class="status pending">수정요청중</span>
                    </c:if>
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

    <c:if test="${order.status eq 'READY_TO_SHIP' and not pendingChangeOrderIds.contains(order.id)}">
        <div class="card">
            <div class="scan-box">
                <div>
                    <div class="scan-title">QR 출고 처리</div>
                    <div class="scan-desc">
                        QR을 스캔하면 해당 상품 항목만 출고완료 대상으로 처리됩니다. 안 찍은 항목은 출고대기로 남습니다.
                    </div>
                </div>

                <div class="scan-actions">
                    <a href="${pageContext.request.contextPath}/logistics/export/scan/${order.id}" class="btn">
                        QR 스캔
                    </a>
                </div>
            </div>
        </div>
    </c:if>

    <div class="card">
        <h2 class="section-title">출고 대상 상품 목록</h2>

        <div class="product-grid">

            <c:choose>
                <c:when test="${empty order.detailList}">
                    <div class="empty">
                        출고 대상 상품이 없습니다.
                    </div>
                </c:when>

                <c:otherwise>
                    <c:forEach var="detail" items="${order.detailList}" varStatus="st">

                        <div class="product-card">

                            <div class="product-title">
                                <h3>${detail.type} / ${detail.model}</h3>

                                <span class="status ready">
                                    ${detail.totalQty} EA
                                </span>
                            </div>

                            <table class="info-table">
                                <tr>
                                    <th>종류</th>
                                    <td>${detail.type}</td>
                                </tr>

                                <tr>
                                    <th>모델/사이즈</th>
                                    <td>${detail.model}</td>
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

                                <tr>
                                    <th>스캔상태</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${detail.outboundStatus eq 'DONE'}">
                                                <span class="status done">스캔완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status etc">스캔대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </table>

                            <c:if test="${(order.status eq 'WAITING' or order.status eq 'READY_TO_SHIP') and not pendingChangeOrderIds.contains(order.id)}">
                                <button type="button"
                                        class="btn"
                                        style="margin-top:14px;"
                                        onclick="makeQr(
                                                'qr-${st.index}',
                                                'EXPORT|${order.id}|${detail.id}|${detail.type}|${detail.model}|${detail.color}|${detail.hardness}|${detail.totalQty}'
                                                )">
                                    EXPORT QR 생성
                                </button>
                            </c:if>

                            <c:if test="${pendingChangeOrderIds.contains(order.id)}">
                                <button type="button"
                                        class="btn gray"
                                        style="margin-top:14px;"
                                        disabled>
                                    수정요청 처리중
                                </button>
                            </c:if>

                            <div id="qr-${st.index}" class="qr-box"></div>

                        </div>

                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <c:if test="${(order.status eq 'WAITING' or order.status eq 'READY_TO_SHIP') and not pendingChangeOrderIds.contains(order.id)}">
        <div class="card">
            <h2 class="section-title">무발주 출고 등록</h2>

            <form action="${pageContext.request.contextPath}/logistics/export/unplanned/save/${order.id}"
                  method="post"
                  id="unplannedExportForm">

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
                               placeholder="예: 지시에 없는 추가 출고">
                    </div>

                </div>

                <button type="submit" class="btn red">
                    무발주 출고 등록
                </button>

            </form>
        </div>
    </c:if>

    <c:if test="${order.status ne 'DONE' and pendingChangeOrderIds.contains(order.id)}">
        <div class="card">
            <h2 class="section-title">무발주 출고 등록</h2>
            <div class="alert">
                수정요청 처리중이므로 무발주 출고 등록을 할 수 없습니다.
            </div>
        </div>
    </c:if>

    <div class="card">
        <h2 class="section-title">무발주 출고 목록</h2>

        <table class="list-table">
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
                <c:when test="${empty unplannedExportList}">
                    <tr>
                        <td colspan="10" class="empty">
                            등록된 무발주 출고 품목이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="item" items="${unplannedExportList}">
                        <tr class="${item.status eq 'PENDING'
                                ? 'row-pending'
                                : item.status eq 'APPROVED'
                                ? 'row-approved'
                                : 'row-rejected'}"
                            id="unplanned-export-row-${item.id}">

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

                                        <c:if test="${not pendingChangeOrderIds.contains(order.id)}">
                                            <button type="button"
                                                    class="btn gray"
                                                    style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                    onclick="deleteUnplannedExport(${item.id})">
                                                취소
                                            </button>
                                        </c:if>
                                    </c:when>

                                    <c:when test="${item.status eq 'APPROVED'}">
                                        <span class="status done">승인완료</span>
                                        <span class="unplanned-badge">무발주</span>

                                        <c:if test="${order.status ne 'DONE' and not pendingChangeOrderIds.contains(order.id)}">
                                            <button type="button"
                                                    class="btn red"
                                                    style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                    onclick="deleteUnplannedExport(${item.id})">
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
        </table>
    </div>

    <div class="bottom-actions">

        <c:choose>
            <c:when test="${pendingChangeOrderIds.contains(order.id)}">
                <button type="button" class="btn gray" disabled>
                    수정요청 처리중
                </button>
            </c:when>

            <c:otherwise>

                <c:if test="${order.status eq 'WAITING'}">
                    <c:choose>
                        <c:when test="${hasPendingUnplannedExport}">
                            <button type="button" class="btn gray" disabled>
                                무발주 승인대기
                            </button>

                            <div style="color:#dc3545; font-weight:bold; margin-top:8px;">
                                승인대기 중인 무발주 출고가 있어 출고준비를 진행할 수 없습니다.
                            </div>
                        </c:when>

                        <c:otherwise>
                            <form method="post"
                                  action="${pageContext.request.contextPath}/logistics/export/ready/${order.id}"
                                  onsubmit="return confirm('출고준비 처리하시겠습니까?');">

                                <button type="submit" class="btn yellow">
                                    출고준비
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <c:if test="${order.status eq 'READY_TO_SHIP'}">
                    <a href="${pageContext.request.contextPath}/logistics/export/scan/${order.id}" class="btn">
                        QR 스캔
                    </a>

                    <form method="post"
                          action="${pageContext.request.contextPath}/logistics/export/rollback/${order.id}"
                          onsubmit="return confirm('출고대기 상태로 되돌리겠습니까?');">

                        <button type="submit" class="btn gray">
                            출고대기로 되돌리기
                        </button>
                    </form>
                </c:if>

                <c:if test="${order.status eq 'READY_DONE'}">
                    <form method="post"
                          action="${pageContext.request.contextPath}/logistics/export/done/${order.id}"
                          onsubmit="return confirm('스캔완료된 품목을 최종 출고완료 처리하시겠습니까?');">

                        <button type="submit" class="btn green">
                            최종 출고완료
                        </button>
                    </form>

                    <form method="post"
                          action="${pageContext.request.contextPath}/logistics/export/rollback/${order.id}"
                          onsubmit="return confirm('출고준비 상태로 되돌리겠습니까?');">

                        <button type="submit" class="btn gray">
                            출고준비로 되돌리기
                        </button>
                    </form>
                </c:if>

                <c:if test="${order.status eq 'DONE'}">
                    <button type="button" class="btn gray" disabled>
                        출고완료 처리됨
                    </button>
                </c:if>

            </c:otherwise>
        </c:choose>

    </div>

</div>

<script>
    function makeQr(targetId, text) {
        var target = document.getElementById(targetId);

        if (!target) {
            return;
        }

        target.innerHTML = "";

        new QRCode(target, {
            text: text,
            width: 160,
            height: 160
        });
    }

    function deleteUnplannedExport(id) {
        if (!confirm('무발주 출고 항목을 취소/삭제하시겠습니까?')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/logistics/export/unplanned/delete/' + id, {
            method: 'POST'
        })
            .then(function () {
                location.reload();
            });
    }

    (function () {
        const contextPath = '${pageContext.request.contextPath}';

        const productType = document.getElementById('productType');
        const modelSelect = document.getElementById('modelSelect');
        const modelName = document.getElementById('modelName');
        const color = document.getElementById('color');
        const hardness = document.getElementById('hardness');
        const baseQty = document.getElementById('baseQty');
        const boxCount = document.getElementById('boxCount');
        const eachQty = document.getElementById('eachQty');
        const totalQty = document.getElementById('totalQty');
        const qty = document.getElementById('qty');

        let currentItems = [];

        if (!productType || !modelSelect || !modelName || !color || !hardness || !baseQty || !boxCount || !eachQty || !totalQty || !qty) {
            return;
        }

        productType.addEventListener('change', function () {

            fetch(contextPath + '/api/items/by-type?productType=' + productType.value)
                .then(res => res.json())
                .then(items => {

                    currentItems = items;

                    modelSelect.innerHTML =
                        '<option value="">선택하세요</option>';

                    const map = new Map();

                    items.forEach(item => {

                        if (!map.has(item.modelName)) {
                            map.set(item.modelName, item);

                            modelSelect.innerHTML +=
                                '<option value="' + map.size + '">' +
                                item.modelName +
                                '</option>';
                        }

                    });

                });

        });

        modelSelect.addEventListener('change', function () {

            const model = modelSelect.options[modelSelect.selectedIndex].text;

            const item = currentItems.find(i => i.modelName === model);

            if (!item) return;

            modelName.value = item.modelName;
            baseQty.value = item.baseQty;
            updateQty();

            color.value = item.color;
            hardness.value = item.hardness;

        });

        function updateQty() {

            const base = Number(baseQty.value || 0);
            const box = Number(boxCount.value || 0);
            const each = Number(eachQty.value || 0);

            totalQty.value = base * box + each;
            qty.value = totalQty.value;
        }

        boxCount.addEventListener('input', updateQty);
        eachQty.addEventListener('input', updateQty);
        modelSelect.addEventListener('change', updateQty);

    })();
</script>

</body>
</html>