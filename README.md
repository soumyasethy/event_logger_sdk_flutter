# logger_sdk

## Clever Tap In-house

## Problem Statement-
Currently we are using Clever Tap for analytics purposes throughout the systems which is a third party tool, comes very expensive and it’s not queryable.

## Limitations

Currently, we are not able to use the full potential of our inhouse data platform as the client does not have a mechanism to push the data directly to Clever Tap.
We consume these data indirectly by syncing data from clever tap to our systems.
Though clevertap does provide some good features, it also misses out on a few important features like that ability to query in a structured manner. We also have issues with mapping our backend model with the client. We pay a huge amount of money for this service. With this sdk we lay one step closer to achieving the ultimate data platform / analytics system. We would also benefit from the fact that all the tools built by our data platform will work across teams. The other important factor is we would not have workflow on two different systems. This would help in improving debugging and analysis of features we release.

Very short size payload can be sent which makes it very hard for debugging purposes.

## Usages
Since we are heavily betting on Flutter. It’s very expandable for integration in  both Mobile and Web.
Queryable, We can have in-house customised data and graphs for debug, analytics purposes. For app debugging we can query by task id or timing of the day.
Battery Saving, Runs fixed configurable time frequency  to make sure it is battery friendly through Work Manager.
Offline caching of all events so saves all data in low connectivity zones.

