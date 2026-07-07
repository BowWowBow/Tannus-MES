<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>재고 조회</title>

    <style>
        :root {
            --accent: #16a34a;
            --accent-dark: #15803d;
            --accent-blue: #2563eb;
            --accent-red: #dc2626;
            --accent-purple: #7c3aed;
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
                    radial-gradient(circle at 8% 8%, rgba(22, 163, 74, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(37, 99, 235, 0.10), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 1360px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .top-box {
            position: relative;
            overflow: hidden;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--accent), var(--accent-dark));
            color: white;
            padding: 30px;
            border-radius: 26px;
            margin-bottom: 18px;
            box-shadow: 0 18px 42px rgba(15,23,42,0.18);
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

        .top-box h1,
        .top-box p {
            position: relative;
            z-index: 1;
        }

        .top-box h1 {
            margin: 0 0 8px;
            font-size: 32px;
            font-weight: 900;
            letter-spacing: -0.6px;
        }

        .top-box p {
            margin: 0;
            opacity: 0.9;
            line-height: 1.6;
            font-size: 14px;
        }

        .user-info {
            text-align: right;
            color: var(--muted);
            font-size: 14px;
            margin-bottom: 10px;
            font-weight: 800;
        }

        .top-link {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 18px;
        }

        .btn {
            border: none;
            border-radius: 13px;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 900;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: white;
            white-space: nowrap;
            transition: transform 0.15s ease, opacity 0.15s ease, box-shadow 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
            box-shadow: 0 10px 22px rgba(15,23,42,0.14);
        }

        .btn-gray {
            background: #334155;
        }

        .btn-blue {
            background: var(--accent-blue);
        }

        .btn-green {
            background: var(--accent);
        }

        .filter-box {
            display: flex;
            gap: 9px;
            margin-bottom: 18px;
            flex-wrap: wrap;
        }

        .btn-filter {
            background: white;
            color: #334155;
            border: 1px solid rgba(37,99,235,0.20);
            box-shadow: 0 8px 20px rgba(15,23,42,0.06);
        }

        .btn-active {
            background: var(--accent);
            color: white;
            border-color: var(--accent);
        }

        .card,
        .table-box,
        .item-box,
        .empty {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
        }

        .card {
            padding: 24px;
            margin-bottom: 20px;
        }

        .table-box {
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f8fafc;
        }

        th {
            background: #f8fafc;
            padding: 15px 10px;
            font-size: 14px;
            color: #334155;
            border-bottom: 1px solid var(--line);
            cursor: pointer;
            user-select: none;
            white-space: nowrap;
            font-weight: 900;
        }

        th:hover {
            background: #eef6ff;
        }

        td {
            padding: 15px 10px;
            text-align: center;
            border-bottom: 1px solid #e5e7eb;
            font-size: 14px;
            color: #475569;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .type-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 76px;
            padding: 6px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 900;
            color: white;
        }

        .type-tire {
            background: var(--accent-blue);
        }

        .type-armour {
            background: var(--accent-red);
        }

        .type-tubeless {
            background: var(--accent-purple);
        }

        .stock-good {
            color: #15803d;
            font-weight: 900;
        }

        .stock-low {
            color: #f59e0b;
            font-weight: 900;
        }

        .stock-zero {
            color: #dc2626;
            font-weight: 900;
        }

        .empty {
            padding: 48px;
            color: #94a3b8;
            text-align: center;
            font-weight: 800;
        }

        .history-link {
            text-decoration: none;
            color: var(--accent-blue);
            font-weight: 900;
        }

        .history-link:hover {
            text-decoration: underline;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1.5fr 1fr 1fr auto;
            gap: 12px;
            align-items: end;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 900;
            color: #334155;
        }

        select,
        input {
            width: 100%;
            height: 44px;
            border: 1px solid #cbd5e1;
            border-radius: 13px;
            padding: 0 12px;
            box-sizing: border-box;
            font-size: 14px;
            background: white;
            outline: none;
        }

        select:focus,
        input:focus {
            border-color: var(--accent-blue);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
        }

        .selected-box {
            margin-top: 16px;
            padding: 15px 17px;
            border-radius: 16px;
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #15803d;
            font-weight: 900;
        }

        .msg-success,
        .msg-error {
            padding: 14px 16px;
            border-radius: 16px;
            margin-bottom: 16px;
            font-weight: 900;
        }

        .msg-success {
            background: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .msg-error {
            background: #fff1f2;
            color: #be123c;
            border: 1px solid #fecdd3;
        }

        .item-box {
            padding: 24px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 12px;
            margin-bottom: 22px;
        }

        .info-card {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            padding: 16px;
            text-align: center;
        }

        .info-title {
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 8px;
            font-weight: 800;
        }

        .info-value {
            font-size: 20px;
            font-weight: 900;
            color: #0f172a;
        }

        .adjust-grid {
            display: grid;
            grid-template-columns: 1fr 2fr auto;
            gap: 12px;
            align-items: end;
        }

        @media (max-width: 980px) {
            .form-grid {
                grid-template-columns: 1fr 1fr;
            }

            .info-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .adjust-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 640px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .form-grid,
            .info-grid {
                grid-template-columns: 1fr;
            }

            .top-box h1 {
                font-size: 26px;
            }
        }

        /* ===== 반응형 보강 ===== */
        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            overflow-x: hidden;
        }

        .table-box {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .table-box table {
            min-width: 920px;
        }

        .table-box::-webkit-scrollbar {
            height: 8px;
        }

        .table-box::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 999px;
        }

        .table-box::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 999px;
        }

        @media (max-width: 1024px) {
            .wrap {
                max-width: 100%;
                padding: 28px 18px 44px;
            }

            .top-box {
                padding: 26px 24px;
            }

            .card,
            .item-box {
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            .user-info {
                text-align: left;
                font-size: 13px;
            }

            .top-link {
                justify-content: flex-start;
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 8px;
            }

            .filter-box {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 8px;
            }

            .top-link .btn,
            .filter-box .btn {
                width: 100%;
                min-height: 42px;
                padding: 10px 8px;
                font-size: 13px;
            }

            .table-box {
                border-radius: 20px;
            }

            th, td {
                padding: 12px 10px;
                font-size: 13px;
                white-space: nowrap;
            }
        }

        @media (max-width: 520px) {
            .wrap {
                padding: 20px 12px 34px;
            }

            .top-box {
                padding: 22px 18px;
                border-radius: 22px;
            }

            .top-box h1 {
                font-size: 24px;
                line-height: 1.25;
            }

            .top-box p {
                font-size: 13px;
            }

            .top-link,
            .filter-box {
                grid-template-columns: 1fr;
            }

            .card,
            .item-box,
            .table-box,
            .empty {
                border-radius: 18px;
            }

            .table-box table {
                min-width: 820px;
            }

            .type-badge {
                min-width: 70px;
                padding: 6px 9px;
                font-size: 11px;
            }
        }


    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>📦 재고 조회</h1>
        <p>상품별 현재 재고 및 최근 입출고 날짜를 확인합니다.</p>
    </div>

    <div class="top-link">

        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-gray">
            대시보드
        </a>

        <c:if test="${loginRole eq 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/stock/adjust" class="btn btn-green">
                재고조정
            </a>
        </c:if>

    </div>

    <div class="filter-box">

        <a href="${pageContext.request.contextPath}/stock/list"
           class="btn btn-filter ${empty selectedProductType ? 'btn-active' : ''}">
            전체
        </a>

        <a href="${pageContext.request.contextPath}/stock/list?productType=TIRE"
           class="btn btn-filter ${selectedProductType eq 'TIRE' ? 'btn-active' : ''}">
            TIRE
        </a>

        <a href="${pageContext.request.contextPath}/stock/list?productType=ARMOUR"
           class="btn btn-filter ${selectedProductType eq 'ARMOUR' ? 'btn-active' : ''}">
            ARMOUR
        </a>

        <a href="${pageContext.request.contextPath}/stock/list?productType=TUBELESS"
           class="btn btn-filter ${selectedProductType eq 'TUBELESS' ? 'btn-active' : ''}">
            TUBELESS
        </a>

    </div>

    <div class="table-box">

        <table id="stockTable">

            <thead>
            <tr>

                <th onclick="sortTable(0)">상품종류</th>
                <th onclick="sortTable(1)">모델/사이즈</th>
                <th onclick="sortTable(2)">색상</th>
                <th onclick="sortTable(3)">경도</th>
                <th onclick="sortTable(4)">현재재고</th>
                <th onclick="sortTable(5)">최근입고일</th>
                <th onclick="sortTable(6)">최근출고일</th>


            </tr>
            </thead>

            <tbody>

            <c:choose>

                <c:when test="${empty itemList}">
                    <tr>
                        <td colspan="8" class="empty">
                            등록된 재고가 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>

                    <c:forEach var="item" items="${itemList}">

                        <tr>

                            <td>

                                <c:choose>

                                    <c:when test="${item.productType eq 'TIRE'}">
                                        <span class="type-badge type-tire">
                                            TIRE
                                        </span>
                                    </c:when>

                                    <c:when test="${item.productType eq 'ARMOUR'}">
                                        <span class="type-badge type-armour">
                                            ARMOUR
                                        </span>
                                    </c:when>

                                    <c:when test="${item.productType eq 'TUBELESS'}">
                                        <span class="type-badge type-tubeless">
                                            TUBELESS
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        ${item.productType}
                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <td>${item.modelName}</td>

                            <td>
                                <c:choose>

                                    <c:when test="${empty item.color}">
                                        -
                                    </c:when>

                                    <c:otherwise>
                                        ${item.color}
                                    </c:otherwise>

                                </c:choose>
                            </td>

                            <td>
                                <c:choose>

                                    <c:when test="${empty item.hardness}">
                                        -
                                    </c:when>

                                    <c:otherwise>
                                        ${item.hardness}
                                    </c:otherwise>

                                </c:choose>
                            </td>

                            <td>

                                <c:choose>

                                    <c:when test="${item.currentQty <= 0}">
                                        <span class="stock-zero">
                                            0
                                        </span>
                                    </c:when>

                                    <c:when test="${item.currentQty < 50}">
                                        <span class="stock-low">
                                                ${item.currentQty}
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="stock-good">
                                                ${item.currentQty}
                                        </span>
                                    </c:otherwise>

                                </c:choose>

                            </td>

                            <td>
                                <c:choose>

                                    <c:when test="${empty item.lastInDate}">
                                        -
                                    </c:when>

                                    <c:otherwise>
                                        ${item.lastInDate}
                                    </c:otherwise>

                                </c:choose>
                            </td>

                            <td>
                                <c:choose>

                                    <c:when test="${empty item.lastOutDate}">
                                        -
                                    </c:when>

                                    <c:otherwise>
                                        ${item.lastOutDate}
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

<script>

    let sortDirection = true;

    function sortTable(columnIndex) {

        const table = document.getElementById("stockTable");

        const tbody = table.querySelector("tbody");

        const rows = Array.from(tbody.querySelectorAll("tr"));

        rows.sort((a, b) => {

            const aText = a.children[columnIndex].innerText.trim();
            const bText = b.children[columnIndex].innerText.trim();

            const aNum = Number(aText);
            const bNum = Number(bText);

            if (!isNaN(aNum) && !isNaN(bNum)) {

                return sortDirection
                    ? aNum - bNum
                    : bNum - aNum;
            }

            return sortDirection
                ? aText.localeCompare(bText)
                : bText.localeCompare(aText);
        });

        sortDirection = !sortDirection;

        rows.forEach(row => tbody.appendChild(row));
    }

</script>

</body>
</html>