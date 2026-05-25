-- Average burnout risk by occupation
SELECT occupation, ROUND(AVG(burnout_risk), 4) AS avg_burnout_risk
FROM cleaned_burnout_data
GROUP BY occupation
ORDER BY avg_burnout_risk DESC;

-- Productivity by work mode
SELECT work_mode, ROUND(AVG(productivity_score), 2) AS avg_productivity
FROM cleaned_burnout_data
GROUP BY work_mode
ORDER BY avg_productivity DESC;

-- Mental state distribution
SELECT mental_health_status, COUNT(*) AS count
FROM cleaned_burnout_data
GROUP BY mental_health_status
ORDER BY count DESC;

-- Average burnout by screen time category
SELECT screen_time_category, ROUND(AVG(burnout_risk), 2) AS avg_burnout_risk
FROM cleaned_burnout_data
GROUP BY screen_time_category
ORDER BY avg_burnout_risk DESC;

-- Burnout category distribution
SELECT burnout_category, COUNT(*) AS count, ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) AS pct
FROM cleaned_burnout_data
GROUP BY burnout_category;
