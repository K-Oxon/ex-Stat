---
title: 提供データ一覧
queries:
  - lake_tables: provided_data_list/lake_table_meta.sql
  - lake_columns: provided_data_list/lake_column_meta.sql
---

## このサイトで提供しているデータ一覧

Table:

<DataTable data={lake_tables} wrapTitles=true>
    <Column id=table_name />
    <Column id=comment wrap=true />
    <Column id=table_record_count />
    <Column id=table_file_size_bytes />
    <Column id=file_format />
    <Column id=file_url contentType=link linkLabel="Download"/>
</DataTable>

Schema:

<Dropdown 
    data={lake_tables} 
    name=table_name_selected 
    value=table_name 
    title="テーブル名" 
    defaultValue="estat_data_catalog"
/>

<DataTable 
    data={lake_columns} 
    wrapTitles=true
    sort="table_id asc column_order asc" >
    <Column id=table_name />
    <Column id=full_name_path />
    <Column id=column_type />
    <Column id=nulls_allowed />
    <Column id=comment wrap=true/>
    <Column id=min_value wrap=true />
    <Column id=max_value wrap=true />
</DataTable>
