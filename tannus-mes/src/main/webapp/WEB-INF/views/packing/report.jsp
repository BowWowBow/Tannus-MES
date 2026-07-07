<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장내역 A4 출력</title>

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

        .page {
            width: 210mm;
            min-height: 297mm;
            margin: 0 auto 20px;
            padding: 12mm;
            background: white;
            box-shadow: 0 18px 42px rgba(15,23,42,0.14);
        }

        .top {
            display: flex;
            justify-content: space-between;
            border-bottom: 3px solid #1d4ed8;
            padding-bottom: 8mm;
            margin-bottom: 8mm;
        }

        h1 {
            margin: 0;
            font-size: 27px;
            font-weight: 900;
            letter-spacing: -0.6px;
            color: #0f172a;
        }

        .sub {
            margin-top: 7px;
            font-size: 12px;
            color: #64748b;
            font-weight: 700;
        }

        .system {
            text-align: right;
            font-size: 11px;
            color: #334155;
            line-height: 1.5;
            font-weight: 900;
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            border-radius: 10px;
            padding: 8px 10px;
            height: fit-content;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 6px;
            margin-bottom: 8mm;
        }

        .info-box {
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            padding: 8px;
            background: #f8fafc;
        }

        .label {
            display: block;
            font-size: 10px;
            color: #64748b;
            margin-bottom: 4px;
            font-weight: 800;
        }

        .value {
            font-size: 13px;
            font-weight: 900;
            color: #0f172a;
        }

        .section-title {
            margin: 0 0 4mm;
            font-size: 17px;
            color: #1d4ed8;
            font-weight: 900;
        }

        .section-title:before {
            content: "";
            display: inline-block;
            width: 5px;
            height: 15px;
            border-radius: 999px;
            background: #2563eb;
            margin-right: 7px;
            vertical-align: -2px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 8mm;
        }

        th, td {
            border: 1px solid #cbd5e1;
            padding: 7px 6px;
            font-size: 11px;
            text-align: center;
            color: #0f172a;
        }

        th {
            background: #f1f5f9;
            font-weight: 900;
        }

        .left { text-align: left; }

        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 999px;
            color: white;
            font-size: 10px;
            font-weight: 900;
        }

        .normal { background: #2563eb; }
        .unplanned { background: #dc2626; }
        .done { background: #16a34a; }
        .waiting { background: #64748b; }

        .empty {
            border: 1px dashed #cbd5e1;
            border-radius: 10px;
            padding: 18px;
            color: #777;
            text-align: center;
            margin-bottom: 8mm;
            background: #f8fafc;
            font-weight: 700;
        }

        .memo-box {
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            min-height: 32mm;
            padding: 10px;
            margin-bottom: 8mm;
            font-size: 12px;
            background: #f8fafc;
        }

        .sign-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 8px;
            margin-top: 8mm;
        }

        .sign-box {
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            height: 24mm;
            padding: 8px;
            font-size: 12px;
        }

        .sign-title {
            font-weight: 900;
            color: #334155;
        }



        /* ===== 화면용 반응형 보강 / 인쇄 레이아웃은 유지 ===== */
        @media screen and (max-width: 900px) {
            body {
                overflow-x: hidden;
            }

            .print-actions {
                width: auto;
                margin: 12px 12px;
                justify-content: stretch;
            }

            .print-actions .btn {
                flex: 1;
                min-height: 42px;
            }

            .page {
                width: calc(100% - 24px);
                min-height: auto;
                margin: 0 12px 18px;
                padding: 18px;
                border-radius: 16px;
                overflow: hidden;
            }

            .top {
                flex-direction: column;
                gap: 12px;
                padding-bottom: 18px;
                margin-bottom: 18px;
            }

            .system {
                width: 100%;
                text-align: left;
            }

            h1 {
                font-size: 24px;
            }

            .info-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 8px;
                margin-bottom: 22px;
            }

            table {
                display: block;
                width: 100%;
                overflow-x: auto;
                white-space: nowrap;
                -webkit-overflow-scrolling: touch;
                border: 1px solid #cbd5e1;
                border-radius: 10px;
            }

            thead, tbody, tr {
                width: max-content;
            }

            th, td {
                padding: 8px 7px;
            }

            .memo-box {
                min-height: 90px;
            }

            .sign-grid {
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .sign-box {
                height: 70px;
            }
        }

        @media screen and (max-width: 520px) {
            .page {
                width: calc(100% - 16px);
                margin: 0 8px 14px;
                padding: 14px;
                border-radius: 14px;
            }

            .print-actions {
                margin: 10px 8px;
                flex-direction: column;
            }

            h1 {
                font-size: 21px;
            }

            .sub {
                font-size: 11px;
                line-height: 1.5;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .section-title {
                font-size: 15px;
            }

            .btn {
                width: 100%;
                min-height: 42px;
            }
        }

        @page {
            size: A4 portrait;
            margin: 8mm;
        }

        @media print {
            body { background: white; }

            .print-actions { display: none; }

            .page {
                width: auto;
                min-height: auto;
                margin: 0;
                padding: 0;
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
        <div>
            <h1>포장내역 확인서</h1>
            <div class="sub">정상 포장 상품 + 승인완료 무발주 상품 포함</div>
        </div>

        <div class="system">
            TANNUS MES<br>
            PACKING REPORT<br>
            A4 DOCUMENT
        </div>
    </div>

    <div class="info-grid">
        <div class="info-box">
            <span class="label">포장 지시번호</span>
            <span class="value">${order.id}</span>
        </div>

        <div class="info-box">
            <span class="label">요청일</span>
            <span class="value">${order.requestDate}</span>
        </div>

        <div class="info-box">
            <span class="label">지시자</span>
            <span class="value">
                <c:choose>
                    <c:when test="${empty order.requestedBy}">-</c:when>
                    <c:otherwise>${order.requestedBy}</c:otherwise>
                </c:choose>
            </span>
        </div>

        <div class="info-box">
            <span class="label">상태</span>
            <span class="value">
                <c:choose>
                    <c:when test="${order.status eq 'REQUESTED'}">포장대기</c:when>
                    <c:when test="${order.status eq 'READY_TO_SHIP'}">포장완료</c:when>
                    <c:when test="${order.status eq 'SHIPPED'}">출고완료</c:when>
                    <c:when test="${order.status eq 'RECEIVED'}">입고완료</c:when>
                    <c:otherwise>${order.status}</c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <h2 class="section-title">1. 정상 포장 상품</h2>

    <c:choose>
        <c:when test="${empty order.detailList}">
            <div class="empty">정상 포장 상품이 없습니다.</div>
        </c:when>

        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>구분</th>
                    <th>상품종류</th>
                    <th>모델/사이즈</th>
                    <th>색상</th>
                    <th>경도</th>
                    <th>기본수량</th>
                    <th>박스수</th>
                    <th>낱개</th>
                    <th>총수량</th>
                    <th>스캔상태</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="detail" items="${order.detailList}">
                    <tr>
                        <td><span class="badge normal">정상</span></td>
                        <td>${detail.productType}</td>
                        <td>${detail.modelName}</td>
                        <td>${detail.color}</td>
                        <td>${detail.hardness}</td>
                        <td>${detail.baseQty}</td>
                        <td>${detail.boxCount}</td>
                        <td>${detail.eachQty}</td>
                        <td>${detail.totalQty} EA</td>
                        <td>
                            <c:choose>
                                <c:when test="${detail.packingScanStatus eq 'DONE'}">
                                    <span class="badge done">완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge waiting">대기</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <h2 class="section-title">2. 무발주 포장 상품</h2>

    <c:choose>
        <c:when test="${empty unplannedPackingList}">
            <div class="empty">무발주 포장 상품이 없습니다.</div>
        </c:when>

        <c:otherwise>
            <table>
                <thead>
                <tr>
                    <th>구분</th>
                    <th>상품종류</th>
                    <th>모델/사이즈</th>
                    <th>색상</th>
                    <th>경도</th>
                    <th>기본수량</th>
                    <th>박스수</th>
                    <th>낱개</th>
                    <th>총수량</th>
                    <th>승인상태</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach var="item" items="${unplannedPackingList}">
                    <c:if test="${item.status eq 'APPROVED'}">
                        <tr>
                            <td><span class="badge unplanned">무발주</span></td>
                            <td>${item.productType}</td>
                            <td>${item.modelName}</td>
                            <td>${item.color}</td>
                            <td>${item.hardness}</td>
                            <td>${item.baseQty}</td>
                            <td>${item.boxCount}</td>
                            <td>${item.eachQty}</td>
                            <td>${item.totalQty} EA</td>
                            <td><span class="badge done">승인완료</span></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>

    <h2 class="section-title">3. 비고 / 확인사항</h2>

    <div class="memo-box">
        <c:choose>
            <c:when test="${empty order.remark}">
                -
            </c:when>
            <c:otherwise>
                ${order.remark}
            </c:otherwise>
        </c:choose>
    </div>

    <div class="sign-grid">
        <div class="sign-box">
            <div class="sign-title">포장 담당자</div>
        </div>

        <div class="sign-box">
            <div class="sign-title">검수자</div>
        </div>

        <div class="sign-box">
            <div class="sign-title">확인자</div>
        </div>
    </div>

</div>

<script>
    window.addEventListener("load", function () {
        setTimeout(function () {
            window.print();
        }, 300);
    });
</script>

</body>
</html>