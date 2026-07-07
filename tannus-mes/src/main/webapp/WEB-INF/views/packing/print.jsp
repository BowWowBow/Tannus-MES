<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 QR 출력</title>

    <script src="https://cdn.jsdelivr.net/npm/qrcodejs@1.0.0/qrcode.min.js"></script>

    <style>
        * { box-sizing: border-box; }

        body {
            margin: 0;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            background:
                    radial-gradient(circle at 10% 8%, rgba(37,99,235,0.10), transparent 26%),
                    linear-gradient(180deg, #f8fbff 0%, #eef3f8 100%);
            color: #111827;
        }

        .page {
            width: 210mm;
            min-height: 297mm;
            margin: 0 auto;
            padding: 8mm;
            background: white;
            box-shadow: 0 18px 42px rgba(15,23,42,0.14);
        }

        .top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 3px solid #1d4ed8;
            padding-bottom: 5mm;
            margin-bottom: 5mm;
        }

        .title-area h1 {
            margin: 0;
            font-size: 23px;
            color: #0f172a;
            font-weight: 900;
            letter-spacing: -0.5px;
        }

        .title-area p {
            margin: 5px 0 0;
            font-size: 11px;
            color: #64748b;
            font-weight: 700;
        }

        .print-date {
            font-size: 10px;
            color: #334155;
            text-align: right;
            line-height: 1.5;
            font-weight: 900;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 10px;
            padding: 8px 10px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 5px;
            margin-bottom: 5mm;
        }

        .info-box {
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            padding: 7px 9px;
            min-height: 39px;
            background: #f8fafc;
        }

        .info-label {
            display: block;
            font-size: 9px;
            color: #64748b;
            margin-bottom: 3px;
            font-weight: 800;
        }

        .info-value {
            display: block;
            font-size: 11px;
            font-weight: 900;
            color: #0f172a;
        }

        .section-title {
            margin: 0 0 4mm;
            font-size: 15px;
            color: #1d4ed8;
            font-weight: 900;
        }

        .section-title:before {
            content: "";
            display: inline-block;
            width: 5px;
            height: 14px;
            border-radius: 999px;
            background: #2563eb;
            margin-right: 6px;
            vertical-align: -2px;
        }

        .label-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 5mm;
            align-items: start;
        }

        .label-card {
            border: 1.8px solid #0f172a;
            border-radius: 10px;
            padding: 7px;
            min-height: 77mm;
            page-break-inside: avoid;
            break-inside: avoid;
            position: relative;
            background: #ffffff;
            box-shadow: inset 0 0 0 2px #f8fafc;
        }

        .label-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 6px;
            margin-bottom: 6px;
            padding-bottom: 5px;
            border-bottom: 1px solid #e2e8f0;
        }

        .label-title {
            font-size: 15px;
            font-weight: 900;
            color: #0f172a;
            line-height: 1.15;
            word-break: break-word;
        }

        .qty-badge {
            flex: 0 0 auto;
            min-width: 42px;
            padding: 4px 8px;
            border-radius: 999px;
            background: #2563eb;
            color: white;
            text-align: center;
            font-size: 11px;
            font-weight: 900;
        }

        .unit-badge {
            display: inline-block;
            padding: 3px 7px;
            border-radius: 999px;
            background: #0f172a;
            color: white;
            font-size: 10px;
            font-weight: 900;
            margin-right: 4px;
        }

        .unplanned-badge {
            background: #dc2626;
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
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
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
            background: #f1f5f9;
            color: #0f172a;
            text-align: left;
            font-weight: 900;
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
            font-weight: 800;
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
            border-radius: 12px;
            padding: 10px 16px;
            background: #2563eb;
            color: white;
            font-weight: 900;
            cursor: pointer;
            box-shadow: 0 10px 22px rgba(15,23,42,0.12);
        }

        .btn.gray { background: #334155; }


        /* ===== 화면용 반응형 보강 ===== */
        @media screen and (max-width: 1100px) {
            .print-actions {
                width: auto;
                margin: 14px 16px;
                padding: 0;
            }

            .page {
                width: calc(100% - 32px);
                min-height: auto;
                margin: 16px auto 28px;
                padding: 18px;
                border-radius: 16px;
            }

            .label-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 14px;
            }

            .label-card {
                min-height: auto;
            }
        }

        @media screen and (max-width: 760px) {
            .print-actions {
                position: sticky;
                top: 0;
                z-index: 30;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
                margin: 0;
                padding: 10px;
                width: 100%;
                background: rgba(255,255,255,0.94);
                border-bottom: 1px solid #e2e8f0;
                backdrop-filter: blur(10px);
            }

            .btn {
                width: 100%;
                padding: 10px 12px;
            }

            .page {
                width: calc(100% - 20px);
                margin: 10px auto 24px;
                padding: 14px;
                box-shadow: 0 10px 26px rgba(15,23,42,0.10);
            }

            .top {
                flex-direction: column;
                gap: 10px;
                align-items: stretch;
            }

            .title-area h1 {
                font-size: 21px;
            }

            .print-date {
                text-align: left;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .label-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .label-head {
                align-items: flex-start;
            }

            .label-title {
                font-size: 14px;
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

            .label-table th,
            .label-table td {
                font-size: 9px;
                padding: 3px;
            }
        }

        @media screen and (max-width: 430px) {
            .page {
                width: calc(100% - 12px);
                padding: 10px;
            }

            .label-card {
                padding: 6px;
                border-radius: 8px;
            }

            .label-body {
                grid-template-columns: 1fr;
            }

            .qr {
                margin: 0 auto;
            }

            .label-table th {
                width: 38%;
            }

            .qr-text {
                font-size: 6.5px;
            }
        }

        @page {
            size: A4 portrait;
            margin: 6mm;
        }

        @media print {
            body { background: white; }

            .page {
                width: auto;
                min-height: auto;
                margin: 0;
                padding: 0;
                box-shadow: none;
            }

            .print-actions { display: none; }

            .top {
                margin-bottom: 4mm;
                padding-bottom: 3mm;
            }

            .info-grid { margin-bottom: 4mm; }

            .label-grid { gap: 4mm; }

            .label-card {
                min-height: 72mm;
                box-shadow: none;
            }
        }
    </style>
</head>

<body>

<div class="print-actions">
    <button type="button"
            class="btn gray"
            onclick="location.href='${pageContext.request.contextPath}/packing/detail/${order.id}'">
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
                <c:when test="${order.status eq 'REQUESTED'}">
                    <h1>포장 QR 출력</h1>
                    <p>포장지시 기준 / BOX·EACH 단위 라벨 출력</p>
                </c:when>
                <c:otherwise>
                    <h1>포장 QR 재출력</h1>
                    <p>포장완료 품목 기준 / BOX·EACH 단위 라벨 출력</p>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="print-date">
            TANNUS MES<br>
            PACKING QR LABEL
        </div>
    </div>

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
            <span class="info-value">
                <c:choose>
                    <c:when test="${empty order.requestedBy}">-</c:when>
                    <c:otherwise>${order.requestedBy}</c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <h2 class="section-title">포장 QR</h2>

    <div class="label-grid" id="labelGrid">
        <c:choose>
            <c:when test="${empty order.detailList && empty unplannedPackingList}">
                <div class="empty">출력할 포장 QR이 없습니다.</div>
            </c:when>

            <c:otherwise>
                <c:forEach var="detail" items="${order.detailList}">
                    <div class="label-source"
                         data-kind="NORMAL"
                         data-kind-name="정상포장"
                         data-order-id="${order.id}"
                         data-detail-id="${detail.id}"
                         data-product-type="${detail.productType}"
                         data-model-name="${detail.modelName}"
                         data-color="${detail.color}"
                         data-hardness="${detail.hardness}"
                         data-base-qty="${detail.baseQty}"
                         data-box-count="${detail.boxCount}"
                         data-each-qty="${detail.eachQty}"
                         data-total-qty="${detail.totalQty}">
                    </div>
                </c:forEach>

                <c:forEach var="item" items="${unplannedPackingList}">
                    <c:if test="${item.status eq 'APPROVED'}">
                        <div class="label-source"
                             data-kind="UNPLANNED"
                             data-kind-name="무발주"
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
            </c:otherwise>
        </c:choose>
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

    function makeScanType(data, unitType) {
        if (data.kind === "UNPLANNED") {
            return unitType === "BOX" ? "UNPLANNED_BOX" : "UNPLANNED_EACH";
        }

        return unitType;
    }

    function makeQrText(data, unitType, unitNo, unitQty) {
        const scanType = makeScanType(data, unitType);

        if (data.kind === "UNPLANNED") {
            return [
                "UNPLANNED",
                data.orderId,
                data.detailId,
                scanType,
                unitNo,
                data.productType,
                data.modelName,
                data.color,
                data.hardness,
                unitQty
            ].join("|");
        }

        return [
            "PACKING",
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
        const scanType = makeScanType(data, unitType);
        const qrText = makeQrText(data, unitType, unitNo, unitQty);

        const unitLabel = unitType === "BOX" ? "박스" : "낱개";
        const badgeClass = data.kind === "UNPLANNED" ? "unit-badge unplanned-badge" : "unit-badge";

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
            '<td><span class="' + badgeClass + '">' + escapeHtml(data.kindName) + '</span></td>' +
            '</tr>' +
            '<tr>' +
            '<th>스캔단위</th>' +
            '<td>' + escapeHtml(scanType) + ' / ' + escapeHtml(unitLabel) + ' ' + unitNo + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>라벨번호</th>' +
            '<td>' + labelNo + ' / ' + labelTotalCount + '</td>' +
            '</tr>' +
            '<tr>' +
            '<th>상세ID</th>' +
            '<td>' + escapeHtml(data.detailId) + '</td>' +
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

    function appendLabels(data) {
        const grid = document.getElementById("labelGrid");
        const labelTotalCount = data.boxCount + (data.eachQty > 0 ? 1 : 0);
        let labelNo = 1;

        for (let i = 1; i <= data.boxCount; i++) {
            const boxQty = data.baseQty > 0 ? data.baseQty : 0;

            if (boxQty <= 0) {
                continue;
            }

            grid.appendChild(
                createLabelCard(data, "BOX", i, boxQty, labelNo, labelTotalCount)
            );

            labelNo++;
        }

        if (data.eachQty > 0) {
            grid.appendChild(
                createLabelCard(data, "EACH", 1, data.eachQty, labelNo, labelTotalCount)
            );
        }
    }

    function buildLabels() {
        const sources = Array.from(document.querySelectorAll(".label-source"));

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

            if (data.totalQty > 0) {
                appendLabels(data);
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