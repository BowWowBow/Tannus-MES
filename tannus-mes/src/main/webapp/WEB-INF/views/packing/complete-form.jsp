<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출고 등록 | 창고 입출고 시스템</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", system-ui, sans-serif;
        }

        html {
            -webkit-text-size-adjust: 100%;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background:
                    radial-gradient(circle at 12% 12%, rgba(220, 38, 38, 0.10), transparent 30%),
                    radial-gradient(circle at 88% 8%, rgba(17, 24, 39, 0.08), transparent 30%),
                    linear-gradient(180deg, #f8fafc 0%, #f4f6f9 100%);
            color: #111827;
            overflow-x: hidden;
        }

        .topbar {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #111827, #1f2937);
            color: #e5e7eb;
            padding: 14px 22px;
            font-size: 14px;
            font-weight: 800;
            letter-spacing: -0.2px;
            box-shadow: 0 10px 24px rgba(15, 23, 42, 0.16);
        }

        .topbar:after {
            content: "";
            position: absolute;
            right: -44px;
            top: -58px;
            width: 130px;
            height: 130px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
        }

        .container {
            max-width: 640px;
            margin: 30px auto 44px;
            padding: 0 16px;
        }

        .page-head {
            margin-bottom: 18px;
        }

        .title {
            margin: 0 0 8px;
            font-size: 24px;
            font-weight: 900;
            color: #111827;
            letter-spacing: -0.7px;
        }

        .sub {
            margin: 0;
            font-size: 13px;
            color: #6b7280;
            line-height: 1.6;
            font-weight: 600;
        }

        .card {
            background: rgba(255,255,255,0.98);
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            box-shadow: 0 16px 36px rgba(15, 23, 42, 0.08);
            padding: 22px 24px 24px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            font-size: 13px;
            color: #374151;
            margin-bottom: 7px;
            font-weight: 800;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            height: 44px;
            padding: 0 12px;
            border-radius: 11px;
            border: 1px solid #d1d5db;
            font-size: 14px;
            outline: none;
            background: #ffffff;
            color: #111827;
            transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
        }

        input:focus {
            border-color: #dc2626;
            box-shadow: 0 0 0 4px rgba(220, 38, 38, 0.12);
            background: #fff;
        }

        .buttons {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
            margin-top: 18px;
            padding-top: 18px;
            border-top: 1px solid #e5e7eb;
        }

        .btn {
            min-height: 40px;
            padding: 0 15px;
            border-radius: 10px;
            border: 1px solid transparent;
            font-size: 13px;
            font-weight: 800;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: background 0.15s, border-color 0.15s, transform 0.05s, box-shadow 0.15s;
            white-space: nowrap;
        }

        .btn-primary {
            background: #dc2626;
            color: #ffffff;
            box-shadow: 0 8px 18px rgba(220, 38, 38, 0.18);
        }

        .btn-primary:hover {
            background: #b91c1c;
            box-shadow: 0 12px 22px rgba(220, 38, 38, 0.22);
        }

        .btn-outline {
            background: #ffffff;
            color: #374151;
            border-color: #d1d5db;
        }

        .btn-outline:hover {
            background: #f3f4f6;
        }

        .btn:active {
            transform: scale(0.98);
        }

        @media (max-width: 768px) {
            .topbar {
                padding: 13px 16px;
            }

            .container {
                max-width: 100%;
                margin: 22px auto 34px;
                padding: 0 14px;
            }

            .title {
                font-size: 22px;
            }

            .card {
                padding: 18px;
                border-radius: 16px;
            }
        }

        @media (max-width: 480px) {
            .container {
                margin-top: 18px;
                padding: 0 12px;
            }

            .title {
                font-size: 21px;
            }

            .sub {
                font-size: 12px;
            }

            .card {
                padding: 16px 14px;
            }

            input[type="text"],
            input[type="number"] {
                height: 46px;
                font-size: 15px;
            }

            .buttons {
                flex-direction: column-reverse;
                align-items: stretch;
            }

            .btn {
                width: 100%;
                min-height: 44px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="topbar">창고 입출고 시스템</div>

<div class="container">
    <div class="page-head">
        <h1 class="title">출고 등록</h1>
        <p class="sub">창고에서 나가는 상품 정보를 입력합니다.</p>
    </div>

    <div class="card">
        <form action="${pageContext.request.contextPath}/inout/out" method="post">
            <div class="form-group">
                <label for="itemName">상품명</label>
                <input id="itemName" type="text" name="itemName" required>
            </div>

            <div class="form-group">
                <label for="quantity">수량</label>
                <input id="quantity" type="number" name="quantity" min="1" required>
            </div>

            <div class="buttons">
                <a href="${pageContext.request.contextPath}/inout/list" class="btn btn-outline">목록으로</a>
                <button type="submit" class="btn btn-primary">출고 저장</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
