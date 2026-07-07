<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 지시 상세</title>

    <style>
        * {
            box-sizing: border-box;
        }

        html {
            width: 100%;
            overflow-x: hidden;
            -webkit-text-size-adjust: 100%;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", sans-serif;
            background:
                    radial-gradient(circle at 15% 5%, rgba(14, 165, 233, 0.18), transparent 32%),
                    radial-gradient(circle at 88% 8%, rgba(16, 185, 129, 0.14), transparent 34%),
                    linear-gradient(135deg, #f8fafc 0%, #eef6ff 48%, #f8fafc 100%);
            color: #0f172a;
        }

        .wrap {
            width: 100%;
            max-width: 1220px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .hero {
            position: relative;
            overflow: hidden;
            border-radius: 26px;
            padding: 28px 30px;
            margin-bottom: 22px;
            background:
                    radial-gradient(circle at 92% 0%, #d1fae5 0%, transparent 35%),
                    linear-gradient(135deg, #ffffff 0%, #ecfdf5 100%);
            border: 1px solid rgba(148, 163, 184, 0.28);
            box-shadow: 0 20px 48px rgba(15, 23, 42, 0.10);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
        }

        .hero:before {
            content: "";
            position: absolute;
            right: -76px;
            top: -92px;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: #1b8a4b;
            opacity: 0.08;
        }

        .hero-text {
            position: relative;
            min-width: 0;
        }

        .hero-badge {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 7px 12px;
            border-radius: 999px;
            background: rgba(255,255,255,0.72);
            color: #1b8a4b;
            font-size: 12px;
            font-weight: 900;
            box-shadow: inset 0 0 0 1px rgba(148, 163, 184, 0.18);
            margin-bottom: 10px;
        }

        .hero h1 {
            margin: 0;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.8px;
            color: #1b8a4b;
        }

        .hero p {
            margin: 9px 0 0;
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .btn-group {
            position: relative;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .btn {
            min-height: 44px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            border-radius: 13px;
            padding: 11px 17px;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            color: white;
            background: linear-gradient(135deg, #1b8a4b, #10b981);
            box-shadow: 0 12px 22px rgba(15, 23, 42, 0.14);
            transition: transform 0.16s ease, box-shadow 0.16s ease, opacity 0.16s ease;
        }

        .btn.gray {
            background: #475569;
        }

        .btn:hover {
            transform: translateY(-1px);
            opacity: 0.95;
            box-shadow: 0 16px 26px rgba(15, 23, 42, 0.18);
        }

        .card {
            width: 100%;
            background: rgba(255,255,255,0.95);
            border: 1px solid rgba(226, 232, 240, 0.94);
            border-radius: 24px;
            padding: 24px;
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.08);
            margin-bottom: 20px;
        }

        .summary-card {
            padding: 0;
            overflow: hidden;
        }

        .summary-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding: 22px 24px;
            border-bottom: 1px solid #e2e8f0;
            background: linear-gradient(135deg, #ffffff, #ecfdf5);
        }

        .summary-title {
            margin: 0;
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
        }

        .summary-sub {
            margin-top: 5px;
            font-size: 13px;
            color: #64748b;
        }

        .summary-body {
            padding: 22px 24px 24px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }

        .info-box {
            position: relative;
            overflow: hidden;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 16px 17px;
        }

        .info-box:before {
            content: "";
            position: absolute;
            left: 0;
            top: 0;
            width: 5px;
            height: 100%;
            background: #1b8a4b;
            opacity: 0.76;
        }

        .info-label {
            display: block;
            font-size: 12px;
            font-weight: 800;
            color: #64748b;
            margin-bottom: 7px;
        }

        .info-value {
            display: block;
            max-width: 100%;
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
            word-break: break-all;
        }

        .remark-box {
            margin-top: 15px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 16px 18px;
        }

        .remark-title {
            font-size: 12px;
            font-weight: 900;
            color: #64748b;
            margin-bottom: 7px;
        }

        .remark-value {
            font-size: 15px;
            color: #1e293b;
            line-height: 1.6;
            min-height: 24px;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 84px;
            height: 30px;
            padding: 0 13px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            line-height: 1;
            white-space: nowrap;
        }

        .status-waiting {
            background: #64748b;
            color: white;
        }

        .status-ready {
            background: #fef3c7;
            color: #92400e;
        }

        .status-shipped {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-done {
            background: #dcfce7;
            color: #166534;
        }

        .status-cancelled {
            background: #fee2e2;
            color: #991b1b;
        }

        .status-etc {
            background: #111827;
            color: white;
        }

        .section-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            gap: 12px;
            margin-bottom: 16px;
        }

        .section-title {
            margin: 0;
            color: #0f172a;
            font-size: 20px;
            font-weight: 900;
            letter-spacing: -0.4px;
        }

        .section-desc {
            margin-top: 5px;
            color: #64748b;
            font-size: 13px;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            background: #ffffff;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 880px;
        }

        thead {
            background: #f1f5f9;
        }

        th, td {
            padding: 15px 12px;
            border-bottom: 1px solid #e5e7eb;
            text-align: center;
            font-size: 14px;
        }

        th {
            color: #334155;
            font-weight: 900;
            white-space: nowrap;
        }

        td {
            color: #475569;
            vertical-align: middle;
        }

        tbody tr:hover td {
            background: #f8fafc;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .empty {
            text-align: center;
            padding: 46px 0;
            color: #94a3b8;
            font-size: 14px;
            font-weight: 800;
        }

        .qty {
            font-weight: 900;
            color: #0f172a;
        }

        @media (max-width: 1100px) {
            .info-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            table {
                min-width: 820px;
            }
        }

        @media (max-width: 900px) {
            .hero {
                align-items: flex-start;
                flex-direction: column;
            }

            .btn-group {
                justify-content: flex-start;
            }

            .info-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 560px) {
            body {
                background:
                        radial-gradient(circle at 20% 0%, rgba(14, 165, 233, 0.16), transparent 32%),
                        linear-gradient(180deg, #f8fafc 0%, #eef6ff 100%);
            }

            .wrap {
                padding: 22px 14px 40px;
            }

            .hero {
                padding: 22px 18px;
                border-radius: 22px;
                margin-bottom: 16px;
            }

            .hero h1 {
                font-size: 25px;
                line-height: 1.25;
            }

            .hero p {
                font-size: 13px;
            }

            .btn-group {
                width: 100%;
                display: grid;
                grid-template-columns: 1fr;
                gap: 9px;
            }

            .btn {
                width: 100%;
                padding: 11px 12px;
            }

            .card {
                padding: 17px;
                border-radius: 20px;
            }

            .summary-head,
            .summary-body {
                padding: 18px;
            }

            .section-head {
                align-items: flex-start;
                flex-direction: column;
                gap: 6px;
            }

            .section-title {
                font-size: 18px;
            }

            .section-desc {
                font-size: 12px;
                line-height: 1.5;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 10px;
            }

            .info-box {
                padding: 14px 15px;
                border-radius: 16px;
            }

            .info-value {
                font-size: 16px;
            }

            .remark-box {
                padding: 14px 15px;
                border-radius: 16px;
            }

            table {
                min-width: 760px;
            }

            th, td {
                padding: 12px 10px;
                font-size: 13px;
            }

            .empty {
                padding: 36px 0;
            }
        }

        @media (max-width: 380px) {
            .wrap {
                padding: 16px 10px 30px;
            }

            .hero {
                padding: 20px 16px;
            }

            .hero h1 {
                font-size: 23px;
            }

            .card {
                padding: 14px;
            }

            .summary-head,
            .summary-body {
                padding: 16px;
            }

            .hero-badge {
                font-size: 11px;
            }
        }
    </style>
</head>

<body>
<div class="wrap">

    <div class="hero">
        <div class="hero-text">
            <div class="hero-badge">EXPORT DETAIL</div>
            <h1>수출 지시 상세</h1>
            <p>지시 기본 정보, 상품 상세 항목, 무발주 요청 내역을 한 화면에서 확인합니다.</p>
        </div>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/admin/export/list" class="btn gray">
                목록으로
            </a>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn gray">
                대시보드
            </a>
        </div>
    </div>

    <div class="card summary-card">
        <div class="summary-head">
            <div>
                <h2 class="summary-title">지시 기본 정보</h2>
                <div class="summary-sub">요청일, 지시자, 현재 처리 상태를 확인합니다.</div>
            </div>
        </div>

        <div class="summary-body">
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
                    <span class="info-value">${order.workerName}</span>
                </div>

                <div class="info-box">
                    <span class="info-label">상태</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${order.status eq 'WAITING'}">
                                <span class="status status-waiting">출고대기</span>
                            </c:when>
                            <c:when test="${order.status eq 'READY_TO_SHIP'}">
                                <span class="status status-ready">출고준비</span>
                            </c:when>
                            <c:when test="${order.status eq 'READY_DONE'}">
                                <span class="status status-shipped">준비완료</span>
                            </c:when>
                            <c:when test="${order.status eq 'DONE'}">
                                <span class="status status-done">출고완료</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status status-etc">${order.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>

            </div>

            <div class="remark-box">
                <div class="remark-title">비고</div>
                <div class="remark-value">
                    <c:choose>
                        <c:when test="${empty order.remark}">-</c:when>
                        <c:otherwise>${order.remark}</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="section-head">
            <div>
                <h2 class="section-title">상품 상세 목록</h2>
                <div class="section-desc">지시에 포함된 상품별 수량 정보를 확인합니다.</div>
            </div>
        </div>

        <div class="table-wrap">
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
                            <td colspan="8" class="empty">상세 항목이 없습니다.</td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="detail" items="${order.detailList}">
                            <tr>
                                <td>${detail.type}</td>
                                <td>${detail.model}</td>
                                <td>${detail.color}</td>
                                <td>${detail.hardness}</td>
                                <td class="qty">${detail.baseQty}</td>
                                <td class="qty">${detail.boxCount}</td>
                                <td class="qty">${detail.eachQty}</td>
                                <td class="qty">${detail.totalQty}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <div class="card">
        <div class="section-head">
            <div>
                <h2 class="section-title">무발주 수출 목록</h2>
                <div class="section-desc">정규 지시 외 추가로 등록된 무발주 요청 내역입니다.</div>
            </div>
        </div>

        <div class="table-wrap">
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
                    <th>상태</th>
                </tr>
                </thead>

                <tbody>
                <c:choose>
                    <c:when test="${empty unplannedExportList}">
                        <tr>
                            <td colspan="10" class="empty">무발주 수출 항목이 없습니다.</td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="item" items="${unplannedExportList}">
                            <tr>
                                <td>${item.productType}</td>
                                <td>${item.modelName}</td>
                                <td>${item.color}</td>
                                <td>${item.hardness}</td>
                                <td class="qty">${item.baseQty}</td>
                                <td class="qty">${item.boxCount}</td>
                                <td class="qty">${item.eachQty}</td>
                                <td class="qty">${item.totalQty}</td>
                                <td>${item.reason}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.status eq 'APPROVED'}">
                                            <span class="status status-done">승인완료</span>
                                        </c:when>
                                        <c:when test="${item.status eq 'PENDING'}">
                                            <span class="status status-ready">승인대기</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status status-etc">${item.status}</span>
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
    </div>

</div>
</body>
</html>
