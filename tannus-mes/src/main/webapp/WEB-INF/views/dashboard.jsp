<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="layout/header.jsp" %>

<div class="container-fluid" style="max-width: 1280px; margin: 0 auto;">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="page-title mb-0">대시보드</h2>
        <div class="text-muted small">
            접속 계정: <strong>${sessionScope.loginUser}</strong>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/inout/in" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title mb-3">입고 등록</h5>
                        <p class="text-muted mb-0">
                            상품 입고를 등록하고 상세 항목을 추가합니다.
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/inout/out" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title mb-3">출고 등록</h5>
                        <p class="text-muted mb-0">
                            상품 출고를 등록하고 이력을 남깁니다.
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/inout/list" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title mb-3">입출고 내역 조회</h5>
                        <p class="text-muted mb-0">
                            입고/출고 내역을 조회하고 상세 내용을 확인합니다.
                        </p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/stock/list" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body">
                        <h5 class="card-title mb-3">재고 현황</h5>
                        <p class="text-muted mb-0">
                            현재 재고 현황을 조회합니다.
                        </p>
                    </div>
                </div>
            </a>
        </div>
    </div>

</div>

<%@ include file="layout/footer.jsp" %>