<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 수정요청 상세</title>

    <style>
        :root {
            --main: #16a34a;
            --main-dark: #15803d;
            --main-light: #dcfce7;
            --main-soft: rgba(22, 163, 74, 0.13);
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #dbe3ee;
            --card: #ffffff;
            --danger: #dc2626;
            --gray: #334155;
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
                    radial-gradient(circle at 8% 8%, rgba(22, 163, 74, 0.12), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(14, 165, 233, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            overflow-x: hidden;
        }

        .page-wrap {
            max-width: 980px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .page-hero {
            position: relative;
            overflow: hidden;
            margin-bottom: 20px;
            padding: 28px 30px;
            border-radius: 24px;
            color: white;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.34), transparent 28%),
                    linear-gradient(135deg, var(--main), var(--main-dark));
            box-shadow: 0 18px 42px rgba(15, 23, 42, 0.18);
        }

        .page-hero:before {
            content: "";
            position: absolute;
            right: -74px;
            top: -88px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.17);
        }

        .page-hero:after {
            content: "";
            position: absolute;
            right: 42px;
            bottom: -86px;
            width: 170px;
            height: 170px;
            border-radius: 50%;
            background: rgba(255,255,255,0.10);
        }

        .page-hero-inner {
            position: relative;
            z-index: 1;
        }

        .page-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 7px 12px;
            margin-bottom: 12px;
            border-radius: 999px;
            background: rgba(255,255,255,0.18);
            border: 1px solid rgba(255,255,255,0.24);
            font-size: 12px;
            font-weight: 900;
            letter-spacing: 0.3px;
        }

        .page-title {
            margin: 0;
            font-size: 30px;
            color: white;
            font-weight: 900;
            letter-spacing: -0.8px;
        }

        .hero-desc {
            margin-top: 10px;
            color: rgba(255,255,255,0.90);
            font-size: 14px;
            font-weight: 700;
            line-height: 1.6;
        }

        .card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 20px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .card-body {
            padding: 22px;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid var(--line);
            border-radius: 0;
            background: white;
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
            border-collapse: collapse;
        }

        .info-table {
            min-width: 520px;
        }

        .detail-table {
            min-width: 820px;
            text-align: center;
        }

        th,
        td {
            border: 1px solid var(--line);
            padding: 15px 13px;
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

        .info-table th {
            width: 150px;
            text-align: left;
        }

        .detail-table thead th {
            text-align: center;
        }

        .detail-table tbody tr:hover td {
            background: #f8fafc;
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 9px;
            margin: 20px 0 14px;
            font-size: 20px;
            font-weight: 900;
            letter-spacing: -0.4px;
            color: #0f172a;
        }

        .section-title:before {
            content: "";
            width: 6px;
            height: 20px;
            border-radius: 999px;
            background: var(--main);
        }

        .request-card .card-body {
            display: grid;
            gap: 18px;
        }

        .label-title {
            display: block;
            margin-bottom: 8px;
            color: #334155;
            font-size: 14px;
            font-weight: 900;
        }

        .text-box {
            min-height: 92px;
            padding: 18px 20px;
            border: 1px solid var(--line);
            border-radius: 15px;
            background: #f8fafc;
            color: #334155;
            white-space: pre-wrap;
            word-break: keep-all;
            line-height: 1.7;
            font-size: 15px;
            font-weight: 800;
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

        .bg-warning {
            background: #f59e0b;
            color: #1f2937;
        }

        .bg-info {
            background: #38bdf8;
            color: #1f2937;
        }

        .bg-success {
            background: var(--main);
        }

        .bg-secondary {
            background: #64748b;
        }

        .empty-row {
            padding: 36px 0 !important;
            color: #94a3b8 !important;
            font-weight: 900 !important;
            text-align: center;
        }

        .bottom-btn-area {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 36px;
        }

        .action-btns {
            display: flex;
            gap: 9px;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        form {
            margin: 0;
        }

        .btn {
            border: none;
            border-radius: 12px;
            padding: 10px 16px;
            min-height: 40px;
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
            opacity: 0.82;
            cursor: not-allowed;
        }

        .btn-outline-secondary {
            background: white;
            color: var(--gray);
            border: 1px solid #cbd5e1;
        }

        .btn-danger {
            background: var(--danger);
        }

        .btn-primary {
            background: #2563eb;
        }

        .btn-success {
            background: var(--main);
        }

        .btn-secondary {
            background: #64748b;
        }

        @media (max-width: 900px) {
            .page-wrap {
                max-width: 100%;
                padding: 24px 14px 42px;
            }

            .page-hero {
                padding: 24px 22px;
            }

            .page-title {
                font-size: 26px;
            }

            .card-body {
                padding: 18px;
            }
        }

        @media (max-width: 640px) {
            .page-wrap {
                padding: 18px 12px 36px;
            }

            .page-hero {
                border-radius: 20px;
                padding: 22px 20px;
            }

            .page-title {
                font-size: 23px;
            }

            .hero-desc {
                font-size: 13px;
            }

            .card {
                border-radius: 18px;
            }

            .card-body {
                padding: 15px;
            }

            th,
            td {
                padding: 12px 10px;
                font-size: 13px;
                white-space: nowrap;
            }

            .text-box {
                min-height: 86px;
                padding: 15px;
                font-size: 14px;
                word-break: break-word;
            }

            .bottom-btn-area {
                flex-direction: column;
                align-items: stretch;
            }

            .bottom-btn-area > a,
            .action-btns,
            .action-btns form,
            .action-btns a,
            .action-btns button {
                width: 100%;
            }

            .action-btns {
                display: grid;
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="page-wrap">

    <div class="page-hero">
        <div class="page-hero-inner">
            <div class="page-badge">🚚 EXPORT CHANGE REQUEST</div>
            <h2 class="page-title">관리자 - 수출 수정요청 상세</h2>
            <div class="hero-desc">물류팀이 요청한 수정 내용을 확인하세요.</div>
        </div>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="table-wrap">
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
    </div>

    <h5 class="section-title">기존 수출 지시 품목</h5>

    <div class="card">
        <div class="card-body">
            <div class="table-wrap">
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
                            <td>${detail.type}</td>
                            <td>${detail.model}</td>
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

    <div class="card request-card">
        <div class="card-body">
            <div>
                <label class="label-title">수정 요청 사유</label>
                <div class="text-box">${request.requestReason}</div>
            </div>

            <div>
                <label class="label-title">요청 내용</label>
                <div class="text-box">${request.requestContent}</div>
            </div>
        </div>
    </div>

    <div class="bottom-btn-area">

        <a href="${pageContext.request.contextPath}/admin/export/change-request/list"
           class="btn btn-outline-secondary">
            목록으로
        </a>

        <div class="action-btns">

            <c:if test="${request.status eq 'WAITING' || request.status eq 'CHECKING'}">

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/export/change-request/reject/${request.id}"
                      onsubmit="return confirm('이 수정요청을 반려하시겠습니까?');">
                    <button type="submit" class="btn btn-danger">
                        반려
                    </button>
                </form>

                <a href="${pageContext.request.contextPath}/admin/export/edit/${order.id}?changeRequestId=${request.id}"
                   class="btn btn-primary">
                    승인완료
                </a>

            </c:if>

            <c:if test="${request.status eq 'APPROVED'}">

                <button type="button" class="btn btn-success" disabled>
                    승인완료
                </button>

                <form method="post"
                      action="${pageContext.request.contextPath}/admin/export/change-request/rollback/${request.id}"
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
                      action="${pageContext.request.contextPath}/admin/export/change-request/rollback/${request.id}"
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
