SELECT 
	cij.createddatetime as "CreateDate Invoice",
	idp.createddatetime as "CreateDate PDF",
	st.customerref,
	st.salesoriginid,
	st.createdby, 
	left(cij.invoiceid,2) as "TypeofVoucher",
	cij.invoiceid
FROM
	"AX.PROD_DynamicsAX2012.dbo.CustInvoiceJour" as cij
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.WINInvoiceDocPrint" as idp
	on cij.recid = idp.SourceDocumentRecId
	--and cij.Tableid = idp.SourceDocumentTableId
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.SalesTable" as st
	on st.salesid = cij.salesid 	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.WINSalesTableStaging" as stg
	on stg.externaldocumentno = st.customerref 		
WHERE
	cast(cij.createddatetime as Date) >= '2017-11-01' 
	and st.salesoriginid in ('WINDELN_DE','BEBITUS_FR','BEBITUS_PT','BEBITUS_ES')
	--and idp.recid IS NULL 
	and st.salestype = 3
	and st.customerref in ('1009429610','1009431713','1009431719','1009431721','1009431625')
	and stg.externaldocumentno IS NOT NULL
	--and st.createdby = 'Admin'
--Group by
--	cast(cij.createddatetime as Date) ,st.salesoriginid,st.createdby,left(cij.invoiceid,2)	
Order by 
	cast(cij.createddatetime as Date) desc ,st.salesoriginid,st.createdby