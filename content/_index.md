+++
title = "Introduction"
menuTitle = "Introduction"
pre = "<i class='fas fa-rocket'></i> "
chapter = false
weight = 1
+++

!['logo-banner'](images/logo_banner.png)

#### Introduction

Welcome to the **Mobile & Hybrid App Analytics** accelerator. Once finished, you will be able to build a deeper understanding of customer behaviour on your mobile apps and use your data to influence business decisions.

Here you will learn to:

- Model and Visualise Snowplow data
  - using the [snowplow-mobile](https://hub.getdbt.com/snowplow/snowplow_mobile/latest/) dbt package and Streamlit
  - using our sample data for Snowflake (no need to have a working pipeline)
- Set-up Snowplow Tracking in a hybrid mobile app
  - track events both from a native iOS/Android/React Native code as well as embedded Web views
- Apply what you have learned on your own pipeline to gain insights

***

Hybrid apps are mobile apps that in addition to a native interface, provide part of the UI through an embedded Web view.
Snowplow events are tracked from both the native code (e.g. written in Swift or Kotlin) as well as the Web view (in JavaScript).
Our goal is to have both events tracked from the native code as well as the Web view, share the same session and appear as tracked with the same tracker.

#### System overview

The diagram below gives a complete overview of the system covered in this accelerator:

1. Events are tracked from app logic both inside the **Web view** as well as the **native app code**.
   - Native code events are tracked using the [Snowplow iOS](https://github.com/snowplow/snowplow-objc-tracker), [Android](https://github.com/snowplow/snowplow-android-tracker), or [React Native tracker](https://github.com/snowplow/snowplow-react-native-tracker).
   - Web view events are tracked using the [WebView tracker](https://github.com/snowplow-incubator/snowplow-webview-tracker) that passes them to be tracked by the Snowplow iOS or Android tracker.
2. Tracked events are loaded into a **Snowflake warehouse** by the Snowplow BDP or Open Source Cloud.
3. The raw events are **modeled into higher level entities** such as screen views, sessions, or users using the [snowplow-mobile](https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-mobile-data-model/dbt-mobile-data-model/) dbt package.
4. Finally, we **visualize** the modeled data using Streamlit.

{{<mermaid>}}
flowchart TB

subgraph hybridApp[Hybrid Mobile App]

    subgraph webView[Web View]
        webViewCode[App logic]
        webViewTracker[Snowplow WebView tracker]

        webViewCode -- "Tracks events" --> webViewTracker

        style webViewTracker fill:#f5f5f5,stroke:#6638B8,stroke-width:3px
        click webViewTracker "https://github.com/snowplow-incubator/snowplow-webview-tracker" "Open tracker package" _blank
    end

    subgraph nativeCode[Native iOS/Android]
        nativeAppCode[App logic]
        nativeTracker[Snowplow iOS/Android/React Native tracker]

        nativeAppCode -- "Tracks events" --> nativeTracker

        style nativeTracker fill:#f5f5f5,stroke:#6638B8,stroke-width:3px
        click nativeTracker "https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/installation-and-set-up/" "Open tracker docs" _blank
    end

    webViewTracker -- "Forwards events" --> nativeTracker
end

subgraph cloud[Cloud]
    snowplow[Snowplow BDP/OS Cloud]
    snowflake[(Snowflake)]
    dbt[snowplow-mobile dbt package]
    streamlit[Streamlit]

    snowplow -- "Loads raw events" --> snowflake
    dbt -- "Models data" --> snowflake
    streamlit -- "Visualises modeled data" --> snowflake

    style dbt fill:#f5f5f5,stroke:#6638B8,stroke-width:3px
    click dbt "https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-mobile-data-model/dbt-mobile-data-model/" "Open dbt package" _blank
    click snowplow "https://snowplow.io/snowplow-bdp/" "Snowplow BDP" _blank
end

nativeTracker -- "Sends tracked events" --> snowplow
{{</mermaid>}}

***

#### Who is this guide for?

- Data practitioners who would like to get familiar with Snowplow data.
- Data practitioners who would like to set up tracking in a mobile hybrid app and learn how to use the Snowplow mobile data model to gain insight from their customers' behavioural data as quickly as possible.

***

#### What you will learn

In approximately 2 working days (~13 working hours) you can achieve the following:

- **Upload data -** Upload a sample Snowplow events dataset to your Snowflake warehouse
- **Model -** Configure and run the snowplow-mobile data model
- **Visualise -** Visualise the modeled data with Streamlit
- **Track -** Set-up and deploy tracking to your hybrid mobile app
- **Next steps -** Gain value from your own pipeline data through modeling and visualisation


{{<mermaid>}}
gantt
        dateFormat  HH-mm
        axisFormat %M
        section 1. Upload
        1h          :upload, 00-00, 1m
        section 2. Model
        2h          :model, after upload, 2m
        section 3. Visualise
        3h          :visualise, after model, 3m
        section 4. Track
        6h          :track, after visualise, 6m
        section 5. Next steps
        1h          :next steps, after track, 2m

{{</mermaid >}}

***

#### Prerequisites

**Modeling and Visualisation**

- dbt CLI installed / dbt Cloud account available
  - New dbt project created and configured
- Python 3 Installed
- Snowflake account and a user with access to create schemas and tables

**Tracking**

- Snowplow pipeline
- Hybrid mobile app to implement tracking on

{{% notice info %}}
Please note that Snowflake will be used for illustration but the snowplow-mobile dbt package also supports **BigQuery, Databricks, Postgres** and **Redshift**. Further adapter support for this accelerator coming soon!
{{% /notice %}}

***

#### What you will build

**Mobile & Hybrid Apps Analytics Dashboard**

!['logo-banner' ](visualisation/images/streamlit.png?width=100pc)
