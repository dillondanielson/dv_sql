with bom as 
(
Select
	bomid,count(recid) as "Anzahl"
From
	"AX.PROD_DynamicsAX2012.dbo.BOM"
Group by
	bomid	 	
)



SELECT 
	bom.Anzahl,stg.externaldocumentno, st.salesoriginid,stg.itemid, stg.qty, stg.description,stg.createddatetime, inv.PmfProductType, 
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
FROM
	"AX.PROD_DynamicsAX2012.dbo.WINSALESLINESTAGING" as stg
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.INVENTTABLE" as inv
	on inv.itemid = stg.itemid 
LEFT JOIN	
	bom
	on bom.bomid = stg.itemid
LEFT JOIN
	"AX.PROD_DynamicsAX2012.dbo.SALESTABLE" as st
	on st.customerref = stg.externaldocumentno 		
WHERE
	--stg.itemid like '%-%'
	--and 
	cast(stg.createddatetime as Date) > '2017-11-01'
	and stg.qty <> 1
	and inv.PmfProductType = 4	
	and BOMUnitId = 'PCS' 
Order by 
	stg.createddatetime desc