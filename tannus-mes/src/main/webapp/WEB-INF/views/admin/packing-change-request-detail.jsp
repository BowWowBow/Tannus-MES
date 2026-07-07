<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 수정요청 상세</title>

    <style>
        :root {
            --blue: #2563eb;
            --blue-dark: #1d4ed8;
            --orange: #f59e0b;
            --orange-dark: #d97706;
            --green: #16a34a;
            --red: #dc2626;
            --gray: #334155;
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
            --card: #ffffff;
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
                    radial-gradient(circle at 8% 8%, rgba(245, 158, 11, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(37, 99, 235, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .page-wrap {
            max-width: 1180px;
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
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--orange), var(--orange-dark));
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
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

        .page-hero > div {
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

        .page-title {
            margin: 0;
            color: white;
            font-size: 31px;
            font-weight: 900;
            letter-spacing: -0.7px;
        }

        .hero-desc {
            margin-top: 9px;
            color: rgba(255,255,255,0.88);
            font-size: 14px;
            line-height: 1.6;
            font-weight: 700;
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

        .section-title {
            margin: 0 0 14px;
            color: #0f172a;
            font-size: 20px;
            font-weight: 900;
            letter-spacing: -0.3px;
        }

        .section-title:before {
            content: "";
            display: inline-block;
            width: 6px;
            height: 19px;
            border-radius: 999px;
            background: var(--orange);
            margin-right: 9px;
            vertical-align: -4px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        .info-table th,
        .info-table td,
        .detail-table th,
        .detail-table td {
            border: 1px solid var(--line);
            padding: 14px 12px;
            font-size: 14px;
            vertical-align: middle;
        }

        .info-table th {
            width: 150px;
            text-align: left;
            background: #f8fafc;
            color: #334155;
            font-weight: 900;
            white-space: nowrap;
        }

        .info-table td {
            color: #475569;
            font-weight: 800;
        }

        .detail-scroll {
            overflow-x: auto;
        }

        .detail-table {
            text-align: center;
            min-width: 920px;
        }

        .detail-table th {
            background: #f8fafc;
            color: #334155;
            font-weight: 900;
            white-space: nowrap;
        }

        .detail-table td {
            color: #475569;
            font-weight: 700;
        }

        .detail-table tbody tr:hover {
            background: #f8fafc;
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

        .bg-warning { background: #f59e0b; color: #1f2937; }
        .bg-info { background: #38bdf8; color: #1f2937; }
        .bg-success { background: var(--green); }
        .bg-secondary { background: #64748b; }
        .bg-dark { background: var(--gray); }

        .text-box {
            min-height: 92px;
            white-space: pre-wrap;
            background: #f8fafc;
            border: 1px solid var(--line);
            border-radius: 16px;
            padding: 15px 16px;
            color: #334155;
            line-height: 1.65;
            font-weight: 700;
        }

        .request-box {
            display: grid;
            gap: 18px;
        }

        .label-title {
            display: block;
            font-size: 14px;
            font-weight: 900;
            color: #334155;
            margin-bottom: 8px;
        }

        .btn-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 36px;
        }

        .btn-group {
            display: flex;
            gap: 9px;
            flex-wrap: wrap;
            justify-content: flex-end;
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

        .btn:hover:not(:disabled) {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn:disabled {
            opacity: 0.8;
            cursor: not-allowed;
        }

        .btn-outline-secondary {
            background: white;
            color: var(--gray);
            border: 1px solid #cbd5e1;
        }

        .btn-danger {
            background: var(--red);
        }

        .btn-primary {
            background: var(--blue);
        }

        .btn-success {
            background: var(--green);
        }

        .btn-secondary {
            background: #64748b;
        }

        .empty-row {
            padding: 42px 0 !important;
            color: #94a3b8 !important;
            font-weight: 900 !important;
        }

        form {
            margin: 0;
        }


        @media (max-width: 1024px) {
            .page-wrap {
                max-width: 100%;
                padding: 28px 18px 46px;
            }

            .detail-table {
                min-width: 860px;
            }
        }

        @media (max-width: 640px) {
            body {
                background:
                        radial-gradient(circle at 10% 4%, rgba(245, 158, 11, 0.16), transparent 32%),
                        linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            }

            .page-wrap {
                padding: 18px 10px 34px;
            }

            .page-hero {
                padding: 22px 18px;
                border-radius: 20px;
                margin-bottom: 14px;
            }

            .page-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .page-title {
                font-size: 23px;
                line-height: 1.25;
            }

            .hero-desc {
                font-size: 13px;
            }

            .card {
                border-radius: 18px;
                margin-bottom: 14px;
            }

            .card-body {
                padding: 16px;
            }

            .section-title {
                font-size: 18px;
                margin: 16px 0 12px;
            }

            .info-table,
            .info-table tbody,
            .info-table tr,
            .info-table th,
            .info-table td {
                display: block;
                width: 100%;
            }

            .info-table tr {
                border: 1px solid var(--line);
                border-radius: 14px;
                overflow: hidden;
                margin-bottom: 10px;
                background: white;
            }

            .info-table th,
            .info-table td {
                border: none;
                padding: 11px 12px;
            }

            .info-table th {
                width: 100%;
                background: #f8fafc;
                border-bottom: 1px solid var(--line);
            }

            .detail-scroll {
                border: 1px solid var(--line);
                border-radius: 16px;
                overflow-x: auto;
                -webkit-overflow-scrolling: touch;
            }

            .detail-table {
                min-width: 780px;
            }

            .detail-table th,
            .detail-table td {
                padding: 12px 10px;
                font-size: 13px;
            }

            .text-box {
                min-height: 76px;
                padding: 13px 14px;
                font-size: 13px;
            }

            .btn {
                min-height: 42px;
                padding: 10px 14px;
            }
        }

        @media (max-width: 420px) {
            .page-wrap {
                padding-left: 8px;
                padding-right: 8px;
            }

            .page-title {
                font-size: 21px;
            }

            .page-hero,
            .card {
                border-radius: 16px;
            }

            .btn-group {
                gap: 8px;
            }
        }

        @media (max-width: 760px) {
            .page-wrap {
                padding: 24px 14px 40px;
            }

            .page-hero {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-title {
                font-size: 26px;
            }

            .card-body {
                padding: 20px;
            }

            .btn-row {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-row .btn,
            .btn-group .btn,
            .btn-group form {
                width: 100%;
            }

            .btn-group {
                width: 100%;
            }

            .btn-group form button {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="page-wrap">

    <div class="page-hero">
        <div>
            <div class="page-badge">📝 ADMIN CHANGE REQUEST</div>
            <h2 class="page-title">관리자 - 포장 수정요청 상세</h2>
            <div class="hero-desc">포장팀이 요청한 수정 내용을 확인하세요.</div>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <table class="info-table">
                <tr>
                    <th>지시 번호</th>
                    <td>${order.id}</td>
                </tr>

                <tr>
                    <th>요청일</th>
                    <td>${request.createdAt}</td>
                </tr>

                <tr>
                    <th>요청자</th>
                    <td>${request.requestUser}</td>
                </tr>

                <tr>
                    <th>상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${request.status eq 'WAITING'}">
                                <span class="badge bg-warning">요청대기</span>
                            </c:when>

                            <c:when test="${request.status eq 'CHECKING'}">
                                <span class="badge bg-info">확인중</span>
                            </c:when>

                            <c:when test="${request.status eq 'APPROVED'}">
                                <span class="badge bg-success">승인완료</span>
                            </c:when>

                            <c:when test="${request.status eq 'REJECTED'}">
                                <span class="badge bg-secondary">반려완료</span>
                            </c:when>

                            <c:otherwise>
                                <span class="badge bg-secondary">${request.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <h5 class="section-title">기존 포장 지시 품목</h5>

    <div class="card">
        <div class="card-body">
            <div class="detail-scroll">
                <table class="detail-table">
                    <thead>
                    <tr>
                        <th>종류</th>
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
                        <tr>
                            <td>${detail.productType}</td>
                            <td>${detail.modelName}</td>
                            <td>${detail.color}</td>
                            <td>${detail.hardness}</td>
                            <td>${detail.baseQty}</td>
                            <td>${detail.boxCount}</td>
                            <td>${detail.eachQty}</td>
                            <td>${detail.totalQty} EA</td>
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

    <div class="card">
        <div class="card-body request-box">
            <div>
                <label class="label-title">수정 요청 사유</label>
                <div class="text-box">
                    ${request.requestReason}
                </div>
            </div>

            <div>
                <label class="label-title">요청 내용</label>
                <div class="text-box">
                    ${request.requestContent}
                </div>
            </div>
        </div>
    </div>

    <div class="btn-row">

        <a href="${pageContext.request.contextPath}/admin/packing/change-request/list"
           class="btn btn-outline-secondary">
            목록으로
        </a>

        <div class="btn-group">

            <c:if test="${request.status eq 'WAITING' || request.status eq 'CHECKING'}">

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/packing/change-request/reject/${request.id}"
                      onsubmit="return confirm('이 수정요청을 반려하시겠습니까?');">
                    <button type="submit" class="btn btn-danger">
                        반려
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/admin/packing/edit/${order.id}?changeRequestId=${request.id}"
                   class="btn btn-primary">
                    승인완료
                </a>

            </c:if>

            <c:if test="${request.status eq 'APPROVED'}">

                <button type="button" class="btn btn-success" disabled>
                    승인완료
                </button>

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/packing/change-request/rollback/${request.id}"
                      onsubmit="return confirm('승인완료 상태를 요청대기로 되돌리겠습니까?');">
                    <button type="submit" class="btn btn-outline-secondary">
                        되돌리기
                    </button>
                </form>

            </c:if>

            <c:if test="${request.status eq 'REJECTED'}">

                <button type="button" class="btn btn-secondary" disabled>
                    반려완료
                </button>

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/packing/change-request/rollback/${request.id}"
                      onsubmit="return confirm('반려완료 상태를 요청대기로 되돌리겠습니까?');">
                    <button type="submit" class="btn btn-outline-secondary">
                        되돌리기
                    </button>
                </form>

            </c:if>

        </div>

    </div>

</div>

</body>
</html>