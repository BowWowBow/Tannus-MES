<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>입고 QR 스캔</title>

    <script src="https://unpkg.com/html5-qrcode"></script>

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
            max-width: 1100px;
            margin: 40px auto 60px;
            padding: 20px;
        }

        .top-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .top-box h1 {
            position: relative;
            margin: 0;
            padding-left: 14px;
            color: #1d4ed8;
            font-size: 30px;
            letter-spacing: -0.6px;
        }

        .top-box h1::before {
            content: "";
            position: absolute;
            left: 0;
            top: 6px;
            width: 5px;
            height: 26px;
            border-radius: 999px;
            background: #38bdf8;
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
            font-weight: 800;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.20);
            white-space: nowrap;
        }

        .btn.gray {
            background: #64748b;
            box-shadow: none;
        }

        .btn.red {
            background: linear-gradient(135deg, #ef4444, #f97316);
            padding: 7px 12px;
            font-size: 13px;
        }

        .card {
            position: relative;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.94);
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

        .info {
            background: linear-gradient(180deg, #f8fbff, #eef6ff);
            border: 1px solid #d8e7fb;
            border-radius: 16px;
            padding: 16px;
            margin-bottom: 20px;
            line-height: 1.6;
            font-weight: 700;
        }

        .info strong {
            color: #1d4ed8;
        }

        h4 {
            margin: 0 0 12px;
            color: #1d4ed8;
            font-size: 18px;
        }

        #reader {
            width: 100%;
            max-width: 520px;
            margin: 0 auto;
        }

        .result-box {
            margin-top: 20px;
            background: #f8fbff;
            border: 1px solid #dbe9f6;
            border-radius: 12px;
            padding: 16px;
        }

        .result-title {
            font-weight: 900;
            margin-bottom: 8px;
            color: #0f172a;
        }

        #qrResult {
            white-space: pre-line;
            word-break: break-all;
            color: #1976d2;
            font-weight: 800;
            line-height: 1.6;
        }

        .btn-row {
            margin-top: 18px;
            display: flex;
            gap: 10px;
        }

        .bottom-row {
            margin-top: 20px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .hidden {
            display: none;
        }

        .table-wrap {
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 850px;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: white;
            margin-top: 10px;
        }

        thead {
            background: linear-gradient(180deg, #eff6ff, #e0f2fe);
        }

        th, td {
            padding: 12px 10px;
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

        .done {
            display: inline-flex;
            min-width: 74px;
            justify-content: center;
            padding: 5px 10px;
            border-radius: 999px;
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            font-weight: 900;
            font-size: 12px;
        }

        .waiting {
            display: inline-flex;
            min-width: 74px;
            justify-content: center;
            padding: 5px 10px;
            border-radius: 999px;
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
            font-weight: 900;
            font-size: 12px;
        }

        .unit-badge {
            display: inline-flex;
            justify-content: center;
            min-width: 82px;
            padding: 5px 10px;
            border-radius: 999px;
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
            font-size: 12px;
            font-weight: 900;
        }

        .unit-badge.each {
            background: #ede9fe;
            color: #5b21b6;
            border-color: #ddd6fe;
        }

        .unit-badge.unplanned {
            background: #fee2e2;
            color: #991b1b;
            border-color: #fecaca;
        }

        .notice {
            margin-top: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            background: #fff8e1;
            border: 1px solid #ffe082;
            color: #6d4c00;
            font-size: 14px;
            font-weight: 800;
            line-height: 1.6;
        }

        hr {
            margin: 18px 0;
            border: none;
            border-top: 1px solid #e2e8f0;
        }


        @media (max-width: 900px) {
            .wrap {
                max-width: 100%;
                margin: 24px auto 46px;
                padding: 16px;
            }

            .card {
                padding: 18px;
                border-radius: 20px;
            }

            .info {
                font-size: 14px;
            }

            #reader {
                max-width: 100%;
            }

            #reader video,
            #reader canvas {
                max-width: 100% !important;
                border-radius: 14px;
            }

            .btn-row,
            .bottom-row {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-row .btn,
            .bottom-row .btn {
                width: 100%;
            }

            .table-wrap {
                overflow-x: visible;
            }

            table {
                min-width: 0;
                border: none;
                background: transparent;
            }

            thead {
                display: none;
            }

            tbody,
            tr,
            td {
                display: block;
                width: 100%;
            }

            tbody tr {
                margin-bottom: 12px;
                border: 1px solid #e2e8f0;
                border-radius: 16px;
                background: #ffffff;
                overflow: hidden;
                box-shadow: 0 8px 20px rgba(15, 23, 42, 0.06);
            }

            tbody tr:last-child {
                margin-bottom: 0;
            }

            td {
                position: relative;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 14px;
                min-height: 46px;
                padding: 12px 14px;
                border-bottom: 1px solid #e5e7eb;
                text-align: right;
                font-size: 13px;
                word-break: keep-all;
            }

            td:last-child {
                border-bottom: none;
            }

            td::before {
                content: attr(data-label);
                flex: 0 0 92px;
                color: #64748b;
                font-weight: 900;
                text-align: left;
                white-space: nowrap;
            }

            td[colspan] {
                display: block;
                text-align: center;
                padding: 26px 12px;
            }

            td[colspan]::before {
                display: none;
            }
        }

        @media (max-width: 760px) {
            .wrap {
                margin-top: 20px;
                padding: 14px;
            }

            .top-box {
                align-items: flex-start;
                flex-direction: column;
            }

            .top-box h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>입고 QR 스캔</h1>

        <a href="${pageContext.request.contextPath}/logistics/detail/${order.id}" class="btn gray">
            상세로
        </a>
    </div>

    <div class="card">

        <div class="info">
            <div><strong>포장 지시번호:</strong> ${order.id}</div>
            <div><strong>출고 요청일:</strong> ${order.requestDate}</div>
            <div><strong>상태:</strong> 물류 입고대기</div>
        </div>

        <h4>입고 스캔 현황</h4>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>상품명</th>
                    <th>단위</th>
                    <th>번호</th>
                    <th>수량</th>
                    <th>상태</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${empty inboundScanList}">
                        <tr>
                            <td colspan="5">생성된 입고 스캔 항목이 없습니다.</td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="scan" items="${inboundScanList}">
                            <c:set var="printed" value="false" />

                            <c:choose>
                                <c:when test="${scan.unitType eq 'BOX' || scan.unitType eq 'EACH'}">
                                    <c:forEach var="detail" items="${order.detailList}">
                                        <c:if test="${detail.id eq scan.detailId}">
                                            <c:set var="printed" value="true" />
                                            <tr>
                                                <td data-label="상품명">
                                                        ${detail.productType} /
                                                        ${detail.modelName} /
                                                        ${detail.color} /
                                                        ${detail.hardness}
                                                </td>

                                                <td data-label="단위">
                                                    <c:choose>
                                                        <c:when test="${scan.unitType eq 'BOX'}">
                                                            <span class="unit-badge">BOX</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="unit-badge each">EACH</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td data-label="번호">${scan.unitNo}</td>
                                                <td data-label="수량">${scan.qty} EA</td>

                                                <td data-label="상태">
                                                    <c:choose>
                                                        <c:when test="${scan.scanStatus eq 'DONE'}">
                                                            <span class="done">스캔완료</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="waiting">스캔대기</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <c:forEach var="item" items="${unplannedList}">
                                        <c:if test="${item.id eq scan.detailId}">
                                            <c:set var="printed" value="true" />
                                            <tr>
                                                <td data-label="상품명">
                                                        ${item.productType} /
                                                        ${item.modelName} /
                                                        ${item.color} /
                                                        ${item.hardness}
                                                </td>

                                                <td data-label="단위">
                                                    <c:choose>
                                                        <c:when test="${scan.unitType eq 'UNPLANNED_BOX'}">
                                                            <span class="unit-badge unplanned">무발주 BOX</span>
                                                        </c:when>
                                                        <c:when test="${scan.unitType eq 'UNPLANNED_EACH'}">
                                                            <span class="unit-badge unplanned">무발주 EACH</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="unit-badge unplanned">${scan.unitType}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>

                                                <td data-label="번호">${scan.unitNo}</td>
                                                <td data-label="수량">${scan.qty} EA</td>

                                                <td data-label="상태">
                                                    <c:choose>
                                                        <c:when test="${scan.scanStatus eq 'DONE'}">
                                                            <span class="done">스캔완료</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="waiting">스캔대기</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not printed}">
                                <tr>
                                    <td data-label="상품명">
                                        <c:choose>
                                            <c:when test="${not empty scan.productType}">
                                                ${scan.productType} /
                                                ${scan.modelName} /
                                                ${scan.color} /
                                                ${scan.hardness}
                                            </c:when>
                                            <c:otherwise>
                                                상세ID ${scan.detailId} 상품정보 없음
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td data-label="단위">
                                        <c:choose>
                                            <c:when test="${scan.unitType eq 'BOX'}">
                                                <span class="unit-badge">BOX</span>
                                            </c:when>
                                            <c:when test="${scan.unitType eq 'EACH'}">
                                                <span class="unit-badge each">EACH</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="unit-badge unplanned">${scan.unitType}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td data-label="번호">${scan.unitNo}</td>
                                    <td data-label="수량">${scan.qty} EA</td>

                                    <td data-label="상태">
                                        <c:choose>
                                            <c:when test="${scan.scanStatus eq 'DONE'}">
                                                <span class="done">스캔완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="waiting">스캔대기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <div class="notice">
            포장팀에서 출력한 QR을 스캔합니다.<br>
            정상 QR 예시: PACKING|지시번호|상세ID|BOX|1|상품|모델|색상|경도|수량<br>
            무발주 QR 예시: UNPLANNED|지시번호|무발주ID|UNPLANNED_EACH|1|상품|모델|색상|경도|수량<br>
            예전 무발주 QR도 인식 가능: UNPLANNED|지시번호|무발주ID|상품|모델|색상|경도|수량
        </div>

        <hr>

        <div id="reader"></div>

        <div class="result-box">
            <div class="result-title">스캔 결과</div>
            <div id="qrResult">아직 스캔된 QR이 없습니다.</div>

            <div id="confirmArea" class="btn-row hidden">
                <button type="button" class="btn" onclick="confirmInbound()">
                    이 항목 입고 확인
                </button>
            </div>
        </div>

        <div class="bottom-row">
            <a href="${pageContext.request.contextPath}/logistics/detail/${order.id}" class="btn gray">
                상세로
            </a>
        </div>

    </div>

</div>

<script>
    let scannedText = "";
    let scannedQrType = "";

    let scannedDetailId = "";
    let scannedUnplannedId = "";

    let scannedUnitType = "";
    let scannedUnitNo = "";

    let lastScanText = "";
    let lastScanTime = 0;

    function hideConfirm() {
        document.getElementById("confirmArea").classList.add("hidden");
    }

    function showResult(message, color) {
        const qrResult = document.getElementById("qrResult");
        qrResult.innerText = message;
        qrResult.style.color = color;
    }

    function resetScan(message, color) {
        scannedText = "";
        scannedQrType = "";
        scannedDetailId = "";
        scannedUnplannedId = "";
        scannedUnitType = "";
        scannedUnitNo = "";

        showResult(message, color);
        hideConfirm();
    }

    function normalizeQrText(decodedText) {
        return decodedText
            .trim()
            .replaceAll("｜", "|")
            .replaceAll("ㅣ", "|")
            .replaceAll("Ｉ", "|");
    }

    function parseOldTypeFormat(cleanText) {
        const result = {};
        const pairs = cleanText.split("&");

        for (let i = 0; i < pairs.length; i++) {
            const pair = pairs[i].split("=");

            if (pair.length >= 2) {
                result[pair[0]] = pair.slice(1).join("=");
            }
        }

        return result;
    }

    function isUnplannedUnit(unitType) {
        return unitType === "UNPLANNED_BOX" ||
            unitType === "UNPLANNED_EACH" ||
            unitType === "UNPLANNED";
    }

    function onScanSuccess(decodedText) {
        const now = Date.now();
        const cleanText = normalizeQrText(decodedText);

        if (cleanText === lastScanText && now - lastScanTime < 2000) {
            return;
        }

        lastScanText = cleanText;
        lastScanTime = now;

        const currentOrderId = "${order.id}";

        let qrType = "";
        let orderId = "";
        let targetId = "";
        let unitType = "";
        let unitNo = "";
        let productType = "";
        let modelName = "";
        let color = "";
        let hardness = "";
        let qty = "";

        const parts = cleanText.split("|");

        if (parts.length >= 10 && parts[0] === "PACKING") {
            qrType = "PACKING";
            orderId = parts[1];
            targetId = parts[2];
            unitType = parts[3];
            unitNo = parts[4];
            productType = parts[5];
            modelName = parts[6];
            color = parts[7];
            hardness = parts[8];
            qty = parts[9];
        } else if (parts.length >= 10 && parts[0] === "UNPLANNED") {
            qrType = "UNPLANNED";
            orderId = parts[1];
            targetId = parts[2];
            unitType = parts[3];
            unitNo = parts[4];
            productType = parts[5];
            modelName = parts[6];
            color = parts[7];
            hardness = parts[8];
            qty = parts[9];

            if (unitType === "UNPLANNED") {
                unitType = "UNPLANNED_EACH";
            }
        } else if (parts.length >= 8 && parts[0] === "UNPLANNED") {
            qrType = "UNPLANNED";
            orderId = parts[1];
            targetId = parts[2];
            unitType = "UNPLANNED_EACH";
            unitNo = "1";
            productType = parts[3];
            modelName = parts[4];
            color = parts[5];
            hardness = parts[6];
            qty = parts[7];
        } else if (cleanText.startsWith("TYPE=")) {
            const map = parseOldTypeFormat(cleanText);

            qrType = map["TYPE"] || "";
            orderId = map["ORDER_ID"] || map["ORDER"] || map["orderId"] || "";
            targetId = map["DETAIL_ID"] || map["DETAIL"] || map["detailId"] || "";
            unitType = map["UNIT_TYPE"] || map["UNIT"] || map["unitType"] || "BOX";
            unitNo = map["UNIT_NO"] || map["NO"] || map["unitNo"] || "1";

            if (qrType === "UNPLANNED") {
                targetId = map["UNPLANNED_ID"] || map["ID"] || targetId;
                unitType = map["UNIT_TYPE"] || map["UNIT"] || map["unitType"] || "UNPLANNED_EACH";
                unitNo = map["UNIT_NO"] || map["NO"] || map["unitNo"] || "1";

                if (unitType === "UNPLANNED") {
                    unitType = "UNPLANNED_EACH";
                }
            }
        } else {
            resetScan(
                "잘못된 입고 QR입니다.\n\n" +
                "포장팀에서 출력한 PACKING 또는 UNPLANNED QR을 스캔해야 합니다.\n\n" +
                "필요 형식:\n" +
                "PACKING|지시번호|상세ID|BOX|1|상품|모델|색상|경도|수량\n" +
                "UNPLANNED|지시번호|무발주ID|UNPLANNED_EACH|1|상품|모델|색상|경도|수량\n\n" +
                "현재 스캔값:\n" + cleanText,
                "#dc3545"
            );
            return;
        }

        if (qrType !== "PACKING" && qrType !== "UNPLANNED") {
            resetScan(
                "입고용 QR이 아닙니다.\n\n" +
                "현재 QR 구분: " + qrType + "\n" +
                "포장 입고 스캔에서는 PACKING 또는 UNPLANNED QR만 가능합니다.\n\n" +
                "스캔값:\n" + cleanText,
                "#dc3545"
            );
            return;
        }

        if (orderId !== currentOrderId) {
            resetScan(
                "잘못된 QR입니다.\n현재 포장 지시번호와 일치하지 않습니다.\n\n" +
                "현재 지시번호: " + currentOrderId + "\n" +
                "QR 지시번호: " + orderId + "\n\n" +
                "스캔값:\n" + cleanText,
                "#dc3545"
            );
            return;
        }

        if (qrType === "PACKING" && unitType !== "BOX" && unitType !== "EACH") {
            resetScan(
                "잘못된 QR입니다.\nPACKING QR은 BOX 또는 EACH 단위여야 합니다.\n\n" +
                "현재 단위: " + unitType + "\n\n" +
                "스캔값:\n" + cleanText,
                "#dc3545"
            );
            return;
        }

        if (qrType === "UNPLANNED" && !isUnplannedUnit(unitType)) {
            resetScan(
                "잘못된 무발주 QR입니다.\nUNPLANNED QR은 UNPLANNED_BOX 또는 UNPLANNED_EACH 단위여야 합니다.\n\n" +
                "현재 단위: " + unitType + "\n\n" +
                "스캔값:\n" + cleanText,
                "#dc3545"
            );
            return;
        }

        scannedText = cleanText;
        scannedQrType = qrType;

        if (qrType === "PACKING") {
            scannedDetailId = targetId;
            scannedUnplannedId = "";
        } else {
            scannedDetailId = "";
            scannedUnplannedId = targetId;
        }

        scannedUnitType = unitType;
        scannedUnitNo = unitNo;

        const unitLabel =
            unitType === "BOX" ? "박스" :
                unitType === "EACH" ? "낱개" :
                    unitType === "UNPLANNED_BOX" ? "무발주 박스" :
                        unitType === "UNPLANNED_EACH" ? "무발주 낱개" :
                            "무발주";

        const idLabel = qrType === "PACKING" ? "상세ID" : "무발주ID";

        showResult(
            "정상 입고 QR입니다.\n\n" +
            "QR구분: " + qrType + "\n" +
            idLabel + ": " + targetId + "\n" +
            "입고단위: " + unitLabel + "\n" +
            "단위번호: " + unitNo + "\n" +
            "상품종류: " + productType + "\n" +
            "모델/사이즈: " + modelName + "\n" +
            "색상: " + color + "\n" +
            "경도: " + hardness + "\n" +
            "입고수량: " + qty,
            "#1976d2"
        );

        document.getElementById("confirmArea").classList.remove("hidden");
    }

    function onScanFailure(error) {
        // 스캔 실패 로그는 화면에 표시하지 않습니다.
    }

    const html5QrcodeScanner = new Html5QrcodeScanner(
        "reader",
        {
            fps: 10,
            qrbox: {
                width: 250,
                height: 250
            }
        },
        false
    );

    html5QrcodeScanner.render(onScanSuccess, onScanFailure);

    function confirmInbound() {
        if (!scannedText || !scannedQrType) {
            alert("정상 입고 QR을 먼저 스캔해주세요.");
            return;
        }

        if (scannedQrType === "PACKING") {
            if (!scannedDetailId || !scannedUnitType || !scannedUnitNo) {
                alert("PACKING QR 정보가 부족합니다.");
                return;
            }
        }

        if (scannedQrType === "UNPLANNED") {
            if (!scannedUnplannedId || !scannedUnitType || !scannedUnitNo) {
                alert("무발주 QR 정보가 부족합니다.");
                return;
            }
        }

        if (!confirm("이 항목을 입고 스캔 완료 처리하시겠습니까?")) {
            return;
        }

        const form = document.createElement("form");
        form.method = "post";
        form.action = "${pageContext.request.contextPath}/logistics/inbound/${order.id}";

        const qrTypeInput = document.createElement("input");
        qrTypeInput.type = "hidden";
        qrTypeInput.name = "qrType";
        qrTypeInput.value = scannedQrType;
        form.appendChild(qrTypeInput);

        if (scannedQrType === "PACKING") {
            const detailInput = document.createElement("input");
            detailInput.type = "hidden";
            detailInput.name = "detailId";
            detailInput.value = scannedDetailId;
            form.appendChild(detailInput);
        }

        if (scannedQrType === "UNPLANNED") {
            const unplannedInput = document.createElement("input");
            unplannedInput.type = "hidden";
            unplannedInput.name = "unplannedId";
            unplannedInput.value = scannedUnplannedId;
            form.appendChild(unplannedInput);
        }

        const unitTypeInput = document.createElement("input");
        unitTypeInput.type = "hidden";
        unitTypeInput.name = "unitType";
        unitTypeInput.value = scannedUnitType;
        form.appendChild(unitTypeInput);

        const unitNoInput = document.createElement("input");
        unitNoInput.type = "hidden";
        unitNoInput.name = "unitNo";
        unitNoInput.value = scannedUnitNo;
        form.appendChild(unitNoInput);

        document.body.appendChild(form);
        form.submit();
    }
</script>

</body>
</html>
