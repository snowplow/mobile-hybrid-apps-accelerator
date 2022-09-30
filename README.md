# Mobile & Hybrid App Analytics Accelerator

This accelerator guides the user through setting up Snowplow tracking in mobile hybrid apps.
It also introduces the Snowplow dbt mobile data model.

## Installation

Recursively update the git submodules:

```
git submodule update --init --recursive
```

Build the Hugo app:

```
./scripts/build.sh
```

## Usage

Run an HTTP server inside the `public` folder. For example, using Python:

```
python3 -m http.server --directory public
```
