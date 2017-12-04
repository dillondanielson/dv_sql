Select
	st.salesid as "Auftragsnummer", st.createddatetime, st.winlastpickingcheck, st.winlastordercheck,
	case st.salesstatus
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
	"AX.PROD_DynamicsAX2012.dbo.SalesTable" as st
Where
	 st.salesoriginid in ('BEBITUS_ES','BEBITUS_FR','BEBITUS_PT') and st.salestype = 3
	 and st.salesstatus <> 4
	 	