<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EXPORT QR 스캔</title>

    <script src="https://unpkg.com/html5-qrcode"></script>

    <style>
        :root {
            --blue: #1565c0;
            --blue-dark: #0d47a1;
            --blue-soft: #eef5ff;
            --purple: #6f42c1;
            --red: #dc3545;
            --green: #2e7d32;
            --orange: #f57c00;
            --gray: #6c757d;
            --bg: #f4f6f9;
            --text: #1f2937;
            --muted: #64748b;
            --line: #e5e7eb;
            --shadow: 0 12px 28px rgba(15, 23, 42, 0.10);
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
                    radial-gradient(circle at 10% 10%, rgba(21, 101, 192, 0.14), transparent 30%),
                    radial-gradient(circle at 90% 0%, rgba(111, 66, 193, 0.10), transparent 28%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            width: 100%;
            max-width: 1120px;
            margin: 0 auto;
            padding: 34px 20px 50px;
        }

        .top-box {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            margin-bottom: 22px;
            padding: 26px 28px;
            border-radius: 24px;
            color: white;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255, 255, 255, 0.34), transparent 30%),
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
            background: rgba(255, 255, 255, 0.14);
        }

        .top-box h1,
        .top-box .btn {
            position: relative;
            z-index: 1;
        }

        .top-box h1 {
            margin: 0;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.7px;
            color: white;
        }

        .top-box h1:before {
            content: "📦 EXPORT SCAN";
            display: inline-flex;
            align-items: center;
            margin-bottom: 10px;
            padding: 7px 12px;
            border-radius: 999px;
            background: rgba(255, 255, 255, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.22);
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 0.5px;
            color: white;
        }

        .top-box h1 {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        .btn {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            min-height: 38px;
            padding: 0 15px;
            text-decoration: none;
            border: none;
            border-radius: 12px;
            background: var(--blue);
            color: white;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover:not(:disabled) {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15, 23, 42, 0.15);
        }

        .btn.gray {
            background: rgba(255, 255, 255, 0.94);
            color: var(--blue-dark);
            border: 1px solid rgba(255, 255, 255, 0.65);
        }

        .btn.red {
            min-height: 32px;
            padding: 0 12px;
            background: var(--red);
            font-size: 13px;
        }

        .card {
            overflow: hidden;
            margin-bottom: 20px;
            padding: 24px;
            border: 1px solid rgba(226, 232, 240, 0.95);
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.97);
            box-shadow: var(--shadow);
        }

        .info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
            margin-bottom: 22px;
            padding: 16px;
            border: 1px solid #c9def8;
            border-radius: 16px;
            background: var(--blue-soft);
        }

        .info div {
            min-height: 42px;
            display: flex;
            align-items: center;
            padding: 10px 12px;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.72);
            color: #334155;
            font-size: 14px;
            font-weight: 800;
            word-break: keep-all;
        }

        .info strong {
            margin-right: 6px;
            color: var(--blue-dark);
            white-space: nowrap;
        }

        h4 {
            margin: 0 0 12px;
            font-size: 19px;
            font-weight: 900;
            color: #0f172a;
        }

        .table-scroll {
            width: 100%;
            overflow-x: auto;
            border: 1px solid var(--line);
            border-radius: 18px;
            background: white;
        }

        table {
            width: 100%;
            min-width: 920px;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 12px 10px;
            border-bottom: 1px solid var(--line);
            text-align: center;
            font-size: 14px;
            vertical-align: middle;
        }

        th {
            background: #f8fafc;
            color: #334155;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            color: #475569;
            font-weight: 700;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .done {
            color: var(--green);
            font-weight: 900;
        }

        .waiting {
            color: var(--orange);
            font-weight: 900;
        }

        .unit-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 72px;
            height: 28px;
            padding: 0 10px;
            border-radius: 999px;
            background: var(--blue);
            color: white;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .unit-badge.each {
            background: var(--purple);
        }

        .unit-badge.unplanned {
            background: #0d6efd;
        }

        .notice {
            margin-top: 16px;
            padding: 13px 15px;
            border: 1px solid #ffe082;
            border-radius: 14px;
            background: #fff8e1;
            color: #6d4c00;
            font-size: 14px;
            font-weight: 900;
            line-height: 1.5;
        }

        hr {
            margin: 22px 0;
            border: none;
            border-top: 1px solid #e2e8f0;
        }

        .scanner-box {
            display: grid;
            grid-template-columns: minmax(280px, 520px) 1fr;
            gap: 18px;
            align-items: start;
        }

        #reader {
            width: 100%;
            max-width: 520px;
            margin: 0 auto;
            overflow: hidden;
            border: 1px solid #dbe9f6;
            border-radius: 18px;
            background: white;
        }

        #reader video {
            border-radius: 14px;
        }

        .result-box {
            min-height: 220px;
            padding: 18px;
            border: 1px solid #dbe9f6;
            border-radius: 18px;
            background: #f8fbff;
        }

        .result-title {
            margin-bottom: 10px;
            color: #222;
            font-size: 16px;
            font-weight: 900;
        }

        #qrResult {
            min-height: 92px;
            white-space: pre-line;
            word-break: break-all;
            color: #1976d2;
            font-weight: 900;
            line-height: 1.65;
            font-size: 14px;
        }

        .btn-row {
            margin-top: 18px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .hidden {
            display: none;
        }

        .empty-row {
            height: 80px;
            color: #94a3b8;
            font-weight: 900;
        }

        @media (max-width: 900px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .top-box {
                padding: 24px 22px;
            }

            .info {
                grid-template-columns: 1fr;
            }

            .scanner-box {
                grid-template-columns: 1fr;
            }

            #reader {
                max-width: 100%;
            }
        }

        @media (max-width: 640px) {
            .top-box {
                flex-direction: column;
                align-items: flex-start;
                border-radius: 20px;
            }

            .top-box h1 {
                font-size: 25px;
            }

            .top-box .btn {
                width: 100%;
            }

            .card {
                padding: 16px;
                border-radius: 20px;
            }

            .table-scroll {
                overflow: visible;
                border: none;
                background: transparent;
            }

            table,
            thead,
            tbody,
            tr,
            th,
            td {
                display: block;
                width: 100%;
            }

            table {
                min-width: 0;
                background: transparent;
            }

            thead {
                display: none;
            }

            tbody tr {
                margin-bottom: 14px;
                overflow: hidden;
                border: 1px solid #e2e8f0;
                border-radius: 18px;
                background: white;
                box-shadow: 0 10px 24px rgba(15, 23, 42, 0.08);
            }

            tbody tr:hover {
                background: white;
            }

            td {
                position: relative;
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 12px;
                min-height: 46px;
                padding: 12px 14px;
                border-bottom: 1px solid #eef2f7;
                text-align: right;
                font-size: 13px;
            }

            td:last-child {
                border-bottom: none;
            }

            td:before {
                content: attr(data-label);
                flex: 0 0 auto;
                color: #64748b;
                font-weight: 900;
                text-align: left;
                white-space: nowrap;
            }

            td form,
            td .btn.red {
                width: auto;
            }

            .empty-row {
                display: block;
                height: auto;
                padding: 28px 14px;
                text-align: center;
            }

            .empty-row:before {
                display: none;
            }

            .info div {
                align-items: flex-start;
                flex-direction: column;
                gap: 4px;
            }

            .info strong {
                margin-right: 0;
            }

            .notice,
            #qrResult {
                font-size: 13px;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>EXPORT QR 스캔</h1>

        <a href="${pageContext.request.contextPath}/logistics/export/detail/${order.id}" class="btn gray">
            상세로
        </a>
    </div>

    <div class="card">

        <div class="info">
            <div><strong>수출 지시번호:</strong> ${order.id}</div>
            <div><strong>출고 요청일:</strong> ${order.requestDate}</div>
            <div><strong>상태:</strong> 출고준비</div>
        </div>

        <h4>출고 품목 스캔 현황</h4>

        <div class="table-scroll">
            <table>
                <thead>
                <tr>
                    <th>스캔ID</th>
                    <th>상세ID</th>
                    <th>단위</th>
                    <th>단위번호</th>
                    <th>수량</th>
                    <th>스캔상태</th>
                    <th>스캔일시</th>
                    <th>작업</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="scan" items="${exportScanList}">
                    <tr>
                        <td data-label="스캔ID">${scan.id}</td>
                        <td data-label="상세ID">${scan.detailId}</td>
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
                        <td data-label="단위번호">${scan.unitNo}</td>
                        <td data-label="수량">${scan.qty} EA</td>
                        <td data-label="스캔상태">
                            <c:choose>
                                <c:when test="${scan.scanStatus eq 'DONE'}">
                                    <span class="done">스캔완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="waiting">스캔대기</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="스캔일시">
                            <c:choose>
                                <c:when test="${empty scan.scannedAt}">-</c:when>
                                <c:otherwise>${scan.scannedAt}</c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="작업">
                            <c:if test="${scan.scanStatus eq 'DONE'}">
                                <form method="post"
                                      action="${pageContext.request.contextPath}/logistics/export/cancel-scan/${order.id}"
                                      onsubmit="return confirm('이 스캔을 취소하시겠습니까?');"
                                      style="margin:0;">
                                    <input type="hidden" name="scanId" value="${scan.id}">
                                    <button type="submit" class="btn red">취소</button>
                                </form>
                            </c:if>

                            <c:if test="${scan.scanStatus ne 'DONE'}">
                                -
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty exportScanList}">
                    <tr>
                        <td colspan="8" class="empty-row">생성된 출고 스캔 항목이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="notice">
            QR은 BOX / EACH / 무발주 단위로 각각 스캔됩니다.
        </div>

        <hr>

        <div class="scanner-box">
            <div id="reader"></div>

            <div class="result-box">
                <div class="result-title">스캔 결과</div>
                <div id="qrResult">아직 스캔된 QR이 없습니다.</div>

                <div id="confirmArea" class="btn-row hidden">
                    <button type="button" class="btn" onclick="confirmExport()">
                        이 항목 출고 확인
                    </button>
                </div>
            </div>
        </div>

    </div>

