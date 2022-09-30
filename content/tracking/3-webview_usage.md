+++
title = "Setting up tracking in Web views"
weight = 3
post = ""
+++

In the [Installation section]({{< ref "tracking/1-installation.md" >}}), you installed the [WebView tracker](https://github.com/snowplow-incubator/snowplow-webview-tracker) in your JavaScript Web app that is accessed in the mobile Web views.
After that, you [learned how to]({{< ref "tracking/2-mobile_trackers_usage.md" >}}) configure and use the mobile trackers to track events and subscribe to events from Web views.
This section explains how to use the WebView tracker to track events inside Web views.

#### Event tracking API

The tracker provides a set of functions to manually track events.
The functions range from single purpose ones, such as `trackScreenView`, to the more complex but flexible `trackSelfDescribingEvent`, which can be used to track any kind of user behaviour.
We strongly recommend using `trackSelfDescribingEvent` for your tracking, as it allows you to design custom event types to match your business requirements. [This post](https://snowplowanalytics.com/blog/2020/01/24/re-thinking-the-structure-of-event-data/) on our blog, "Re-thinking the structure of event data" might be informative here.

You can import the functions from the `@snowplow/webview-tracker` package:

```javascript
import { trackSelfDescribingEvent, trackScreenView } from '@snowplow/webview-tracker';
```

The following functions are available:

| Method | Event type tracked |
|---|---|
| `trackSelfDescribingEvent` | Track a custom event based on "self-describing" JSON schema |
| `trackStructEvent` | Track a semi-custom structured event |
| `trackScreenView` | Track a view of a screen in the app (to be used with the [Snowplow mobile data model](https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-mobile-model/)) |
| `trackPageView` | Track a Web page visit (to be used with the [Snowplow web data model](https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-web-data-model/)) |

All the methods share common features and parameters. Every type of event can have an optional context added. See the end of this section to learn about adding context entities to events. It's important to understand how event context works, as it is one of the most powerful Snowplow features. Adding event context entities is a way to add depth, richness and value to all of your events.

All of the `trackXYZ()` methods accept two arguments:

| Argument   | Description                                                    | Required? |
| -----------| -------------------------------------------------------------- | ------------------ |
| `event`    | Event body, depends on the event being tracked                 | Yes                |
| `trackers` | Optional list of tracker namespaces to track the event with (undefined for default tracker) | No  |

For instance, the following tracks a structured event (explained below) using a tracker initialized with the namespace `ns1`:

```javascript
trackStructEvent(
    {
        category: 'shop',
        action: 'add-to-basket'
    },
    ['ns1']
);
```

#### Track self-describing events with `trackSelfDescribingEvent`

Use the `trackSelfDescribingEvent` function to track a custom event.
This is the most advanced and powerful tracking method, which requires a certain amount of planning and infrastructure.

Self-describing events are based around "self-describing" (self-referential) JSONs, which are a specific kind of [JSON schema](http://json-schema.org/).
A unique schema can be designed for each type of event that you want to track.
This allows you to track the specific things that are important to you, in a way that is defined by you.

This is particularly useful when:

- You want to track event types which are proprietary/specific to your business
- You want to track events which have unpredictable or frequently changing properties

A self-describing JSON has two keys, `schema` and `data`.
The `schema` value should point to a valid self-describing JSON schema.
They are called self-describing because the schema will specify the fields allowed in the data value.
Read more about how schemas are used with Snowplow [here](https://docs.snowplowanalytics.com/docs/understanding-tracking-design/understanding-schemas-and-validation/).

| Argument       | Description                                                    | Required? |
| ---------------| -------------------------------------------------------------- | ------------------ |
| `event.schema` | The grouping of structured events which this action belongs to | Yes                |
| `event.data`   | Defines the type of user interaction which this event involves | Yes                |
| `context`      | List of context entities as self-describing JSONs              | No                 |

Example using the default tracker:

```javascript
trackSelfDescribingEvent({
    event: {
        schema: 'iglu:com.example_company/save_game/jsonschema/1-0-2',
        data: {
            'saveId': '4321',
            'level': 23,
            'difficultyLevel': 'HARD',
            'dlContent': true
        }
    }
});
```

#### Track structured events with `Structured`

This method provides a halfway-house between tracking fully user-defined self-describing events and out-of-the box predefined events.
This event type can be used to track many types of user activity, as it is somewhat customizable.
"Struct" events closely mirror the structure of Google Analytics events, with "category", "action", "label", and "value" properties.

As these fields are fairly arbitrary, we recommend following the advice in this table on how to define structured events.
It's important to be consistent throughout the business about how each field is used.

| Argument   | Description                                                    | Required? |
| -----------| -------------------------------------------------------------- | ------------------ |
| `category` | The grouping of structured events which this action belongs to | Yes                |
| `action`   | Defines the type of user interaction which this event involves | Yes                |
| `label`    | Often used to refer to the 'object' the action is performed on | No                 |
| `property` | Describing the 'object', or the action performed on it         | No                 |
| `value`    | Provides numerical data about the event                        | No                 |
| `context`  | List of context entities as self-describing JSONs              | No                 |

Example:

```javascript
trackStructEvent({
    category: 'shop',
    action: 'add-to-basket',
    label: 'Add To Basket',
    property: 'pcs',
    value: 2.00,
});
```

#### Track screen views with `trackScreenView`

Use `ScreenView` to track a user viewing a screen (or similar) within your app.
This is the page view equivalent for apps that are not webpages.
Screen view events are used in the [Snowplow mobile data model](https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-mobile-model/).

This method creates an unstruct event, by creating and tracking a self-describing event.
The schema ID for this is "iglu:com.snowplowanalytics.snowplow/screen_view/jsonschema/1-0-0", and the data field will contain the parameters which you provide.
That schema is hosted on the schema repository Iglu Central, and so will always be available to your pipeline.

| Argument | Description | Required? |
|---|---|---|
| `name` | The human-readable name of the screen viewed. | Yes |
| `id` | The id (UUID v4) of screen that was viewed. | Yes |
| `type` | The type of screen that was viewed. | No |
| `previousName` | The name of the previous screen that was viewed. | No |
| `previousType` | The type of screen that was viewed. | No |
| `previousId` | The id (UUID v4) of the previous screen that was viewed. | No |
| `transitionType` | The type of transition that led to the screen being viewed. | No |
| `context` | List of context entities as self-describing JSONs | No |

Example:

```javascript
trackScreenView({
    id: '2c295365-eae9-4243-a3ee-5c4b7baccc8f',
    name: 'home',
    type: 'full',
    transitionType: 'none'
});
```

#### Track Web page views with `trackPageView`

The `PageViewEvent` may be used to track page views on the Web.
The event is designed to track web page views and automatically captures page title, referrer and URL.

Page view events are the basic building blocks for the [Snowplow web data model](https://docs.snowplowanalytics.com/docs/modeling-your-data/the-snowplow-web-data-model/).
For mobile apps we recommend using the mobile data model and tracking screen view events instead.

| Argument | Description | Required? |
|---|---|---|
| `title` | Override the page title. | No |
| `context` | List of context entities as self-describing JSONs | No |

```javascript
trackPageView();
```

#### Adding data to your events using context entities

Event context is an incredibly powerful aspect of Snowplow tracking, which allows you to create very rich data.
It is based on the same self-describing JSON schemas as the self-describing events.
Using event context, you can add any details you like to your events, as long as you can describe them in a self-describing JSON schema.

Each schema will describe a single "entity".
All of an event's entities together form the event context.
The event context will be sent as one field of the event, finally ending up in one column (`context`) in your data storage.
There is no limit to how many entities can be attached to one event.

Note that context can be added to any event type, not just self-describing events.
This means that even a simple event type like a page view can hold complex and extensive information – reducing the chances of data loss and the amount of modelling (JOINs etc.) needed in modelling, while increasing the value of each event, and the sophistication of the possible use cases.

The entities you provide are validated against their schemas as the event is processed (during the enrich phase).
If there is a mistake or mismatch, the event is processed as a Bad Event.

Once defined, an entity can be attached to any kind of event.
This is also an important point; it means your tracking is as DRY as possible.
Using the same "user" or "image" or "search result" (etc.) entities throughout your tracking reduces error, and again makes the data easier to model.

Example:

```javascript
trackStructEvent(
    {
        category: 'shop',
        action: 'add-to-basket',
        label: 'Add To Basket',
        property: 'pcs',
        value: 2.00,
        context: [
            {
                schema: 'iglu:com.my_company/movie_poster/jsonschema/1-0-0',
                data: {
                    movie_name: 'Solaris',
                    poster_country: 'JP',
                    poster_date: '1978-01-01'
                }
            },
            {
                schema: 'iglu:com.my_company/customer/jsonschema/1-0-0',
                data: {
                    p_buy: 0.23,
                    segment: 'young_adult'
                }
            }
        ]
    },
    ['ns1']
);
```
