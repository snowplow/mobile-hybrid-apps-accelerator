+++
title = "Modeling"
chapter = true
weight = 2
pre = "2. "
post = ""
+++

# Modeling your Data

{{<mermaid>}}
flowchart LR
    id1(Upload)-->id2(Model)-->id3(Visaualize)-->id4(Track)-->id5(Next steps)
    style id2 fill:#f5f5f5,stroke:#6638B8,stroke-width:3px
    style id1 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id4 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id5 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id3 fill:#f5f5f5,stroke:#333,stroke-width:1px
{{</mermaid >}}

The [snowplow-mobile dbt package](https://hub.getdbt.com/snowplow/snowplow_mobile/latest/) transforms and aggregates the raw mobile event data collected from the Snowplow mobile trackers (e.g. the [Android tracker](https://github.com/snowplow/snowplow-android-tracker), [iOS tracker](https://github.com/snowplow/snowplow-objc-tracker), [React Native tracker](https://github.com/snowplow/snowplow-react-native-tracker)) into a set of derived tables: *screen views, sessions, users* and *user mappings*. Modeling the data makes it easier to digest and derive business value from the Snowplow data either through AI or BI.

In this chapter you will learn how to set-up an run the snowplow-mobile package to model the sample data.
