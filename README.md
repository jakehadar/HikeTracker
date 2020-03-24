# HikeTracker
An iOS hike tracker for recording, measuring, and saving the user's hikes.

HikeTracker is a native iOS app that uses CoreMotion, CoreData, and MapKit to track, measure, and record the user's location, speed, and elevation changes during a hike. As the user moves, a polyline is rendered to show where they have travelled, and they can access more information regarding their hike via "Hike Stats". The user can also change the map view as desired. Once finished the user can save or discard their hike and corresponding stats. 

## Demo
Note: this demo is using Xcode's built in location simulator and therefore does not update altitude changes via CoreMotion.
![](hiketracker-min.gif)


#### Known Issues, Limitations, and Future Plans
HikeTracker's UI is currently only set up for iPhone 8. The hope is to make the app compatable for all iOS mobile devices and add a built in camera functionality that allows the user to capture photos that render as annotations along their route. Ideally they can then upload selected hikes to a backend server where they can be shared and/or imported to other users' devices.

#### Developer Note
This was my first exposure to Swift and the vast world of mapping tools and SDKs. The project was built over a one week period and has some areas I would love to improve upon. Any feedback is welcome!
