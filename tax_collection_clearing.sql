Select
	ljt.journalnum, lg.difforiginaltransactionvoucher, ljt.voucher
FROM
	"AX.PROD_DynamicsAX2012.dbo.WINLedgerJournalTrans_AccountClearing" as lg
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.LedgerJournalTrans" as ljt
	on ljt.recid =  lg.refrecid
WHERE
	ljt.voucher in
('GJ04355411','GJ04282525','GJ04281460','GJ04281456','GJ04281448','GJ04281394','GJ04281318','GJ04281247','GJ04281144','GJ04281143','GJ04281027','GJ04281026')
order by 	
	lg.difforiginaltransactionvoucher asc