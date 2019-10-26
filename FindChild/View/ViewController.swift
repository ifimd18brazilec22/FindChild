//
//  ViewController.swift
//  FindChild
//
//  Created by Артем Стратиенко on 26/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import NMAKit
import CoreTelephony
//
protocol quaklyInit{
    func MapInit ()
}
protocol InitMap {
    var copyrightLogoPosition : UInt {get set}
    var orientation : UInt {get set}
    var mapScheme : String {get set}
}
//*** user's struct
struct objpost {
    var latitude = Double()
    var longitude = Double()
    var cellor = String()
}
struct closedArea {
    var frame_area = [NMAGeoCoordinates]()
}
// let/var
    var str = [NMAGeoCoordinates]()
    var array_area = closedArea()
    private var geoBox1 : NMAGeoBoundingBox?
    private var geoPolyline : NMAMapPolyline?

// class vc
class ViewController: UIViewController {
    @IBOutlet var status: UITextField!
    var idArea = 0
    var end_area = ""
    var shape = ""
    var boxik : NMAGeoBoundingBox?
    var index_touch = Int()
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
    //
    @IBOutlet weak var mapHere: NMAMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapHere.MapInit()
        self.mapHere.gestureDelegate = self
        // tpos
        NMAPositioningManager.sharedInstance().dataSource = NMAHEREPositionSource()
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(ViewController.didUpdatePosition),
                                                name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
                                                object: NMAPositioningManager.sharedInstance())
        let  myPosition = NMAPositioningManager.sharedInstance().currentPosition
        self.trackingTimer()
        coreRouter = NMACoreRouter()
        self.getLive()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        progress?.cancel()
    }

    @IBOutlet var Label_button: UIButton!
    
    @objc func didUpdatePosition() {
       guard let position = NMAPositioningManager.sharedInstance().currentPosition,
           let coordinates = position.coordinates else {
               return
       }
   }
  @objc  func TrackingMyPosition() {
    var cerror: String = "empty"
    if NMAPositioningManager.sharedInstance().currentPosition?.coordinates != nil {
            let networkInfo = CTTelephonyNetworkInfo()
            let back_info = networkInfo.subscriberCellularProvider
            let radio_info = networkInfo.serviceCurrentRadioAccessTechnology
            let level_info = radio_info?.values
            for name_carrier in level_info! {
                cerror = name_carrier
            }
                    if cerror == "CTRadioAccessTechnologyLTE" {
        //                print("CTRadioAccessTechnologyLTE")
                    } else if cerror == "CTRadioAccessTechnologyWCDMA" {
        //                print("CTRadioAccessTechnologyWCDMA")
                    } else if cerror == "CTRadioAccessTechnologyEdge" {
        //                print("CTRadioAccessTechnologyEdge")
                    }
            obj.cellor = cerror
            let latTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude
            let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
            obj.latitude = latTracking!
            obj.longitude = lonTracking!
            //
            arrayObj["latitude"] = obj.latitude as Double
            arrayObj["longitude"] = obj.longitude as Double
            arrayObj["cellor"] = obj.cellor
            post(url: "http://172.31.18.155:8080/api/location/live", parametrs: arrayObj)
        createCircle(geoCoord: NMAGeoCoordinates(latitude:  arrayObj["latitude"] as! Double, longitude: arrayObj["longitude"] as! Double), color: UIColor.blue, rad: 5)
    }
        }
    
    @IBAction func StartPoly(_ sender: Any)
    {
        if Label_button.currentTitle == "Начать" {
        end_area = "start"
        shape = "poly"
        Label_button.setTitle("Завершить", for: .normal)
        } else {
        Label_button.setTitle("Начать", for: .normal)
        end_area = "end"
        shape = "poly"
            let last =  array_area.frame_area[0]
            array_area.frame_area.append(last)
            let polyTester = drawRectwithPoint(centrBox: array_area.frame_area, 20)
            polyTester.map{mapHere.add(mapObject: $0)}
            array_area.frame_area.removeAll()
        }
    }
    @IBAction func setMyPos(_ sender: Any) {
        let latTracking = (NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.latitude)!
        let lonTracking = NMAPositioningManager.sharedInstance().currentPosition?.coordinates?.longitude
        self.mapHere.set(geoCenter: NMAGeoCoordinates(latitude: latTracking, longitude: lonTracking!), animation: .none)
    }
    @IBAction func drawZone(_ sender: Any) {
        self.getLive()
    }
    @IBAction func getPoint(_ sender: Any) {
        let image = "https://image.maps.api.here.com/mia/1.6/mapview?app_id=0ZZSBa9QPnfBc8zgJC1p&app_code=R7UJ1isf9yaZLiV058KZoQ&lat=55.86&lon=38.402277&vt=0&z=15"
        getImage(url: image)
    }
}

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
    timeGeoPosition = Timer.scheduledTimer(timeInterval: 1, target: self, selector: "TrackingMyPosition", userInfo: nil, repeats: true)
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
            self.zoneObject(id: self.index_placed, geo: NMAGeoCoordinates(latitude: latLocal, longitude: lonLocal,altitude: 1), type: "home-button-for-interface 1.png")
           // print(self.route)
            //mapView.onMapObjectSelected(latLocal, lonLocal)
            self.routeChild((Any).self)
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
    // *LongPress* touch to detected point in poly
       
    func mapView(_ mapView: NMAMapView, didReceiveDoubleTapAt location: CGPoint) {
        
        var getCoordinate = mapView.geoCoordinates(from: location)
       
        if end_area == "start" && shape == "poly" {
        array_area.frame_area.append(getCoordinate!)
        createPolyline(CTR: array_area.frame_area)
        } else if end_area == "end" && shape == "poly" {
            if array_area.frame_area != nil {
            
            }
        }
    }
    func mapView(_ mapView: NMAMapView, didReceiveTwoFingerTapAt location: CGPoint) {
    }
    // *LongPress* touch to detected point in poly
}
//
extension ViewController {
    // post
    func post(url : String,parametrs : [String:Any]) {
        guard let url = URL(string: url) else {return}
        let parametrs = parametrs//["id":"3","carrier":"LTE"]
        var request = URLRequest(url : url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        guard let httBody = try? JSONSerialization.data(withJSONObject: parametrs, options: [.fragmentsAllowed]) else { return }
        
        //data(withJSONObject: parametrs, options: []) else {return}
        request.httpBody = httBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data,response,error) in
            if let response = response {
        //        print(response)
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
       //          print(json)
                
            } catch {
      //          print(error)
            }
        }.resume()
    }
    // get
    func get(url : String/*,parametrs : [String:Any]*/) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data,response,error) in
            if let response = response {
                print(response)
            }
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                 print(json)
                let data = json as! [String:Any]
                let lat = data["latitude"] as! Double
                let lon = data["longitude"] as! Double
                self.createCircle(geoCoord: NMAGeoCoordinates(latitude: lat, longitude: lon), color: UIColor.lightGray, rad: 1)
            
            } catch {
                print(error)
            }
        }.resume()
    }
    // get
    func getImage(url : String/*,parametrs : [String:Any]*/) {
        guard let url = URL(string: url) else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data,response,error) in
            if let response = response {
                print(response)
            }
            guard let data = data else {return}
            print(data)
        }.resume()
    }
}
extension ViewController {
    func getLive() {
        get(url: "http://172.31.18.155:8080/api/location/live")
    }
}