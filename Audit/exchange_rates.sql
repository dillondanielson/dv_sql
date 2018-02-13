Select
	--count(exrp.recid)
	exr.*, exrp.*
From
	"AX.PROD_DynamicsAX2012.dbo.EXCHANGERATE" as exr
Left Join
	"AX.PROD_DynamicsAX2012.dbo.EXCHANGERATECURRENCYPAIR" as exrp
	on exr.EXCHANGERATECURRENCYPAIR = exrp.Recid
Where
	validfrom between '2017-11-22' and '2017-12-31'		 	