SELECT 

stg.salesid,st.salesoriginid,	case st.salesstatus
			when '1' then 'Open order'
			when '3' then 'Invoiced'
			when '4' then 'Canceled'
			else 'na'
		end	"SalesStatus          ", 
		case st.documentstatus
			when '0' then 'None'
			when '3' then 'Confirmation'
			when '4' then 'Picking list'
			when '5' then 'Return'
			when '7' then 'Invoice'
			else 'na'
		end "DocumentStatus",
		stg.deliverydate--,doc.notes

FROM 
	"AX.PROD_DynamicsAX2012.dbo.WINSALESORDEROUTPUTTABLESTAGING" as stg

INNER JOIN   
	"AX.PROD_DynamicsAX2012.dbo.SALESTABLE" as st
	on stg.salesid = st.salesid
	--and st.salesoriginid = 'TMALL_CN'
	--and st.inventlocationid IN ('CTC_BCN')

/*LEFT JOIN 
	"AX.PROD_DynamicsAX2012.dbo.MCRHOLDCODETRANS" as tra 
	on stg.salesid = tra.inventrefid
	and	tra.mcrcleared = '0'
	
INNER JOIN  
	"AX.PROD_DynamicsAX2012.dbo.DOCUREF" as doc 
	on tra.RECID = DOC.REFRECID
	and doc.notes IS NOT NULL
	--and doc.notes <> 'WUNDERLAND'
	--and doc.notes NOT LIKE'1%'	*/
	
Where 
	stg.status = 2 --and st.salesstatus = 1 and st.documentstatus = 4

/*Group by
case st.salesstatus
			when '1' then 'Offener Auftrag'
			when '3' then 'Fakturiert'
			when '4' then 'Storniert'
			else 'na'
		end	, 
		case st.documentstatus
			when '0' then 'Keiner'
			when '3' then 'Bestätigt'
			when '4' then 'KommListe'
			when '5' then 'Retoure'
			when '7' then 'Fakturiert'
			else 'na'
		end */


Order by
case st.salesstatus
			when '1' then 'Offener Auftrag'
			when '3' then 'Fakturiert'
			when '4' then 'Storniert'
			else 'na'
		end	, 
		case st.documentstatus
			when '0' then 'Keiner'
			when '3' then 'Bestätigt'
			when '4' then 'KommListe'
			when '5' then 'Retoure'
			when '7' then 'Fakturiert'
			else 'na'
		end 	