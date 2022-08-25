# Snowplow Hybrid Apps Accelerator

Hybrid apps are mobile apps that in addition to a native interface, provide part of the UI through an embedded Web view.
Snowplow events are tracked from both the native code (e.g., written in Swift or Java) as well as the Web view (in JavaScript).
Our goal is to have both events tracked from the native code as well as the Web view share the same session and appear as tracked with the same tracker.

This accelerator shows how to set up tracking in hybrid apps so that events tracked inside the Web view are passed to the native layer to be tracked by Snowplow mobile trackers.
Since all events are tracked by the native mobile trackers, they share the same session and other properties.
To achieve this, we make use of both the mobile tracker libraries for iOS and Android as well as the WebView tracker used in JavaScript inside the Web view.
