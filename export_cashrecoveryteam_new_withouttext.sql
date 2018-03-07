with tax as
(
Select 
	voucher, sum(taxbaseamount) as "TaxBaseEUR",sum(taxamount) as "TaxEUR",sum(taxbaseamountcur) as "TaxBaseCUR",sum(taxamountcur) as "TaxCUR"
From
	"AX.PROD_DynamicsAX2012.dbo.TAXTRANS"
--WHERE
--	voucher = 'II00027696'
GROUP BY
	voucher
)

SELECT
	vt.accountnum AS "Lieferanten-Nummer"
	,vtc."Name" AS "Lieferanten-Name"
	,vt.invoice AS "Rechnungsnummer"
	,vij.documentdate AS "Rechnungsdatum"
	,vij.invoiceamountmst AS "Brutto Rechnungsbetrag HW"
	,IFNULL(tax.TaxEUR,0)as "Mehrwertsteuerbetrag HW"
	,ca."Percent_" AS "Skonto-Prozentsatz"
	,vt.amountmst "Brutto Zahlungsbetrag HW"
	,cast(vt.transdate as Date) as "Eingabedatum"
	,vij.Purchid AS "Bestellnummer"
	,
	case vt.transtype
		when 0 then 'None'
		when 1 then 'Transfer'
		when 2 then 'SalesOrder'
		when 3 then 'PurchaseOrder'
		when 4 then 'Inventory'
		when 5 then 'Production'
		when 6 then 'Project'
		when 7 then 'Interest'
		when 8 then 'Customer'
		when 9 then 'Exchange adjustment'
		when 10 then 'Totaled'
		when 11 then 'Payroll'
		when 12 then 'Fixed assets'
		when 13 then 'Collection letter'
		when 14 then 'Vendor'
		when 15 then 'Payment'
		when 16 then 'Sales Tax'
		when 17 then 'Bank'
		when 18 then 'Conversion'
		when 19 then 'Bill of exchange'
		when 20 then 'Promissory note'
		when 21 then 'Cost accounting'
		when 22 then 'Labor'
		when 23 then 'Fee'
		when 24 then 'Settlement'
		when 25 then 'Allocation'
		when 26 then 'Elimination'
		when 27 then 'Cash Discount'
		when 28 then 'Overpayment-Underpayment'
		when 29 then 'Penny Difference'
		when 30 then 'Intercompany settlement'		
	end as "Belegart"
	
	,vij.internalinvoiceid AS "Systeminterne Belegnummer"
	,vt.voucher AS "Ablagennummer"
	--,vt.txt AS "Buchungstext"
	,vt.currencycode AS "Währungs-Kennziffer"
	,vij.invoiceamount AS "Brutto Rechnungsbetrag BW"
	,IFNULL(vij.cashdisc,0) as "Skonto-Betrag BW"
	,vt.amountcur "Brutto Zahlungsbetrag BW"
	,IFNULL(tax.TaxCUR,0) as "Mehrwertsteuerbetrag BW"
	
	
 FROM
	"AX.PROD_DynamicsAX2012.dbo.VendTrans" as vt
	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.VendInvoiceJour" as vij
	on vij.ledgervoucher = vt.voucher and vt.accountnum = vij.invoiceaccount and vt.transdate = vij.invoicedate
	
LEFT JOIN
    "AX.PROD_DynamicsAX2012.dbo.CASHDISC" ca ON ca.CASHDISCCODE = vij.CASHDISCCODE
	
LEFT JOIN
	tax on tax.voucher = vt.voucher
	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.VendTableCube" as vtc
	on vtc.accountnum = vt.accountnum and "vtc.DATAAREAID" = 'deag'		
	
WHERE
	--vt.accountnum = '72020'
	--and 
	"vt.TRANSTYPE" NOT IN (9)
	
ORDER BY
    vt.accountnum
   ,cast(vt.transdate as Date)