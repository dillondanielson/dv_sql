/* Analyse FF Aufträge inkl. Trackingnummern in AX für Project Puffer */
with creditnote as
(
Select 
	cij.salesid, st.customerref, cij.invoiceid
From
	"AX.PROD_DynamicsAX2012.dbo.CUSTINVOICEJOUR" cij
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.SALESTABLE" as st
	on st.salesid = cij.salesid
Where
	st.salestype = 4
	--and st.customerref in ('1006491713','1007415685')
)


SELECT
	distinct st.customerref
	,st.salesid
	,cij.taxgroup
	,year(cij.invoicedate) as "InvoiceDate"
	,st.salesname
	,lpa.countryregionid
	,lpa.zipcode
	,lpa.city
	,lpa.street
	,wsct.TrackingNumber
	,case 
		when creditnote.customerref IS NULL then 'OK'
		else 'NOK'
	end "Include"
	,cast(cij.Invoiceamount as double) as "InvoiceAmount"
	,cast(cij.Sumtax as Double) as "SumTax"
	,cast(cij.SalesBalance as double) as "SumNet"
	
FROM
	"AX.PROD_DynamicsAX2012.dbo.CUSTINVOICEJOUR" as cij
	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.SALESTABLE" as st
	on st.salesid = cij.salesid	
	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.LOGISTICSPOSTALADDRESS" as lpa
	on lpa.recid = st.DeliveryPostalAddress	
	
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.LOGISTICSLOCATION" as ll
	on ll.recid = lpa.location	

LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.WINShipCarrierTracking" as wsct
	on wsct.salesid = st.salesid 	

LEFT JOIN
	creditnote
	on creditnote.customerref = st.customerref

Where 
	st.salestype = 3 and left(st.salesid,3) <> 'COR'	
	and lpa.zipcode = '42389'
	--and lpa.city = 'H%'
	and lpa.street like '%der Fleute%'	
	and wsct.trackingnumber IS NOT NULL
	--and st.customerref in ('1006491713','1007415685')

Order by
	st.customerref, st.salesid	
