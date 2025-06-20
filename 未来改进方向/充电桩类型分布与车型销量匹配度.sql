SELECT 
    ne.dt,
    ne.production_ev AS pure_electric_production,
    ne.production_phev AS plug_in_hybrid_production,
    pc.dc_national AS fast_charging_piles,
    pc.ac_national AS slow_charging_piles
FROM new_energy_vehicle ne
JOIN public_charging_pile pc ON ne.dt = DATE_FORMAT(pc.dt, 'yyyy-MM');

