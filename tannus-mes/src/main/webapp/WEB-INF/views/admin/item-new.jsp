<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 추가</title>

    <style>
        :root {
            --accent: #2563eb;
            --accent-dark: #1d4ed8;
            --accent-soft: rgba(37, 99, 235, 0.12);
            --bg: #f5f7fb;
            --text: #0f172a;
            --muted: #64748b;
            --line: #e2e8f0;
            --card: #ffffff;
            --green: #16a34a;
            --dark: #334155;
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
                    radial-gradient(circle at 8% 8%, rgba(37, 99, 235, 0.13), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(14, 165, 233, 0.12), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
        }

        .wrap {
            max-width: 980px;
            margin: 34px auto;
            padding: 0 18px;
        }

        .panel {
            overflow: hidden;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 28px;
            box-shadow: 0 18px 42px rgba(15,23,42,0.12);
        }

        .top {
            position: relative;
            overflow: hidden;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            padding: 28px 30px;
            background:
                    radial-gradient(circle at 88% 12%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--accent), var(--accent-dark));
            color: white;
        }

        .top:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 230px;
            height: 230px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .top-left,
        .top .back {
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

        h2 {
            margin: 0;
            font-size: 30px;
            color: white;
            font-weight: 900;
            letter-spacing: -0.6px;
        }

        .top-sub {
            margin-top: 8px;
            color: rgba(255,255,255,0.86);
            font-size: 14px;
        }

        .back {
            text-decoration: none;
            background: rgba(255,255,255,0.92);
            color: var(--accent-dark);
            padding: 10px 15px;
            border-radius: 13px;
            font-size: 13px;
            font-weight: 900;
            white-space: nowrap;
        }

        .content {
            padding: 26px 30px 30px;
        }

        .desc {
            position: relative;
            background: #f8fbff;
            border: 1px solid #dbeafe;
            border-radius: 18px;
            padding: 16px 18px;
            font-size: 13px;
            color: #475569;
            margin-bottom: 22px;
            line-height: 1.75;
        }

        .alert-error,
        .alert-success {
            padding: 13px 15px;
            border-radius: 14px;
            margin-bottom: 15px;
            font-weight: 900;
            font-size: 13px;
        }

        .alert-error {
            background: #fff1f2;
            color: #be123c;
            border: 1px solid #fecdd3;
        }

        .alert-success {
            background: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 17px 18px;
        }

        .form-grid.three {
            grid-template-columns: 1fr 1fr 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-size: 13px;
            font-weight: 900;
            margin-bottom: 7px;
            color: #334155;
        }

        .required {
            color: #ef4444;
        }

        input,
        select {
            height: 44px;
            border: 1px solid #cbd5e1;
            border-radius: 13px;
            padding: 0 12px;
            font-size: 14px;
            outline: none;
            background: white;
            color: #0f172a;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

        input:focus,
        select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
        }

        input[readonly] {
            background: #f1f5f9;
            color: #64748b;
            cursor: not-allowed;
        }

        .section-line {
            margin: 28px 0 20px;
            border-top: 1px solid var(--line);
        }

        .btn-row {
            margin-top: 26px;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            border-top: 1px solid var(--line);
            padding-top: 20px;
        }

        .btn {
            border: none;
            border-radius: 13px;
            padding: 11px 18px;
            font-weight: 900;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            transition: transform 0.15s ease, opacity 0.15s ease;
        }

        .btn:hover {
            opacity: 0.94;
            transform: translateY(-1px);
        }

        .btn-blue {
            background: var(--accent);
            color: white;
        }

        .btn-green {
            background: var(--green);
            color: white;
        }

        .btn-gray {
            background: var(--dark);
            color: white;
        }

        .example {
            font-size: 12px;
            color: #64748b;
            margin-top: 6px;
        }

        .result-box {
            margin-top: 22px;
            background: #ffffff;
            border: 1px solid #dbeafe;
            border-radius: 20px;
            padding: 20px;
            box-shadow: 0 10px 28px rgba(15,23,42,0.06);
        }

        .result-title {
            font-size: 18px;
            font-weight: 900;
            color: #0f172a;
            margin-bottom: 15px;
        }

        @media (max-width: 900px) {
            .wrap {
                margin: 22px auto;
                padding: 0 14px;
            }

            .top {
                flex-direction: column;
                align-items: flex-start;
                padding: 26px 24px;
            }

            .back {
                width: 100%;
                text-align: center;
            }

            .form-grid,
            .form-grid.three {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 560px) {
            .wrap {
                margin: 0 auto;
                padding: 0;
            }

            .panel {
                min-height: 100vh;
                border-radius: 0;
                border-left: none;
                border-right: none;
            }

            .top {
                padding: 22px 18px;
            }

            h2 {
                font-size: 25px;
            }

            .top-sub,
            .desc {
                font-size: 13px;
                word-break: keep-all;
            }

            .content {
                padding: 20px 16px 24px;
            }

            .desc {
                padding: 14px 15px;
                border-radius: 16px;
            }

            input,
            select {
                height: 46px;
                font-size: 16px;
            }

            .btn-row {
                flex-direction: column-reverse;
                gap: 9px;
                margin-top: 22px;
            }

            .btn {
                width: 100%;
                text-align: center;
                display: inline-flex;
                justify-content: center;
                padding: 13px 16px;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="panel">

        <div class="top">
            <div class="top-left">
                <div class="page-badge">➕ ITEM MASTER</div>
                <h2>상품 추가</h2>
                <div class="top-sub">신규 상품 마스터를 등록합니다.</div>
            </div>
            <a class="back" href="${pageContext.request.contextPath}/dashboard">대시보드</a>
        </div>

        <div class="content">

            <c:if test="${not empty error}">
                <div class="alert-error">${error}</div>
            </c:if>

            <c:if test="${not empty message}">
                <div class="alert-success">${message}</div>
            </c:if>

            <div class="desc">
                관리자용 신규 상품 등록 화면입니다.<br>
                상품 추가에서는 모델 마스터만 등록합니다.<br>
                현재재고는 입력하지 않고 처음 등록 시 자동으로 0으로 저장됩니다.<br>
                색상과 경도는 포장 지시 / 수출 지시 등록 화면에서 선택합니다.<br>
                기본 등록값: TIRE = MIDNIGHT/R, ARMOUR = RED/R, TUBELESS = BLACK/R
            </div>

            <form id="itemForm"
                  action="${pageContext.request.contextPath}/admin/item/new"
                  method="post">

                <input type="hidden" id="color" name="color" value="">
                <input type="hidden" id="hardness" name="hardness" value="R">
                <input type="hidden" id="currentQty" name="currentQty" value="0">

                <div class="form-grid">

                    <div class="form-group">
                        <label>상품 종류 <span class="required">*</span></label>
                        <select id="productType" name="productType" required onchange="changeProductType()">
                            <option value="">선택하세요</option>
                            <option value="TIRE">TIRE</option>
                            <option value="ARMOUR">ARMOUR</option>
                            <option value="TUBELESS">TUBELESS</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>모델 / 사이즈 <span class="required">*</span></label>
                        <input type="text"
                               id="modelName"
                               name="modelName"
                               placeholder="예: 46-622, 27.5 Pro"
                               required>
                        <div class="example">예: 46-622 / 700x25C / 27.5 Pro</div>
                    </div>

                    <div class="form-group">
                        <label>기본수량 <span class="required">*</span></label>
                        <input type="number"
                               id="baseQty"
                               name="baseQty"
                               min="1"
                               required
                               placeholder="예: 20">
                    </div>

                </div>

                <div class="btn-row">
                    <a class="btn btn-gray" href="${pageContext.request.contextPath}/stock/list">재고 목록</a>
                    <button type="submit" class="btn btn-blue">상품 등록</button>
                </div>

            </form>

        </div>

    </div>

</div>

<script>
    const form = document.getElementById("itemForm");

    function changeProductType() {
        const productType = document.getElementById("productType").value;
        const color = document.getElementById("color");
        const hardness = document.getElementById("hardness");

        hardness.value = "R";

        if (productType === "TIRE") {
            color.value = "MIDNIGHT";
            return;
        }

        if (productType === "ARMOUR") {
            color.value = "RED";
            return;
        }

        if (productType === "TUBELESS") {
            color.value = "BLACK";
            return;
        }

        color.value = "";
        hardness.value = "R";
    }

    function normalizeInputs() {
        const modelName = document.getElementById("modelName");
        modelName.value = modelName.value.trim();

        const productType = document.getElementById("productType").value;
        const color = document.getElementById("color");
        const hardness = document.getElementById("hardness");
        const currentQty = document.getElementById("currentQty");

        hardness.value = "R";
        currentQty.value = "0";

        if (productType === "TIRE") {
            color.value = "MIDNIGHT";
        } else if (productType === "ARMOUR") {
            color.value = "RED";
        } else if (productType === "TUBELESS") {
            color.value = "BLACK";
        } else {
            color.value = "";
        }
    }

    async function checkDuplicate() {
        normalizeInputs();

        const productType = document.getElementById("productType").value;
        const modelName = document.getElementById("modelName").value.trim();
        const color = document.getElementById("color").value;
        const hardness = document.getElementById("hardness").value;

        if (!productType || !modelName || !color || !hardness) {
            return false;
        }

        const url =
            "${pageContext.request.contextPath}/api/items/exists"
            + "?productType=" + encodeURIComponent(productType)
            + "&modelName=" + encodeURIComponent(modelName)
            + "&color=" + encodeURIComponent(color)
            + "&hardness=" + encodeURIComponent(hardness);

        const response = await fetch(url);
        const exists = await response.json();

        if (exists === true) {
            alert(
                "이미 등록된 상품입니다.\n\n"
                + productType + " / "
                + modelName + " / "
                + color + " / "
                + hardness
            );
            return true;
        }

        return false;
    }

    form.addEventListener("submit", async function (e) {
        e.preventDefault();

        normalizeInputs();

        const productType = document.getElementById("productType").value;
        const modelName = document.getElementById("modelName").value.trim();
        const baseQty = Number(document.getElementById("baseQty").value);

        if (!productType) {
            alert("상품 종류를 선택하세요.");
            return;
        }

        if (!modelName) {
            alert("모델 / 사이즈를 입력하세요.");
            return;
        }

        if (baseQty <= 0) {
            alert("기본수량은 1 이상 입력해야 합니다.");
            return;
        }

        const duplicated = await checkDuplicate();

        if (duplicated) {
            return;
        }

        form.submit();
    });

    document.getElementById("modelName").addEventListener("blur", checkDuplicate);
</script>

</body>
</html>