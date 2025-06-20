SELECT 
    pc.dt,
    pc.cq AS chongqing_piles,
    pc.gd AS guangdong_piles,
    ne.sales_total * 0.3 AS estimated_regional_sales -- 假设TOP10省份占比70%
FROM public_charging_pile pc
JOIN new_energy_vehicle ne ON SUBSTR(pc.dt, 1, 7) = ne.dt;