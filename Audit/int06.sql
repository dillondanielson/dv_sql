SELECT 
	count(recid)
	--*
FROM 
	"AX.PROD_DynamicsAX2012.dbo.WINSALESORDEROUTPUTTABLESTAGING"
WHERE
	shippingdate between '2017-11-01' and '2017-11-30'	