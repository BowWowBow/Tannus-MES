<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Tannus MES</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #eef5ff 0%, #dfefff 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .hero {
            text-align: center;
        }

        .title {
            font-size: 72px;
            font-weight: 800;
            color: #1565c0;
            margin-bottom: 20px;
            letter-spacing: 2px;
        }

        .sub-title {
            font-size: 22px;
            color: #4f7db8;
            margin-bottom: 40px;
            letter-spacing: 4px;
        }

        .enter-btn {
            display: inline-block;
            padding: 16px 42px;
            border-radius: 999px;
            border: 2px solid #d3e3fb;
            background: rgba(255,255,255,0.55);
            color: #7aa3d8;
            text-decoration: none;
            font-size: 18px;
            font-weight: 700;
            transition: all 0.2s ease;
        }

        .enter-btn:hover {
            background: #ffffff;
            color: #1565c0;
            border-color: #9fc3f5;
        }
    </style>
</head>
<body>
<div class="hero">
    <div class="title">Tannus MES</div>
    <div class="sub-title">SMART WORKFLOW PROTOTYPE</div>

    <a href="${pageContext.request.contextPath}/login" class="enter-btn">
        ENTER
    </a>
</div>
</body>
</html>