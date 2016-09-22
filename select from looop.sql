select sum(flow)*(3600/60/5)*sum(flow)/((sum(speed*flow)+0.0000000001)*max(laneno)) as k,
	   sum(speed*flow)/(sum(flow)+0.0000000001) as v,
	   sum(flow)*(3600/60/5)/max(laneno) as q,
	   g + 1 as minIndex,
	   floor((g+1)/(3600/60/5)/24) + 1 as dayNum
from
(
	select flow, laneno, speed, 
		   floor((ctime-to_date('2016-01-1 00:00:00','yyyy-mm-dd hh24:mi:ss'))*24*3600/60/5) as g 
	from xianquan t
	where cpn='LP/B9' 
	and ctime>to_date('2016-01-1 00:00:00','yyyy-mm-dd hh24:mi:ss')
)
group by g
order by g;