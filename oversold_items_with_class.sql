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
	dim.inventlocationid in ('FIEGE_GB','CTC_BCN','FIEGE_AR','USTER','BWH_CA')
	--and invsum.itemid = '0000000000055'	
)

Select
	stock.*, item_class.winproductclass
FROM
	stock
Left join
	item_class
	on item_class.itemid = stock.itemid and item_class.inventsiteid = stock.inventsiteid
Where
	stock.PhysAvailable - stock.onorder < 0
order by
	stock.onorder desc
	
		