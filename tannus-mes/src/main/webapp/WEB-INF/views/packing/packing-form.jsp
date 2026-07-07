<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<div class="row mb-3">
    <div class="col-12 d-flex justify-content-between align-items-center">
        <div class="page-title">
            입고 등록
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/inout/list"
               class="btn btn-outline-secondary">
                목록으로
            </a>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-body">

        <form id="inForm" method="post" action="${pageContext.request.contextPath}/inout/in">

            <!-- 입력 방식 선택 -->
            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label">입력 방식</label>
                    <div class="d-flex gap-2">
                        <button type="button" id="btnManualMode" class="btn btn-primary">
                            수기 입력
                        </button>
                        <button type="button" id="btnScanMode" class="btn btn-outline-secondary">
                            QR / 바코드 스캔 열기
                        </button>
                    </div>
                    <div class="form-text">
                        수기 입력과 스캔 입력을 둘 다 사용할 수 있습니다.
                    </div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">스캔 결과</label>
                    <input type="text" id="scanResult" class="form-control"
                           placeholder="예: TIRE|40-622|MIDNIGHT|R" readonly>
                </div>
            </div>

            <!-- 스캐너 영역 -->
            <div id="scannerWrapper" class="card mb-4" style="display:none; background: rgba(255,255,255,0.55);">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">QR / 바코드 스캔</h6>
                        <button type="button" id="btnCloseScanner" class="btn btn-sm btn-outline-danger">
                            스캔 닫기
                        </button>
                    </div>

                    <div class="row g-3 align-items-start">
                        <div class="col-md-6">
                            <div id="reader" style="width:100%; max-width:420px;"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="alert alert-info mb-2">
                                QR 또는 바코드를 카메라에 비춰주세요.
                            </div>
                            <div class="small text-muted">
                                지원 예시:<br>
                                <code>TIRE|40-622|MIDNIGHT|R</code><br>
                                <code>ARMOUR|47-559|RED|R</code><br>
                                <code>TUBELESS|27.5 (Pro)|BLACK|R</code>
                            </div>

                            <hr>

                            <label class="form-label">테스트용 직접 입력</label>
                            <div class="input-group">
                                <input type="text" id="manualScanInput" class="form-control"
                                       placeholder="예: TIRE|40-622|MIDNIGHT|R">
                                <button type="button" id="btnApplyScanText" class="btn btn-outline-primary">
                                    적용
                                </button>
                            </div>
                            <div class="form-text">
                                실제 카메라 스캔이 어렵다면 테스트 문자열로도 적용할 수 있습니다.
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ✅ 1. 상단 선택 영역 -->
            <div class="row g-3">

                <!-- 상품 종류 -->
                <div class="col-md-3">
                    <label class="form-label required">상품 종류</label>
                    <select id="productType" class="form-select" required>
                        <option value="">선택하세요</option>
                        <option value="TIRE">타이어 (Tire)</option>
                        <option value="ARMOUR">아머 (Armour)</option>
                        <option value="TUBELESS">튜브리스 (Tubeless)</option>
                    </select>
                </div>

                <!-- 모델 / 사이즈 -->
                <div class="col-md-3">
                    <label class="form-label required">모델 / 사이즈 (Model / Size)</label>

                    <select id="modelTire" class="form-select type-block" style="display:none;">
                        <option value="">선택</option>
                        <option value="40-622">40-622</option>
                        <option value="32-622">32-622</option>
                        <option value="51-559">51-559</option>
                        <option value="44-559">44-559</option>
                        <option value="35-590">35-590</option>
                        <option value="35-559">35-559</option>
                        <option value="44-507">44-507</option>
                        <option value="40-540">40-540</option>
                        <option value="40-501">40-501</option>
                        <option value="51-406">51-406</option>
                        <option value="40-406">40-406</option>
                        <option value="40-355">40-355</option>
                        <option value="40-349">40-349</option>
                        <option value="40-305">40-305</option>
                        <option value="28-622">28-622</option>
                        <option value="25-622">25-622</option>
                        <option value="23-622">23-622</option>
                        <option value="28-451">28-451</option>
                        <option value="32-406">32-406</option>
                        <option value="32-349">32-349</option>
                        <option value="32-305">32-305</option>
                    </select>

                    <select id="modelArmour" class="form-select type-block" style="display:none;">
                        <option value="">선택</option>
                        <option value="47-559">47-559</option>
                        <option value="63-559">63-559</option>
                        <option value="63-584">63-584</option>
                        <option value="40-622">40-622</option>
                        <option value="47-622">47-622</option>
                        <option value="63-622">63-622</option>
                        <option value="63-406">63-406</option>
                        <option value="63-507">63-507</option>
                        <option value="34-622">34-622</option>
                        <option value="54-559">54-559</option>
                        <option value="50-406">50-406</option>
                        <option value="75-584">75-584</option>
                        <option value="75-622">75-622</option>
                        <option value="40-540">40-540</option>
                        <option value="75-559">75-559</option>
                        <option value="34-590">34-590</option>
                        <option value="37-540">37-540</option>
                        <option value="120-559">120-559</option>
                        <option value="100-406">100-406</option>
                        <option value="120-406">120-406</option>
                        <option value="100-507">100-507</option>
                        <option value="(89-100)-406">(89-100)-406</option>
                        <option value="80-90-17">80-90-17</option>
                        <option value="70-90-17">70-90-17</option>
                    </select>

                    <select id="modelTubeless" class="form-select type-block" style="display:none;">
                        <option value="">선택</option>
                        <option value="27.5 (Pro)">27.5 (Pro)</option>
                        <option value="29 (Pro)">29 (Pro)</option>
                        <option value="27.5 (Fusion)">27.5 (Fusion)</option>
                        <option value="29 (Fusion)">29 (Fusion)</option>
                        <option value="26mm Lite">26mm Lite</option>
                        <option value="32mm Lite">32mm Lite</option>
                        <option value="27.5 Lite (32mm)">27.5 Lite (32mm)</option>
                    </select>
                </div>

                <!-- 색상 -->
                <div class="col-md-3">
                    <label class="form-label required">색상 (Color)</label>
                    <select id="color" class="form-select" required>
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

                <!-- 경도 -->
                <div class="col-md-3">
                    <label class="form-label required">경도 (Hardness)</label>
                    <select id="hardness" class="form-select" required>
                        <option value="">선택</option>
                        <option value="S">S</option>
                        <option value="R">R</option>
                        <option value="H">H</option>
                    </select>
                </div>

                <!-- 창고 위치 -->
                <div class="col-md-6">
                    <label class="form-label required">창고 위치</label>

                    <div class="row g-2">
                        <div class="col-3">
                            <select id="whZone" class="form-select">
                                <option value="">동</option>
                                <option value="A">A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="E">E</option>
                                <option value="F">F</option>
                                <option value="G">G</option>
                                <option value="H">H</option>
                                <option value="I">I</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <select id="whRow" class="form-select">
                                <option value="">열</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <select id="whCol" class="form-select">
                                <option value="">단</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                        <div class="col-3">
                            <select id="whSide" class="form-select">
                                <option value="">좌/우</option>
                                <option value="좌">좌</option>
                                <option value="우">우</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-text mt-1">
                        선택된 위치:
                        <span id="locationPreview" class="fw-semibold text-primary"></span>
                    </div>
                </div>

                <!-- 수량 -->
                <div class="col-md-3">
                    <label class="form-label required">수량 (Qty)</label>
                    <input type="number" id="qty" class="form-control" min="1" value="1" required>
                </div>

                <!-- 항목 추가 버튼 -->
                <div class="col-md-3 d-flex align-items-end">
                    <button type="button" id="btnAdd"
                            class="btn btn-dark w-100">
                        추가(Add)
                    </button>
                </div>
            </div>

            <hr class="my-4">

            <!-- ✅ 2. 추가된 상품 리스트 -->
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                    <tr>
                        <th>상품명</th>
                        <th style="width: 120px;">수량</th>
                        <th style="width: 180px;">창고 위치</th>
                        <th style="width: 80px;">삭제</th>
                    </tr>
                    </thead>
                    <tbody id="itemTableBody">
                    </tbody>
                </table>
            </div>

            <!-- 비고 / 작업자 -->
            <div class="row g-3 mt-3">
                <div class="col-md-6">
                    <label class="form-label">비고</label>
                    <input type="text" name="remark" class="form-control"
                           placeholder="비고 사항을 입력하세요.">
                </div>
                <div class="col-md-6">
                    <label class="form-label">작업자</label>
                    <input type="text" name="workerName" class="form-control"
                           value="MES-USER01">
                </div>
            </div>

            <input type="hidden" id="detailJson" name="detailJson"/>

            <div class="col-12 text-end mt-4">
                <button type="submit" class="btn btn-primary">
                    입고 확정
                </button>
            </div>
        </form>
    </div>
