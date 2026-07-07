<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Tannus MES</title>

    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            background:
                radial-gradient(circle at top left, rgba(255,255,255,0.95), transparent 30%),
                radial-gradient(circle at top right, rgba(186,230,253,0.65), transparent 28%),
                linear-gradient(135deg, #F8FBFF 0%, #EAF4FF 45%, #DDEEFF 100%);
            color: #1F2937;
        }

        .tannus-navbar {
            background: linear-gradient(90deg, #42A5F5, #1E88E5);
            box-shadow: 0 4px 16px rgba(30,136,229,0.18);
        }

        .tannus-navbar .navbar-brand,
        .tannus-navbar .nav-link,
        .tannus-navbar .navbar-text {
            color: #ffffff !important;
        }

        .tannus-navbar .nav-link {
            transition: all 0.2s ease;
            border-bottom: 2px solid transparent;
            font-weight: 500;
        }

        .tannus-navbar .nav-link:hover {
            color: #E3F2FD !important;
            border-bottom: 2px solid rgba(255,255,255,0.75);
        }

        .page-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1565C0;
        }

        .card {
            border-radius: 1rem;
            border: 1px solid rgba(255,255,255,0.85);
            background: rgba(255,255,255,0.82);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            box-shadow: 0 10px 24px rgba(30,136,229,0.10);
            color: #1F2937;
        }

        .card .text-muted {
            color: #6B7280 !important;
        }

        .form-control,
        .form-select {
            background-color: #FFFFFF;
            border: 1px solid #CFE3F8;
            color: #1F2937;
            border-radius: 0.75rem;
        }

        .form-label {
            color: #374151;
            font-weight: 600;
        }

        .btn-primary {
            background: linear-gradient(45deg, #42A5F5, #29B6F6);
            border: none;
            color: #ffffff;
            font-weight: 700;
            border-radius: 0.75rem;
        }

        .btn-outline-secondary {
            border-color: #90CAF9;
            color: #1565C0;
            border-radius: 0.75rem;
            background-color: rgba(255,255,255,0.7);
        }

        .required::after {
            content: " *";
            color: #E53935;
            font-weight: 700;
        }

        .content-wrap {
            min-height: calc(100vh - 140px);
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg tannus-navbar mb-4">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/dashboard">
            Tannus MES
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon" style="filter: invert(1);"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/inout/in">입고 등록</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/inout/out">출고 등록</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/inout/list">입출고 내역 조회</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/stock/list">재고 현황</a>
                </li>
            </ul>

            <div class="d-flex align-items-center gap-3">
                <span class="navbar-text">
                    ${sessionScope.loginUser} / ${sessionScope.loginRole}
                </span>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">
                    로그아웃
                </a>
            </div>
        </div>
    </div>
</nav>

<div class="container-xxl mb-4 content-wrap">