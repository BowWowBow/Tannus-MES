<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <title>TANNUS MES Intro</title>


    <meta property="og:title" content="TANNUS MES" />
    <meta property="og:description" content="생산 · 물류 통합 관리 시스템" />
    <meta property="og:image" content="http://43.203.123.217:8080/tannus-mes-og-image.png" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="http://43.203.123.217:8080/" />

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        html, body {
            width: 100%;
            min-height: 100%;
            font-family: "Pretendard", "Noto Sans KR", "Malgun Gothic", Arial, sans-serif;
            background: #000;
        }

        body {
            overflow: hidden;
            background:
                    radial-gradient(circle at 20% 30%, rgba(120, 60, 20, 0.35), transparent 35%),
                    radial-gradient(circle at 80% 25%, rgba(255, 140, 60, 0.12), transparent 30%),
                    radial-gradient(circle at 70% 70%, rgba(100, 40, 20, 0.28), transparent 32%),
                    linear-gradient(135deg, #050505 0%, #140b08 40%, #050505 100%);
        }

        .intro-wrap {
            position: relative;
            width: 100%;
            min-height: 100vh;
            min-height: 100dvh;
            overflow: hidden;
            cursor: pointer;
            background: transparent;
        }

        .bg-motion {
            position: absolute;
            top: -10%;
            left: -10%;
            width: 120%;
            height: 120%;
            background:
                    radial-gradient(circle at 30% 40%, rgba(255, 120, 40, 0.10), transparent 20%),
                    radial-gradient(circle at 75% 35%, rgba(255, 180, 100, 0.08), transparent 18%),
                    radial-gradient(circle at 60% 75%, rgba(120, 40, 10, 0.18), transparent 22%);
            animation: bgMove 8s ease-in-out infinite alternate;
            z-index: 1;
        }

        @keyframes bgMove {
            from {
                transform: translate(-2%, -2%) scale(1.02);
            }
            to {
                transform: translate(2%, 2%) scale(1.08);
            }
        }

        .overlay {
            position: absolute;
            inset: 0;
            background:
                    linear-gradient(to bottom, rgba(0,0,0,0.25), rgba(0,0,0,0.58)),
                    rgba(0,0,0,0.28);
            z-index: 2;
        }

        .top-logo {
            position: absolute;
            top: 32px;
            left: 42px;
            z-index: 4;
            color: #fff;
            font-weight: 900;
            font-size: 28px;
            letter-spacing: 1px;
            text-shadow: 0 4px 18px rgba(0,0,0,0.35);
        }

        .center-content {
            position: absolute;
            inset: 0;
            z-index: 4;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            color: #fff;
            padding: 84px 24px 82px;
        }

        .main-title {
            font-size: clamp(40px, 5vw, 76px);
            font-weight: 900;
            line-height: 1.15;
            letter-spacing: -1.6px;
            margin-bottom: 18px;
            opacity: 0;
            transform: translateY(30px);
            animation: titleUp 1.2s ease forwards;
            text-shadow: 0 4px 24px rgba(0,0,0,0.35);
            word-break: keep-all;
        }

        .sub-title {
            font-size: clamp(14px, 1.3vw, 20px);
            font-weight: 700;
            color: rgba(255,255,255,0.76);
            letter-spacing: -0.2px;
            line-height: 1.6;
            opacity: 0;
            transform: translateY(20px);
            animation: titleUp 1.2s ease forwards;
            animation-delay: 0.35s;
            word-break: keep-all;
        }

        @keyframes titleUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .enter-guide {
            position: absolute;
            bottom: 42px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 5;
            color: rgba(255,255,255,0.38);
            font-size: 14px;
            font-weight: 800;
            letter-spacing: 4px;
            text-transform: uppercase;
            animation: blink 1.8s ease-in-out infinite;
            user-select: none;
            white-space: nowrap;
        }

        @keyframes blink {
            0%, 100% { opacity: 0.22; }
            50% { opacity: 0.82; }
        }

        .left-caption {
            position: absolute;
            left: 22px;
            bottom: 20px;
            z-index: 5;
            color: rgba(255,255,255,0.42);
            font-size: 11px;
            letter-spacing: 0.2px;
            white-space: nowrap;
        }

        .fade-out {
            animation: fadeOutScreen 0.8s ease forwards;
        }

        @keyframes fadeOutScreen {
            to {
                opacity: 0;
                visibility: hidden;
            }
        }

        @media (max-width: 1024px) {
            .top-logo {
                top: 28px;
                left: 30px;
                font-size: 25px;
            }

            .center-content {
                padding-left: 22px;
                padding-right: 22px;
            }
        }

        @media (max-width: 768px) {
            .top-logo {
                top: 22px;
                left: 20px;
                font-size: 22px;
            }

            .center-content {
                justify-content: center;
                padding: 86px 18px 90px;
            }

            .main-title {
                font-size: clamp(38px, 12vw, 58px);
                line-height: 1.18;
                margin-bottom: 14px;
                letter-spacing: -1.2px;
            }

            .sub-title {
                max-width: 330px;
                font-size: 14px;
            }

            .enter-guide {
                bottom: 34px;
                font-size: 12px;
                letter-spacing: 3px;
            }

            .left-caption {
                display: none;
            }
        }

        @media (max-width: 420px) {
            .top-logo {
                font-size: 20px;
            }

            .main-title {
                font-size: 40px;
            }

            .sub-title {
                font-size: 13px;
            }

            .enter-guide {
                bottom: 28px;
                font-size: 11px;
                letter-spacing: 2px;
            }
        }
    </style>
</head>
<body>

<div class="intro-wrap" id="introWrap">
    <div class="bg-motion"></div>
    <div class="overlay"></div>

    <div class="top-logo">TANNUS</div>

    <div class="center-content">
        <div class="main-title">
            TANNUS MES
        </div>
        <div class="sub-title">
            스마트한 입출고와 재고 관리를 위한 통합 시스템
        </div>
    </div>

    <div class="enter-guide">PRESS ENTER</div>

    <div class="left-caption">Tannus Manufacturing Execution System</div>
</div>

<script>
    const introWrap = document.getElementById("introWrap");
    let isMoving = false;

    function goLogin() {
        if (isMoving) return;
        isMoving = true;

        introWrap.classList.add("fade-out");

        setTimeout(() => {
            window.location.href = "${pageContext.request.contextPath}/login?fromIntro=true";
        }, 750);
    }

    document.addEventListener("keydown", function (e) {
        if (e.key === "Enter") {
            goLogin();
        }
    });

    introWrap.addEventListener("click", function () {
        goLogin();
    });
</script>

</body>
</html>
