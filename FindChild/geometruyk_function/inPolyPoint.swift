//
//  inPolyPoint.swift
//  FindChild
//
//  Created by Артем Стратиенко on 27/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit
extension ViewController {

struct dec_point {
    var status = Bool()
    var id_obj = Int()
}
public func ckeckPoint(checkPoint : NMAGeoCoordinates) -> dec_point {
    var status_id = dec_point()
    //print("size arrayOBJ : = \(arrayObjSelect) + and count \(arrayObjSelect.count)")
    if arrayObjSelect.count > 0 {
        for i in 0...arrayObjSelect.count - 1 {
            let arg = arrayObjSelect[i] as! objectSelectedUsers
            let obArray = self.NMAGeoToDoubleArray(arrayHere: arg.frame)
                var indoorpoly = self.pnpoly(arg.frame.count, obArray.pointX, obArray.pointY, checkPoint.latitude, checkPoint.longitude)
            if indoorpoly == true {
                print("point is poly - \(indoorpoly) id object : \(arg.id)")
                status_id.status = indoorpoly
                status_id.id_obj = arg.id
                } else {
                //print("point is poly - \(indoorpoly) id object : _")
            }
        }
       
    } else {
    
//var obS = self.NMAGeoToDoubleArray(arrayHere: areCheking)
//var indoorpoly = self.pnpoly(areCheking.count - 1, obS.pointX, obS.pointY, checkPoint.latitude, checkPoint.longitude)
 //      print(indoorpoly)
  //  Carrier.text = "Point is : \(indoorpoly) - touch ID :\(self.index_touch)"
    self.index_touch += 1
   // status_id.status = indoorpoly
  //  status_id.id_obj = self.index_touch
    }
    return status_id
}
}
