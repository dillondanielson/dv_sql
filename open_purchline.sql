Select
	cast(pl.createddatetime as Date) as "CreateDate",
	cast(pl.deliverydate as Date) as "DeliveryDate",
	pl.itemid,
	pl.purchid,
	pl.remainpurchphysical,
	dim.inventlocationid, 
	vpj.winpurchadvicesent
FROM
	"AX.PROD_DynamicsAX2012.dbo.purchline" as pl
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.Inventdim" as dim
	on dim.inventdimid = pl.inventdimid	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.VendPurchOrderJour" as vpj
	on vpj.purchid = pl.purchid and vpj.winpurchadvicesent = 1			
Where
	pl.remainpurchphysical <> 0 and dim.inventlocationid = 'CTC_BCN' --and pl.itemid = '7613032378240'
--Group by
--	pl.itemid
order by 
	pl.purchid asc
		