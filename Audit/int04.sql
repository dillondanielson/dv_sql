SELECT 
	--count(recid)	
	*
FROM 
	"AX.PROD_DynamicsAX2012.dbo.WINSALESTABLESTAGING"
Where
	cast(createddatetime as Date) between '2017-10-31' and '2017-12-31'	