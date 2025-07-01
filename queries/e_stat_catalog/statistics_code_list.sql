select distinct
    dataset__stat_name__code as statistics_code,
    dataset__stat_name__name as statistics_name
from statistics_code
order by statistics_code
