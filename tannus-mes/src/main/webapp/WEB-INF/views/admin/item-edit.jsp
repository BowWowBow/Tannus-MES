<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 기본수량 수정</title>

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
                padding: 24px 22px;
            }

            .top .back {
                width: 100%;
                text-align: center;
            }

            .content {
                padding: 22px 20px 26px;
            }

            .form-grid,
            .form-grid.three {
                grid-template-columns: 1fr;
            }

            .btn-row {
                justify-content: stretch;
                flex-direction: column;
            }

            .btn-row .btn,
            .btn-row button {
                width: 100%;
                text-align: center;
            }
        }

        @media (max-width: 560px) {
            .wrap {
                margin: 14px auto;
                padding: 0 10px;
            }

            .panel {
                border-radius: 22px;
            }

            .top {
                padding: 22px 18px;
            }

            .content {
                padding: 18px 16px 22px;
            }

            h2 {
                font-size: 24px;
                line-height: 1.25;
            }

            .top-sub,
            .desc {
                font-size: 12px;
            }

            .desc {
                padding: 14px;
            }

            .result-box {
                padding: 16px;
                border-radius: 18px;
            }

            input,
            select {
                height: 42px;
                font-size: 13px;
            }

            .btn {
                padding: 11px 14px;
                font-size: 13px;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="panel">

        <div class="top">
            <div class="top-left">
                <div class="page-badge">🔢 BASE QTY</div>
                <h2>상품 기본수량 수정</h2>
                <div class="top-sub">등록된 상품의 기본수량만 안전하게 변경합니다.</div>
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
                상품종류와 모델/사이즈를 입력해서 기존 상품을 조회합니다.<br>
                조회 후에는 <b>기본수량만 수정</b>할 수 있습니다.<br>
                상품종류와 모델/사이즈는 조회용이며, 수정 대상은 기본수량 하나입니다.
            </div>

            <form id="searchForm"
                  action="${pageContext.request.contextPath}/admin/item/base-qty/edit"
                  method="get">

                <div class="form-grid">

                    <div class="form-group">
                        <label>상품 종류 <span class="required">*</span></label>
                        <select id="searchProductType" name="productType" required>
                            <option value="">선택하세요</option>
                            <option value="TIRE" ${productType eq 'TIRE' ? 'selected' : ''}>TIRE</option>
                            <option value="ARMOUR" ${productType eq 'ARMOUR' ? 'selected' : ''}>ARMOUR</option>
                            <option value="TUBELESS" ${productType eq 'TUBELESS' ? 'selected' : ''}>TUBELESS</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>모델 / 사이즈 <span class="required">*</span></label>
                        <input type="text"
                               id="searchModelName"
                               name="modelName"
                               value="${modelName}"
                               placeholder="예: 46-622, 27.5 Pro"
                               required>
                        <div class="example">예: 46-622 / 700x25C / 27.5 Pro</div>
                    </div>

                </div>

                <div class="btn-row">
                    <a class="btn btn-gray" href="${pageContext.request.contextPath}/stock/list">재고 목록</a>
                    <button type="submit" class="btn btn-blue">상품 조회</button>
                </div>

            </form>

            <c:if test="${not empty item}">

                <div class="section-line"></div>

                <div class="result-box">

                    <div class="result-title">조회된 상품</div>

                    <form id="updateForm"
                          action="${pageContext.request.contextPath}/admin/item/base-qty/update"
                          method="post">

                        <input type="hidden" name="id" value="${item.id}">

                        <div class="form-grid three">

                            <div class="form-group">
                                <label>상품 종류</label>
                                <input type="text"
                                       value="${item.productType}"
                                       readonly>
                            </div>

                            <div class="form-group">
                                <label>모델 / 사이즈</label>
                                <input type="text"
                                       value="${item.modelName}"
                                       readonly>
                            </div>

                            <div class="form-group">
                                <label>기본수량 <span class="required">*</span></label>
                                <input type="number"
                                       id="baseQty"
                                       name="baseQty"
                                       min="1"
                                       value="${item.baseQty}"
                                       required>
                                <div class="example">이 값만 수정됩니다.</div>
                            </div>

                        </div>

                        <div class="btn-row">
                            <a class="btn btn-gray"
                               href="${pageContext.request.contextPath}/admin/item/base-qty/edit">
                                다시 조회
                            </a>

                            <button type="submit" class="btn btn-green">
                                기본수량 수정
                            </button>
                        </div>

                    </form>

                </div>

            </c:if>

        </div>

    </div>

</div>

<script>
    const searchForm = document.getElementById("searchForm");
    const updateForm = document.getElementById("updateForm");

    searchForm.addEventListener("submit", function(e) {
        const productType = document.getElementById("searchProductType").value;
        const modelName = document.getElementById("searchModelName").value.trim();

        if (!productType) {
            alert("상품 종류를 선택하세요.");
            e.preventDefault();
            return;
        }

        if (!modelName) {
            alert("모델 / 사이즈를 입력하세요.");
            e.preventDefault();
            return;
        }

        document.getElementById("searchModelName").value = modelName;
    });

    if (updateForm) {
        updateForm.addEventListener("submit", function(e) {
            const baseQty = Number(document.getElementById("baseQty").value);

            if (baseQty <= 0) {
                alert("기본수량은 1 이상 입력해야 합니다.");
                e.preventDefault();
                return;
            }

            if (!confirm("기본수량만 수정하시겠습니까?")) {
                e.preventDefault();
            }
        });
    }
</script>

</body>
</html>
