---
title: ex-Stat
description: |
  政府統計サイト「e-Stat」のデータは使いにくいという声が多く、課題があります。特に、サイト構造や検索機能が分かりにくいため、欲しいデータを探すのが難しいのが問題です。
  そこで、本サイト「ex-Stat」では、e-StatのAPIを使って取得したデータカタログをparquet形式で配布しています。データは毎週更新し、簡単に利用できるよう整理しています。
queries:
  - estat_catalog_columns: idx_lake_estat_catalog_columns.sql
  - estat_catalog_url: idx_lake_estat_catalog_url.sql
---

政府統計ポータルサイト「[e-Stat](https://www.e-stat.go.jp/)」は、日本のさまざまな統計データを公開している公式サイトですが、データの流通という観点では多くのユーザーにとって使いやすいとは言えず、課題が多いことが指摘されています。

これらの課題には、サイト構造の複雑さや検索機能の不十分さ、またデータを作成している各官庁のデータ公開に対する意識の違いなど、さまざまな理由が考えられます。結果として、次のような悪循環が生まれています。

1. サイトの構造や概念が分かりにくく、検索性が悪い。
2. どんなデータが公開されているのか把握しにくく、活用可能性も見えにくい。
3. 改善要望を出したくても、データの検索や活用の手前でつまづくため、具体的な改善点を指摘しづらい。
4. 「e-Statは使いにくい・使うのに苦労した」という認知のみが広がり、利用が進まない。

これらの課題のうち、「どんなデータがe-Statに置いてあるのか」という点については、e-Statが提供しているAPIのデータカタログ機能を利用することである程度解消可能です。ただ、このAPIも検索機能は限定的であり、全データを一覧として取得するには非常に長い時間を要します。

そこで、本サイト「ex-Stat」では、より簡単に統計データの一覧を確認できるよう、e-Stat APIから取得したカタログデータをparquet形式で提供しています。提供するデータは管理人oxonが個人的に抽出・整理したもので、定期的に更新しています。

## 配布データについて

- 更新: 毎週日曜日
- ファイル形式: parquet

スキーマ情報:

<DataTable 
    data={estat_catalog_columns} 
    sort="column_order asc" 
    groupBy=root_column_name
    groupsOpen=false
    wrapTitles=true >
    <Column id=full_name_path />
    <Column id=column_type />
    <Column id=nulls_allowed />
    <Column id=comment wrap=true/>
    <Column id=min_value wrap=true />
    <Column id=max_value wrap=true />
</DataTable>

参考: [e-Stat API Swagger UI](https://api.e-stat.go.jp/swagger-ui)のgetDataCatalogエンドポイント

## for データアナリスト・データエンジニア・ソフトウェアエンジニア

こちらのURLでparquetを配布しています。

<DataTable data={estat_catalog_url} sortable=false downloadable=false compact=true wrapTitles=true>
    <Column id=file_url contentType=link wrap=true/>
</DataTable>

duckdbなどを使えば簡単にローカルで集計や検索ができます。

sql例

```sql
from read_parquet(
  'https://data.oxon-data.work/data/estat_api/estat_data_catalog/ducklake-01980372-2c34-79b9-81c9-25f2e366840c.parquet'
)
limit 10
```

## for このサイト上で検索したい人

[e-Stat カタログ検索](e_stat_catalog/e_stat_catalog_search) でフィルターや検索などを使用してデータの一覧を表示できます。
抽出した結果をcsvでダウンロードできます。

## もしかしたらやるかも

- landing_pageなどをscrapeして、ランディングページの情報を追加
- 上記をベクトル化し、RAGなどに対応
- e-Stat CatalogのMCP化
- API提供データのparquet配布
- ファイル提供データの年度を結合したparquetの配布

## クレジット

<Note>
このサービスは、政府統計総合窓口(e-Stat)のAPI機能を使用していますが、サービスの内容は国によって保証されたものではありません。
</Note>
