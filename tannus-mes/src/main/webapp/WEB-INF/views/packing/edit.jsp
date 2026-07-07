<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp" />

<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold">포장 지시 수정</h2>
            <p class="text-muted mb-0">요청일, 상태, 비고를 수정합니다.</p>
        </div>

        <a href="${pageContext.request.contextPath}/packing/detail/${order.id}"
           class="btn btn-outline-secondary">
            상세로
        </a>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">

            <form method="post"
                  action="${pageContext.request.contextPath}/packing/edit/${order.id}">

                <div class="mb-3">
                    <label class="form-label">지시 번호</label>
                    <input type="text" class="form-control" value="${order.id}" readonly>
                </div>

                <div class="mb-3">
                    <label class="form-label">요청일</label>
                    <input type="date"
                           name="requestDate"
                           class="form-control"
                           value="${order.requestDate}"
                           required>
                </div>

                <div class="mb-3">
                    <label class="form-label">상태</label>
                    <select name="status" class="form-select">
                        <option value="REQUESTED"
                                <c:if test="${order.status eq 'REQUESTED'}">selected</c:if>>
                            포장대기
                        </option>

                        <option value="READY_TO_SHIP"
                                <c:if test="${order.status eq 'READY_TO_SHIP'}">selected</c:if>>
                            포장완료
                        </option>

                        <option value="SHIPPED"
                                <c:if test="${order.status eq 'SHIPPED'}">selected</c:if>>
                            출고완료
                        </option>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">비고</label>
                    <textarea name="remark"
                              class="form-control"
                              rows="4">${order.remark}</textarea>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/packing/list"
                       class="btn btn-outline-secondary">
                        목록으로
                    </a>

                    <button type="submit" class="btn btn-primary">
                        수정 저장
                    </button>
                </div>

            </form>

        </div>
    </div>

</div>

<jsp:include page="../layout/footer.jsp" />