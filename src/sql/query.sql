-- FUNCTION: adempiere.rep_leftoverstockproduct()

-- DROP FUNCTION IF EXISTS adempiere.rep_leftoverstockproduct();

CREATE OR REPLACE FUNCTION adempiere.rep_leftoverstockproduct(
	)
    RETURNS TABLE(currentdate date, warehouse character varying, locator character varying, product_code character varying, product_name character varying, qtyavailable numeric, qtyonhand numeric, qtyreserved numeric, m_warehouse_id numeric, m_locator_id numeric, m_product_id numeric) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

begin
return query
(
select
	now()::date as currentdate_x,
	w."name" as warehouse_x,
	l."value" as locator_x,
	p.value as product_code_x,
	p.name as product_name_x,
	adempiere.bomqtyavailable(p.m_product_id, l.m_warehouse_id, l.m_locator_id) as qtyavailable_x,
	adempiere.bomqtyonhand(p.m_product_id, l.m_warehouse_id, l.m_locator_id) as qtyonhand_x,
	adempiere.bomqtyreserved(p.m_product_id, l.m_warehouse_id, l.m_locator_id) as qtyreserved_x,
	w.m_warehouse_id as m_warehouse_id_x,
	l.m_locator_id as m_locator_id_x,
	p.m_product_id as m_product_id_x
from m_product p
	cross join m_locator l
	join m_warehouse w
	on l.m_warehouse_id = w.m_warehouse_id
where p.ad_client_id = 11
	and p.isstocked = 'Y'
	and l.ad_client_id = 11
order by
	9, 4
);
end;
$BODY$;

ALTER FUNCTION adempiere.rep_leftoverstockproduct()
    OWNER TO adempiere;
