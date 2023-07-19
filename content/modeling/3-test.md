+++
title= "Explore Snowplow data"
weight = 3
post = ""
+++

Data should now be loaded into your warehouse. In this section, we will take a closer look at the output to mitigate data issues and get familiar with the derived tables.

***

#### **Step 1:** Check the output schemas

Head to the SQL editor of your choice (e.g.: Snowflake Web UI) to check the model's output. You should be able to see three new schemas created:

1. [your_custom_schema]_***scratch***: drop and recompute models that aid the incremental run
2. [your_custom_schema]_***derived***: main output models you can use in your downstream models and reporting
3. [your_custom_schema]_***snowplow_manifest***: tables that help the integrity and core incremental logic of the model

***

#### **Step 2:** Explore your data

Take some time to familiarize yourself with the derived tables. You could run a few simple queries such as the ones listed below. Make sure to modify the schema to be aligned with your custom dbt schema.

**Find out the number of screen views using `derived.snowplow_mobile_screen_views:`**

```sql
WITH VIEWS AS (

  SELECT

    SCREEN_VIEW_NAME,
    COUNT(*)

  FROM YOUR_CUSTOM_SCHEMA_DERIVED.SNOWPLOW_MOBILE_SCREEN_VIEWS

  GROUP BY 1 ORDER BY 2 DESC

)

SELECT * FROM VIEWS
```

**Calculate the bounce rate using `derived.snowplow_sessions:`**

```sql
WITH BOUNCE_RATE AS (

  SELECT

    APP_ID,
    COUNT(DISTINCT SESSION_ID) AS SESSIONS,
    COUNT(DISTINCT CASE WHEN SCREEN_VIEWS = 1 THEN SESSION_ID END) / COUNT(DISTINCT SESSION_ID) AS BOUNCE_RATE

  FROM YOUR_CUSTOM_SCHEMA_DERIVED.SNOWPLOW_MOBILE_SESSIONS

  GROUP BY 1
  ORDER BY SESSIONS DESC

)

SELECT * FROM BOUNCE_RATE
```

**Find out details about the highest engaged user using `derived.snowplow_users:`**

```sql
WITH ENGAGEMENT AS (

  SELECT *

  FROM YOUR_CUSTOM_SCHEMA_DERIVED.SNOWPLOW_MOBILE_USERS

  ORDER BY SCREEN_VIEWS DESC

  LIMIT 1

)

SELECT * FROM ENGAGEMENT
```

***

Check out the **database** section of the [documentation site](https://snowplow.github.io/dbt-snowplow-mobile/#!/overview/snowplow_mobile) for a full breakdown of what the output should look like.
