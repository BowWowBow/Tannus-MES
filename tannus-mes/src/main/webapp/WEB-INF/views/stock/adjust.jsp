<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>재고 조정</title>

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
    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <h1>📦 재고 조정</h1>
        <p>상품을 선택해서 현재고를 확인한 뒤 플러스 / 마이너스 조정합니다.</p>
    </div>

    <div class="top-link">
        <a href="${pageContext.request.contextPath}/stock/list" class="btn btn-gray">재고조회</a>
        <a href="${pageContext.request.contextPath}/stock/history" class="btn btn-gray">재고히스토리</a>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-blue">대시보드</a>
    </div>

    <c:if test="${not empty successMsg}">
        <div class="msg-success">${successMsg}</div>
    </c:if>

    <c:if test="${not empty errorMsg}">
        <div class="msg-error">${errorMsg}</div>
    </c:if>

    <div class="card">

        <form action="${pageContext.request.contextPath}/stock/adjust" method="get" id="adjustSearchForm">

            <div class="form-grid">

                <div>
                    <label>상품종류</label>
                    <select id="productType" name="productType" required>
                        <option value="">선택</option>
                        <option value="TIRE" <c:if test="${selectedProductType eq 'TIRE'}">selected</c:if>>TIRE</option>
                        <option value="ARMOUR" <c:if test="${selectedProductType eq 'ARMOUR'}">selected</c:if>>ARMOUR</option>
                        <option value="TUBELESS" <c:if test="${selectedProductType eq 'TUBELESS'}">selected</c:if>>TUBELESS</option>
                    </select>
                </div>

                <div>
                    <label>모델/사이즈</label>

                    <select id="modelSelect" required>
                        <option value="">선택</option>

                        <c:forEach var="item" items="${itemList}">
                            <option value="${item.productType}|${item.modelName}|${item.color}|${item.hardness}"
                                    data-type="${item.productType}"
                                    data-model="${item.modelName}"
                                    data-color="${item.color}"
                                    data-hardness="${item.hardness}">
                                    ${item.modelName}
                            </option>
                        </c:forEach>
                    </select>

                    <input type="hidden" id="modelName" name="modelName" value="${selectedModelName}">
                </div>

                <div>
                    <label>색상</label>
                    <select id="color" name="color" required>
                        <option value="">선택</option>
                        <option value="LEMON">LEMON</option>
                        <option value="MELON">MELON</option>
                        <option value="VOLCANO">VOLCANO</option>
                        <option value="AQUAMARINE">AQUAMARINE</option>
                        <option value="COTTON">COTTON</option>
                        <option value="MIDNIGHT">MIDNIGHT</option>
                        <option value="VEGAS">VEGAS</option>
                        <option value="CARROT">CARROT</option>
                        <option value="LOVE">LOVE</option>
                        <option value="MOCHA">MOCHA</option>
                        <option value="CITY">CITY</option>
                        <option value="SAHARA">SAHARA</option>
                        <option value="BLACK">BLACK</option>
                        <option value="RED">RED</option>
                    </select>
                </div>

                <div>
                    <label>경도</label>
                    <select id="hardness" name="hardness" required>
                        <option value="">선택</option>
                        <option value="S">S</option>
                        <option value="R">R</option>
                        <option value="H">H</option>
                    </select>
                </div>

                <div>
                    <button type="submit" class="btn btn-blue">조회</button>
                </div>

            </div>

            <div class="selected-box">
                <c:choose>
                    <c:when test="${not empty selectedModelName}">
                        선택 상품:
                        ${selectedProductType} / ${selectedModelName} / ${selectedColor} / ${selectedHardness}
                    </c:when>
                    <c:otherwise>
                        상품을 선택 후 조회하세요.
                    </c:otherwise>
                </c:choose>
            </div>

        </form>

    </div>

    <c:choose>
        <c:when test="${not empty selectedItem}">

            <div class="item-box">

                <div class="info-grid">
                    <div class="info-card">
                        <div class="info-title">상품종류</div>
                        <div class="info-value">${selectedItem.productType}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-title">모델/사이즈</div>
                        <div class="info-value">${selectedItem.modelName}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-title">색상</div>
                        <div class="info-value">${selectedItem.color}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-title">경도</div>
                        <div class="info-value">${selectedItem.hardness}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-title">현재고</div>
                        <div class="info-value">${selectedItem.currentQty}</div>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/stock/adjust" method="post">

                    <input type="hidden" name="itemId" value="${selectedItem.id}">

                    <div class="adjust-grid">

                        <div>
                            <label>조정수량</label>
                            <input type="number" name="adjustQty" placeholder="예: 10 또는 -5" required>
                        </div>

                        <div>
                            <label>조정사유</label>
                            <input type="text" name="reason" placeholder="예: 실사 재고 차이, 파손, 오입고 수정" required>
                        </div>

                        <div>
                            <button type="submit" class="btn btn-green">재고조정</button>
                        </div>

                    </div>

                </form>

            </div>

        </c:when>

        <c:when test="${not empty selectedModelName and empty selectedItem}">
            <div class="empty">
                선택한 상품의 재고 데이터가 없습니다.
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty">
                상품을 선택하면 재고조정 화면이 표시됩니다.
            </div>
        </c:otherwise>
    </c:choose>

