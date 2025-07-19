with recursive
    base as (select * from fukagawa_lake_dbt.mrt_fukagawa_lake.lake_column_meta),
    column_hierarchy as (
        -- ベースケース: parent_columnがNULLの行（最上位）から開始
        select
            schema_id,
            table_id,
            column_id,
            parent_column,
            column_name,
            array[column_name] as full_name_path,
            column_id as root_column_id,
            column_name as root_column_name,
            0 as level
        from base
        where parent_column is null

        union all

        -- 再帰ケース: 子要素を辿る
        select
            child.schema_id,
            child.table_id,
            child.column_id,
            child.parent_column,
            child.column_name,
            array_append(h.full_name_path, child.column_name) as full_name_path,
            h.root_column_id,
            h.root_column_name,
            h.level + 1 as level
        from column_hierarchy h
        inner join base child on h.column_id = child.parent_column
    )
select
    base.*,
    -- 配列を文字列に変換（最上位から最下位への順番）
    array_to_string(full_name_path, '.') as full_name_path,
    root_column_id,
    root_column_name,
    level
from base
left join
    column_hierarchy
    on base.schema_id = column_hierarchy.schema_id
    and base.table_id = column_hierarchy.table_id
    and base.column_id = column_hierarchy.column_id
order by column_order
;
