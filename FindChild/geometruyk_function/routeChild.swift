//
//  routeChild.swift
//  FindChild
//
//  Created by Артем Стратиенко on 27/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit

extension ViewController {
@IBAction func routeChild(_ sender: Any) {
    let  myPosition = NMAPositioningManager.sharedInstance().currentPosition
    var routingMode = NMARoutingMode()
    routingMode = NMARoutingMode.init(
        routingType: NMARoutingType.balanced,//shortest,//.fastest,
        transportMode: NMATransportMode.pedestrian,//pedestrian,
        routingOptions: []//NMARoutingOption.avoidTollRoad
    )
    // check if calculation completed otherwise cancel.
    if !(progress?.isFinished ?? false) {
        progress?.cancel()
    }
    route.insert(NMAGeoCoordinates(latitude: (myPosition?.coordinates!.latitude)!, longitude: (myPosition?.coordinates!.longitude)!), at: 0)
    print(route)
    progress = coreRouter.calculateRoute(withStops: route, routingMode: routingMode, { (routeResult, error) in
  //      print(self.route)
        if (error != NMARoutingError.none) {
            NSLog("Error in callback: \(error)")
            return
        }
        guard let route = routeResult?.routes?.first else {
            print("Empty Route result")
            return
        }
        guard let box = route.boundingBox, let mapRoute = NMAMapRoute.init(route) else {
            print("Can't init Map Route")
            return
        }
        
        if (self.mapRouts.count != 0) {
            for route in self.mapRouts {
                self.mapHere.remove(mapObject: route)
            }
            self.mapRouts.removeAll()
        }
        self.mapRouts.append(mapRoute)
        self.mapHere.set(boundingBox: box, animation: NMAMapAnimation.linear)
        //NMAMapRoute(route)
        self.mapHere.add(mapObject: mapRoute)
    })
}
    @IBAction func clearMap(_ sender: UIButton) {
        // remove all routes from mapView.
        for route in mapRouts {
            self.mapHere.remove(mapObject: route)
        }
        route.removeAll()
        //self.mapHere.zoomLevel = 10
    }
}
