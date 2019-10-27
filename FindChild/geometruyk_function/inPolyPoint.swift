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
    if arrayObjSelect.count > 0 {
        for i in 0...arrayObjSelect.count - 1 {
            let arg = arrayObjSelect[i] as! objectSelectedUsers
            let obArray = self.NMAGeoToDoubleArray(arrayHere: arg.frame)
                var indoorpoly = self.pnpoly(arg.frame.count, obArray.pointX, obArray.pointY, checkPoint.latitude, checkPoint.longitude)
            if indoorpoly == true {
                print("point is poly - \(indoorpoly) id object : \(arg.id)")
                status_id.status = indoorpoly
                status_id.id_obj = arg.id
                status.text = "Point is : \(indoorpoly) - touch ID :\(arg.id)"
                } else {
                //print("point is poly - \(indoorpoly) id object : _")
            }
        }
    }
    return status_id
}
    
}
