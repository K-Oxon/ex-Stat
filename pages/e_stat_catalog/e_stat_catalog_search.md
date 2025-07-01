---
title: e-Stat カタログ検索
queries:
  - statistics_code_list: e_stat_catalog/statistics_code_list.sql
  - statistics_code_filtered: e_stat_catalog/statistics_code_filtered.sql
  - estat_catalog_flatten: e_stat_catalog/estat_catalog_flatten.sql
  - catalog_output: e_stat_catalog/catalog_output.sql
---

## カタログの抽出方法

このページではe-Statに掲載されているデータカタログの検索、抽出ができます。

e-Statの統計表の構造は以下のようになっていることに留意してください。

政府統計 → データセット一覧 → 統計表

## 政府統計コード一覧

{statistics_code_list.length} 個ある政府統計名の一覧です。

<TextInput
    name=search_text
    title="政府統計名検索"
    defaultValue=""
    description="政府統計名称を部分一致で検索"
/>

<DataTable data={statistics_code_filtered} rowShading=true>
    <Column id=statistics_code title="政府統計コード"/>
    <Column id=statistics_name title="統計表名"/>
    <Column id=organization_name title="提供機関名"/>
    <Column id=contact_point title="連絡先"/>
    <Column id=landing_page title="url" contentType=link linkLabel="Detail ->"/>
</DataTable>

## 統計表一覧

### 政府統計コードを一つ選択

<Dropdown
    data={statistics_code_list}
    name=selected_statistics_code_2
    value=statistics_code
    title="政府統計コード"
    defaultValue="00200251"
>
</Dropdown>

```sql selected_statistics_name
select dataset__stat_name__name as statistics_name
from statistics_code
where dataset__stat_name__code = '${inputs.selected_statistics_code_2.value}'
```

選択政府統計名: <Value data={selected_statistics_name} color=primary />

```sql resource_dimension
from ${estat_catalog_flatten}
select
    format,
    dataset__title__survey_date,
    dataset__title__name,
    dataset__title__tabulation_sub_category1,
    dataset__title__tabulation_sub_category2,
    stats_data__title__table_no,
    count(*) as resource_count
group by all
```

### (オプション1: 値を選択で絞り込み)

<DimensionGrid
    data={resource_dimension}
    metric='sum(resource_count)'
    name=resource_dimension
    multiple
/>

### (オプション2: テキストでさらに絞り込み)

<TextInput
    name=search_dataset_title
    title="dataset title"
    defaultValue=""
    description="データセット一覧名称を部分一致で検索"
/>

<TextInput
    name=search_stats_title
    title="統計表名"
    defaultValue=""
    description="統計表名を部分一致で検索"
/>

### 対象のカタログをダウンロード

1,000件が上限です。

<DataTable data={catalog_output} rowShading=true wrapTitles=true>
    <Column id=stats_data_id title="統計表ID"/>
    <Column id=stats_data__title__table_no title="統計表番号"/>
    <Column id=stats_data__title__name title="統計表名"/>
    <Column id=format />
    <Column id=dataset__title__survey_date title="データセット調査年"/>
    <Column id=dataset__landing_page title="データセット名" contentType=link linkLabel=dataset__title__name openInNewTab=true/>
    <Column id=url contentType=link linkLabel="Download link" openInNewTab=true/>
</DataTable>

<DownloadData data={catalog_output} text="ダウンロード" />

---

更新日時: <LastRefreshed/>