</div>

<script>
    let scannedText = "";
    let scannedQrType = "";
    let scannedDetailId = "";
    let scannedUnitType = "";
    let scannedUnitNo = "";

    let lastScanText = "";
    let lastScanTime = 0;

    function resetScannedData() {
        scannedText = "";
        scannedQrType = "";
        scannedDetailId = "";
        scannedUnitType = "";
        scannedUnitNo = "";
    }

    function hideConfirm() {
        document.getElementById("confirmArea").classList.add("hidden");
    }

    function showResult(message, color) {
        const qrResult = document.getElementById("qrResult");
        qrResult.innerText = message;
        qrResult.style.color = color;
    }

    function normalizeQrText(decodedText) {
        return decodedText
            .trim()
            .replaceAll("｜", "|")
            .replaceAll("ㅣ", "|")
            .replaceAll("Ｉ", "|");
    }

    function onScanSuccess(decodedText) {
        const now = Date.now();
        const cleanText = normalizeQrText(decodedText);

        if (cleanText === lastScanText && now - lastScanTime < 2000) {
            return;
        }

        lastScanText = cleanText;
        lastScanTime = now;

        const parts = cleanText.split("|");
        const currentOrderId = "${order.id}";

        let qrType = "";
        let orderId = "";
        let detailId = "";
        let unitType = "";
        let unitNo = "";
        let productType = "";
        let modelName = "";
        let color = "";
        let hardness = "";
        let qty = "";

        /*
            일반 수출 QR:
            EXPORT|수출지시번호|상세ID|BOX|1|상품종류|모델|색상|경도|수량
            EXPORT|수출지시번호|상세ID|EACH|1|상품종류|모델|색상|경도|수량

            무발주 수출 QR:
            UNPLANNED_EXPORT|수출지시번호|무발주ID|상품종류|모델|색상|경도|수량
        */

        if (parts.length >= 10 && parts[0] === "EXPORT") {
            qrType = parts[0];
            orderId = parts[1];
            detailId = parts[2];
            unitType = parts[3];
            unitNo = parts[4];
            productType = parts[5];
            modelName = parts[6];
            color = parts[7];
            hardness = parts[8];
            qty = parts[9];

            if (unitType !== "BOX" && unitType !== "EACH") {
                resetScannedData();

                showResult(
                    "잘못된 EXPORT QR입니다.\n" +
                    "BOX 또는 EACH 단위 QR이 아닙니다.\n\n" +
                    "현재 읽힌 단위값: " + unitType + "\n\n" +
                    "스캔값:\n" + cleanText,
                    "#dc3545"
                );

                hideConfirm();
                return;
            }

        } else if (parts.length >= 8 && parts[0] === "UNPLANNED_EXPORT") {
            qrType = parts[0];
            orderId = parts[1];
            detailId = parts[2];
            unitType = "UNPLANNED";
            unitNo = "1";
            productType = parts[3];
            modelName = parts[4];
            color = parts[5];
            hardness = parts[6];
            qty = parts[7];

        } else {
            resetScannedData();

            let extraMessage = "";

            if (cleanText.startsWith("TYPE=")) {
                extraMessage =
                    "\n\n현재 QR은 기존 포장용/일반 QR 형식입니다.\n" +
                    "수출 출고 스캔에는 사용할 수 없습니다.\n" +
                    "수출 QR 출력 화면에서 새로 출력한 EXPORT QR을 찍어야 합니다.";
            }

            showResult(
                "잘못된 EXPORT QR입니다.\n" +
                "현재는 일반 수출 QR 또는 무발주 수출 QR만 처리할 수 있습니다.\n\n" +
                "필요 형식 1:\n" +
                "EXPORT|수출지시번호|상세ID|BOX|1|상품|모델|색상|경도|수량\n\n" +
                "필요 형식 2:\n" +
                "UNPLANNED_EXPORT|수출지시번호|무발주ID|상품|모델|색상|경도|수량\n\n" +
                "현재 분리 개수: " + parts.length + "개" +
                extraMessage +
                "\n\n스캔값:\n" + cleanText,
                "#dc3545"
            );

            hideConfirm();
            return;
        }

        if (orderId !== currentOrderId) {
            resetScannedData();

            showResult(
                "잘못된 EXPORT QR입니다.\n" +
                "현재 수출 지시번호와 일치하지 않습니다.\n\n" +
                "현재 지시번호: " + currentOrderId + "\n" +
                "QR 지시번호: " + orderId + "\n\n" +
                "스캔값:\n" + cleanText,
                "#dc3545"
            );

            hideConfirm();
            return;
        }

        scannedText = cleanText;
        scannedQrType = qrType;
        scannedDetailId = detailId;
        scannedUnitType = unitType;
        scannedUnitNo = unitNo;

        const unitLabel =
            unitType === "BOX" ? "박스" :
                unitType === "EACH" ? "낱개" :
                    "무발주";

        showResult(
            "정상 EXPORT QR입니다.\n\n" +
            "QR구분: " + qrType + "\n" +
            "상세/무발주ID: " + detailId + "\n" +
            "출고단위: " + unitLabel + "\n" +
            "단위번호: " + unitNo + "\n" +
            "상품종류: " + productType + "\n" +
            "모델/사이즈: " + modelName + "\n" +
            "색상: " + color + "\n" +
            "경도: " + hardness + "\n" +
            "출고수량: " + qty,
            "#1976d2"
        );

        document.getElementById("confirmArea").classList.remove("hidden");
    }

    function onScanFailure(error) {
        // 스캔 실패는 계속 발생하므로 화면에 표시하지 않음
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

    function confirmExport() {
        if (!scannedText || !scannedDetailId || !scannedUnitType || !scannedUnitNo) {
            alert("정상 EXPORT QR을 먼저 스캔해주세요.");
            return;
        }

        if (!confirm("이 항목만 출고 확인 처리하시겠습니까?")) {
            return;
        }

        const form = document.createElement("form");
        form.method = "post";
        form.action = "${pageContext.request.contextPath}/logistics/export/complete/${order.id}";

        const detailInput = document.createElement("input");
        detailInput.type = "hidden";
        detailInput.name = "detailId";
        detailInput.value = scannedDetailId;
        form.appendChild(detailInput);

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
