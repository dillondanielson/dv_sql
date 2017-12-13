SELECT count("ENTRYNO"), "SHOPCODE", "STATUS" FROM "AX.PROD_DynamicsAX2012.dbo.WINSALESTABLESTAGING"
where status <> 1
group by status, shopcode
order by shopcode desc
