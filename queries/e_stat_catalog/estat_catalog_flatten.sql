-- unnestする前にfilterするのがpoint
with
    src as (
        from estat_data_catalog
        select
            aid,
            json_extract_string(
                dataset__stat_name, '$.@code'
            ) as dataset__stat_name__code,
            json_extract_string(dataset__stat_name, '$.$') as dataset__stat_name__name,
            json_extract_string(
                dataset__organization, '$.@code'
            ) as dataset__organization__code,
            json_extract_string(
                dataset__organization, '$.$'
            ) as dataset__organization__name,
            dataset__title,
            dataset__description,
            dataset__publisher,
            dataset__contact_point,
            dataset__creator,
            dataset__release_date,
            dataset__last_modified_date,
            dataset__frequency_of_update,
            dataset__landing_page,
            resources__resource,
        where dataset__stat_name__code = '${inputs.selected_statistics_code_2.value}'
    ),
    unnested as (
        from src
        select
            aid,
            dataset__stat_name__code,
            dataset__stat_name__name,
            dataset__title,
            dataset__description,
            dataset__publisher,
            dataset__contact_point,
            dataset__creator,
            dataset__release_date,
            dataset__last_modified_date,
            dataset__frequency_of_update,
            dataset__landing_page,
            -- resources__resource,
            unnest(json_extract(resources__resource, '$[*]')) as resource
    ),
    flatten_tbl as (
        from unnested
        select
            aid as catalog_id,
            dataset__stat_name__code,
            dataset__stat_name__name,
            json_extract_string(dataset__title, '$.NAME') as dataset__title__name,
            json_extract_string(
                dataset__title, '$.TABULATION_CATEGORY'
            ) as dataset__title__tabulation_category,
            json_extract_string(
                dataset__title, '$.TABULATION_SUB_CATEGORY1'
            ) as dataset__title__tabulation_sub_category1,
            json_extract_string(
                dataset__title, '$.TABULATION_SUB_CATEGORY2'
            ) as dataset__title__tabulation_sub_category2,
            json_extract_string(
                dataset__title, '$.TABULATION_SUB_CATEGORY3'
            ) as dataset__title__tabulation_sub_category3,
            json_extract_string(
                dataset__title, '$.TABULATION_SUB_CATEGORY4'
            ) as dataset__title__tabulation_sub_category4,
            json_extract_string(
                dataset__title, '$.TABULATION_SUB_CATEGORY5'
            ) as dataset__title__tabulation_sub_category5,
            json_extract_string(dataset__title, '$.CYCLE') as dataset__title__cycle,
            json_extract_string(
                dataset__title, '$.SURVEY_DATE'
            ) as dataset__title__survey_date,
            json_extract_string(
                dataset__title, '$.COLLECT_AREA'
            ) as dataset__title__collect_area,
            dataset__publisher,
            dataset__contact_point,
            dataset__creator,
            dataset__release_date,
            dataset__last_modified_date,
            dataset__landing_page,
            json_extract_string(resource, '$.@id') as stats_data_id,
            json_extract_string(resource, '$.TITLE.NAME') as stats_data__title__name,
            json_extract_string(
                resource, '$.TITLE.TABLE_NO'
            ) as stats_data__title__table_no,
            json_extract_string(resource, '$.URL') as url,
            json_extract_string(resource, '$.DESCRIPTION') as stats_data__description,
            json_extract_string(resource, '$.FORMAT') as format,
            json_extract_string(resource, '$.RELEASE_DATE') as stats_data__release_date,
            json_extract_string(
                resource, '$.LAST_MODIFIED_DATE'
            ) as stats_data__last_modefied_date,
            json_extract_string(resource, '$.RESOURCE_LICENCE_ID') as licence_id,
    )
from flatten_tbl
select *
limit 10000
