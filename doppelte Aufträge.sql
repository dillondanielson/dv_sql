with countlines as
(
Select salesid, count(linenum)
FROM "AX.PROD_DynamicsAX2012.dbo.SALESLINE"
Group by salesid
),
salesamount as
(
Select salesid, sum(lineamount)
FROM "AX.PROD_DynamicsAX2012.dbo.SALESLINE"
Group by salesid
)


Select st.winsplitordercounter, st.salesname,st.salesoriginid,
st.customerref,cast(st.createddatetime as Date) as "CreatedDate", countlines.expr2 "AnzahlZeilen",salesamount.expr2 "Auftragswert",st.email,count(st.salesid) "AnzahlOrders", max(st.salesid), min(st.salesid)
FROM 
	"AX.PROD_DynamicsAX2012.dbo.SALESTABLE" st
LEFT JOIN 
	countlines 
	on countlines.salesid = st.salesid
LEFT JOIN 
	salesamount 
	on salesamount.salesid = st.salesid
Where 
	st.salestype = 3 and st.salesid > 'A0005800000' --and st.documentstatus in ('0', '3')
	and left(st.salesid,3) <> 'COR'
	and st.createdby = 'Admin'
	and st.winsplitordercounter = 0
	and st.createddatetime > '2017-11-27'
Group by 
	st.winsplitordercounter,  st.salesname, st.salesoriginid,st.customerref, countlines.expr2,salesamount.expr2,st.email, cast(st.createddatetime as Date)

having 
	count(st.salesid) > 1
