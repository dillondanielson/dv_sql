Select
	st.salesid as "Auftragsnummer", st.winlastpickingcheck,wol.aifmessageid,
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
	"AX.PROD_DynamicsAX2012.dbo.SALESTABLE" as st
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.WINAIFOUTBOUNDINTERFACEMESSAGELOG" as wol
	on wol.ENTITYRECID = st.recid
Where
	st.documentstatus = 4 and st.salesstatus <> 4
	and cast(st.createddatetime as Date) between '2017-02-01' and CURDATE()
	and st.customerref = '6000270113'
order by 
	cast(st.createddatetime as date) asc