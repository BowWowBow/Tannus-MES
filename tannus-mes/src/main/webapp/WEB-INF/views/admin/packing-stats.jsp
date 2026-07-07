<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>포장 처리율 통계</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>

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
            --danger: #ef4444;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            font-family: "Malgun Gothic", "Apple SD Gothic Neo", sans-serif;
            background:
                    radial-gradient(circle at 8% 8%, var(--accent-soft), transparent 28%),
                    radial-gradient(circle at 92% 0%, rgba(14, 165, 233, 0.11), transparent 30%),
                    linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
            color: var(--text);
        }

        .wrap {
            max-width: 1280px;
            margin: 0 auto;
            padding: 34px 22px 52px;
        }

        .top-box {
            position: relative;
            overflow: hidden;
            background:
                    radial-gradient(circle at 88% 15%, rgba(255,255,255,0.38), transparent 28%),
                    linear-gradient(135deg, var(--accent), var(--accent-dark));
            color: white;
            padding: 28px 30px;
            border-radius: 26px;
            margin-bottom: 18px;
            box-shadow: 0 18px 42px rgba(15,23,42,0.18);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
        }

        .top-box:before {
            content: "";
            position: absolute;
            right: -70px;
            top: -90px;
            width: 240px;
            height: 240px;
            border-radius: 50%;
            background: rgba(255,255,255,0.16);
        }

        .top-box > div,
        .top-btn {
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

        .top-box h1 {
            margin: 0 0 7px;
            font-size: 30px;
            font-weight: 900;
            letter-spacing: -0.6px;
        }

        .top-box p {
            margin: 0;
            opacity: 0.9;
            font-size: 14px;
            line-height: 1.6;
        }

        .top-btn {
            text-decoration: none;
            background: rgba(255,255,255,0.94);
            color: var(--accent-dark);
            padding: 10px 15px;
            border-radius: 13px;
            font-weight: 900;
            font-size: 13px;
            white-space: nowrap;
        }

        .summary-line {
            position: relative;
            overflow: hidden;
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 22px 26px;
            margin-bottom: 18px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-left: 7px solid var(--accent);
            gap: 16px;
        }

        .summary-line:after {
            content: "";
            position: absolute;
            right: -34px;
            top: -34px;
            width: 118px;
            height: 118px;
            border-radius: 50%;
            background: var(--accent-soft);
        }

        .summary-left,
        .year-rate {
            position: relative;
            z-index: 1;
        }

        .summary-left h2 {
            margin: 0;
            font-size: 22px;
            font-weight: 900;
            letter-spacing: -0.3px;
        }

        .summary-left p {
            margin: 7px 0 0;
            font-size: 13px;
            color: var(--muted);
            font-weight: 700;
        }

        .year-rate {
            font-size: 46px;
            font-weight: 900;
            color: var(--accent-dark);
            letter-spacing: -1px;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .chart-card {
            background: rgba(255,255,255,0.96);
            border: 1px solid rgba(226,232,240,0.95);
            border-radius: 24px;
            padding: 20px 22px;
            box-shadow: 0 16px 38px rgba(15,23,42,0.09);
        }

        .wide {
            grid-column: span 2;
        }

        .chart-head {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 12px;
        }

        .chart-head h3 {
            margin: 0 0 5px;
            font-size: 20px;
            font-weight: 900;
            color: #0f172a;
            letter-spacing: -0.3px;
        }

        .chart-head p {
            margin: 0;
            font-size: 12px;
            color: var(--muted);
            line-height: 1.5;
            font-weight: 700;
        }

        .badge {
            background: var(--accent-soft);
            color: var(--accent-dark);
            padding: 7px 12px;
            border-radius: 999px;
            font-size: 11px;
            font-weight: 900;
            white-space: nowrap;
        }

        .chart-area {
            height: 282px;
        }

        .wide .chart-area {
            height: 330px;
        }

        canvas {
            width: 100% !important;
            height: 100% !important;
        }

        @media (max-width: 1100px) {
            .grid {
                grid-template-columns: 1fr;
            }

            .wide {
                grid-column: span 1;
            }
        }

        @media (max-width: 720px) {
            .wrap {
                padding: 24px 14px 40px;
            }

            .top-box,
            .summary-line {
                flex-direction: column;
                align-items: flex-start;
            }

            .top-box h1 {
                font-size: 26px;
            }

            .year-rate {
                font-size: 40px;
            }
        }


        /* ===== 반응형 보강 ===== */
        .top-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        @media (max-width: 900px) {
            .chart-head {
                flex-direction: column;
                align-items: flex-start;
            }

            .badge {
                align-self: flex-start;
            }

            .chart-area,
            .wide .chart-area {
                height: 300px;
            }
        }

        @media (max-width: 560px) {
            body {
                min-width: 0;
            }

            .wrap {
                padding: 18px 12px 32px;
            }

            .top-box {
                padding: 22px 20px;
                border-radius: 22px;
            }

            .top-box h1 {
                font-size: 23px;
                line-height: 1.25;
            }

            .top-box p {
                font-size: 13px;
                word-break: keep-all;
            }

            .top-btn {
                width: 100%;
                min-height: 42px;
            }

            .summary-line {
                padding: 20px;
                border-radius: 20px;
            }

            .summary-left h2 {
                font-size: 18px;
                line-height: 1.35;
            }

            .year-rate {
                width: 100%;
                font-size: 36px;
                text-align: right;
            }

            .chart-card {
                padding: 18px 16px;
                border-radius: 20px;
            }

            .chart-head h3 {
                font-size: 18px;
            }

            .chart-head p {
                word-break: keep-all;
            }

            .chart-area {
                height: 280px;
                overflow-x: auto;
            }

            .wide .chart-area {
                height: 300px;
                overflow-x: auto;
            }

            .wide canvas {
                min-width: 720px;
            }
        }

        @media (max-width: 380px) {
            .top-box h1 {
                font-size: 21px;
            }

            .year-rate {
                font-size: 32px;
            }

            .chart-area {
                height: 260px;
            }
        }
    </style>
</head>

<body>

<div class="wrap">

    <div class="top-box">
        <div>
            <div class="page-badge">📦 PACKING STATS</div>
            <h1>포장 처리율 통계</h1>
            <p>${year}년 기준 포장 지시의 처리 흐름을 분석합니다.</p>
        </div>

        <a href="${pageContext.request.contextPath}/dashboard" class="top-btn">
            대시보드
        </a>
    </div>

    <div class="summary-line">
        <div class="summary-left">
            <h2>${year}년 전체 포장 처리율</h2>
            <p>READY_TO_SHIP / SHIPPED 상태 기준 완료율</p>
        </div>

        <div class="year-rate">${yearRate}%</div>
    </div>

    <div class="grid">

        <div class="chart-card">
            <div class="chart-head">
                <div>
                    <h3>분기별 처리율</h3>
                    <p>분기 단위 포장 완료 흐름</p>
                </div>
                <div class="badge">Quarter</div>
            </div>

            <div class="chart-area">
                <canvas id="quarterChart"></canvas>
            </div>
        </div>

        <div class="chart-card">
            <div class="chart-head">
                <div>
                    <h3>월별 처리율</h3>
                    <p>데이터가 있는데 0%인 월은 빨간색으로 표시합니다.</p>
                </div>
                <div class="badge">Month</div>
            </div>

            <div class="chart-area">
                <canvas id="monthChart"></canvas>
            </div>
        </div>

        <div class="chart-card wide">
            <div class="chart-head">
                <div>
                    <h3>주별 처리율</h3>
                    <p>주차별 처리율 변화를 확인합니다.</p>
                </div>
                <div class="badge">Week</div>
            </div>

            <div class="chart-area">
                <canvas id="weekChart"></canvas>
            </div>
        </div>

    </div>

</div>

<script>
    Chart.register(ChartDataLabels);

    const quarterRates = [
        ${quarterRates[0]},
        ${quarterRates[1]},
        ${quarterRates[2]},
        ${quarterRates[3]}
    ];

    const monthRates = [
        ${monthRates[0]}, ${monthRates[1]}, ${monthRates[2]}, ${monthRates[3]},
        ${monthRates[4]}, ${monthRates[5]}, ${monthRates[6]}, ${monthRates[7]},
        ${monthRates[8]}, ${monthRates[9]}, ${monthRates[10]}, ${monthRates[11]}
    ];

    const monthHasData = [
        ${monthHasDataList[0]}, ${monthHasDataList[1]}, ${monthHasDataList[2]}, ${monthHasDataList[3]},
        ${monthHasDataList[4]}, ${monthHasDataList[5]}, ${monthHasDataList[6]}, ${monthHasDataList[7]},
        ${monthHasDataList[8]}, ${monthHasDataList[9]}, ${monthHasDataList[10]}, ${monthHasDataList[11]}
    ];

    const weekRates = [
        <c:forEach var="rate" items="${weekRates}" varStatus="st">
        ${rate}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const quarterLabelOption = {
        anchor: "end",
        align: "top",
        color: "#555",
        font: {
            weight: "bold",
            size: 10
        },
        formatter: function(value) {
            return value + "%";
        }
    };

    new Chart(document.getElementById("quarterChart"), {
        type: "bar",
        data: {
            labels: ["1분기", "2분기", "3분기", "4분기"],
            datasets: [{
                data: quarterRates,
                backgroundColor: quarterRates.map(rate => rate === 0 ? "#dfe6ee" : "#2563eb"),
                borderRadius: 10,
                barThickness: 46
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                datalabels: quarterLabelOption,
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.raw + "%";
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { display: false }
                },
                y: {
                    beginAtZero: true,
                    max: 100,
                    ticks: {
                        callback: function(value) {
                            return value + "%";
                        }
                    }
                }
            }
        }
    });

    new Chart(document.getElementById("monthChart"), {
        type: "bar",
        data: {
            labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            datasets: [{
                data: monthRates,
                backgroundColor: monthRates.map(function(rate, index) {
                    if (!monthHasData[index]) {
                        return "#dfe6ee";
                    }

                    if (rate === 0) {
                        return "#ef4444";
                    }

                    return "#2563eb";
                }),
                borderRadius: 8,
                barThickness: 22
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                datalabels: {
                    anchor: "end",
                    align: "top",
                    color: function(context) {
                        const index = context.dataIndex;
                        const value = context.dataset.data[index];

                        if (!monthHasData[index]) {
                            return "#aaa";
                        }

                        return value === 0 ? "#ef4444" : "#555";
                    },
                    font: {
                        weight: "bold",
                        size: 10
                    },
                    formatter: function(value, context) {
                        const index = context.dataIndex;

                        if (!monthHasData[index]) {
                            return "";
                        }

                        return value + "%";
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const index = context.dataIndex;

                            if (!monthHasData[index]) {
                                return "데이터 없음";
                            }

                            return context.raw + "%";
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { display: false }
                },
                y: {
                    beginAtZero: true,
                    max: 100,
                    ticks: {
                        callback: function(value) {
                            return value + "%";
                        }
                    }
                }
            }
        }
    });

    new Chart(document.getElementById("weekChart"), {
        type: "line",
        data: {
            labels: Array.from({length: 53}, function(_, i) {
                return (i + 1) + "주";
            }),
            datasets: [{
                data: weekRates,
                borderColor: "#1d4ed8",
                backgroundColor: "rgba(21,101,192,0.10)",
                fill: true,
                tension: 0.35,
                pointRadius: 2,
                pointHoverRadius: 5,
                pointBackgroundColor: "#1d4ed8",
                borderWidth: 3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                datalabels: { display: false },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.raw + "%";
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { display: false },
                    ticks: { maxTicksLimit: 14 }
                },
                y: {
                    beginAtZero: true,
                    max: 100,
                    ticks: {
                        callback: function(value) {
                            return value + "%";
                        }
                    }
                }
            }
        }
    });
</script>

</body>
</html>