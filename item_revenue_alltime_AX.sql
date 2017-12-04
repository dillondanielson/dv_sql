Select
	cast(invoicedate as Date) as "InvoiceDate", itemid, qty, salesprice, lineamount, lineamountmst, currencycode
From
	"AX.PROD_DynamicsAX2012.dbo.CustInvoiceTrans" 
Where
	itemid <> ''	