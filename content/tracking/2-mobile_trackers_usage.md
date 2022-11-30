+++
title = "Configuring and using the iOS, Android or React Native trackers"
weight = 2
post = ""
+++

Having installed the tracker dependencies, the next step is to initialize the tracker instances in your app.
Tracker instances are initialized given configuration that includes network settings, tracker feature settings, session settings, and more.

The following snippets show how to initialize tracker instances using the default settings.
They call the `Snowplow.createTracker()` function and pass it two required information:

1. The tracker namespace which uniquely identifies the tracker within the app.
2. Network configuration with the endpoint address of the Snowplow Collector (e.g. [Snowplow Micro](https://docs.snowplowanalytics.com/docs/understanding-your-pipeline/what-is-snowplow-micro/) or [Snowplow Mini](https://docs.snowplowanalytics.com/docs/understanding-your-pipeline/what-is-snowplow-mini/)) to send events to.

{{< tabs groupId="platform" >}}

{{% tab name="iOS" %}}

```swift
import SnowplowTracker

let networkConfig = NetworkConfiguration(endpoint: COLLECTOR_URL, method: .post)
let tracker = Snowplow.createTracker(
    namespace: "appTracker",
    network: networkConfig,
    configurations: []
);
```

{{% /tab %}}

{{% tab name="Android" %}}

```java
import com.snowplowanalytics.snowplow.Snowplow;
import com.snowplowanalytics.snowplow.network.HttpMethod;
import com.snowplowanalytics.snowplow.configuration.NetworkConfiguration;

NetworkConfiguration networkConfig = new NetworkConfiguration(COLLECTOR_URL, HttpMethod.POST);
TrackerController tracker = Snowplow.createTracker(context,
    "appTracker",
    networkConfig
);
```

{{% /tab %}}

{{% tab name="React Native" %}}

```typescript
import { createTracker } from '@snowplow/react-native-tracker';

const tracker = createTracker(
    'appTracker',
    {
      endpoint: COLLECTOR_URL,
    },
    {
        trackerConfig: {
            appId: 'appTracker',
        },
    },
);
```

{{% /tab %}}
{{< /tabs >}}

You can learn more about installing and configuring the mobile trackers in [the mobile tracker documentation](https://docs.snowplowanalytics.com/docs/collecting-data/collecting-from-own-applications/mobile-trackers/mobile-trackers-v3-0/introduction/).

#### Tracking events in native code

The initialized tracker instances can be used to track events in your native code.
We won't go into detail on all the tracking features, but only give an example how to track self-describing events.
Self-describing events are based around "self-describing" (self-referential) JSONs, which are a specific kind of [JSON schema](http://json-schema.org/).
A unique schema can be designed for each type of event that you want to track.
This allows you to track the specific things that are important to you, in a way that is defined by you.

A self-describing JSON has two keys, schema and data.
The schema value should point to a valid self-describing JSON schema.
They are called self-describing because the schema will specify the fields allowed in the data value.
Read more about how schemas are used with Snowplow [here](https://docs.snowplowanalytics.com/docs/understanding-tracking-design/understanding-schemas-and-validation/).

{{< tabs groupId="platform" >}}

{{% tab name="iOS" %}}

```swift
let schema = "iglu:com.snowplowanalytics.snowplow/link_click/jsonschema/1-0-1"
let data = ["targetUrl": "http://a-target-url.com"]
let event = SelfDescribing(schema: schema, payload: data)       
tracker.track(event)
```

{{% /tab %}}

{{% tab name="Android" %}}

```java
String schema = "iglu:com.snowplowanalytics.snowplow/link_click/jsonschema/1-0-1";
Map data = new HashMap();
data.put("targetUrl", "http://a-target-url.com");
SelfDescribingJson sdj = new SelfDescribingJson(schema, data);
SelfDescribing event = new SelfDescribing(sdj);
tracker.track(event);
```

{{% /tab %}}

{{% tab name="React Native" %}}

```typescript
tracker.trackSelfDescribingEvent({
    schema: 'iglu:com.snowplowanalytics.snowplow/link_click/jsonschema/1-0-1',
    data: {
        targetUrl: 'http://a-target-url.com',
    },
});
```

{{% /tab %}}
{{< /tabs >}}

#### Subscribing to events from the Web view

In addition to tracking events from the native code, we also want to track events from the Web view.
In the [following section]({{< ref "tracking/3-webview_usage.md" >}}), we will explain how to instrument your Web application to use the WebView tracker.
However, in order for the events from the WebView tracker to arrive at the Snowplow Collector, it is necessary to subscribe the native mobile trackers to listen for messages from the Web view.

{{< tabs groupId="platform" >}}

{{% tab name="iOS" %}}

You can call the `Snowplow.subscribeToWebViewEvents(webView)` function to subscribe to the messages.
The `webView` object is an instance of `WKWebView`.

```swift
Snowplow.subscribeToWebViewEvents(webView)
```

{{% /tab %}}

{{% tab name="Android" %}}

You can call the `Snowplow.subscribeToWebViewEvents(webView)` function to subscribe to the messages.
The `webView` object is an instance of `WebView`.

```java
Snowplow.subscribeToWebViewEvents(webView);
```

{{% /tab %}}

{{% tab name="React Native" %}}

The tracker supports Web views created using the [React Native WebView package](https://www.npmjs.com/package/react-native-webview).

You can pass a callback created using `getWebViewCallback()` as a parameter in your `WebView` component:

```typescript
import { getWebViewCallback } from '@snowplow/react-native-tracker';

const YourWebViewComponent = () => {
    return <WebView
        onMessage={getWebViewCallback()}
        source={{uri: WEB_VIEW_URI}}
        ... />;
```

{{% /tab %}}
{{< /tabs >}}

Please note that the events will only be tracked if you have initialized a tracker instance as described above.
