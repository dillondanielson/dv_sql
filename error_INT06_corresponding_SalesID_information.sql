Select 
	stg.salesid, case st.salesstatus
			when '1' then 'Offener Auftrag'
			when '3' then 'Fakturiert'
			when '4' then 'Storniert'
			else 'na'
		end	"SalesStatus          ", 
		case st.documentstatus
			when '0' then 'Keiner'
			when '3' then 'Bestätigt'
			when '4' then 'KommListe'
			when '5' then 'Retoure'
			when '7' then 'Fakturiert'
			else 'na'
		end "DocumentStatus"
From
	"AX.PROD_DynamicsAX2012.dbo.WINSALESORDEROUTPUTTABLESTAGING" as stg
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.SalesTable" as st
	on stg.salesid = st.salesid
Where
	stg.status = 2 and stg.inventlocationid = 'BWH_CA'	 	 	