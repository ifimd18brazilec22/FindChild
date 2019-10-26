//
//  CheckerArea.swift
//  FindChild
//
//  Created by Артем Стратиенко on 27/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit
// draw area for user's poi
extension ViewController {
    public func zoneObject(id : Int, geo : NMAGeoCoordinates, type : String) {
        objSelect = objectSelectedUsers()
        if objSelect.id == 0 {
        }
         /*1*/       objSelect.id = id
        let polyTester = drawRectwith(centrBox: geo, 0.005)
            polyTester.polyGon.map{mapHere.add(mapObject: $0)}
            boxik = polyTester.polyBox
            let marker = NMAMapMarker(geoCoordinates: geo, image: UIImage(named: type)!)
            coordSystemHeli.append(geo)
            let cluster = NMAClusterLayer()
            cluster.addMarker(marker)
            self.mapHere.add(clusterLayer: cluster)
            print("struct - \(arrayObjSelect)")
    }
}
