DROP MATERIALIZED VIEW BILLCHKOW.fin_hb_csa_dm_mview;

CREATE MATERIALIZED VIEW BILLCHKOW.fin_hb_csa_dm_mview AS
(
    select distinct a.uf, a.csa, b.geo_region 
    from fin_heldbill_fact a, FIN_GEO_DM b
    where a.uf = b.geo_state
);




