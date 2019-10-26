//
//  ViewController.swift
//  FindChild
//
//  Created by Артем Стратиенко on 26/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import NMAKit
//***
struct objpost {
       var latitude = Double()
       var longitude = Double()
   }
struct closedArea {
           var id_area = Int()
           var frame_area = [NMAGeoCoordinates]()
       }
   var str = [NMAGeoCoordinates]()
   var array_area = closedArea()
private var geoBox1 : NMAGeoBoundingBox?
private var geoPolyline : NMAMapPolyline?
let areCheking =
   /*1*/       [NMAGeoCoordinates(latitude: 55.76238, longitude: 37.61084, altitude: 10),
   /*2*/        NMAGeoCoordinates(latitude: 55.75794, longitude: 37.60277, altitude: 10),
   /*3*/        NMAGeoCoordinates(latitude: 55.75040, longitude: 37.60054, altitude: 10),
   /*4*/        NMAGeoCoordinates(latitude: 55.74499, longitude: 37.60723, altitude: 10),
   /*5*/        NMAGeoCoordinates(latitude: 55.74480, longitude: 37.61581, altitude: 10),
   /*6*/        NMAGeoCoordinates(latitude: 55.75137, longitude: 37.61238, altitude: 10),
   /*7*/        NMAGeoCoordinates(latitude: 55.75774, longitude: 37.61908, altitude: 10),
   /*8*/        NMAGeoCoordinates(latitude: 55.75504, longitude: 37.62302, altitude: 10),
   /*9*/        NMAGeoCoordinates(latitude: 55.74837, longitude: 37.63212, altitude: 10),
   /*10*/       NMAGeoCoordinates(latitude: 55.75697, longitude: 37.63521, altitude: 10),
   /*11*/       NMAGeoCoordinates(latitude: 55.76325, longitude: 37.61599, altitude: 10),
   /*12*/       NMAGeoCoordinates(latitude: 55.76238, longitude: 37.61084, altitude: 10)]
class ViewController: UIViewController {
    @IBOutlet var status: UITextField!
    var idArea = 0
    var end_area = ""
    var boxik : NMAGeoBoundingBox?
     var index_touch = Int()
    /*
     var coreRouter: NMACoreRouter!
       //
     var polyX = [Double]()
        var polyY = [Double]()
        //
        let zoomLevel : Float = 15
       
        
        // def values
         private var geoBox1 : NMAGeoBoundingBox?
         private var geoPolyline : NMAMapPolyline?
         private var mapCircle : NMAMapCircle?
       var boxik : NMAGeoBoundingBox?
       var mapRouts = [NMAMapRoute]()
  
       //
       var route = [NMAGeoCoordinates]()
       //
           let LeftUp = UIImage(named: "1.png")
           let RightUp = UIImage(named: "2.png")
           let RightDown = UIImage(named: "3.png")
           let LeftDown = UIImage(named: "4.png")
           var objSelect = objectSelectedUsers()
           var arrayObjSelect = [Any]()
     */
    var mapRouts = [NMAMapRoute]()
    var coreRouter: NMACoreRouter!
         var progress: Progress? = nil
    var objSelect = objectSelectedUsers()
              var arrayObjSelect = [Any]()
    var index_placed = Int()
    var route = [NMAGeoCoordinates]()
    public var coordSystemHeli = [NMAGeoCoordinates]()
    var obj = objpost()
    var arrayObj = [String:Any]()
    var timeGeoPosition = Timer()
    private var mapCircle : NMAMapCircle?
    @IBOutlet weak var mapHere: NMAMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapHere.MapInit()
        self.mapHere.gestureDelegate = self

