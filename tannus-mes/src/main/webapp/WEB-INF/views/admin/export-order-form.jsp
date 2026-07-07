<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수출 지시 등록</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", Arial, sans-serif;
            background:
                    radial-gradient(circle at 10% 10%, rgba(14, 165, 233, 0.12), transparent 30%),
                    linear-gradient(135deg, #f8fbff 0%, #eef7ff 48%, #dff2ff 100%);
            color: #0f172a;
        }

        .export-page {
            max-width: 1180px;
            margin: 0 auto;
            padding: 34px 20px 48px;
        }

        .export-hero {
            position: relative;
            overflow: hidden;
            border-radius: 24px;
            padding: 24px 28px;
            margin-bottom: 18px;
            color: #0f172a;
            background:
                    radial-gradient(circle at 92% 10%, rgba(34, 197, 94, 0.20), transparent 34%),
                    linear-gradient(135deg, #ffffff 0%, #eef7ff 48%, #dcfce7 100%);
            border: 1px solid rgba(148, 163, 184, 0.24);
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.10);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
        }

        .export-hero:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -80px;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: rgba(22, 163, 74, 0.10);
        }

        .export-title {
            position: relative;
            margin: 0;
            font-size: 28px;
            font-weight: 900;
            letter-spacing: -0.6px;
            color: #166534;
        }

        .export-subtitle {
            position: relative;
            margin-top: 8px;
            margin-bottom: 0;
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .hero-badge {
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 7px 12px;
            border-radius: 999px;
            background: rgba(34, 197, 94, 0.13);
            color: #15803d;
            font-size: 12px;
            font-weight: 800;
            margin-bottom: 10px;
        }

        .hero-actions {
            position: relative;
            display: flex;
            gap: 8px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .export-card {
            border: 0;
            border-radius: 24px;
            overflow: hidden;
            background: rgba(255,255,255,0.94);
            box-shadow: 0 18px 45px rgba(15, 23, 42, 0.10);
        }

        .export-card .card-body {
            padding: 24px;
        }

        .section-panel {
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 18px;
            background: linear-gradient(180deg, #ffffff 0%, #f8fbff 100%);
        }

        .section-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 12px;
            font-size: 14px;
            font-weight: 900;
            color: #0f172a;
        }

        .section-title:before {
            content: "";
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: #22c55e;
            box-shadow: 0 0 0 5px rgba(34, 197, 94, 0.12);
        }

        .mode-button-wrap .btn,
        .btn {
            border-radius: 12px;
        }

        .excel-guide-box {
            border: 1px solid #bbf7d0;
            border-radius: 14px;
            padding: 12px 14px;
            background: #f0fdf4;
            color: #14532d;
            font-size: 13px;
            font-weight: 800;
            word-break: keep-all;
        }

        .upload-guide {
            border: 0;
            border-radius: 20px;
            padding: 18px 20px;
            background:
                    linear-gradient(135deg, rgba(34, 197, 94, 0.13), rgba(14, 165, 233, 0.10)),
                    #f0fdf4;
            color: #064e3b;
            box-shadow: inset 0 0 0 1px rgba(16, 185, 129, 0.16);
        }

        .upload-guide code {
            color: #be185d;
            background: rgba(255,255,255,0.75);
            border-radius: 6px;
            padding: 2px 5px;
            font-weight: 800;
        }

        .input-grid {
            padding: 18px;
            border-radius: 20px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
        }

        .form-label {
            font-size: 13px;
            font-weight: 800;
            color: #334155;
        }

        .required:after {
            content: " *";
            color: #ef4444;
            font-weight: 900;
        }

        .form-control,
        .form-select {
            border-radius: 12px;
            border-color: #cbd5e1;
            min-height: 40px;
            font-size: 13px;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #22c55e;
            box-shadow: 0 0 0 4px rgba(34, 197, 94, 0.14);
        }

        .btn-dark {
            background: #0f172a;
            border-color: #0f172a;
            font-weight: 800;
        }

        .list-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }

        .list-title {
            margin: 0;
            font-size: 16px;
            font-weight: 900;
            color: #0f172a;
        }

        .table-wrap {
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            overflow: hidden;
            background: #fff;
        }

        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: #f1f5f9;
            color: #334155;
            font-size: 13px;
            font-weight: 900;
            border-bottom: 1px solid #e2e8f0;
            padding: 12px;
        }

        .table tbody td {
            vertical-align: middle;
            font-size: 13px;
            padding: 13px 12px;
        }

        .summary-card {
            border: 0 !important;
            border-radius: 20px !important;
            background:
                    radial-gradient(circle at 90% 5%, rgba(34, 197, 94, 0.18), transparent 35%),
                    linear-gradient(135deg, #ffffff, #f8fafc) !important;
            box-shadow: 0 14px 35px rgba(15, 23, 42, 0.08);
        }

        .bottom-panel {
            padding: 18px;
            border-radius: 20px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
        }

        .submit-area {
            display: flex;
            justify-content: flex-end;
            margin-top: 22px;
        }

        #btnSubmitFinal {
            min-width: 180px;
            padding: 11px 18px;
            font-weight: 900;
            border-radius: 14px;
            background: linear-gradient(135deg, #16a34a, #2563eb);
            border: 0;
            box-shadow: 0 12px 24px rgba(22, 163, 74, 0.22);
        }

        @media (max-width: 768px) {
            .export-page {
                padding: 20px 12px 36px;
            }

            .export-hero {
                align-items: flex-start;
                flex-direction: column;
                padding: 20px;
            }

            .export-title {
                font-size: 23px;
            }

            .export-card .card-body {
                padding: 16px;
            }

            .list-head {
                align-items: flex-start;
                flex-direction: column;
            }
        }


        /* =========================
           반응형 추가 적용
           - PC 디자인은 유지
           - 태블릿/모바일에서는 입력폼과 버튼이 세로 정렬
           - 표는 가로 스크롤로 안전하게 처리
        ========================= */
        .table-wrap {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .table-wrap table {
            min-width: 760px;
        }

        .hero-actions .btn {
            white-space: nowrap;
            font-weight: 800;
        }

        @media (max-width: 992px) {
            .export-page {
                max-width: 100%;
                padding: 26px 16px 42px;
            }

            .export-hero {
                align-items: flex-start;
                flex-direction: column;
            }

            .hero-actions {
                width: 100%;
                justify-content: flex-start;
            }

            .hero-actions .btn {
                min-height: 42px;
            }

            .section-panel,
            .input-grid,
            .bottom-panel {
                padding: 16px;
            }

            .upload-guide {
                padding: 16px;
            }
        }

        @media (max-width: 768px) {
            body {
                background:
                        radial-gradient(circle at 10% 8%, rgba(14, 165, 233, 0.12), transparent 30%),
                        linear-gradient(180deg, #f8fbff 0%, #eef7ff 100%);
            }

            .export-page {
                padding: 18px 12px 34px;
            }

            .export-hero {
                border-radius: 20px;
                padding: 20px 18px;
                margin-bottom: 14px;
            }

            .export-title {
                font-size: 24px;
                line-height: 1.25;
            }

            .export-subtitle {
                font-size: 13px;
            }

            .hero-actions {
                display: grid;
                grid-template-columns: 1fr;
                gap: 8px;
            }

            .hero-actions .btn {
                width: 100%;
            }

            .export-card {
                border-radius: 20px;
            }

            .export-card .card-body {
                padding: 14px;
            }

            .section-panel,
            .input-grid,
            .bottom-panel {
                border-radius: 16px;
                padding: 14px;
            }

            .mode-button-wrap,
            .section-panel .d-flex,
            .list-head > div {
                width: 100%;
            }

            .section-panel .d-flex .btn,
            .list-head .btn {
                flex: 1;
            }

            .upload-guide {
                border-radius: 16px;
                padding: 14px;
                font-size: 12px;
            }

            .upload-guide .small {
                font-size: 12px;
                line-height: 1.65;
            }

            .list-head {
                align-items: stretch;
                flex-direction: column;
            }

            .list-head > div {
                align-items: stretch !important;
                flex-direction: column;
            }

            .table-wrap {
                border-radius: 16px;
            }

            .table thead th,
            .table tbody td {
                font-size: 12px;
                padding: 11px 10px;
                white-space: nowrap;
            }

            .summary-card .card-body {
                padding: 14px !important;
            }

            .bottom-panel .col-md-4,
            .bottom-panel .col-md-12 {
                width: 100%;
            }

            .submit-area {
                margin-top: 18px;
            }

            #btnSubmitFinal {
                width: 100%;
                min-width: 0;
                min-height: 48px;
            }
        }

        @media (max-width: 480px) {
            .export-page {
                padding: 14px 10px 30px;
            }

            .export-hero {
                padding: 18px 16px;
                border-radius: 18px;
            }

            .hero-badge {
                font-size: 11px;
                padding: 6px 10px;
            }

            .export-title {
                font-size: 22px;
            }

            .export-subtitle br {
                display: none;
            }

            .excel-guide-box {
                font-size: 12px;
                line-height: 1.6;
            }

            .form-label {
                font-size: 12px;
            }

            .form-control,
            .form-select {
                min-height: 42px;
                font-size: 13px;
            }

            .table-wrap table {
                min-width: 720px;
            }
        }

    </style>
</head>
<body>

<div class="export-page">

    <div class="export-hero">
        <div>
            <div class="hero-badge">EXPORT ORDER</div>
            <h1 class="export-title">수출 지시 등록</h1>
            <p class="export-subtitle">
                상품 선택부터 수량 계산, 엑셀 일괄 등록까지 한 화면에서 처리합니다.
            </p>
        </div>

        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="btn btn-outline-primary">
                관리자 홈
            </a>
        </div>
    </div>

    <div class="card export-card">
        <div class="card-body">

            <form id="exportOrderForm"
                  method="post"
                  action="${pageContext.request.contextPath}/admin/export/save"
                  novalidate>

                <div class="row g-3 mb-3 section-panel">
                    <div class="col-md-6">
                        <div class="section-title">입력 방식</div>
                        <div class="d-flex gap-2 flex-wrap">
                            <button type="button" id="btnManualMode" class="btn btn-primary">
                                수기 입력
                            </button>
                            <button type="button" id="btnExcelMode" class="btn btn-outline-success">
                                엑셀파일 추가
                            </button>
                            <input type="file" id="excelFileInput" accept=".xlsx,.xls" style="display:none;">
                        </div>
                        <div class="form-text">
                            수기 입력 또는 엑셀 일괄 등록으로 수출 지시 항목을 추가할 수 있습니다.
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="section-title">엑셀 양식 안내</div>
                        <div class="excel-guide-box">
                            상품종류 | 모델/사이즈 | 색상 | 경도 | 기본수량 | 박스수 | 낱개수량 | 총수량
                        </div>
                    </div>
                </div>

                <div class="alert upload-guide mb-4">
                    <div class="fw-bold mb-1">엑셀 업로드 형식</div>
                    <div class="small">
                        첫 행은 제목행으로 사용합니다.<br>
                        컬럼 순서:
                        <code>상품종류 | 모델/사이즈 | 색상 | 경도 | 기본수량 | 박스수 | 낱개수량 | 총수량</code><br><br>
                        <b>참고:</b><br>
                        - 상품 목록은 관리자 상품 추가 화면에서 등록된 <b>item 테이블</b> 기준으로 불러옵니다.<br>
                        - 상품추가에서 등록한 신규 모델도 바로 선택 목록에 표시됩니다.<br>
                        - 기본수량(E열)은 참고용으로 보여도 됩니다. 업로드 시 DB 기준값을 다시 사용합니다.<br>
                        - 총수량(H열)도 참고용입니다. 업로드 시 재계산합니다.<br>
                        - 실제 입력값은 <b>박스수(F열)</b>, <b>낱개수량(G열)</b> 입니다.<br><br>
                        예시:<br>
                        <code>TIRE | 48-622 | MIDNIGHT | R | 20 | 5 | 3 | 103</code><br>
                        <code>ARMOUR | 47-559 | RED | R | 40 | 2 | 0 | 80</code><br>
                        <code>TUBELESS | 27.5 (Pro) | BLACK | R | 24 | 0 | 7 | 7</code>
                    </div>
                </div>

                <div class="row g-3 input-grid">

                    <div class="col-md-2">
                        <label class="form-label required">상품 종류</label>
                        <select id="productType" class="form-select">
                            <option value="">선택하세요</option>
                            <option value="TIRE">타이어</option>
                            <option value="ARMOUR">아머</option>
                            <option value="TUBELESS">튜브리스</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label required">모델 / 사이즈</label>
                        <select id="modelName" class="form-select">
                            <option value="">상품 종류를 먼저 선택하세요</option>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label required">색상</label>
                        <select id="color" class="form-select">
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

                    <div class="col-md-1">
                        <label class="form-label required">경도</label>
                        <select id="hardness" class="form-select">
                            <option value="">선택</option>
                            <option value="S">S</option>
                            <option value="R">R</option>
                            <option value="H">H</option>
                        </select>
                    </div>

                    <div class="col-md-1">
                        <label class="form-label">기본수량</label>
                        <input type="number" id="baseQty" class="form-control" readonly>
                    </div>

                    <div class="col-md-1">
                        <label class="form-label required">박스수</label>
                        <input type="number" id="boxCount" class="form-control" min="0" value="0">
                    </div>

                    <div class="col-md-1">
                        <label class="form-label required">낱개수량</label>
                        <input type="number" id="eachQty" class="form-control" min="0" value="0">
                    </div>

                    <div class="col-md-1">
                        <label class="form-label">총수량</label>
                        <input type="number" id="totalQty" class="form-control" readonly>
                    </div>

                    <div class="col-md-1 d-flex align-items-end">
                        <button type="button" id="btnAdd" class="btn btn-dark w-100">
                            추가
                        </button>
                    </div>
                </div>

                <hr class="my-4">

                <div class="list-head">
                    <h6 class="list-title">수출 지시 목록</h6>
                    <div class="d-flex align-items-center gap-2">
                        <span class="text-muted small">아래 목록이 최종 지시 데이터로 저장됩니다.</span>
                        <button type="button" id="btnDeleteAll" class="btn btn-sm btn-outline-danger">전체삭제</button>
                    </div>
                </div>

                <div class="table-responsive table-wrap">
                    <table class="table table-hover">
                        <thead class="table-light">
                        <tr>
                            <th>상품명</th>
                            <th style="width:100px;">기본수량</th>
                            <th style="width:100px;">박스수</th>
                            <th style="width:110px;">낱개수량</th>
                            <th style="width:110px;">총수량</th>
                            <th style="width:80px;">삭제</th>
                        </tr>
                        </thead>
                        <tbody id="itemTableBody"></tbody>
                    </table>
                </div>

                <div class="row mt-3">
                    <div class="col-md-6 ms-auto">
                        <div class="card border-0 summary-card">
                            <div class="card-body py-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="fw-bold">전체 박스수</span>
                                    <span id="summaryBoxCount" class="text-primary fw-bold">0</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="fw-bold">전체 낱개수량</span>
                                    <span id="summaryEachQty" class="text-warning fw-bold">0</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="fw-bold">전체 수량</span>
                                    <span id="summaryTotalQty" class="text-success fw-bold">0</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-3 mt-3 bottom-panel">
                    <div class="col-md-4">
                        <label class="form-label required">요청일</label>
                        <input type="date" id="requestDate" name="requestDate" class="form-control">
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">담당팀</label>
                        <input type="text" class="form-control" value="물류팀" readonly>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">지시자</label>
                        <input type="text" name="workerName" class="form-control" value="${loginUser}" readonly>
                    </div>

                    <div class="col-md-12">
                        <label class="form-label">비고</label>
                        <input type="text" name="remark" class="form-control" placeholder="비고 사항을 입력하세요.">
                    </div>
                </div>

                <input type="hidden" id="detailJson" name="detailJson"/>

                <div class="submit-area">
                    <button type="button" id="btnSubmitFinal" class="btn btn-primary">
                        수출 지시 확정
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/xlsx/dist/xlsx.full.min.js"></script>

    <script>
        (function () {
            const contextPath = '${pageContext.request.contextPath}';

            const form = document.getElementById('exportOrderForm');
            form.noValidate = true;

            const typeSelect = document.getElementById('productType');
            const modelSelect = document.getElementById('modelName');

            const colorSel = document.getElementById('color');
            const hardnessSel = document.getElementById('hardness');
            const baseQtyInput = document.getElementById('baseQty');
            const boxCountInput = document.getElementById('boxCount');
            const eachQtyInput = document.getElementById('eachQty');
            const totalQtyInput = document.getElementById('totalQty');
            const requestDateInput = document.getElementById('requestDate');

            const btnAdd = document.getElementById('btnAdd');
            const btnSubmitFinal = document.getElementById('btnSubmitFinal');
            const tableBody = document.getElementById('itemTableBody');
            const detailJsonInput = document.getElementById('detailJson');

            const summaryBoxCount = document.getElementById('summaryBoxCount');
            const summaryEachQty = document.getElementById('summaryEachQty');
            const summaryTotalQty = document.getElementById('summaryTotalQty');

            const btnExcelMode = document.getElementById('btnExcelMode');
            const excelFileInput = document.getElementById('excelFileInput');
            const btnDeleteAll = document.getElementById('btnDeleteAll');

            let detailList = [];
            let currentItems = [];

            function sanitizeNonNegativeInteger(value) {
                const n = parseInt(value || '0', 10);
                if (isNaN(n) || n < 0) return 0;
                return n;
            }

            function setSelectValue(select, value) {
                if (value === undefined || value === null) {
                    select.value = '';
                    return;
                }

                const stringValue = String(value).trim();

                let exists = false;
                for (let i = 0; i < select.options.length; i++) {
                    if (select.options[i].value === stringValue) {
                        exists = true;
                        break;
                    }
                }

                if (!exists && stringValue !== '') {
                    const option = document.createElement('option');
                    option.value = stringValue;
                    option.textContent = stringValue;
                    select.appendChild(option);
                }

                select.value = stringValue;
            }

            function clearModelSelect(message) {
                modelSelect.innerHTML = '';
                const option = document.createElement('option');
                option.value = '';
                option.textContent = message || '선택';
                modelSelect.appendChild(option);
            }

            function clearEntryArea() {
                typeSelect.value = '';
                currentItems = [];
                clearModelSelect('상품 종류를 먼저 선택하세요');

                colorSel.disabled = false;
                hardnessSel.disabled = false;
                colorSel.value = '';
                hardnessSel.value = '';

                baseQtyInput.value = '';
                boxCountInput.value = 0;
                eachQtyInput.value = 0;
                totalQtyInput.value = '';
            }

            function updateTotalQty() {
                const baseQty = sanitizeNonNegativeInteger(baseQtyInput.value);
                const boxCount = sanitizeNonNegativeInteger(boxCountInput.value);
                const eachQty = sanitizeNonNegativeInteger(eachQtyInput.value);

                boxCountInput.value = boxCount;
                eachQtyInput.value = eachQty;

                if (baseQty <= 0) {
                    totalQtyInput.value = '';
                    return;
                }

                totalQtyInput.value = (baseQty * boxCount) + eachQty;
            }

            function applyTypeRuleOnly() {
                const type = typeSelect.value;

                colorSel.disabled = false;
                hardnessSel.disabled = false;

                if (type === 'TIRE') {
                    if (!colorSel.value) colorSel.value = 'MIDNIGHT';
                    if (!hardnessSel.value) hardnessSel.value = 'R';
                } else if (type === 'ARMOUR') {
                    colorSel.value = 'RED';
                    hardnessSel.value = 'R';
                    colorSel.disabled = true;
                    hardnessSel.disabled = true;
                } else if (type === 'TUBELESS') {
                    colorSel.value = 'BLACK';
                    hardnessSel.value = 'R';
                    colorSel.disabled = true;
                    hardnessSel.disabled = true;
                } else {
                    colorSel.value = '';
                    hardnessSel.value = '';
                }
            }

            function buildModelOptions(items) {
                clearModelSelect('선택');

                if (!items || items.length === 0) {
                    clearModelSelect('등록된 상품이 없습니다');
                    return;
                }

                currentItems = [];

                const modelMap = new Map();

                items.forEach(function (item) {
                    if (!item || !item.modelName) return;

                    const key = String(item.modelName).trim();

                    if (!modelMap.has(key)) {
                        modelMap.set(key, item);
                    }
                });

                currentItems = Array.from(modelMap.values());

                currentItems.forEach(function (item, index) {
                    const option = document.createElement('option');
                    option.value = String(index);
                    option.textContent = item.modelName;
                    modelSelect.appendChild(option);
                });
            }

            function loadItemsByType(productType) {
                currentItems = [];
                clearModelSelect('불러오는 중...');

                colorSel.disabled = false;
                hardnessSel.disabled = false;
                colorSel.value = '';
                hardnessSel.value = '';
                baseQtyInput.value = '';
                totalQtyInput.value = '';

                if (!productType) {
                    clearModelSelect('상품 종류를 먼저 선택하세요');
                    return;
                }

                fetch(contextPath + '/api/items/by-type?productType=' + encodeURIComponent(productType))
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error('상품 목록 조회 실패');
                        }
                        return response.json();
                    })
                    .then(function (items) {
                        currentItems = Array.isArray(items) ? items : [];
                        buildModelOptions(currentItems);
                        applyTypeRuleOnly();
                    })
                    .catch(function (error) {
                        console.error(error);
                        currentItems = [];
                        clearModelSelect('상품 조회 오류');
                        alert('상품 목록을 불러오지 못했습니다.');
                    });
            }

            function getSelectedItem() {
                const index = modelSelect.value;
                if (index === '') return null;

                const item = currentItems[parseInt(index, 10)];
                return item || null;
            }

            function applySelectedItem() {
                const item = getSelectedItem();

                if (!item) {
                    baseQtyInput.value = '';
                    totalQtyInput.value = '';
                    return;
                }

                setSelectValue(colorSel, item.color);
                setSelectValue(hardnessSel, item.hardness);

                baseQtyInput.value = item.baseQty || 0;

                applyTypeRuleOnly();
                updateTotalQty();
            }

            function updateSummary() {
                let totalBoxes = 0;
                let totalEachQty = 0;
                let totalQty = 0;

                detailList.forEach(function (item) {
                    totalBoxes += item.boxCount;
                    totalEachQty += item.eachQty;
                    totalQty += item.totalQty;
                });

                summaryBoxCount.textContent = totalBoxes;
                summaryEachQty.textContent = totalEachQty;
                summaryTotalQty.textContent = totalQty;
            }

            function renderTable() {
                tableBody.innerHTML = '';

                if (detailList.length === 0) {
                    const tr = document.createElement('tr');
                    const td = document.createElement('td');
                    td.colSpan = 6;
                    td.className = 'text-center text-muted py-4';
                    td.textContent = '추가된 수출 지시 항목이 없습니다.';
                    tr.appendChild(td);
                    tableBody.appendChild(tr);
                } else {
                    detailList.forEach(function (item, idx) {
                        const tr = document.createElement('tr');

                        const nameTd = document.createElement('td');
                        nameTd.textContent = item.displayName;

                        const baseQtyTd = document.createElement('td');
                        baseQtyTd.textContent = item.baseQty;

                        const boxTd = document.createElement('td');
                        boxTd.textContent = item.boxCount;

                        const eachTd = document.createElement('td');
                        eachTd.textContent = item.eachQty;

                        const totalQtyTd = document.createElement('td');
                        totalQtyTd.textContent = item.totalQty;

                        const delTd = document.createElement('td');
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.className = 'btn btn-sm btn-outline-danger';
                        btn.textContent = '삭제';
                        btn.addEventListener('click', function () {
                            detailList.splice(idx, 1);
                            renderTable();
                        });
                        delTd.appendChild(btn);

                        tr.appendChild(nameTd);
                        tr.appendChild(baseQtyTd);
                        tr.appendChild(boxTd);
                        tr.appendChild(eachTd);
                        tr.appendChild(totalQtyTd);
                        tr.appendChild(delTd);

                        tableBody.appendChild(tr);
                    });
                }

                updateSummary();
            }

            function addItemToDetailList(productType, modelName, color, hardness, baseQty, boxCount, eachQty) {
                if (!productType || !modelName || !color || !hardness || !baseQty) {
                    return false;
                }

                const numberBaseQty = sanitizeNonNegativeInteger(baseQty);
                const numberBoxCount = sanitizeNonNegativeInteger(boxCount);
                const numberEachQty = sanitizeNonNegativeInteger(eachQty);

                if (numberBaseQty < 1) {
                    return false;
                }

                if (numberBoxCount === 0 && numberEachQty === 0) {
                    return false;
                }

                const totalQty = (numberBaseQty * numberBoxCount) + numberEachQty;
                const displayName = productType + ' / ' + modelName + ' / ' + color + ' / ' + hardness;

                detailList.push({
                    productType: productType,
                    modelName: modelName,
                    color: color,
                    hardness: hardness,
                    baseQty: numberBaseQty,
                    boxCount: numberBoxCount,
                    eachQty: numberEachQty,
                    totalQty: totalQty,
                    displayName: displayName
                });

                return true;
            }

            function normalizeValue(value) {
                if (value === undefined || value === null) return '';
                return String(value).trim();
            }

            function findExcelHeaderIndex(rows) {
                for (let i = 0; i < rows.length; i++) {
                    const row = rows[i] || [];
                    const col0 = normalizeValue(row[0]);
                    const col1 = normalizeValue(row[1]);

                    if (col0 === '상품종류' && col1 === '모델/사이즈') {
                        return i;
                    }
                }

                return -1;
            }

            function findItemFromCurrentList(productType, modelName) {
                for (let i = 0; i < currentItems.length; i++) {
                    const item = currentItems[i];

                    if (
                        item.productType === productType &&
                        item.modelName === modelName
                    ) {
                        return item;
                    }
                }

                return null;
            }

            async function loadItemsForExcel(productType) {
                return fetch(contextPath + '/api/items/by-type?productType=' + encodeURIComponent(productType))
                    .then(function (response) {
                        if (!response.ok) {
                            throw new Error('상품 목록 조회 실패');
                        }
                        return response.json();
                    });
            }

            async function processExcelRows(rows) {
                if (!rows || rows.length < 2) {
                    alert('엑셀 데이터가 없거나 형식이 올바르지 않습니다.');
                    return;
                }

                const headerIndex = findExcelHeaderIndex(rows);

                if (headerIndex < 0) {
                    alert('엑셀 제목행을 찾지 못했습니다.\n상품종류 | 모델/사이즈 | 색상 | 경도 형식인지 확인하세요.');
                    return;
                }

                let allItems = [];

                try {
                    const tireItems = await loadItemsForExcel('TIRE');
                    const armourItems = await loadItemsForExcel('ARMOUR');
                    const tubelessItems = await loadItemsForExcel('TUBELESS');

                    allItems = []
                        .concat(Array.isArray(tireItems) ? tireItems : [])
                        .concat(Array.isArray(armourItems) ? armourItems : [])
                        .concat(Array.isArray(tubelessItems) ? tubelessItems : []);

                } catch (error) {
                    console.error(error);
                    alert('DB 상품 목록을 불러오지 못했습니다.');
                    return;
                }

                currentItems = allItems;

                let addedCount = 0;
                let skippedCount = 0;

                for (let i = headerIndex + 1; i < rows.length; i++) {
                    const row = rows[i] || [];

                    const productType = normalizeValue(row[0]).toUpperCase();
                    const modelName = normalizeValue(row[1]);
                    let color = normalizeValue(row[2]).toUpperCase();
                    let hardness = normalizeValue(row[3]).toUpperCase();

                    const boxCount = sanitizeNonNegativeInteger(row[5]);
                    const eachQty = sanitizeNonNegativeInteger(row[6]);

                    if (!productType && !modelName) {
                        continue;
                    }

                    if (productType !== 'TIRE' && productType !== 'ARMOUR' && productType !== 'TUBELESS') {
                        skippedCount++;
                        continue;
                    }

                    if (!modelName) {
                        skippedCount++;
                        continue;
                    }

                    if (productType === 'TIRE') {
                        if (!color) color = 'MIDNIGHT';
                        if (!hardness) hardness = 'R';
                    } else if (productType === 'ARMOUR') {
                        color = 'RED';
                        hardness = 'R';
                    } else if (productType === 'TUBELESS') {
                        color = 'BLACK';
                        hardness = 'R';
                    }

                    const item = findItemFromCurrentList(productType, modelName);

                    if (!item) {
                        skippedCount++;
                        continue;
                    }

                    const baseQty = sanitizeNonNegativeInteger(item.baseQty);

                    const added = addItemToDetailList(
                        productType,
                        modelName,
                        color,
                        hardness,
                        baseQty,
                        boxCount,
                        eachQty
                    );

                    if (added) {
                        addedCount++;
                    } else {
                        skippedCount++;
                    }
                }

                renderTable();

                alert(
                    '엑셀 업로드 완료\n\n' +
                    '추가: ' + addedCount + '건\n' +
                    '제외: ' + skippedCount + '건'
                );
            }

            btnAdd.addEventListener('click', function () {
                const type = typeSelect.value;
                if (!type) {
                    alert('상품 종류를 선택하세요.');
                    typeSelect.focus();
                    return;
                }

                const item = getSelectedItem();
                if (!item) {
                    alert('모델/사이즈를 선택하세요.');
                    modelSelect.focus();
                    return;
                }

                if (!colorSel.value) {
                    alert('색상을 선택하세요.');
                    colorSel.focus();
                    return;
                }

                if (!hardnessSel.value) {
                    alert('경도를 선택하세요.');
                    hardnessSel.focus();
                    return;
                }

                const baseQty = sanitizeNonNegativeInteger(baseQtyInput.value);
                if (baseQty < 1) {
                    alert('기본수량이 올바르지 않습니다.\n상품 추가 화면에서 기본수량을 1 이상으로 등록해야 합니다.');
                    return;
                }

                const boxCount = sanitizeNonNegativeInteger(boxCountInput.value);
                const eachQty = sanitizeNonNegativeInteger(eachQtyInput.value);

                if (boxCount === 0 && eachQty === 0) {
                    alert('박스수 또는 낱개수량 중 하나는 입력해야 합니다.');
                    return;
                }

                const added = addItemToDetailList(
                    item.productType,
                    item.modelName,
                    colorSel.value,
                    hardnessSel.value,
                    baseQty,
                    boxCount,
                    eachQty
                );

                if (!added) {
                    alert('항목 추가 중 오류가 발생했습니다.');
                    return;
                }

                renderTable();
                clearEntryArea();
            });

            btnExcelMode.addEventListener('click', function () {
                excelFileInput.click();
            });

            btnDeleteAll.addEventListener('click', function () {
                if (!confirm('전체 목록을 삭제하시겠습니까?')) {
                    return;
                }

                detailList = [];
                renderTable();
            });

            excelFileInput.addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (!file) return;

                const reader = new FileReader();

                reader.onload = function (event) {
                    try {
                        const data = new Uint8Array(event.target.result);
                        const workbook = XLSX.read(data, { type: 'array' });
                        const firstSheetName = workbook.SheetNames[0];
                        const worksheet = workbook.Sheets[firstSheetName];
                        const rows = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

                        processExcelRows(rows);
                    } catch (error) {
                        console.error(error);
                        alert('엑셀 파일을 읽는 중 오류가 발생했습니다.');
                    } finally {
                        excelFileInput.value = '';
                    }
                };

                reader.readAsArrayBuffer(file);
            });

            btnSubmitFinal.addEventListener('click', function () {
                if (!requestDateInput.value) {
                    alert('요청일을 선택하세요.');
                    requestDateInput.focus();
                    return;
                }

                if (detailList.length === 0) {
                    alert('수출 지시 항목을 한 개 이상 추가하세요.');
                    return;
                }

                const saveList = detailList.map(function (item) {
                    return {
                        type: item.productType,
                        model: item.modelName,
                        color: item.color,
                        hardness: item.hardness,
                        baseQty: item.baseQty,
                        boxCount: item.boxCount,
                        eachQty: item.eachQty,
                        totalQty: item.totalQty,
                        displayName: item.displayName
                    };
                });

                detailJsonInput.value = JSON.stringify(saveList);
                form.submit();
            });

            typeSelect.addEventListener('change', function () {
                loadItemsByType(typeSelect.value);
                boxCountInput.value = 0;
                eachQtyInput.value = 0;
            });

            modelSelect.addEventListener('change', applySelectedItem);

            colorSel.addEventListener('change', updateTotalQty);
            hardnessSel.addEventListener('change', updateTotalQty);
            boxCountInput.addEventListener('input', updateTotalQty);
            eachQtyInput.addEventListener('input', updateTotalQty);

            clearEntryArea();
            renderTable();
        })();
    </script>

</div>

</body>
</html>
