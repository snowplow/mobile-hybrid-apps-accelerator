+++
title = "Tracking"
chapter = true
weight = 1
pre = "<b>1. </b>"
post = ""
+++

# Tracking

Mobile hybrid apps implement some app logic in the platform native code (e.g., in Swift or Java) while some UI is implemented using embedded Web views.
Since the two parts are developed using separate code bases, Snowplow events need to be tracked separately.

The diagram below shows the interaction between different components in a hybrid app in relation to Snowplow event tracking.
Events can be tracked from app logic both inside the Web view as well as the native code.
Native code events are tracked using the [Snowplow iOS](https://github.com/snowplow/snowplow-objc-tracker) or [Android tracker](https://github.com/snowplow/snowplow-android-tracker) that sends them to the Snowplow Collector.
Web view events are tracked using the [WebView tracker](https://github.com/snowplow-incubator/snowplow-webview-tracker) that passes them to be tracked by the Snowplow iOS or Android tracker.

{{<mermaid>}}
flowchart TB

subgraph hybridApp[Hybrid Mobile App]

    subgraph webView[Web View]
        webViewCode[App logic]
        webViewTracker[Snowplow WebView tracker]

        webViewCode -- "Tracks events" --> webViewTracker
    end

    subgraph nativeCode[Native Code]
        nativeAppCode[App logic]
        nativeTracker[Snowplow iOS/Android tracker]

        nativeAppCode -- "Tracks events" --> nativeTracker
    end

    webViewTracker -- "Forwards events" --> nativeTracker
end

subgraph cloud[Cloud]
    collector[Snowplow Collector]
end

nativeTracker -- "Sends tracked events" --> collector
{{</mermaid>}}

This tutorial guides you to instrument Snowplow tracking in both the Web view and native mobile code and track events with consistent session and properties on both sides.
It is structured in three parts:

1. [Installation]({{< ref "tracking/1-installation.md" >}}) of the trackers in your apps.
2. [Instrumenting your native iOS or Android app]({{< ref "tracking/2-mobile_trackers_usage.md" >}}) with the mobile trackers and setting up the Web view communication.
3. [Tracking events from your Web view]({{< ref "tracking/3-webview_usage.md" >}}) with the WebView tracker.
