# Snowplow Hybrid Apps Tracking

## Introduction

In this guide you'll learn how to set up tracking as well as how to model and visualise Snowplow data in mobile hybrid apps.

Hybrid apps are mobile apps that in addition to a native interface, provide part of the UI through an embedded Web view.
Snowplow events are tracked from both the native code (e.g., written in Swift or Kotlin) as well as the Web view (in JavaScript).
Our goal is to have both events tracked from the native code as well as the Web view share the same session and appear as tracked with the same tracker.

This accelerator shows how to set up tracking in hybrid apps so that events tracked inside the Web view are passed to the native layer to be tracked by Snowplow mobile trackers.
Since all events are tracked by the native mobile trackers, they share the same session and other properties.
To achieve this, we make use of both the mobile tracker libraries for iOS and Android as well as the WebView tracker used in JavaScript inside the Web view.

We will model the tracked data using the [snowplow-mobile](https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-mobile-data-model/dbt-mobile-data-model/) dbt package.

***

## Who is this guide for?

Data practicioners who would like to set up tracking in a mobile hybrid app and learn how to use the Snowplow mobile data model to gain insight from their customers' behavioural data as quickly as possible.

***

## What you'll learn

In less than 2 working days you will learn to: 

- **Track -** Setup and deploy tracking to mobile hybrid application
- **Model -** Configure the snowplow-mobile data model and run it against your Snowflake warehouse

{{<mermaid>}}
gantt
        dateFormat  HH-mm
        axisFormat %M
        section 1. Track
        10h          :track, 00-00, 6m
        section 2. Model
        2h          :model, after track, 4m
{{</mermaid >}}

***

## Prerequisites

- Snowplow Pipeline
- Hybrid mobile app to implement tracking on
- dbt installed
  - a new dbt project created and configured
  - a dataset of events from the Snowplow Javascript tracker in your data warehouse (Snowflake will be used for illustration but the package also supports BigQuery, Databricks, Postgres and Redshift)
