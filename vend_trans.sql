Select
	accountnum, cast(transdate as Date) as "TransDate      ", amountcur, amountmst, currencycode
From
	"AX.PROD_DynamicsAX2012.dbo.VendTrans"
Where 
	--voucher = 'VI00015095' and 
	accountnum = '80676'
	and transtype = 14
		 	