</div>

<script>
    const selectedProductType = '${selectedProductType}';
    const selectedModelName = '${selectedModelName}';
    const selectedColor = '${selectedColor}';
    const selectedHardness = '${selectedHardness}';

    const productType = document.getElementById('productType');
    const modelSelect = document.getElementById('modelSelect');
    const modelNameHidden = document.getElementById('modelName');
    const color = document.getElementById('color');
    const hardness = document.getElementById('hardness');
    const adjustSearchForm = document.getElementById('adjustSearchForm');

    function resetColorHardnessStyle() {
        color.style.pointerEvents = 'auto';
        hardness.style.pointerEvents = 'auto';
        color.style.background = 'white';
        hardness.style.background = 'white';
    }

    function lockColorHardness() {
        color.style.pointerEvents = 'none';
        hardness.style.pointerEvents = 'none';
        color.style.background = '#e9ecef';
        hardness.style.background = '#e9ecef';
    }

    function deduplicateTireModels() {
        const seen = new Set();

        Array.from(modelSelect.options).forEach(option => {
            if (!option.value || option.dataset.type !== 'TIRE') {
                return;
            }

            const key = option.dataset.type + '|' + option.dataset.model;

            if (seen.has(key)) {
                option.remove();
            } else {
                seen.add(key);
            }
        });
    }

    function filterModelOptions(resetModel) {
        const type = productType.value;

        Array.from(modelSelect.options).forEach(option => {
            if (!option.value) {
                option.hidden = false;
                return;
            }

            option.hidden = option.dataset.type !== type;
        });

        if (resetModel) {
            modelSelect.value = '';
            modelNameHidden.value = '';
            color.value = '';
            hardness.value = '';
            resetColorHardnessStyle();
        }

        if (type === 'TIRE') {
            if (!color.value) {
                color.value = 'MIDNIGHT';
            }

            if (!hardness.value) {
                hardness.value = 'R';
            }

            resetColorHardnessStyle();
        }

        if (type === 'ARMOUR') {
            color.value = 'RED';
            hardness.value = 'R';
            lockColorHardness();
        }

        if (type === 'TUBELESS') {
            color.value = 'BLACK';
            hardness.value = 'R';
            lockColorHardness();
        }
    }

    function applySelectedItemInfo() {
        const selectedOption = modelSelect.options[modelSelect.selectedIndex];

        if (!selectedOption || !selectedOption.value) {
            modelNameHidden.value = '';
            color.value = '';
            hardness.value = '';
            resetColorHardnessStyle();
            return;
        }

        modelNameHidden.value = selectedOption.dataset.model;

        if (productType.value === 'TIRE') {
            if (!color.value) {
                color.value = 'MIDNIGHT';
            }

            if (!hardness.value) {
                hardness.value = 'R';
            }

            resetColorHardnessStyle();
            return;
        }

        color.value = selectedOption.dataset.color;
        hardness.value = selectedOption.dataset.hardness;
        lockColorHardness();
    }

    function restoreSelectedOption() {
        if (!selectedProductType || !selectedModelName) {
            return;
        }

        Array.from(modelSelect.options).forEach(option => {
            if (option.dataset.type === selectedProductType &&
                option.dataset.model === selectedModelName) {
                modelSelect.value = option.value;
            }
        });

        modelNameHidden.value = selectedModelName;
        color.value = selectedColor || (selectedProductType === 'TIRE' ? 'MIDNIGHT' : '');
        hardness.value = selectedHardness || 'R';

        if (selectedProductType === 'TIRE') {
            resetColorHardnessStyle();
        } else {
            lockColorHardness();
        }
    }

    productType.addEventListener('change', function () {
        filterModelOptions(true);
    });

    modelSelect.addEventListener('change', function () {
        applySelectedItemInfo();
    });

    adjustSearchForm.addEventListener('submit', function (e) {
        applySelectedItemInfo();

        if (!productType.value) {
            alert('상품종류를 선택하세요.');
            e.preventDefault();
            return;
        }

        if (!modelNameHidden.value) {
            alert('모델/사이즈를 선택하세요.');
            e.preventDefault();
            return;
        }

        if (!color.value) {
            alert('색상을 선택하세요.');
            e.preventDefault();
            return;
        }

        if (!hardness.value) {
            alert('경도를 선택하세요.');
            e.preventDefault();
        }
    });

    document.addEventListener('DOMContentLoaded', function () {
        deduplicateTireModels();

        if (selectedProductType) {
            productType.value = selectedProductType;
            filterModelOptions(false);
            restoreSelectedOption();
        } else {
            filterModelOptions(true);
        }
    });
</script>

</body>
</html>