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
           //arrayObjSelect
           objSelect = objectSelectedUsers()
           if objSelect.id == 0 {
             //  delete(objSelect[0])
           }
            /*1*/       objSelect.id = id
           let polyTester = drawRectwith(centrBox: geo, 0.00005)
               polyTester.polyGon.map{mapHere.add(mapObject: $0)}
               boxik = polyTester.polyBox
              // ***
             //  let leftUp = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (boxik?.topLeft.latitude)!, longitude:
              //     (boxik?.topLeft.longitude)!,altitude: 1), image: LeftUp!)
              // print("Marker coordinates : \(leftUp.coordinates)")
           //    self.mapHere.add(mapObject: leftUp)
           //*
              // let rightUp = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (boxik?.topRight.latitude)!, longitude: (boxik?.topRight.longitude)!,altitude: 1), image: RightUp!)
           //    self.mapHere.add(mapObject: rightUp)
           //*
             //   let rightDown = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (boxik?.bottomRight.latitude)!, longitude: (boxik?.bottomRight.longitude)!,altitude: 1), image: RightDown!)
           //     self.mapHere.add(mapObject: leftDown)
           //*
           //    let leftDown = NMAMapMarker(geoCoordinates: NMAGeoCoordinates(latitude: (boxik?.bottomLeft.latitude)!, longitude: (boxik?.bottomLeft.longitude)!,altitude: 1), image: LeftDown!)
          //     self.mapHere.add(mapObject: leftDown)
                  // objSelect.frame =
               //
               // sub cluster
             //  let frame_cluster = NMAClusterLayer()
            //   frame_cluster.addMarkers([leftUp,rightUp,rightDown,leftDown])
            //   self.mapHere.add(clusterLayer: frame_cluster)
                        //boxik!.topLeft.altitude = 10
           /*2*/   //     objSelect.frame.append(leftUp.coordinates)
                   //     objSelect.frame.append(rightUp.coordinates)
                   //     objSelect.frame.append(rightDown.coordinates)
                  //      objSelect.frame.append(leftDown.coordinates)
           /*3*/  //      objSelect.header = LeftUp!.description
              
                        //arrayObjSelect.append(objSelect)
                        //arrayObjSelect as! [objectSelectedUsers]
           //.removeAll()
               //
               let marker = NMAMapMarker(geoCoordinates: geo, image: UIImage(named: type)!)
               coordSystemHeli.append(geo)
               let cluster = NMAClusterLayer()
               cluster.addMarker(marker)
            //   cluster.addMarker(rightUp)
            //   cluster.addMarker(leftDown)
               self.mapHere.add(clusterLayer: cluster)
               
          //     print("coordMass\(coordSystemHeli)")
          //     print("coordMass.count :\(coordSystemHeli.count)")
               print("struct - \(arrayObjSelect)")
               //rechangeCount()
       }
}
