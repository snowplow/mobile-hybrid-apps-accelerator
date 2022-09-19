+++
title = "Tracking"
chapter = true
weight = 5
pre = "4. "
post = ""
+++

# Tracking

{{<mermaid>}}
flowchart LR
    id1(Upload)-->id2(Model)-->id3(Visualise)-->id4(Track)-->id5(Next steps)
    style id4 fill:#f5f5f5,stroke:#6638B8,stroke-width:3px
    style id1 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id3 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id5 fill:#f5f5f5,stroke:#333,stroke-width:1px
    style id2 fill:#f5f5f5,stroke:#333,stroke-width:1px
{{</mermaid >}}

Mobile hybrid apps implement some app logic in the platform native code (e.g., in Swift or Java) while some UI is implemented using embedded Web views.
Since the two parts are developed using separate code bases, Snowplow events need to be tracked separately.

This part guides you to instrument Snowplow tracking in both the Web view and native mobile code and track events with consistent session and properties on both sides.
It is structured in three parts:

1. [Installation]({{< ref "tracking/1-installation.md" >}}) of the trackers in your apps.
2. [Instrumenting your native iOS or Android app]({{< ref "tracking/2-mobile_trackers_usage.md" >}}) with the [mobile trackers](https://docs.snowplow.io/docs/collecting-data/collecting-from-own-applications/mobile-trackers/installation-and-set-up/) and setting up the Web view communication.
3. [Tracking events from your Web view]({{< ref "tracking/3-webview_usage.md" >}}) with the [WebView tracker](https://github.com/snowplow-incubator/snowplow-webview-tracker).