        NMAPositioningManager.sharedInstance().dataSource = NMAHEREPositionSource()
         
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(ViewController.didUpdatePosition),
                                                name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
                                                object: NMAPositioningManager.sharedInstance())
        let  myPosition = NMAPositioningManager.sharedInstance().currentPosition
        self.trackingTimer()
        self.createPolyline(CTR: areCheking)
        coreRouter = NMACoreRouter()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progress?.cancel()
    }

    
   @objc func didUpdatePosition() {
       guard let position = NMAPositioningManager.sharedInstance().currentPosition,
           let coordinates = position.coordinates else {
               return
       }
    
   }
  @objc  func TrackingMyPosition() {
    if NMAPositioningManager.sharedInstance().currentPosition?.coordinates != nil {
            let latTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude
            let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
            obj.latitude = latTracking!
            obj.longitude = lonTracking!
            //
            arrayObj["latitude"] = obj.latitude
            arrayObj["longitude"] = obj.longitude
            //print(obj)
    /*
            let urlstring = "http://185.81.248.50:8080/api/location"//"http://192.168.43.42:8080/add"
            arrayObj["latitude"] = obj.latitude
            arrayObj["longitude"] = obj.longitude
            //arrayObj["signal"] = obj.signal
           // arrayObj["carrier"] = obj.carrier
           // Carrier.text = arrayObj["carrier"] as! String
            post(url: urlstring, parametrs:arrayObj)
            createCircle(geoCoord: NMAGeoCoordinates(latitude:  arrayObj["latitude"] as! Double, longitude: arrayObj["longitude"] as! Double), color: UIColor.red, rad: 5) */
        createCircle(geoCoord: NMAGeoCoordinates(latitude:  arrayObj["latitude"] as! Double, longitude: arrayObj["longitude"] as! Double), color: UIColor.blue, rad: 5)
    }
        }
    @IBAction func setMyPos(_ sender: Any) {
        let latTracking = (NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude)!
        let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
        self.mapHere.set(geoCenter: NMAGeoCoordinates(latitude: latTracking, longitude: lonTracking!), animation: .none)
    }
    @IBAction func drawZone(_ sender: Any) {
        let latTracking = (NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude)!
        let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
        self.mapHere.set(geoCenter: NMAGeoCoordinates(latitude: latTracking, longitude: lonTracking!), animation: .none)
    }
}
protocol quaklyInit{
    func MapInit ()
}
protocol InitMap {
    var copyrightLogoPosition : UInt {get set}
    var orientation : UInt {get set}
    var mapScheme : String {get set}
}
/*extension NMAMapView : InitMap {
    var copyrightLogoPosition: UInt {
        get {
        }
        set {
        }
    }
    
    var orientation: UInt {
        get {
        }
        set {
        }
    }
    
    
} */

extension NMAMapView : quaklyInit {
    // MARK 1
    func MapInit() {
        self.copyrightLogoPosition = NMALayoutPosition.bottomLeft
        self.orientation = 35
        self.mapScheme = NMAMapSchemeNormalDay
        self.positionIndicator.isVisible = true
        let geoCoodCenter = NMAGeoCoordinates(
        latitude: 55.812619,
        longitude: 37.572213)
        self.set(geoCenter: geoCoodCenter, animation: .none)
    }
}
extension ViewController {

