<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>물류팀 입고 상세</title>

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

        .btn-group {
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
            transform: none !important;
            box-shadow: none !important;
        }

        .card {
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

        .card::before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, #2563eb, #38bdf8, #93c5fd);
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
        }

        .status.waiting {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
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

        td.status-cell {
            text-align: center !important;
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

        .section-desc {
            margin: -8px 0 16px;
            color: #64748b;
            font-size: 13px;
            line-height: 1.5;
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
            font-weight: 600;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        tr.row-waiting {
            background: #fff8e1;
        }

        tr.row-done {
            background: #f0fdf4;
        }

        tr.row-pending {
            background: #fff1f2;
        }

        tr.row-approved {
            background: #f0fdf4;
        }

        tr.row-rejected {
            background: #f8fafc;
        }

        .empty {
            text-align: center;
            padding: 42px 0;
            color: #64748b;
            line-height: 1.6;
            font-weight: 700;
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
        }

        .scan-actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0;
        }

        .summary-box {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 14px;
        }

        .summary-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border-radius: 999px;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            padding: 8px 13px;
            font-size: 13px;
            font-weight: 900;
            color: #1e3a8a;
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

        .type-block {
            display: none;
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

            .btn-group {
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

        .btn-group form {
            margin: 0;
        }

        @media (max-width: 980px) {
            .wrap {
                max-width: 100%;
                margin: 24px auto 44px;
                padding: 0 18px;
            }

            .scan-actions,
            .btn-group {
                width: 100%;
            }

            .scan-actions .btn,
            .btn-group .btn,
            .btn-group form,
            .btn-group form button {
                width: 100%;
            }
        }

        @media (max-width: 560px) {
            .wrap {
                margin-top: 14px;
                padding: 0 12px 34px;
            }

            .top-box {
                border-radius: 20px;
                padding: 20px 18px;
            }

            .top-box h1 {
                font-size: 23px;
            }

            .card {
                padding: 18px 16px;
                border-radius: 18px;
            }

            .section-title {
                font-size: 18px;
            }

            .scan-title {
                font-size: 16px;
            }

            .scan-desc,
            .section-desc {
                font-size: 13px;
            }

            .summary-box {
                display: grid;
                grid-template-columns: 1fr;
            }

            .summary-pill {
                width: 100%;
                justify-content: center;
            }

            table {
                min-width: 860px;
            }

            th, td {
                padding: 11px 9px;
                font-size: 13px;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>물류팀 입고 상세</h1>

        <div class="btn-group">

            <a href="${pageContext.request.contextPath}/logistics/list" class="btn gray">
                목록으로
            </a>

            <a href="${pageContext.request.contextPath}/logistics/dashboard" class="btn gray">
                대시보드
            </a>

            <c:choose>
                <c:when test="${order.status eq 'RECEIVED'}">
                    <button type="button"
                            class="btn gray"
                            style="cursor:not-allowed; opacity:0.7;"
                            disabled>
                        입고 완료
                    </button>
                </c:when>

                <c:when test="${hasPendingUnplanned}">
                    <button type="button"
                            class="btn gray"
                            style="cursor:not-allowed; opacity:0.7;"
                            disabled>
                        추가입고 승인대기중
                    </button>
                </c:when>

                <c:when test="${canConfirmReceive}">
                    <form action="${pageContext.request.contextPath}/logistics/receive/confirm/${order.id}"
                          method="post"
                          style="display:inline;"
                          onsubmit="return confirm('스캔 완료된 수량만 입고 확정하고 이 지시를 입고완료로 넘기시겠습니까?\n못 잡은 잔여 수량은 긴급/추가입고에서 따로 등록하면 됩니다.');">
                        <button type="submit" class="btn">
                            스캔수량 확정 후 입고완료
                        </button>
                    </form>
                </c:when>

                <c:otherwise>
                    <button type="button"
                            class="btn gray"
                            style="cursor:not-allowed; opacity:0.7;"
                            disabled>
                        스캔 완료 수량 없음
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="card">

        <div class="info-grid">

            <div class="info-box">
                <span class="info-label">지시번호</span>
                <span class="info-value">${order.id}</span>
            </div>

            <div class="info-box">
                <span class="info-label">요청일</span>
                <span class="info-value">${order.requestDate}</span>
            </div>

            <div class="info-box">
                <span class="info-label">지시자</span>
                <span class="info-value">${order.requestedBy}</span>
            </div>

            <div class="info-box">
                <span class="info-label">상태</span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${order.status eq 'SHIPPED'}">
                            <span class="status waiting">부분입고/입고대기</span>
                        </c:when>

                        <c:when test="${order.status eq 'RECEIVED'}">
                            <span class="status done">입고완료</span>
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

    <c:if test="${order.status eq 'SHIPPED'}">
        <div class="card">
            <div class="scan-box">
                <div>
                    <div class="scan-title">QR 입고 처리</div>
                    <div class="scan-desc">
                        QR을 스캔하면 박스/낱개 단위로 입고 처리됩니다. 스캔한 수량만 확정 후 입고완료로 넘기고, 누락 수량은 긴급/추가입고에서 따로 등록합니다.
                    </div>
                </div>

                <div class="scan-actions">
                    <a href="${pageContext.request.contextPath}/logistics/scan/${order.id}" class="btn">
                        QR 스캔
                    </a>
                </div>
            </div>
        </div>
    </c:if>

    <div class="card">
        <h2 class="section-title">입고 대상 상품 목록</h2>
        <div class="section-desc">
            이 영역은 입고될 예정 상품만 보여줍니다. 실제 스캔/확정 상태는 아래 박스·낱개 QR 스캔 현황과 최종 입고 목록에서 확인합니다.
        </div>

        <table>
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
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty order.detailList}">
                    <tr>
                        <td colspan="8" class="empty">
                            입고 대상 상세 항목이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="detail" items="${order.detailList}">
                        <tr>
                            <td>${detail.productType}</td>
                            <td>${detail.modelName}</td>
                            <td>${detail.color}</td>
                            <td>${detail.hardness}</td>
                            <td>${detail.baseQty}</td>
                            <td>${detail.boxCount}</td>
                            <td>${detail.eachQty}</td>
                            <td>${detail.totalQty}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h2 class="section-title">박스/낱개 QR 스캔 현황</h2>

        <div class="summary-box">
            <span class="summary-pill">스캔완료: ${normalScanDoneCount}</span>
            <span class="summary-pill">스캔대기: ${normalScanWaitingCount}</span>
        </div>

        <table>
            <thead>
            <tr>
                <th>상품종류</th>
                <th>모델/사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>입고단위</th>
                <th>단위번호</th>
                <th>수량</th>
                <th>스캔상태</th>
                <th>작업</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty inboundScanList}">
                    <tr>
                        <td colspan="9" class="empty">
                            생성된 박스/낱개 스캔 항목이 없습니다.<br>
                            기존 출고완료 데이터라면 packing_inbound_scan 생성 여부와 Controller의 inboundScanList 전달 여부를 확인해주세요.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="scan" items="${inboundScanList}">
                        <c:set var="matched" value="false" />

                        <c:forEach var="detail" items="${order.detailList}">
                            <c:if test="${detail.id eq scan.detailId}">
                                <c:set var="matched" value="true" />

                                <tr class="${scan.scanStatus eq 'DONE' ? 'row-done' : 'row-waiting'}">
                                    <td>${detail.productType}</td>
                                    <td>${detail.modelName}</td>
                                    <td>${detail.color}</td>
                                    <td>${detail.hardness}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${scan.unitType eq 'BOX'}">
                                                <span class="status etc">박스</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status pending">낱개</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${scan.unitNo}</td>
                                    <td>${scan.qty}</td>
                                    <td class="status-cell">
                                        <c:choose>
                                            <c:when test="${scan.scanStatus eq 'DONE'}">
                                                <span class="status done">스캔완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status waiting">스캔대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="status-cell">
                                        <c:choose>
                                            <c:when test="${order.status eq 'RECEIVED'}">
                                                <button type="button"
                                                        class="btn gray"
                                                        style="padding:6px 10px; font-size:12px; cursor:not-allowed; opacity:0.7;"
                                                        disabled>
                                                    입고확정
                                                </button>
                                            </c:when>

                                            <c:when test="${scan.scanStatus eq 'DONE' && scan.stockApplied ne 'Y'}">
                                                <button type="button"
                                                        class="btn red"
                                                        style="padding:6px 10px; font-size:12px;"
                                                        onclick="cancelInboundScan(${scan.id}, this)">
                                                    스캔취소
                                                </button>
                                            </c:when>

                                            <c:when test="${scan.stockApplied eq 'Y'}">
                                                <button type="button"
                                                        class="btn gray"
                                                        style="padding:6px 10px; font-size:12px; cursor:not-allowed; opacity:0.7;"
                                                        disabled>
                                                    입고확정
                                                </button>
                                            </c:when>

                                            <c:otherwise>
                                                -
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>

                        <c:if test="${not matched}">
                            <c:set var="matchedUnplanned" value="false" />

                            <c:forEach var="item" items="${unplannedList}">
                                <c:if test="${item.id eq scan.detailId}">
                                    <c:set var="matchedUnplanned" value="true" />

                                    <tr class="${scan.scanStatus eq 'DONE' ? 'row-done' : 'row-waiting'}">
                                        <td>${item.productType}</td>
                                        <td>${item.modelName}</td>
                                        <td>${item.color}</td>
                                        <td>${item.hardness}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${scan.unitType eq 'UNPLANNED_BOX'}">
                                                    <span class="status etc">무발주 박스</span>
                                                </c:when>
                                                <c:when test="${scan.unitType eq 'UNPLANNED_EACH'}">
                                                    <span class="status pending">무발주 낱개</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status pending">${scan.unitType}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${scan.unitNo}</td>
                                        <td>${scan.qty}</td>
                                        <td class="status-cell">
                                            <c:choose>
                                                <c:when test="${scan.scanStatus eq 'DONE'}">
                                                    <span class="status done">스캔완료</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status waiting">스캔대기</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="status-cell">
                                            <c:choose>
                                                <c:when test="${order.status eq 'RECEIVED'}">
                                                    <button type="button"
                                                            class="btn gray"
                                                            style="padding:6px 10px; font-size:12px; cursor:not-allowed; opacity:0.7;"
                                                            disabled>
                                                        입고확정
                                                    </button>
                                                </c:when>

                                                <c:when test="${scan.scanStatus eq 'DONE' && scan.stockApplied ne 'Y'}">
                                                    <button type="button"
                                                            class="btn red"
                                                            style="padding:6px 10px; font-size:12px;"
                                                            onclick="cancelInboundScan(${scan.id}, this)">
                                                        스캔취소
                                                    </button>
                                                </c:when>

                                                <c:when test="${scan.stockApplied eq 'Y'}">
                                                    <button type="button"
                                                            class="btn gray"
                                                            style="padding:6px 10px; font-size:12px; cursor:not-allowed; opacity:0.7;"
                                                            disabled>
                                                        입고확정
                                                    </button>
                                                </c:when>

                                                <c:otherwise>
                                                    -
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>

                            <c:if test="${not matchedUnplanned}">
                                <tr class="${scan.scanStatus eq 'DONE' ? 'row-done' : 'row-waiting'}">
                                    <td colspan="4">상세ID ${scan.detailId} 상품정보 없음</td>
                                    <td>${scan.unitType}</td>
                                    <td>${scan.unitNo}</td>
                                    <td>${scan.qty}</td>
                                    <td class="status-cell">${scan.scanStatus}</td>
                                    <td class="status-cell">-</td>
                                </tr>
                            </c:if>
                        </c:if>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>


    <c:if test="${order.status ne 'RECEIVED'}">
        <div class="card">
            <h2 class="section-title">긴급/추가입고 등록</h2>

            <form action="${pageContext.request.contextPath}/logistics/unplanned/save"
                  method="post"
                  id="unplannedForm">

                <input type="hidden" name="packingOrderId" value="${order.id}">
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

                        <select id="modelTire" class="type-block">
                            <option value="">선택</option>
                            <option value="40-622">40-622</option>
                            <option value="32-622">32-622</option>
                            <option value="51-559">51-559</option>
                            <option value="44-559">44-559</option>
                            <option value="35-590">35-590</option>
                            <option value="35-559">35-559</option>
                            <option value="44-507">44-507</option>
                            <option value="40-540">40-540</option>
                            <option value="40-501">40-501</option>
                            <option value="51-406">51-406</option>
                            <option value="40-406">40-406</option>
                            <option value="40-355">40-355</option>
                            <option value="40-349">40-349</option>
                            <option value="40-305">40-305</option>
                            <option value="28-622">28-622</option>
                            <option value="25-622">25-622</option>
                            <option value="23-622">23-622</option>
                            <option value="28-451">28-451</option>
                            <option value="32-406">32-406</option>
                            <option value="32-349">32-349</option>
                            <option value="32-305">32-305</option>
                        </select>

                        <select id="modelArmour" class="type-block">
                            <option value="">선택</option>
                            <option value="47-559">47-559</option>
                            <option value="63-559">63-559</option>
                            <option value="63-584">63-584</option>
                            <option value="40-622">40-622</option>
                            <option value="47-622">47-622</option>
                            <option value="63-622">63-622</option>
                            <option value="63-406">63-406</option>
                            <option value="63-507">63-507</option>
                            <option value="34-622">34-622</option>
                            <option value="54-559">54-559</option>
                            <option value="50-406">50-406</option>
                            <option value="75-584">75-584</option>
                            <option value="75-622">75-622</option>
                            <option value="40-540">40-540</option>
                            <option value="75-559">75-559</option>
                            <option value="34-590">34-590</option>
                            <option value="37-540">37-540</option>
                            <option value="120-559">120-559</option>
                            <option value="100-406">100-406</option>
                            <option value="120-406">120-406</option>
                            <option value="100-507">100-507</option>
                            <option value="(89-100)-406">(89-100)-406</option>
                            <option value="80-90-17">80-90-17</option>
                            <option value="70-90-17">70-90-17</option>
                        </select>

                        <select id="modelTubeless" class="type-block">
                            <option value="">선택</option>
                            <option value="27.5 (Pro)">27.5 (Pro)</option>
                            <option value="29 (Pro)">29 (Pro)</option>
                            <option value="27.5 (Fusion)">27.5 (Fusion)</option>
                            <option value="29 (Fusion)">29 (Fusion)</option>
                            <option value="26mm Lite">26mm Lite</option>
                            <option value="32mm Lite">32mm Lite</option>
                            <option value="27.5 Lite (32mm)">27.5 Lite (32mm)</option>
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
                               placeholder="예: 지시에 없는 품목 / 지시번호 미입고 잔여분">
                    </div>

                </div>

                <button type="submit" class="btn red">
                    긴급/추가입고 등록
                </button>

            </form>
        </div>

        <div class="card">
            <h2 class="section-title">긴급/추가입고 목록</h2>

            <table>
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
                    <th>승인상태</th>
                    <th>입고상태</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>

                    <c:when test="${empty unplannedList}">
                        <tr>
                            <td colspan="11" class="empty">
                                등록된 긴급/추가입고 품목이 없습니다.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>

                        <c:forEach var="item" items="${unplannedList}">

                            <tr class="${item.status eq 'PENDING'
                            ? 'row-pending'
                            : item.status eq 'APPROVED'
                            ? 'row-approved'
                            : 'row-rejected'}"
                                id="unplanned-row-${item.id}">

                                <td>${item.productType}</td>
                                <td>${item.modelName}</td>
                                <td>${item.color}</td>
                                <td>${item.hardness}</td>
                                <td>${item.baseQty}</td>
                                <td>${item.boxCount}</td>
                                <td>${item.eachQty}</td>
                                <td>${item.totalQty}</td>
                                <td>${item.reason}</td>

                                <td class="status-cell">

                                    <c:choose>

                                        <c:when test="${item.status eq 'PENDING'}">

                                        <span class="status pending">
                                            승인대기
                                        </span>

                                            <button type="button"
                                                    class="btn gray"
                                                    style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                    onclick="deleteUnplanned(${item.id}, this)">
                                                취소
                                            </button>

                                        </c:when>

                                        <c:when test="${item.status eq 'APPROVED'}">

                                        <span class="status done">
                                            승인완료
                                        </span>

                                            <span style="
                                            display:inline-block;
                                            margin-left:6px;
                                            padding:4px 8px;
                                            border-radius:999px;
                                            background:#f1f3f5;
                                            color:#555;
                                            font-size:11px;
                                            font-weight:bold;
                                        ">
                                            무발주
                                        </span>

                                            <c:if test="${order.status ne 'RECEIVED'}">

                                                <button type="button"
                                                        class="btn red"
                                                        style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                        onclick="deleteUnplanned(${item.id}, this)">
                                                    삭제
                                                </button>

                                            </c:if>

                                        </c:when>

                                        <c:otherwise>
                                            <span class="status reject">반려</span>
                                        </c:otherwise>

                                    </c:choose>

                                </td>

                                <td class="status-cell">
                                    <c:choose>
                                        <c:when test="${item.inboundStatus eq 'DONE'}">
                                            <span class="status done">입고완료</span>

                                            <c:if test="${order.status ne 'RECEIVED'}">
                                                <button type="button"
                                                        class="btn red"
                                                        style="padding:6px 10px; font-size:12px; margin-left:8px;"
                                                        onclick="cancelUnplannedInbound(${item.id}, this)">
                                                    삭제
                                                </button>
                                            </c:if>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status waiting">입고대기</span>
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
    </c:if>

</div>

<script>

    window.deleteUnplanned = function (id, btn) {

        if (!confirm('취소/삭제하시겠습니까?')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/logistics/unplanned/delete/' + id, {
            method: 'POST'
        })
            .then(function () {
                location.reload();
            });

    };

    window.cancelInboundScan = function (id, btn) {

        if (!confirm('이 박스/낱개 스캔완료를 취소하고 스캔대기로 되돌리겠습니까?')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/logistics/inbound/scan/cancel/' + id, {
            method: 'POST'
        })
            .then(function (response) {
                if (!response.ok) {
                    alert('스캔취소 처리 중 오류가 발생했습니다.');
                    return;
                }

                return response.text();
            })
            .then(function (result) {
                if (!result) {
                    return;
                }

                if (result !== 'OK') {
                    alert('스캔취소 실패: ' + result);
                    return;
                }

                location.reload();
            });

    };

    window.cancelUnplannedInbound = function (id, btn) {

        if (!confirm('무발주 입고완료를 취소하고 입고대기로 되돌리겠습니까?')) {
            return;
        }

        fetch('${pageContext.request.contextPath}/logistics/unplanned/inbound/cancel/' + id, {
            method: 'POST'
        })
            .then(function () {
                location.reload();
            });

    };

    (function () {

        const productType = document.getElementById('productType');
        const modelTire = document.getElementById('modelTire');
        const modelArmour = document.getElementById('modelArmour');
        const modelTubeless = document.getElementById('modelTubeless');
        const modelName = document.getElementById('modelName');

        const color = document.getElementById('color');
        const hardness = document.getElementById('hardness');

        const baseQty = document.getElementById('baseQty');
        const boxCount = document.getElementById('boxCount');
        const eachQty = document.getElementById('eachQty');
        const totalQty = document.getElementById('totalQty');
        const qty = document.getElementById('qty');

        const typeBlocks = document.querySelectorAll('.type-block');
        const form = document.getElementById('unplannedForm');

        const tireBaseQtyMap = {
            "40-622": 20, "32-622": 24, "51-559": 15, "44-559": 20,
            "35-590": 24, "35-559": 24, "44-507": 28, "40-540": 28,
            "40-501": 28, "51-406": 15, "40-406": 28, "40-355": 28,
            "40-349": 28, "40-305": 28, "28-622": 30, "25-622": 30,
            "23-622": 30, "28-451": 30, "32-406": 30,
            "32-349": 30, "32-305": 30
        };

        const armourBaseQtyMap = {
            "47-559": 10, "63-559": 10, "63-584": 10, "40-622": 10,
            "47-622": 10, "63-622": 10, "63-406": 10, "63-507": 10,
            "34-622": 10, "54-559": 10, "50-406": 10, "75-584": 10,
            "75-622": 10, "40-540": 10, "75-559": 10, "34-590": 10,
            "37-540": 10, "120-559": 10, "100-406": 10, "120-406": 10,
            "100-507": 10, "(89-100)-406": 10, "80-90-17": 10,
            "70-90-17": 10
        };

        const tubelessBaseQtyMap = {
            "27.5 (Pro)": 10,
            "29 (Pro)": 10,
            "27.5 (Fusion)": 10,
            "29 (Fusion)": 10,
            "26mm Lite": 10,
            "32mm Lite": 10,
            "27.5 Lite (32mm)": 10
        };

        function resetQtyInputs() {
            boxCount.value = '0';
            eachQty.value = '0';
            totalQty.value = '0';
            qty.value = '0';
        }

        function hideModels() {
            typeBlocks.forEach(function (el) {
                el.style.display = 'none';
                el.required = false;
                el.value = '';
            });
        }

        function showModelSelect(type) {
            hideModels();

            if (type === 'TIRE') {
                modelTire.style.display = 'block';
                modelTire.required = true;
            } else if (type === 'ARMOUR') {
                modelArmour.style.display = 'block';
                modelArmour.required = true;
            } else if (type === 'TUBELESS') {
                modelTubeless.style.display = 'block';
                modelTubeless.required = true;
            }
        }

        function applyTypeRule() {
            const type = productType.value;

            color.disabled = false;
            hardness.disabled = false;

            if (type === 'TIRE') {
                color.value = 'MIDNIGHT';
                hardness.value = 'R';
            } else if (type === 'ARMOUR') {
                color.value = 'RED';
                hardness.value = 'R';
                color.disabled = true;
                hardness.disabled = true;
            } else if (type === 'TUBELESS') {
                color.value = 'BLACK';
                hardness.value = 'R';
                color.disabled = true;
                hardness.disabled = true;
            } else {
                color.value = '';
                hardness.value = '';
            }
        }

        function syncModelName() {
            const type = productType.value;

            if (type === 'TIRE') {
                modelName.value = modelTire.value;
            } else if (type === 'ARMOUR') {
                modelName.value = modelArmour.value;
            } else if (type === 'TUBELESS') {
                modelName.value = modelTubeless.value;
            } else {
                modelName.value = '';
            }

            updateBaseQty();
            updateTotalQty();
        }

        function updateBaseQty() {
            const type = productType.value;
            const model = modelName.value;

            if (type === 'TIRE') {
                baseQty.value = tireBaseQtyMap[model] || '';
            } else if (type === 'ARMOUR') {
                baseQty.value = armourBaseQtyMap[model] || '';
            } else if (type === 'TUBELESS') {
                baseQty.value = tubelessBaseQtyMap[model] || '';
            } else {
                baseQty.value = '';
            }
        }

        function updateTotalQty() {
            const base = parseInt(baseQty.value || '0', 10);
            const box = parseInt(boxCount.value || '0', 10);
            const each = parseInt(eachQty.value || '0', 10);

            const total = (base * box) + each;

            totalQty.value = total;
            qty.value = total;
        }

        productType.addEventListener('change', function () {
            resetQtyInputs();
            showModelSelect(productType.value);
            applyTypeRule();
            syncModelName();
        });

        modelTire.addEventListener('change', function () {
            resetQtyInputs();
            syncModelName();
        });

        modelArmour.addEventListener('change', function () {
            resetQtyInputs();
            syncModelName();
        });

        modelTubeless.addEventListener('change', function () {
            resetQtyInputs();
            syncModelName();
        });

        boxCount.addEventListener('input', updateTotalQty);
        eachQty.addEventListener('input', updateTotalQty);

        form.addEventListener('submit', function (e) {
            syncModelName();
            updateTotalQty();

            const total = parseInt(totalQty.value || '0', 10);

            if (total <= 0) {
                e.preventDefault();
                alert('총수량이 0인 무발주 매입은 등록할 수 없습니다.');
                return;
            }

            color.disabled = false;
            hardness.disabled = false;
        });

        hideModels();
        resetQtyInputs();

    })();

</script>

</body>
</html>
