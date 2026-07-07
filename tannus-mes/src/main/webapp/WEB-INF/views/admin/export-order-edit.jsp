<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 지시 수정</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --green: #16a34a;
            --green-dark: #15803d;
            --red: #dc2626;
            --gray: #334155;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
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
            max-width: 1220px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .page-hero {
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
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
        }

        .page-hero.blue {
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--blue), var(--blue-dark));
        }

        .page-hero.green {
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--green), var(--green-dark));
        }

        .page-hero:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .page-hero > div,
        .action-group {
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

        h2 {
            margin: 0;
            color: white;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.7px;
        }

        .hero-desc {
            margin-top: 9px;
            color: rgba(255,255,255,0.86);
            font-size: 14px;
            line-height: 1.6;
        }

        .action-group {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 9px;
            flex-wrap: wrap;
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
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn-outline-secondary {
            background: rgba(255,255,255,0.94);
            color: var(--gray);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn-outline-danger {
            background: rgba(255,255,255,0.94);
            color: var(--red);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn-primary {
            background: var(--blue);
        }

        .btn-success {
            background: var(--green);
        }

        .card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .card-body {
            padding: 24px;
        }

        .section-title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .section-title-row h5 {
            margin: 0;
            font-size: 19px;
            font-weight: 900;
            color: #0f172a;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        .table-bordered th,
        .table-bordered td {
            border: 1px solid var(--line);
        }

        th {
            background: #f8fafc;
            color: #334155;
            font-size: 14px;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            color: #475569;
            font-size: 14px;
        }

        th, td {
            padding: 14px 12px;
            vertical-align: middle;
        }

        .info-table th {
            width: 150px;
            text-align: left;
        }

        .text-center {
            text-align: center;
        }

        .align-middle td,
        .align-middle th {
            vertical-align: middle;
        }

        .form-control {
            width: 100%;
            height: 42px;
            border: 1px solid #cbd5e1;
            border-radius: 12px;
            padding: 0 12px;
            font-size: 14px;
            outline: none;
            background: white;
        }

        .form-control:focus {
            border-color: var(--green);
            box-shadow: 0 0 0 4px rgba(22,163,74,0.12);
        }

        .qty-input,
        .boxCount,
        .eachQty {
            text-align: center;
            max-width: 110px;
            margin: 0 auto;
        }

        .badge {
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

        .bg-secondary { background: #64748b; }
        .bg-success { background: var(--green); }
        .bg-primary { background: var(--blue); }
        .bg-dark { background: #334155; }
        .bg-danger { background: var(--red); }
        .bg-warning { background: #f59e0b; }
        .bg-info { background: #38bdf8; }
        .text-dark { color: #1f2937 !important; }

        .total-qty-text,
        .totalQty {
            font-weight: 900;
            color: #0f172a;
        }

        .empty-row {
            color: #94a3b8;
            font-weight: 800;
            padding: 30px 0;
        }


        /* =========================
           반응형 보강
           - PC 디자인은 유지
           - 태블릿/모바일에서는 버튼과 표가 깨지지 않도록 처리
        ========================= */

        html {
            width: 100%;
            overflow-x: hidden;
        }

        .table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid var(--line);
            border-radius: 18px;
            background: white;
        }

        .table-responsive table {
            min-width: 900px;
        }

        .info-responsive table {
            min-width: 0;
        }

        .table-responsive::-webkit-scrollbar {
            height: 8px;
        }

        .table-responsive::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .table-responsive::-webkit-scrollbar-track {
            background: #f1f5f9;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 28px 18px 44px;
            }

            .page-hero {
                padding: 26px 24px;
            }

            .card-body {
                padding: 22px;
            }
        }

        @media (max-width: 768px) {
            body {
                background:
                        radial-gradient(circle at 10% 5%, rgba(37, 99, 235, 0.10), transparent 30%),
                        linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            }

            .page-hero {
                border-radius: 22px;
                padding: 24px 20px;
            }

            .action-group {
                width: 100%;
                display: grid;
                grid-template-columns: 1fr;
                gap: 9px;
            }

            .action-group .btn {
                width: 100%;
                min-height: 44px;
            }

            .card {
                border-radius: 20px;
            }

            .card-body {
                padding: 18px;
            }

            .section-title-row {
                align-items: flex-start;
                flex-direction: column;
            }

            .section-title-row .badge {
                width: 100%;
                min-height: 34px;
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
                border-bottom: 1px solid var(--line);
            }

            .info-table tr:last-child {
                border-bottom: none;
            }

            .info-table th {
                border-bottom: none;
                padding: 13px 13px 6px;
                background: #f8fafc;
            }

            .info-table td {
                padding: 6px 13px 13px;
                border-top: none;
            }

            .form-control {
                min-height: 44px;
            }

            th, td {
                padding: 13px 10px;
                font-size: 13px;
            }

            .qty-input,
            .boxCount,
            .eachQty {
                max-width: 96px;
                min-width: 82px;
            }
        }

        @media (max-width: 480px) {
            .wrap {
                padding: 18px 10px 34px;
            }

            .page-hero {
                padding: 22px 16px;
                border-radius: 20px;
            }

            .page-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            h2 {
                font-size: 24px;
            }

            .hero-desc {
                font-size: 13px;
            }

            .card-body {
                padding: 14px;
            }

            .section-title-row h5 {
                font-size: 17px;
            }

            .table-responsive {
                border-radius: 14px;
            }

            .table-responsive table {
                min-width: 820px;
            }

            .info-responsive table {
                min-width: 0;
            }

            .badge {
                min-width: 76px;
                font-size: 11px;
            }
        }


        @media (max-width: 768px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .page-hero {
                flex-direction: column;
                align-items: flex-start;
            }

            .action-group {
                justify-content: flex-start;
            }

            h2 {
                font-size: 26px;
            }
        }
    </style>

</head>
<body>
<div class="wrap">

    <div class="page-hero green">
        <div>
            <div class="page-badge">🚚 EXPORT EDIT</div>
            <h2>수출 지시 수정</h2>
            <div class="hero-desc">
                수량 변경 후 저장하면 수정요청도 승인완료 처리됩니다.
            </div>
        </div>

        <div class="action-group">
            <a href="${pageContext.request.contextPath}/admin/export/list"
               class="btn btn-outline-secondary">
                목록으로
            </a>

            <c:if test="${order.status ne 'DONE' && order.status ne 'CANCELLED'}">
                <button type="button"
                        class="btn btn-outline-danger"
                        onclick="cancelExportOrder();">
                    수출지시 취소
                </button>
            </c:if>

            <button type="submit"
                    form="exportEditForm"
                    class="btn btn-success">
                수정 저장하기
            </button>
        </div>
    </div>

    <form id="exportEditForm"
          method="post"
          action="${pageContext.request.contextPath}/admin/export/update"
          onsubmit="return beforeSubmit();">

        <input type="hidden" name="id" value="${order.id}">
        <input type="hidden" name="changeRequestId" value="${changeRequestId}">
        <input type="hidden" id="detailJson" name="detailJson">

        <div class="card">
            <div class="card-body">
                <div class="table-responsive info-responsive">
                    <table class="table-bordered info-table">
                        <tr>
                            <th style="width:150px;">지시번호</th>
                            <td>${order.id}</td>
                        </tr>

                        <tr>
                            <th>요청일</th>
                            <td>${order.requestDate}</td>
                        </tr>

                        <tr>
                            <th>지시자</th>
                            <td>${order.workerName}</td>
                        </tr>

                        <tr>
                            <th>상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status eq 'WAITING'}">
                                        <span class="badge bg-warning text-dark">출고대기</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                        <span class="badge bg-primary">출고준비</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'READY_DONE'}">
                                        <span class="badge bg-info text-dark">출고준비완료</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'DONE'}">
                                        <span class="badge bg-success">출고완료</span>
                                    </c:when>
                                    <c:when test="${order.status eq 'CANCELLED'}">
                                        <span class="badge bg-danger">주문취소</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-dark">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>

                        <tr>
                            <th>비고</th>
                            <td>
                                <input type="text"
                                       name="remark"
                                       class="form-control"
                                       value="${order.remark}">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="section-title-row">
                    <h5 >상품 상세 목록 수정</h5>

                    <c:if test="${order.status ne 'DONE' && order.status ne 'CANCELLED'}">
                        <span class="badge bg-success">
                            출고완료 전 수정/취소 가능
                        </span>
                    </c:if>
                </div>

                <div class="table-responsive">
                    <table class="table-bordered text-center align-middle">
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
                        <c:forEach var="detail" items="${order.detailList}">
                            <tr class="detail-row">
                                <td>
                                        ${detail.type}
                                    <input type="hidden" class="type" value="${detail.type}">
                                </td>
                                <td>
                                        ${detail.model}
                                    <input type="hidden" class="model" value="${detail.model}">
                                </td>
                                <td>
                                        ${detail.color}
                                    <input type="hidden" class="color" value="${detail.color}">
                                </td>
                                <td>
                                        ${detail.hardness}
                                    <input type="hidden" class="hardness" value="${detail.hardness}">
                                </td>
                                <td>
                                        ${detail.baseQty}
                                    <input type="hidden" class="baseQty" value="${detail.baseQty}">
                                </td>
                                <td>
                                    <input type="number"
                                           class="form-control qty-input boxCount"
                                           min="0"
                                           value="${detail.boxCount}">
                                </td>
                                <td>
                                    <input type="number"
                                           class="form-control qty-input eachQty"
                                           min="0"
                                           value="${detail.eachQty}">
                                </td>
                                <td>
                                    <span class="total-qty-text"><span class="totalQty">${detail.totalQty}</span> EA</span>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty order.detailList}">
                            <tr>
                                <td colspan="8" class="empty-row">상세 품목이 없습니다.</td>
                            </tr>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </form>

    <c:if test="${order.status ne 'DONE' && order.status ne 'CANCELLED'}">
        <form method="post"
              action="${pageContext.request.contextPath}/admin/export/cancel/${order.id}"
              id="cancelExportForm"
              style="display:none;">
        </form>
    </c:if>

</div>

<script>
    function toInt(value) {
        const n = parseInt(value || "0", 10);
        return isNaN(n) || n < 0 ? 0 : n;
    }

    function recalcRow(row) {
        const baseQty = toInt(row.querySelector(".baseQty").value);
        const boxCount = toInt(row.querySelector(".boxCount").value);
        const eachQty = toInt(row.querySelector(".eachQty").value);

        row.querySelector(".boxCount").value = boxCount;
        row.querySelector(".eachQty").value = eachQty;
        row.querySelector(".totalQty").innerText = (baseQty * boxCount) + eachQty;
    }

    document.querySelectorAll(".detail-row").forEach(function(row) {
        row.querySelector(".boxCount").addEventListener("input", function() {
            recalcRow(row);
        });

        row.querySelector(".eachQty").addEventListener("input", function() {
            recalcRow(row);
        });
    });

    function beforeSubmit() {
        const detailList = [];

        document.querySelectorAll(".detail-row").forEach(function(row) {
            const type = row.querySelector(".type").value;
            const model = row.querySelector(".model").value;
            const color = row.querySelector(".color").value;
            const hardness = row.querySelector(".hardness").value;
            const baseQty = toInt(row.querySelector(".baseQty").value);
            const boxCount = toInt(row.querySelector(".boxCount").value);
            const eachQty = toInt(row.querySelector(".eachQty").value);
            const totalQty = (baseQty * boxCount) + eachQty;
            const displayName = type + " / " + model + " / " + color + " / " + hardness;

            detailList.push({
                type: type,
                model: model,
                color: color,
                hardness: hardness,
                baseQty: baseQty,
                boxCount: boxCount,
                eachQty: eachQty,
                totalQty: totalQty,
                displayName: displayName
            });
        });

        document.getElementById("detailJson").value = JSON.stringify(detailList);
        return true;
    }

    function cancelExportOrder() {
        if (!confirm('출고완료 전 수출지시만 취소할 수 있습니다.\n이 수출지시를 취소하시겠습니까?')) {
            return;
        }

        document.getElementById('cancelExportForm').submit();
    }
</script>

</body>
</html>
