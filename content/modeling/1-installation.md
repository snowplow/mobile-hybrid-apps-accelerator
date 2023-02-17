+++
title = "Install Snowplow dbt Package"
weight = 1
post = ""
+++

#### **Step 1:** Add snowplow-mobile package

Add the snowplow-mobile package to your packages.yml file. The latest version can be found [here](https://hub.getdbt.com/snowplow/snowplow_mobile/latest/)

```yml
packages:
  - package: snowplow/snowplow_mobile
    version: {{<component name="snowplow_mobile_latest">}}
```

***

#### **Step 2:** Install the package

Install the package by running:

```sh
dbt deps
```
