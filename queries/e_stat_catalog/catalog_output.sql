select
    stats_data_id,
    stats_data__title__table_no,
    stats_data__title__name,
    if(format = 'DB', null, url) as url,
    format,
    stats_data__last_modefied_date,
    dataset__title__name,
    dataset__title__cycle,
    dataset__title__survey_date,
    dataset__last_modified_date,
    dataset__landing_page,
from ${estat_catalog_flatten}
where 1=1
and ${inputs.resource_dimension}
and dataset__title__name like '%${inputs.search_dataset_title}%'
and stats_data__title__name like '%${inputs.search_stats_title}%'
order by stats_data__title__table_no, stats_data__title__name
limit 1000
