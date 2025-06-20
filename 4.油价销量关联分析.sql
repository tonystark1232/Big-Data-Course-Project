SELECT 
    gp.dt AS month,
    gp.price_92,
    ne.sales_total,
    (ne.sales_total - LAG(ne.sales_total) OVER (ORDER BY gp.dt)) / LAG(ne.sales_total) OVER (ORDER BY gp.dt) AS sales_growth_rate
FROM gasoline_price gp
JOIN new_energy_vehicle ne ON gp.dt = ne.dt;

--将数据写入hive表
create table ads_yj_xl_gl as
SELECT
    gp.dt AS month,
    gp.price_92,
    ne.sales_total,
    (ne.sales_total - LAG(ne.sales_total) OVER (ORDER BY gp.dt)) / LAG(ne.sales_total) OVER (ORDER BY gp.dt) AS sales_growth_rate
FROM gasoline_price gp
JOIN new_energy_vehicle ne ON gp.dt = ne.dt;