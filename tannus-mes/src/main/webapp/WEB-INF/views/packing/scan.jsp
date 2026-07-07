<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PACKING QR 스캔</title>

    <script src="https://unpkg.com/html5-qrcode"></script>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --green: #16a34a;
            --red: #dc2626;
            --orange: #f59e0b;
            --gray: #334155;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
        }

        * {
            box-sizing: border-box;
        }

        html {
            -webkit-text-size-adjust: 100%;
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
            overflow-x: hidden;
        }

        .wrap {
            max-width: 1180px;
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
        .top-box a {
            position: relative;
            z-index: 1;
        }

        .top-box h1 {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            margin: 0;
            color: white;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.7px;
            line-height: 1.25;
        }

        .top-box h1:before {
            content: "📷 PACKING SCAN";
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

        .btn {
            text-decoration: none;
            border: none;
            background: var(--blue);
            color: white;
            padding: 10px 16px;
            border-radius: 13px;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover:not(:disabled) {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn.gray {
            background: rgba(255,255,255,0.94);
            color: var(--gray);
            border: 1px solid rgba(255,255,255,0.65);
        }

        .btn.red {
            background: var(--red);
            color: white;
            padding: 7px 11px;
            font-size: 12px;
            border-radius: 11px;
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
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

        .info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            background: #f8fbff;
            border: 1px solid #dbeafe;
            border-radius: 18px;
            padding: 16px;
            margin-bottom: 20px;
        }

        .info div {
            min-height: 50px;
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 12px 14px;
            font-size: 14px;
            font-weight: 800;
            color: #334155;
        }

        .info strong {
            display: block;
            color: var(--muted);
            font-size: 12px;
            font-weight: 900;
            margin-bottom: 5px;
        }

        h4 {
            margin: 0 0 14px;
            color: #0f172a;
            font-size: 20px;
            font-weight: 900;
            letter-spacing: -0.3px;
        }

        h4:before {
            content: "";
            display: inline-block;
            width: 6px;
            height: 19px;
            border-radius: 999px;
            background: var(--blue);
            margin-right: 9px;
            vertical-align: -4px;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid var(--line);
            border-radius: 18px;
            background: white;
            margin-bottom: 18px;
        }

        .table-wrap::-webkit-scrollbar {
            height: 8px;
        }

        .table-wrap::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .table-wrap::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        table {
            width: 100%;
            min-width: 980px;
            border-collapse: collapse;
        }

        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid #e5e7eb;
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

        tbody tr:hover {
            background: #f8fafc;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .product-cell {
            text-align: left;
            font-weight: 900;
            color: #0f172a;
            min-width: 260px;
        }

        .done,
        .waiting,
        .unplanned,
        .normal {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 78px;
            min-height: 29px;
            padding: 0 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            white-space: nowrap;
        }

        .done {
            background: #dcfce7;
            color: #15803d;
        }

        .waiting {
            background: #fef3c7;
            color: #92400e;
        }

        .unplanned {
            background: #fee2e2;
            color: #b91c1c;
        }

        .normal {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .notice {
            margin-top: 14px;
            padding: 14px 16px;
            border-radius: 16px;
            background: #fff7ed;
            border: 1px solid #fed7aa;
            color: #9a3412;
            font-size: 14px;
            line-height: 1.6;
            font-weight: 900;
        }

        .small-text {
            font-size: 12px;
            color: #64748b;
            margin-top: 5px;
            font-weight: 800;
        }

        hr {
            margin: 24px 0;
            border: none;
            border-top: 1px solid var(--line);
        }

        #reader {
            width: 100%;
            max-width: 520px;
            margin: 0 auto;
            overflow: hidden;
            border-radius: 18px;
        }

        #reader video {
            border-radius: 18px;
        }

        .result-box {
            margin-top: 20px;
            background: #f8fbff;
            border: 1px solid #dbeafe;
            border-radius: 18px;
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
            font-weight: 900;
            line-height: 1.6;
        }

        form {
            margin: 0;
        }

        @media (max-width: 900px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .top-box {
                flex-direction: column;
                align-items: flex-start;
                padding: 24px 22px;
            }

            .info {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 20px;
            }
        }

        @media (max-width: 560px) {
            .top-box h1 {
                font-size: 26px;
            }

            .top-box .btn {
                width: 100%;
            }

            .card {
                padding: 16px;
                border-radius: 20px;
            }

            th, td {
                padding: 11px 9px;
                font-size: 13px;
            }

            #reader {
                max-width: 100%;
            }

            .notice {
                font-size: 13px;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>PACKING QR 스캔</h1>

        <a href="${pageContext.request.contextPath}/packing/detail/${order.id}" class="btn gray">
            상세로
        </a>
    </div>

    <div class="card">

        <div class="info">
            <div><strong>포장 지시번호:</strong> ${order.id}</div>
            <div><strong>요청일:</strong> ${order.requestDate}</div>
            <div><strong>상태:</strong> 포장 스캔 진행중</div>
        </div>

        <h4>포장 BOX / EACH 스캔 현황</h4>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>상품명</th>
                    <th>구분</th>
                    <th>단위</th>
                    <th>번호</th>
                    <th>수량</th>
                    <th>스캔상태</th>
                    <th>관리</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${empty scanList}">
                        <tr>
                            <td colspan="7">생성된 스캔 단위가 없습니다.</td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="scan" items="${scanList}">
                            <c:set var="isUnplanned"
                                   value="${scan.scanType eq 'UNPLANNED_BOX' || scan.scanType eq 'UNPLANNED_EACH'}" />

                            <tr>
                                <td class="product-cell">
                                    <c:choose>
                                        <c:when test="${isUnplanned}">
                                            <c:forEach var="item" items="${unplannedPackingList}">
                                                <c:if test="${item.id eq scan.detailId}">
                                                    ${item.productType} / ${item.modelName} / ${item.color} / ${item.hardness}
                                                </c:if>
                                            </c:forEach>
                                        </c:when>

                                        <c:otherwise>
                                            <c:forEach var="detail" items="${order.detailList}">
                                                <c:if test="${detail.id eq scan.detailId}">
                                                    ${detail.productType} / ${detail.modelName} / ${detail.color} / ${detail.hardness}
                                                </c:if>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>

                                    <div class="small-text">
                                        <c:choose>
                                            <c:when test="${isUnplanned}">
                                                무발주번호: ${scan.detailId}
                                            </c:when>
                                            <c:otherwise>
                                                상세번호: ${scan.detailId}
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${isUnplanned}">
                                            <span class="unplanned">무발주</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="normal">정상지시</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${scan.scanType eq 'BOX' || scan.scanType eq 'UNPLANNED_BOX'}">
                                            BOX
                                        </c:when>
                                        <c:otherwise>
                                            EACH
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${scan.scanSeq}</td>
                                <td>${scan.qty} EA</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${scan.status eq 'DONE'}">
                                            <span class="done">스캔완료</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="waiting">스캔대기</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${scan.status eq 'DONE'}">
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/packing/cancel-scan/${order.id}"
                                                  onsubmit="return confirm('이 스캔을 취소하시겠습니까?');"
                                                  style="margin:0;">
                                                <input type="hidden" name="scanId" value="${scan.id}">
                                                <button type="submit" class="btn red">
                                                    취소
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            -
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

        <div class="notice">
            QR을 스캔하면 해당 BOX/EACH가 바로 스캔완료 처리됩니다.
            모든 항목을 스캔하면 자동으로 포장완료 상태로 넘어갑니다.
        </div>

        <hr>

        <div id="reader"></div>

        <div class="result-box">
            <div class="result-title">스캔 결과</div>
            <div id="qrResult">아직 스캔된 QR이 없습니다.</div>
        </div>

    </div>

</div>

<script>
    let lastScanText = "";
    let lastScanTime = 0;
    let submitting = false;

    function showResult(message, color) {
        const qrResult = document.getElementById("qrResult");
        qrResult.innerText = message;
        qrResult.style.color = color;
    }

    function onScanSuccess(decodedText) {
        const now = Date.now();

        if (submitting) {
            return;
        }

        if (decodedText === lastScanText && now - lastScanTime < 3000) {
            return;
        }

        lastScanText = decodedText;
        lastScanTime = now;

        const parts = decodedText.split("|");
        const currentOrderId = "${order.id}";

        if (
            parts.length < 6 ||
            (parts[0] !== "PACKING" && parts[0] !== "UNPLANNED") ||
            parts[1] !== currentOrderId
        ) {
            showResult(
                "잘못된 PACKING QR입니다.\n현재 포장 지시번호와 일치하지 않습니다.\n\n스캔값: " + decodedText,
                "#dc3545"
            );
            return;
        }

        const scannedDetailId = parts[2];
        const scanType = parts[3];
        const scanSeq = parts[4];
        const qty = parts[5];

        showResult(
            "정상 PACKING QR입니다.\n바로 스캔완료 처리합니다.\n\n" +
            "단위: " + scanType + "\n" +
            "번호: " + scanSeq + "\n" +
            "수량: " + qty + " EA",
            "#1976d2"
        );

        submitting = true;

        const form = document.createElement("form");
        form.method = "post";
        form.action = "${pageContext.request.contextPath}/packing/complete/${order.id}";

        const detailInput = document.createElement("input");
        detailInput.type = "hidden";
        detailInput.name = "detailId";
        detailInput.value = scannedDetailId;

        const scanTypeInput = document.createElement("input");
        scanTypeInput.type = "hidden";
        scanTypeInput.name = "scanType";
        scanTypeInput.value = scanType;

        const scanSeqInput = document.createElement("input");
        scanSeqInput.type = "hidden";
        scanSeqInput.name = "scanSeq";
        scanSeqInput.value = scanSeq;

        form.appendChild(detailInput);
        form.appendChild(scanTypeInput);
        form.appendChild(scanSeqInput);

        document.body.appendChild(form);
        form.submit();
    }

    function onScanFailure(error) {
        // 무시
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
</script>

</body>
</html>