</div>

<!-- html5-qrcode -->
<script src="https://unpkg.com/html5-qrcode"></script>

<script>
    (function () {
        const typeSelect = document.getElementById('productType');
        const modelTire = document.getElementById('modelTire');
        const modelArmour = document.getElementById('modelArmour');
        const modelTubeless = document.getElementById('modelTubeless');
        const typeBlocks = document.querySelectorAll('.type-block');

        const colorSel = document.getElementById('color');
        const hardnessSel = document.getElementById('hardness');
        const whZone = document.getElementById('whZone');
        const whRow = document.getElementById('whRow');
        const whCol = document.getElementById('whCol');
        const whSide = document.getElementById('whSide');
        const qtyInput = document.getElementById('qty');

        const locationPreview = document.getElementById('locationPreview');
        const btnAdd = document.getElementById('btnAdd');
        const tableBody = document.getElementById('itemTableBody');
        const form = document.getElementById('inForm');
        const detailJsonInput = document.getElementById('detailJson');

        const btnScanMode = document.getElementById('btnScanMode');
        const btnManualMode = document.getElementById('btnManualMode');
        const btnCloseScanner = document.getElementById('btnCloseScanner');
        const scannerWrapper = document.getElementById('scannerWrapper');
        const scanResult = document.getElementById('scanResult');
        const manualScanInput = document.getElementById('manualScanInput');
        const btnApplyScanText = document.getElementById('btnApplyScanText');

        let detailList = [];
        let html5QrCode = null;
        let scannerRunning = false;

        function updateModelSelect() {
            typeBlocks.forEach(el => el.style.display = 'none');

            const v = typeSelect.value;
            if (v === 'TIRE') modelTire.style.display = 'block';
            else if (v === 'ARMOUR') modelArmour.style.display = 'block';
            else if (v === 'TUBELESS') modelTubeless.style.display = 'block';
        }

        function applyTypeRule() {
            const type = typeSelect.value;

            colorSel.disabled = false;
            hardnessSel.disabled = false;

            if (type === 'TUBELESS') {
                colorSel.value = 'BLACK';
                colorSel.disabled = true;
            } else if (type === 'ARMOUR') {
                colorSel.value = 'RED';
                colorSel.disabled = true;
            } else if (type === 'TIRE') {
                if (!colorSel.value) colorSel.value = 'MIDNIGHT';
                if (!hardnessSel.value) hardnessSel.value = 'R';
            }

            hardnessSel.required = true;
        }

        typeSelect.addEventListener('change', function () {
            updateModelSelect();
            applyTypeRule();
        });

        function updateLocationPreview() {
            const z = whZone.value;
            const r = whRow.value;
            const c = whCol.value;
            const s = whSide.value;

            if (z && r && c && s) {
                locationPreview.textContent = z + '-' + r + '-' + c + '(' + s + ')';
            } else {
                locationPreview.textContent = '';
            }
        }

        [whZone, whRow, whCol, whSide].forEach(el =>
            el.addEventListener('change', updateLocationPreview)
        );

        function renderTable() {
            tableBody.innerHTML = '';

            detailList.forEach((item, idx) => {
                const tr = document.createElement('tr');

                const nameTd = document.createElement('td');
                nameTd.textContent = item.displayName;

                const qtyTd = document.createElement('td');
                qtyTd.textContent = item.qty;

                const locTd = document.createElement('td');
                locTd.textContent = item.location;

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
                tr.appendChild(qtyTd);
                tr.appendChild(locTd);
                tr.appendChild(delTd);

                tableBody.appendChild(tr);
            });
        }

        function getSelectedModel() {
            const type = typeSelect.value;
            if (type === 'TIRE') return modelTire.value;
            if (type === 'ARMOUR') return modelArmour.value;
            if (type === 'TUBELESS') return modelTubeless.value;
            return '';
        }

        function setModelByType(type, model) {
            if (type === 'TIRE') modelTire.value = model;
            else if (type === 'ARMOUR') modelArmour.value = model;
            else if (type === 'TUBELESS') modelTubeless.value = model;
        }

        function applyScannedData(rawText) {
            if (!rawText) {
                alert('스캔 결과가 비어 있습니다.');
                return;
            }

            const parts = rawText.split('|').map(v => v.trim());

            if (parts.length < 4) {
                alert('QR/바코드 형식이 올바르지 않습니다.\\n예: TIRE|40-622|MIDNIGHT|R');
                return;
            }

            const type = parts[0];
            const model = parts[1];
            const color = parts[2];
            const hardness = parts[3];

            const validTypes = ['TIRE', 'ARMOUR', 'TUBELESS'];
            if (!validTypes.includes(type)) {
                alert('지원하지 않는 상품 종류입니다: ' + type);
                return;
            }

            typeSelect.value = type;
            updateModelSelect();
            applyTypeRule();
            setModelByType(type, model);

            if (type === 'TIRE') {
                colorSel.disabled = false;
                colorSel.value = color;
            } else if (type === 'ARMOUR') {
                colorSel.value = 'RED';
            } else if (type === 'TUBELESS') {
                colorSel.value = 'BLACK';
            }

            hardnessSel.disabled = false;
            hardnessSel.value = hardness;

            scanResult.value = rawText;
            alert('스캔 적용 완료\\n상품 정보가 자동 입력되었습니다.');
        }

        btnAdd.addEventListener('click', function () {
            const type = typeSelect.value;
            if (!type) {
                alert('상품 종류를 선택하세요.');
                typeSelect.focus();
                return;
            }

            const model = getSelectedModel();
            if (!model) {
                alert('모델/사이즈를 선택하세요.');
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

            const z = whZone.value, r = whRow.value, c = whCol.value, s = whSide.value;
            if (!z || !r || !c || !s) {
                alert('창고 위치를 모두 선택하세요.');
                whZone.focus();
                return;
            }
            const location = z + '-' + r + '-' + c + '(' + s + ')';

            const qty = parseInt(qtyInput.value || '0', 10);
            if (!qty || qty < 1) {
                alert('수량을 1개 이상 입력하세요.');
                qtyInput.focus();
                return;
            }

            const colorVal = colorSel.value;
            const hardnessVal = hardnessSel.value;

            const displayName = type + ' / ' + model + ' / ' + colorVal + ' / ' + hardnessVal;

            detailList.push({
                type: type,
                model: model,
                color: colorVal,
                hardness: hardnessVal,
                location: location,
                qty: qty,
                displayName: displayName
            });

            renderTable();
        });

        form.addEventListener('submit', function (e) {
            if (detailList.length === 0) {
                e.preventDefault();
                alert('입고할 상품을 한 개 이상 추가하세요.');
                return;
            }

            detailJsonInput.value = JSON.stringify(detailList);
        });

        async function startScanner() {
            if (scannerRunning) return;

            scannerWrapper.style.display = 'block';

            try {
                html5QrCode = new Html5Qrcode("reader");

                await html5QrCode.start(
                    { facingMode: "environment" },
                    {
                        fps: 10,
                        qrbox: { width: 250, height: 250 }
                    },
                    function (decodedText) {
                        applyScannedData(decodedText);
                        stopScanner();
                    },
                    function (errorMessage) {
                        // 계속 발생하는 중간 스캔 에러는 무시
                    }
                );

                scannerRunning = true;
            } catch (e) {
                alert('카메라를 시작할 수 없습니다.\\n브라우저 카메라 권한을 확인하세요.');
                console.error(e);
            }
        }

        async function stopScanner() {
            if (html5QrCode && scannerRunning) {
                try {
                    await html5QrCode.stop();
                    await html5QrCode.clear();
                } catch (e) {
                    console.error(e);
                }
            }
            scannerRunning = false;
            html5QrCode = null;
            document.getElementById('reader').innerHTML = '';
            scannerWrapper.style.display = 'none';
        }

        btnScanMode.addEventListener('click', function () {
            startScanner();
        });

        btnCloseScanner.addEventListener('click', function () {
            stopScanner();
        });

        btnManualMode.addEventListener('click', function () {
            scannerWrapper.style.display = 'none';
        });

        btnApplyScanText.addEventListener('click', function () {
            const value = manualScanInput.value.trim();
            applyScannedData(value);
        });

        updateModelSelect();
        updateLocationPreview();
        applyTypeRule();
    })();
</script>

<jsp:include page="../layout/footer.jsp" />