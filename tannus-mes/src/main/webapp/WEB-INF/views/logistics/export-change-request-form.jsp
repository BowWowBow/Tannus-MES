<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 수정요청</title>

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
            max-width: 1200px;
            margin: 34px auto 60px;
            padding: 0 22px;
        }

        .top-box {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 18px;
            margin-bottom: 22px;
            padding: 24px 26px;
            border: 1px solid rgba(148, 163, 184, 0.28);
            border-radius: 24px;
            background:
                    linear-gradient(135deg, rgba(30, 64, 175, 0.95), rgba(37, 99, 235, 0.92)),
                    linear-gradient(135deg, #1d4ed8, #0ea5e9);
            box-shadow: 0 18px 40px rgba(30, 64, 175, 0.22);
        }

        .top-title h1 {
            position: relative;
            margin: 0 0 8px;
            padding-left: 16px;
            font-size: 30px;
            letter-spacing: -0.6px;
            color: white;
            line-height: 1.25;
        }

        .top-title h1::before {
            content: "";
            position: absolute;
            left: 0;
            top: 6px;
            width: 5px;
            height: 28px;
            border-radius: 999px;
            background: #93c5fd;
        }

        .top-title p {
            margin: 0;
            color: rgba(255, 255, 255, 0.86);
            font-size: 14px;
            line-height: 1.6;
            font-weight: 700;
        }

        .btn-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-end;
            gap: 10px;
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
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(37, 99, 235, 0.20);
            transition: transform 0.15s ease, box-shadow 0.15s ease, opacity 0.15s ease;
            white-space: nowrap;
        }

        .btn.gray {
            background: rgba(15, 23, 42, 0.18);
            border: 1px solid rgba(255, 255, 255, 0.36);
            box-shadow: none;
        }

        .btn.red {
            background: linear-gradient(135deg, #ef4444, #f97316);
            box-shadow: 0 8px 18px rgba(239, 68, 68, 0.18);
        }

        .btn:hover {
            opacity: 0.96;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.24);
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

        .info-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
        }

        .info-box {
            background: linear-gradient(180deg, #f8fbff, #eef6ff);
            border: 1px solid #d8e7fb;
            border-radius: 16px;
            padding: 15px 16px;
            min-height: 82px;
        }

        .info-label {
            display: block;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 8px;
            font-weight: 800;
        }

        .info-value {
            font-size: 17px;
            font-weight: 900;
            color: #0f172a;
            word-break: break-all;
        }

        .status {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 28px;
            min-width: 78px;
            padding: 5px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            box-sizing: border-box;
            letter-spacing: -0.2px;
        }

        .status.waiting {
            background: #fef3c7;
            color: #92400e;
            border: 1px solid #fde68a;
        }

        .status.ready {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .status.ready-done {
            background: #e0f2fe;
            color: #075985;
            border: 1px solid #bae6fd;
        }

        .status.done {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .status.etc {
            background: #e5e7eb;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .section-title {
            position: relative;
            margin: 0 0 16px;
            padding-left: 13px;
            color: #1d4ed8;
            font-size: 20px;
            letter-spacing: -0.4px;
        }

        .section-title::before {
            content: "";
            position: absolute;
            left: 0;
            top: 5px;
            width: 5px;
            height: 20px;
            border-radius: 999px;
            background: #38bdf8;
        }

        .section-desc {
            margin: -8px 0 16px;
            color: #64748b;
            font-size: 13px;
            line-height: 1.5;
            font-weight: 700;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: white;
        }

        thead {
            background: linear-gradient(180deg, #eff6ff, #e0f2fe);
        }

        th, td {
            padding: 14px 12px;
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
            font-weight: 600;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        .empty {
            text-align: center;
            padding: 38px 0;
            color: #64748b;
            line-height: 1.6;
            font-weight: 800;
        }

        .form-box {
            margin-bottom: 18px;
        }

        .form-box label {
            display: block;
            font-size: 14px;
            margin-bottom: 8px;
            color: #334155;
            font-weight: 900;
        }

        .form-box select,
        .form-box textarea {
            width: 100%;
            border: 1px solid #cbd5e1;
            border-radius: 14px;
            padding: 12px 14px;
            background: white;
            color: #0f172a;
            font-size: 15px;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            font-weight: 700;
            outline: none;
        }

        .form-box select {
            height: 46px;
        }

        .form-box textarea {
            min-height: 170px;
            resize: vertical;
            line-height: 1.6;
        }

        .form-box select:focus,
        .form-box textarea:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }

        .btn-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-top: 18px;
        }

        .warning-box {
            margin-bottom: 18px;
            background: #fff7ed;
            border: 1px solid #fed7aa;
            color: #9a3412;
            border-radius: 16px;
            padding: 14px 16px;
            font-size: 14px;
            line-height: 1.6;
            font-weight: 800;
        }

        @media (max-width: 1000px) {
            .info-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .card {
                overflow-x: auto;
            }

            table {
                min-width: 820px;
            }
        }

        @media (max-width: 760px) {
            .wrap {
                margin-top: 18px;
                padding: 0 14px;
            }

            .top-box {
                flex-direction: column;
                padding: 22px;
            }

            .top-title h1 {
                font-size: 25px;
            }

            .btn-group {
                width: 100%;
                justify-content: flex-start;
            }

            .info-grid {
                grid-template-columns: 1fr;
            }

            .btn-box {
                flex-direction: column;
                align-items: stretch;
            }
        }
        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .card {
            -webkit-overflow-scrolling: touch;
        }

        .card::-webkit-scrollbar {
            height: 8px;
        }

        .card::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .card::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        .btn-group .btn,
        .btn-box .btn,
        .btn-box button {
            min-height: 42px;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                margin: 26px auto 48px;
                padding: 0 18px;
            }

            .card {
                padding: 22px;
            }

            table {
                min-width: 780px;
            }
        }

        @media (max-width: 640px) {
            .wrap {
                margin-top: 14px;
                padding: 0 12px;
            }

            .top-box {
                border-radius: 20px;
                gap: 14px;
            }

            .top-title h1 {
                font-size: 23px;
            }

            .top-title p {
                font-size: 13px;
            }

            .btn-group {
                display: grid;
                grid-template-columns: 1fr;
                width: 100%;
            }

            .btn-group .btn {
                width: 100%;
            }

            .card {
                padding: 18px;
                border-radius: 18px;
            }

            .info-box {
                min-height: auto;
            }

            .section-title {
                font-size: 18px;
            }

            .form-box select,
            .form-box textarea {
                font-size: 14px;
            }

            .btn-box .btn,
            .btn-box button {
                width: 100%;
            }

            table {
                min-width: 720px;
            }

            th, td {
                padding: 12px 10px;
                font-size: 13px;
            }
        }

    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <div class="top-title">
            <h1>수출 수정요청</h1>
            <p>출고 수량 또는 품목 이상 발생 시 관리자에게 수정요청합니다.</p>
        </div>

        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/logistics/export/detail/${order.id}"
               class="btn gray">
                상세로
            </a>

            <a href="${pageContext.request.contextPath}/logistics/export/list"
               class="btn gray">
                목록으로
            </a>
        </div>
    </div>

    <div class="card">
        <div class="info-grid">

            <div class="info-box">
                <span class="info-label">수출 지시번호</span>
                <span class="info-value">${order.id}</span>
            </div>

            <div class="info-box">
                <span class="info-label">출고 요청일</span>
                <span class="info-value">${order.requestDate}</span>
            </div>

            <div class="info-box">
                <span class="info-label">지시자</span>
                <span class="info-value">${order.workerName}</span>
            </div>

            <div class="info-box">
                <span class="info-label">현재 상태</span>
                <span class="info-value">
                    <c:choose>
                        <c:when test="${order.status eq 'WAITING'}">
                            <span class="status waiting">출고대기</span>
                        </c:when>

                        <c:when test="${order.status eq 'READY_TO_SHIP'}">
                            <span class="status ready">출고준비</span>
                        </c:when>

                        <c:when test="${order.status eq 'READY_DONE'}">
                            <span class="status ready-done">출고준비완료</span>
                        </c:when>

                        <c:when test="${order.status eq 'DONE'}">
                            <span class="status done">출고완료</span>
                        </c:when>

                        <c:otherwise>
                            <span class="status etc">${order.status}</span>
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

        </div>
    </div>

    <div class="card">
        <h2 class="section-title">상세 품목</h2>
        <div class="section-desc">
            현재 수출 지시에 포함된 품목입니다. 수정요청 내용 작성 시 변경 전/후 수량과 사유를 함께 적어주세요.
        </div>

        <table>
            <thead>
            <tr>
                <th>종류</th>
                <th>모델/사이즈</th>
                <th>색상</th>
                <th>경도</th>
                <th>박스수</th>
                <th>낱개수량</th>
                <th>총수량</th>
            </tr>
            </thead>

            <tbody>
            <c:choose>
                <c:when test="${empty order.detailList}">
                    <tr>
                        <td colspan="7" class="empty">
                            상세 품목이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="detail" items="${order.detailList}">
                        <tr>
                            <td>${detail.type}</td>
                            <td>${detail.model}</td>
                            <td>${detail.color}</td>
                            <td>${detail.hardness}</td>
                            <td>${detail.boxCount}</td>
                            <td>${detail.eachQty}</td>
                            <td>${detail.totalQty} EA</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>
    </div>

    <div class="card">
        <h2 class="section-title">수정요청 작성</h2>

        <div class="warning-box">
            수정요청을 등록하면 관리자의 승인 또는 반려 처리 전까지 해당 수출 지시의 출고 처리가 제한될 수 있습니다.
        </div>

        <form method="post"
              action="${pageContext.request.contextPath}/logistics/export/change-request/${order.id}">

            <input type="hidden" name="exportOrderId" value="${order.id}">

            <div class="form-box">
                <label>수정요청 사유</label>
                <select name="requestReason" required>
                    <option value="">선택하세요</option>
                    <option value="수량부족">수량부족</option>
                    <option value="수량초과">수량초과</option>
                    <option value="파손">파손</option>
                    <option value="누락">누락</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <div class="form-box">
                <label>상세 요청내용</label>
                <textarea name="requestContent"
                          rows="7"
                          placeholder="예: 수출 품목 수량 100EA → 95EA 변경 요청 / 사유: 실제 출고 가능 수량 부족"
                          required></textarea>
            </div>

            <div class="btn-box">
                <a href="${pageContext.request.contextPath}/logistics/export/detail/${order.id}"
                   class="btn gray">
                    취소하고 상세로
                </a>

                <button type="submit"
                        class="btn red"
                        onclick="return confirm('수출 수정요청을 등록하시겠습니까?');">
                    수정요청 보내기
                </button>
            </div>

        </form>
    </div>

</div>

</body>
</html>
