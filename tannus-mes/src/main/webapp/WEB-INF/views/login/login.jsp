<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tannus 로그인</title>

    <style>
        * { box-sizing: border-box; }

        html, body {
            width: 100%;
            min-height: 100%;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", sans-serif;
            background:
                    radial-gradient(circle at 20% 20%, rgba(33,150,243,0.22), transparent 30%),
                    radial-gradient(circle at 80% 10%, rgba(25,118,210,0.20), transparent 28%),
                    linear-gradient(135deg, #eef7ff 0%, #d9ecff 45%, #f8fbff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #1f2937;
            padding: 24px 14px;
        }

        .login-wrap {
            width: 440px;
            max-width: 100%;
            background: rgba(255,255,255,0.92);
            border: 1px solid rgba(255,255,255,0.8);
            border-radius: 26px;
            padding: 42px 38px;
            box-shadow: 0 18px 45px rgba(21,101,192,0.18);
        }

        .brand {
            text-align: center;
            margin-bottom: 34px;
        }

        .logo {
            width: 58px;
            height: 58px;
            margin: 0 auto 14px;
            border-radius: 18px;
            background: linear-gradient(135deg, #1e88e5, #1565c0);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            font-weight: 900;
            box-shadow: 0 10px 22px rgba(21,101,192,0.32);
        }

        .brand h1 {
            margin: 0;
            font-size: 30px;
            font-weight: 900;
            color: #0f172a;
            letter-spacing: -1px;
        }

        .brand p {
            margin: 9px 0 0;
            font-size: 14px;
            color: #64748b;
            line-height: 1.5;
            word-break: keep-all;
        }

        .error-text {
            background: #fff1f2;
            color: #e11d48;
            border: 1px solid #fecdd3;
            border-radius: 12px;
            padding: 12px 14px;
            margin-bottom: 18px;
            text-align: center;
            font-size: 14px;
            font-weight: 700;
            line-height: 1.5;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-size: 14px;
            font-weight: 800;
            color: #334155;
        }

        input {
            width: 100%;
            height: 48px;
            border: 1px solid #cbd5e1;
            border-radius: 14px;
            padding: 0 14px;
            font-size: 15px;
            outline: none;
            background: white;
        }

        input:focus {
            border-color: #1e88e5;
            box-shadow: 0 0 0 4px rgba(30,136,229,0.13);
        }

        .login-btn {
            width: 100%;
            height: 50px;
            margin-top: 8px;
            border: none;
            border-radius: 14px;
            background: linear-gradient(135deg, #1e88e5, #1565c0);
            color: white;
            font-size: 16px;
            font-weight: 900;
            cursor: pointer;
            box-shadow: 0 10px 22px rgba(21,101,192,0.28);
        }

        .login-btn:hover {
            opacity: 0.94;
        }

        .intro-link {
            margin-top: 20px;
            text-align: center;
        }

        .intro-link a {
            color: #1565c0;
            font-size: 14px;
            font-weight: 800;
            text-decoration: none;
        }

        .intro-link a:hover {
            text-decoration: underline;
        }

        .footer-text {
            margin-top: 28px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
            text-align: center;
            font-size: 12px;
            color: #94a3b8;
        }

        @media (max-width: 768px) {
            body {
                align-items: center;
                padding: 20px 14px;
            }

            .login-wrap {
                width: 100%;
                max-width: 440px;
                padding: 36px 28px;
                border-radius: 24px;
            }

            .brand {
                margin-bottom: 30px;
            }

            .brand h1 {
                font-size: 28px;
            }
        }

        @media (max-width: 480px) {
            body {
                align-items: flex-start;
                padding: 18px 12px;
            }

            .login-wrap {
                padding: 30px 22px;
                border-radius: 22px;
                box-shadow: 0 14px 34px rgba(21,101,192,0.16);
            }

            .logo {
                width: 52px;
                height: 52px;
                border-radius: 16px;
                font-size: 25px;
            }

            .brand h1 {
                font-size: 25px;
            }

            .brand p {
                font-size: 13px;
            }

            input,
            .login-btn {
                height: 46px;
            }

            .footer-text {
                margin-top: 24px;
            }
        }

        @media (max-width: 360px) {
            .login-wrap {
                padding: 26px 18px;
            }

            .brand h1 {
                font-size: 23px;
            }

            .intro-link a {
                font-size: 13px;
            }
        }
    </style>
</head>

<body>

<div class="login-wrap">

    <div class="brand">
        <div class="logo">T</div>
        <h1>Tannus System</h1>
        <p>포장 · 물류 · 수출 흐름을 한눈에 관리하는<br>통합 업무 시스템</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="error-text">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">

        <div class="form-group">
            <label>아이디</label>
            <input type="text"
                   name="userId"
                   placeholder="아이디를 입력하세요"
                   required>
        </div>

        <div class="form-group">
            <label>비밀번호</label>
            <input type="password"
                   name="password"
                   placeholder="비밀번호를 입력하세요"
                   required>
        </div>

        <button type="submit" class="login-btn">로그인</button>
    </form>

    <div class="intro-link">
        <a href="${pageContext.request.contextPath}/">메인페이지로 돌아가기</a>
    </div>

    <div class="footer-text">
        Tannus Integrated Work System
    </div>

</div>

</body>
</html>
