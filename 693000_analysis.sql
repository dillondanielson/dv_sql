Select
	*
FROM
	"AX.PROD_DynamicsAX2012.dbo.GENERALJOURNALENTRY" as gj
LEFT JOIN
	 "AX.PROD_DynamicsAX2012.dbo.GENERALJOURNALACCOUNTENTRY" as gja
	 on gj.recid = gja.generaljournalentry 
Where
	--gj.subledgervoucher = 'REB0026360'	and
	left(gja.ledgeraccount,6) = 688100
	and gj.createdby = 'yilmazR'