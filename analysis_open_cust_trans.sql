Select
	*
From
	"AX.PROD_DynamicsAX2012.dbo.CustTrans" as ct
Left Join

	"AX.PROD_DynamicsAX2012.dbo.CustTransOpen" as cto
	on cto.refrecid = ct.recid and cto.accountnum = ct.accountnum
	 	
Where 
--	ct.accountnum = 'D03938482' 
--and 
--	cto.recid IS NULL
--and
	ct.Transtype = 2
and 
 	ct.txt in ('8000122826','8000122909','8000122617','8000122691','8000122375','8000122735','8000122592','8000122839','8000122387','8000122392','8000122671','8000122705','8000122960','8000122647','8000122543','8000131520','8000122684','8000122964','8000122386','8000122438','8000122599','8000131553','8000122820','8000122435','8000122516','8000122743')	