    public func createCircle(geoCoord : NMAGeoCoordinates, color : UIColor,rad : Int) {
        //create NMAMapCircle located at geo coordiate and with radium in meters
        mapCircle = NMAMapCircle(geoCoord, radius: Double(rad))
        //set fill color to be gray
        mapCircle?.fillColor = color
        //set border line width.
        mapCircle?.lineWidth = 12;
        //set border line color to be red.
        mapCircle?.lineColor = color
        //add Map Circel to map view
        _ = mapCircle.map{ mapHere.add(mapObject: $0) }
    }
func trackingTimer()
{
    timeGeoPosition.invalidate()
    timeGeoPosition = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: "TrackingMyPosition", userInfo: nil, repeats: true)
}
}
extension ViewController {
    public func createPolyline(CTR : [NMAGeoCoordinates]) {
        // cleanup()
        //create a NMAGeoBoundingBox with center gec coordinates, width and hegiht in degrees.
        geoBox1 = NMAGeoBoundingBox(coordinates: CTR)
        geoPolyline = geoBox1.map{ _ in NMAMapPolyline(vertices: CTR) }
        //set border line width in pixels
        geoPolyline?.lineWidth = 10;
        //set border line color to be red
        geoPolyline?.lineColor = UIColor(displayP3Red: 0.6, green: 0.8, blue: 1, alpha: 0.6)
        //add NMAMapPolyline to map view
        _ = geoPolyline.map { mapHere?.add(mapObject: $0) }
    }
}
extension ViewController : NMAMapGestureDelegate {
    // add touch in map and draw rote to point
    func mapView(_ mapView: NMAMapView, didReceiveLongPressAt location: CGPoint) {
        print("location :\(String(describing: mapView.geoCoordinates(from: location)))")
    
        let alert = UIAlertController(title: "location", message: "\(String(describing: mapView.geoCoordinates(from: location)))", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Построить маршрут", style: .default) { (_) -> Void in
            let latLocal = mapView.geoCoordinates(from: location)!.latitude
            let lonLocal = mapView.geoCoordinates(from: location)!.longitude
            self.route.append(NMAGeoCoordinates(latitude: latLocal, longitude: lonLocal))
            self.drawRailStation(id: self.index_placed, geo: NMAGeoCoordinates(latitude: latLocal, longitude: lonLocal,altitude: 1), type: "home-button-for-interface 1.png")
           // print(self.route)
            //mapView.onMapObjectSelected(latLocal, lonLocal)
            self.addRoute((Any).self)
            self.index_placed += 1
        }
        let canceledAction = UIAlertAction(title: "Отменить", style: .cancel) {
            (_) -> Void in
        }
        alert.addAction(saveAction)
        alert.addAction(canceledAction)
        self.present(alert, animated: true, completion: nil)
    }
    //
    func mapView(_ mapView: NMAMapView, didReceiveTapAt location: CGPoint) {
        var pTemp = self.ckeckPoint(checkPoint: mapView.geoCoordinates(from: location)!)
        print(pTemp)
    }
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
                    status.text = "Point is : \(indoorpoly) - touch ID :\(arg.id)"
                    } else {
                    //print("point is poly - \(indoorpoly) id object : _")
                }
            }
          
        } else {
        
    var obS = self.NMAGeoToDoubleArray(arrayHere: areCheking)
    var indoorpoly = self.pnpoly(areCheking.count - 1, obS.pointX, obS.pointY, checkPoint.latitude, checkPoint.longitude)
           print(indoorpoly)
        status.text = "Point is : \(indoorpoly) - touch ID :\(self.index_touch)"
        self.index_touch += 1
        status_id.status = indoorpoly
        status_id.id_obj = self.index_touch
        }
        return status_id
    }
    // *LongPress* touch to detected point in poly
       
    func mapView(_ mapView: NMAMapView, didReceiveDoubleTapAt location: CGPoint) {
        
        var getCoordinate = mapView.geoCoordinates(from: location)
        if end_area == "end" {
        idArea += 1
            let end_poly = array_area.frame_area
            print(end_poly[0])
            array_area.frame_area.append(end_poly[0])
            print(array_area.frame_area)
        let polyTester = drawRectwithPoint(centrBox: array_area.frame_area, 20)
        polyTester.map{mapHere.add(mapObject: $0)}
        array_area.frame_area.removeAll()
        } else {
        array_area.id_area = idArea
        array_area.frame_area.append(getCoordinate!)
        }
        print(array_area.frame_area)
        print(array_area.id_area)
        createPolyline(CTR: array_area.frame_area)
        
       // }
        
            //   var pTemp = self.ckeckPoint(checkPoint: mapView.geoCoordinates(from: location)!)
    //    print(pTemp)
    }
    func mapView(_ mapView: NMAMapView, didReceiveTwoFingerTapAt location: CGPoint) {
        if end_area == "end" {
        end_area = "start"
        } else {
        end_area = "end"
        }
    }
    // *LongPress* touch to detected point in poly
}
extension ViewController {
    public func drawRailStation(id : Int, geo : NMAGeoCoordinates, type : String) {
        //arrayObjSelect
        objSelect = objectSelectedUsers()
        if objSelect.id == 0 {
          //  delete(objSelect[0])
        }
         /*1*/       objSelect.id = id
        let polyTester = drawRectwith(centrBox: geo, 0.005)
            polyTester.polyGon.map{mapHere.add(mapObject: $0)}
            boxik = polyTester.polyBox
           // ***
        
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
extension ViewController {
@IBAction func addRoute(_ sender: Any) {
    let  myPosition = NMAPositioningManager.sharedInstance().currentPosition
    var routingMode = NMARoutingMode()
    routingMode = NMARoutingMode.init(
        routingType: NMARoutingType.fastest,//shortest,//.fastest,
        transportMode: NMATransportMode.car,//pedestrian,
        routingOptions: []//NMARoutingOption.avoidTollRoad
    )
    // check if calculation completed otherwise cancel.
    if !(progress?.isFinished ?? false) {
        progress?.cancel()
    }
    // store progress.
  //  print(route)
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
}
