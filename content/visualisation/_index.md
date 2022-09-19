+++
title = "Visualisation"
chapter = true
weight = 4
pre = "3. "
post = ""
+++

<!-- ### Chapter 3 -->

# Visualisation

{{<mermaid>}}
flowchart LR
    id1(Upload)-->id2(Model)-->id3(Visualise)-->id4(Track)-->id5(Enrich)-->id6(Test)
    style id3 fill:#f5f5f5,stroke:#6638B8,stroke-width:3px
    style id1 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id5 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id4 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id2 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id6 fill:#f5f5f5,stroke:#333,stroke-width:1px
{{</mermaid >}}

Use Streamlit to visualise your Snowplow data to make it easier to identify patterns and trends in your data.
