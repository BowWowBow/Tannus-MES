<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 QR 출력</title>

    <script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Malgun Gothic", sans-serif;
            background: #eef1f5;
            color: #111827;
        }

        .page {
            width: 210mm;
            min-height: 297mm;
            margin: 0 auto;
            padding: 8mm;
            background: white;
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #111827;
            padding-bottom: 5mm;
            margin-bottom: 5mm;
        }

        .title-area h1 {
            margin: 0;
            font-size: 22px;
            color: #111827;
        }

        .title-area p {
            margin: 4px 0 0;
            font-size: 11px;
            color: #6b7280;
            line-height: 1.5;
        }

        .print-date {
            font-size: 10px;
            color: #64748b;
            text-align: right;
            line-height: 1.4;
            font-weight: 700;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 4px;
            margin-bottom: 5mm;
        }

        .info-box {
            border: 1px solid #cbd5e1;
            border-radius: 5px;
            padding: 6px 8px;
            min-height: 38px;
        }

        .info-label {
            display: block;
            font-size: 9px;
            color: #64748b;
            margin-bottom: 3px;
        }

        .info-value {
            display: block;
            font-size: 11px;
            font-weight: bold;
            color: #111827;
        }

        .section-title {
            margin: 0 0 4mm;
            font-size: 15px;
            color: #1565c0;
        }

        .label-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 5mm;
            align-items: start;
        }

        .label-card {
            border: 1.5px solid #111827;
            border-radius: 8px;
            padding: 7px;
            min-height: 77mm;
            page-break-inside: avoid;
            break-inside: avoid;
            position: relative;
        }

        .label-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 6px;
            margin-bottom: 5px;
        }

        .label-title {
            font-size: 15px;
            font-weight: 900;
            color: #111827;
            line-height: 1.15;
            word-break: break-word;
        }

        .qty-badge {
            flex: 0 0 auto;
            min-width: 42px;
            padding: 4px 8px;
            border-radius: 999px;
            background: #1565c0;
            color: white;
            text-align: center;
            font-size: 11px;
            font-weight: bold;
        }

        .unit-badge {
            display: inline-block;
            padding: 3px 7px;
            border-radius: 999px;
            background: #111827;
            color: white;
            font-size: 10px;
            font-weight: bold;
            margin-right: 4px;
        }

        .label-body {
            display: grid;
            grid-template-columns: 82px 1fr;
            gap: 6px;
            align-items: start;
        }

        .qr {
            width: 78px;
            height: 78px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .qr img,
        .qr canvas {
            width: 78px !important;
            height: 78px !important;
        }

        .label-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .label-table th,
        .label-table td {
            border: 1px solid #cbd5e1;
            padding: 3px 4px;
            font-size: 9.5px;
            line-height: 1.2;
            word-break: break-word;
        }

        .label-table th {
            width: 42%;
            background: #f8fafc;
            color: #111827;
            text-align: left;
        }

        .qr-text {
            margin-top: 5px;
            padding-top: 4px;
            border-top: 1px dashed #94a3b8;
            font-size: 7px;
            color: #64748b;
            word-break: break-all;
            line-height: 1.2;
        }

        .cut-line {
            margin-top: 4px;
            border-top: 1px dashed #9ca3af;
            text-align: center;
            font-size: 8px;
            color: #64748b;
        }

        .empty {
            grid-column: 1 / -1;
            padding: 40px 0;
            text-align: center;
            color: #888;
            border: 1px dashed #ccc;
            border-radius: 8px;
        }

        .print-actions {
            width: 210mm;
            margin: 16px auto;
            display: flex;
            justify-content: flex-end;
            gap: 8px;
        }

        .btn {
            border: none;
            border-radius: 8px;
            padding: 10px 16px;
            background: #1565c0;
            color: white;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }

        .btn.gray {
            background: #6c757d;
        }



        /* ===== 화면 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .page {
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.14);
        }

        .print-actions {
            position: sticky;
            top: 0;
            z-index: 20;
            padding: 10px 0;
            background: rgba(238, 241, 245, 0.92);
            backdrop-filter: blur(8px);
        }

        @media screen and (max-width: 920px) {
            .print-actions {
                width: calc(100% - 28px);
                margin: 12px auto;
            }

            .page {
                width: calc(100% - 28px);
                min-height: auto;
                margin: 0 auto 24px;
                padding: 18px;
                border-radius: 16px;
            }

            .top {
                gap: 14px;
                flex-wrap: wrap;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .label-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 14px;
            }

            .label-card {
                min-height: auto;
            }
        }

        @media screen and (max-width: 640px) {
            .print-actions {
                width: calc(100% - 24px);
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
            }

            .btn {
                width: 100%;
                text-align: center;
            }

            .page {
                width: calc(100% - 20px);
                padding: 14px;
            }

            .top {
                flex-direction: column;
                align-items: stretch;
            }

            .title-area h1 {
                font-size: 21px;
            }

            .print-date {
                text-align: left;
            }

            .section-title {
                font-size: 14px;
            }

            .label-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .label-body {
                grid-template-columns: 76px 1fr;
            }

            .qr,
            .qr img,
            .qr canvas {
                width: 72px !important;
                height: 72px !important;
            }
        }

        @page {
            size: A4 portrait;
            margin: 6mm;
        }

        @media print {
            body {
                background: white;
            }

            .page {
                width: auto;
                min-height: auto;
                margin: 0;
                padding: 0;
                box-shadow: none;
            }

            .print-actions {
                display: none;
            }

            .top {
                margin-bottom: 4mm;
                padding-bottom: 3mm;
            }

            .info-grid {
                margin-bottom: 4mm;
            }

            .label-grid {
                gap: 4mm;
            }

            .label-card {
                min-height: 72mm;
            }
        }
    </style>
</head>

<body>

<div class="print-actions">
    <button type="button"
            class="btn gray"
            onclick="location.href='${pageContext.request.contextPath}/logistics/export/detail/${order.id}'">
        뒤로
    </button>

    <button type="button" class="btn" onclick="window.print();">
        인쇄
    </button>
</div>

<div class="page">

    <div class="top">
        <div class="title-area">
            <c:choose>
                <c:when test="${order.status eq 'DONE'}">
                    <h1>수출 QR 재출력</h1>
                    <p>출고 스캔 완료 품목 기준 / 박스·낱개 단위 라벨 출력</p>
                </c:when>

                <c:otherwise>
                    <h1>수출 QR 출력</h1>
                    <p>물류팀 수출 출고지시 기준 / 박스·낱개 단위 라벨 출력</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="print-date">
            TANNUS MES<br>
            EXPORT QR LABEL
        </div>
    </div>

    <div class="info-grid">
        <div class="info-box">
            <span class="info-label">수출지시번호</span>
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
                    <c:when test="${empty order.workerName}">
                        -
                    </c:when>
                    <c:otherwise>
                        ${order.workerName}
                    </c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <h2 class="section-title">정상 수출 QR</h2>

    <div class="label-grid" id="normalLabelGrid">
        <c:choose>
            <c:when test="${empty order.detailList}">
                <div class="empty">출력할 정상 수출 QR이 없습니다.</div>
            </c:when>

            <c:otherwise>
                <c:forEach var="detail" items="${order.detailList}">
                    <c:if test="${order.status ne 'DONE' || detail.outboundStatus eq 'DONE'}">
                        <div class="label-source"
                             data-kind="EXPORT"
                             data-kind-name="정상수출"
                             data-order-id="${order.id}"
                             data-detail-id="${detail.id}"
                             data-product-type="${detail.type}"
                             data-model-name="${detail.model}"
                             data-color="${detail.color}"
                             data-hardness="${detail.hardness}"
                             data-base-qty="${detail.baseQty}"
                             data-box-count="${detail.boxCount}"
                             data-each-qty="${detail.eachQty}"
                             data-total-qty="${detail.totalQty}">
                        </div>
                    </c:if>
                </c:forEach>
            </c:otherwise>
        </c:choose>

        <c:forEach var="item" items="${unplannedExportList}">
            <c:if test="${item.status eq 'APPROVED'}">
                <div class="label-source"
                     data-kind="UNPLANNED_EXPORT"
                     data-kind-name="무발주수출"
                     data-order-id="${order.id}"
                     data-detail-id="${item.id}"
                     data-product-type="${item.productType}"
                     data-model-name="${item.modelName}"
                     data-color="${item.color}"
                     data-hardness="${item.hardness}"
                     data-base-qty="${item.baseQty}"
                     data-box-count="${item.boxCount}"
                     data-each-qty="${item.eachQty}"
                     data-total-qty="${item.totalQty}">
                </div>
            </c:if>
        </c:forEach>
    </div>

</div>

<script>
    function toInt(value) {
        const num = parseInt(value, 10);
        return isNaN(num) ? 0 : num;
    }

    function escapeHtml(value) {
        if (value === null || value === undefined) {
            return "";
        }

        return String(value)
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll('"', "&quot;")
            .replaceAll("'", "&#039;");
    }

    function makeQrText(data, unitType, unitNo, unitQty) {
        if (data.kind === "UNPLANNED_EXPORT") {
            return [
                data.kind,
                data.orderId,
                data.detailId,
                data.productType,
                data.modelName,
                data.color,
                data.hardness,
                data.totalQty
            ].join("|");
        }

        return [
            data.kind,
            data.orderId,
            data.detailId,
            unitType,
            unitNo,
            data.productType,
            data.modelName,
            data.color,
            data.hardness,
            unitQty
        ].join("|");
    }

    function createLabelCard(data, unitType, unitNo, unitQty, labelNo, labelTotalCount) {
        const qrText = makeQrText(data, unitType, unitNo, unitQty);

        const unitLabel = unitType === "BOX" ? "박스" : "낱개";
        const unitDisplay = data.kind === "UNPLANNED_EXPORT"
            ? "무발주"
            : unitLabel + " " + unitNo;

        const card = document.createElement("div");
        card.className = "label-card";

        card.innerHTML =
            '<div class="label-head">' +
            '<div class="label-title">' +
            escapeHtml(data.productType) + ' / ' + escapeHtml(data.modelName) +
            '</div>' +
            '<div class="qty-badge">' + unitQty + ' EA</div>' +
            '</div>' +

            '<div class="label-body">' +
            '<div class="qr qr-target" data-qr="' + escapeHtml(qrText) + '"></div>' +

            '<table class="label-table">' +
            '<tr>' +
            '<th>구분</th>' +
            '<td>' +
            '<span class="unit-badge">' + escapeHtml(unitDisplay) + '</span>' +
            escapeHtml(data.kindName) +
            '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>라벨번호</th>' +
            '<td>' + labelNo + ' / ' + labelTotalCount + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>상품종류</th>' +
            '<td>' + escapeHtml(data.productType) + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>모델/사이즈</th>' +
            '<td>' + escapeHtml(data.modelName) + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>색상</th>' +
            '<td>' + escapeHtml(data.color) + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>경도</th>' +
            '<td>' + escapeHtml(data.hardness) + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>기준수량</th>' +
            '<td>' + data.baseQty + ' EA</td>' +
            '</tr>' +
            '<tr>' +
            '<th>라벨수량</th>' +
            '<td>' + unitQty + ' EA</td>' +
            '</tr>' +
            '<tr>' +
            '<th>총수량</th>' +
            '<td>' + data.totalQty + ' EA</td>' +
            '</tr>' +
            '</table>' +
            '</div>' +

            '<div class="qr-text">' + escapeHtml(qrText) + '</div>' +
            '<div class="cut-line">절취선</div>';

        return card;
    }

    function buildLabels() {
        const grid = document.getElementById("normalLabelGrid");
        const sources = Array.from(document.querySelectorAll(".label-source"));

        if (sources.length === 0) {
            return;
        }

        sources.forEach(function (source) {
            const data = {
                kind: source.dataset.kind || "",
                kindName: source.dataset.kindName || "",
                orderId: source.dataset.orderId || "",
                detailId: source.dataset.detailId || "",
                productType: source.dataset.productType || "",
                modelName: source.dataset.modelName || "",
                color: source.dataset.color || "",
                hardness: source.dataset.hardness || "",
                baseQty: toInt(source.dataset.baseQty),
                boxCount: toInt(source.dataset.boxCount),
                eachQty: toInt(source.dataset.eachQty),
                totalQty: toInt(source.dataset.totalQty)
            };

            if (data.totalQty <= 0) {
                source.remove();
                return;
            }

            if (data.kind === "UNPLANNED_EXPORT") {
                const card = createLabelCard(
                    data,
                    "UNPLANNED",
                    1,
                    data.totalQty,
                    1,
                    1
                );

                grid.appendChild(card);
                source.remove();
                return;
            }

            const labelTotalCount = data.boxCount + (data.eachQty > 0 ? 1 : 0);
            let labelNo = 1;

            for (let i = 1; i <= data.boxCount; i++) {
                const boxQty = data.baseQty > 0 ? data.baseQty : 0;

                if (boxQty <= 0) {
                    continue;
                }

                const card = createLabelCard(
                    data,
                    "BOX",
                    i,
                    boxQty,
                    labelNo,
                    labelTotalCount
                );

                grid.appendChild(card);
                labelNo++;
            }

            if (data.eachQty > 0) {
                const card = createLabelCard(
                    data,
                    "EACH",
                    1,
                    data.eachQty,
                    labelNo,
                    labelTotalCount
                );

                grid.appendChild(card);
            }

            source.remove();
        });
    }

    function renderQrs() {
        document.querySelectorAll(".qr-target").forEach(function (el) {
            const text = el.getAttribute("data-qr");

            if (!text) {
                return;
            }

            new QRCode(el, {
                text: text,
                width: 78,
                height: 78,
                correctLevel: QRCode.CorrectLevel.M
            });
        });
    }

    window.addEventListener("load", function () {
        buildLabels();
        renderQrs();

        setTimeout(function () {
            window.print();
        }, 500);
    });
</script>

</body>
</html>
