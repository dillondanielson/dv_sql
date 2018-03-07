with min_date as
(
	Select 
		customerref, min(salesid) as "MinSalesId",cast(min(createddatetime) as Date) as "MinDate"
	From
		"AX.PROD_DynamicsAX2012.dbo.SalesTable" 
	Where
		taxgroup = 'PT_NAT'	
	Group by 
		customerref	
)

Select
	cij.invoiceid, cij.salesid as "ReturnSalesId","cij.TAXGROUP" ,cast ("cij.INVOICEDATE" as Date) as "CreditNoteDate" ,st.customerref, cast(min_date.MinDate  as Date) as "OriginalCreateDate", min_date.Minsalesid as "OriginalSalesId"
From
	"AX.PROD_DynamicsAX2012.dbo.CustInvoiceJour" as cij
Left Join
	"AX.PROD_DynamicsAX2012.dbo.SalesTable" as st
	on st.salesid = cij.salesid
Left join
	min_date on min_date.customerref = st.customerref	 	
Where
	"cij.TAXGROUP" = 'PT_NAT' and left(cij.invoiceid,2) = 'CN'