select
    dataset__stat_name__code as statistics_code,
    dataset__stat_name__name as statistics_name,
    dataset__organization__name as organization_name,
    dataset__contact_point as contact_point,
    landing_page
from statistics_code
where
    dataset__stat_name__code like '${inputs.selected_statistics_code.value}'
    and dataset__stat_name__name like '%${inputs.search_text}%'
order by statistics_code
