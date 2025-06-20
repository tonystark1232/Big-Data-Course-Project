SELECT 
    pc.dt,
    (pc.dc_national + pc.ac_national) / ne.sales_total AS charging_pile_per_10k_vehicles,
    gp.price_92 * 12 AS annual_fuel_cost_per_car -- 假设年均行驶里程折算
FROM public_charging_pile pc
JOIN new_energy_vehicle ne ON SUBSTR(pc.dt, 1, 7) = ne.dt
JOIN gasoline_price gp ON ne.dt = gp.dt;

CREATE TABLE ads_cdj_fyc_db AS
SELECT 
    pc.dt,
    (pc.dc_national + pc.ac_national) / ne.sales_total AS charging_pile_per_10k_vehicles,
    gp.price_92 * 12 AS annual_fuel_cost_per_car -- 假设年均行驶里程折算
FROM public_charging_pile pc
JOIN new_energy_vehicle ne ON SUBSTR(pc.dt, 1, 7) = ne.dt
JOIN gasoline_price gp ON ne.dt = gp.dt;