with item_class as
(
SELECT
	invset.itemid
	,invset.winproductclass
	,dim.inventsiteid

FROM
	"AX.PROD_DynamicsAX2012.dbo.INVENTITEMINVENTSETUP" as invset
LEFT JOIN 
	"AX.PROD_DynamicsAX2012.dbo.INVENTDIM"  as dim
	on invset.inventdimid = dim.inventdimid
	--	on price.itemrelation = inv.itemid  and price.inventdimid = inv.inventdimid	and 
WHERE 	
	invset.inventdimid <> 'AllBlank' -- and invset.itemid = '4008976021483' 

),
stock as
(
SELECT 
	invsum.itemid
	,invsum.availphysical as"PhysAvailable"
	,invsum.onorder
	,invsum.ordered
	,dim.inventsiteid
	,dim.inventlocationid
FROM
	"AX.PROD_DynamicsAX2012.dbo.INVENTSUM" as invsum
LEFT JOIN 
	"AX.PROD_DynamicsAX2012.dbo.INVENTDIM"  as dim
	on invsum.inventdimid = dim.inventdimid
WHERE	
	dim.inventlocationid in (/*'FIEGE_GB',*/'CTC_BCN'/*,'FIEGE_AR','USTER','BWH_CA'*/)
	--and invsum.itemid = '0000000000055'	
),
open_sales as 
(
Select
	cast(min(sl.createddatetime) as Date) as "MinSalesDate", sl.itemid
From
	"AX.PROD_DynamicsAX2012.dbo.SalesLine" as sl
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.SalesTable" as st
	on sl.salesid = st.salesid
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.Inventdim" as dim
	on dim.inventdimid = sl.inventdimid		
Where
	sl.salesstatus = 1	and st.salesstatus = 1 and st.salestype = 3 and dim.inventlocationid = 'CTC_BCN'
Group by 
	sl.itemid	
),
open_purch as
(

Select
	cast(min(pl.deliverydate) as Date) as "MinDeliveryDate",
	pl.itemid
FROM
	"AX.PROD_DynamicsAX2012.dbo.purchline" as pl
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.Inventdim" as dim
	on dim.inventdimid = pl.inventdimid	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.VendPurchOrderJour" as vpj
	on vpj.purchid = pl.purchid and vpj.winpurchadvicesent = 1			
Where
	pl.remainpurchphysical <> 0 and dim.inventlocationid = 'CTC_BCN'
Group by
	pl.itemid
)

Select
	stock.*, item_class.winproductclass, open_sales.MinSalesDate,open_purch.MinDeliveryDate
FROM
	stock
Left join
	item_class
	on item_class.itemid = stock.itemid and item_class.inventsiteid = stock.inventsiteid
Left join
	open_sales
	on open_sales.itemid = stock.itemid
Left Join
	open_purch
	on open_purch.itemid = stock.itemid	
Where
	stock.PhysAvailable - stock.onorder < 0 --and  stock.itemid = '9321104863621'
order by
	stock.onorder desc
	
		