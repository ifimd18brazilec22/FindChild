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
struct Location {
    var  latitude : Double
    var longitude : Double
}
var arrayLocation = [Location]()
var poly = Location(latitude: 0, longitude: 0)
//
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
    var id_user = 0
// class vc
class ViewController: UIViewController {

    // TableView Properties
    @IBOutlet var status: UITextField!
    @IBOutlet weak var kidsTableView: UITableView!
    @IBOutlet weak var stork: CardView!
    let kidsNamesArray = ["Bobby", "Masha"]
    let kidsStatusArray = ["online", "offline"]
    let kidsLocationArray = ["Going to school", "At home"]
    let kidsImagesArray: [UIImage] = [#imageLiteral(resourceName: "bobby"), #imageLiteral(resourceName: "masha")]
    
    // MapProperties
    var idArea = 0
    var end_area = ""
    var shape = ""
    var boxik : NMAGeoBoundingBox?

    var polyX = [Double]()
    var polyY = [Double]()
    //
    let zoomLevel : Float = 15
    var index_touch = Int()
    var index_placed = Int()
    // def values
     private var geoBox1 : NMAGeoBoundingBox?
     private var geoPolyline : NMAMapPolyline?
     private var mapCircle : NMAMapCircle?
     var timeNewRoute = Timer()
//     var obj = track_info()
     var arrayObj = [String:Any]()
     public var coordSystemHeli = [NMAGeoCoordinates]()
     public var computeRoute = [NMAGeoCoordinates]()
     var myCordinate = NMAGeoCoordinates()
    //
    var coreRouter: NMACoreRouter!
    //
    var mapRouts = [NMAMapRoute]()
    var progress: Progress? = nil
    //
    var route = [NMAGeoCoordinates]()
    //
        let LeftUp = UIImage(named: "1.png")
        let RightUp = UIImage(named: "2.png")
        let RightDown = UIImage(named: "3.png")
        let LeftDown = UIImage(named: "4.png")
        var objSelect = objectSelectedUsers()
        var arrayObjSelect = [Any]()
    var obj = objpost()
    var locObj = [String:Any]()
    var timeGeoPosition = Timer()
    var timeGeoPositionChild = Timer()
  //  private var mapCircle : NMAMapCircle?
   
    //
   // UIColor(displayP3Red: 0.6, green: 0.8, blue: 1, alpha: 0.6)
    //
    @IBOutlet weak var mapHere: NMAMapView!
   
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Скрываем штокру для детей
        print("\(currentUser)")
        if currentUser == .Masha || currentUser == .Bobby {
            stork.isHidden = true
        }
        
        self.index_touch = 0
        self.index_placed = 1
        self.mapHere.MapInit()
        self.mapHere.gestureDelegate = self
        coreRouter = NMACoreRouter()
        // tpos
        NMAPositioningManager.sharedInstance().dataSource = NMAHEREPositionSource()
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(ViewController.didUpdatePosition),
                                                name: NSNotification.Name.NMAPositioningManagerDidUpdatePosition,
                                                object: NMAPositioningManager.sharedInstance())
        let  myPosition = NMAPositioningManager.sharedInstance().currentPosition
        self.trackingTimer()
        self.trackingTimerChild()
        self.zoneObject(id: 1, geo: NMAGeoCoordinates(latitude: 55.79510365474969, longitude: 37.55457465864718), type: "home")
         self.zoneObject(id: 2, geo: NMAGeoCoordinates(latitude: 55.80510365474969, longitude: 37.52457465864718), type: "school")
        self.zoneObject(id: 3, geo: NMAGeoCoordinates(latitude: 55.76510365474969, longitude: 37.50457465864718), type: "home")
        self.zoneObject(id: 4, geo: NMAGeoCoordinates(latitude: 55.83510365474969, longitude: 37.49457465864718), type: "school")
        self.zoneObject(id: 5, geo: NMAGeoCoordinates(latitude: 55.82510365474969, longitude: 37.45457465864718), type: "home")
        self.zoneObject(id: 6, geo: NMAGeoCoordinates(latitude: 55.85510365474969, longitude: 37.37457465864718), type: "school")
    }

    
    @IBAction func first_user(_ sender: Any) {
        id_user = 1
    }
    @IBAction func two_user(_ sender: Any) {
        id_user = 2
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
            print(arrayObj)
            post(url: "http://172.31.18.155:8080/api/location/live", parametrs: arrayObj)
        createCircle(geoCoord: NMAGeoCoordinates(latitude:  arrayObj["latitude"] as! Double, longitude: arrayObj["longitude"] as! Double), color: UIColor.blue, rad: Int(2.5))
    }
        }
    @objc  func TrackingChildPosition() {
        getLive()
    }
    
    @IBAction func StartPoly(_ sender: Any)
    {
        if Label_button.currentTitle == "Draw zone" {
        end_area = "start"
        shape = "poly"
        Label_button.setTitle("Finish", for: .normal)
        } else {
        Label_button.setTitle("Draw zone", for: .normal)
        end_area = "end"
        shape = "poly"
           
            let last =  array_area.frame_area[0]
            array_area.frame_area.append(last)
            let polyTester = drawRectwithPoint(centrBox: array_area.frame_area, 20)
            polyTester.map{mapHere.add(mapObject: $0)}
            
            // var Loc = array_area.frame_area
            
          //  for at in Loc {
          //      poly.latitude = at.latitude
          //      poly.longitude = at.longitude
          //      let lat = poly.latitude
          //      let lon = poly.longitude
          //      arrayLocation.append(Location(latitude: lat, longitude: lon))
          //  }
          //  locObj["location"] = arrayLocation
            array_area.frame_area.removeAll()
            print(locObj)
        }
    }
    @IBAction func postPoly(_ sender: Any) {
        post(url: "/*http://172.31.18.155:8080/api/location/polygon", parametrs: locObj)
        print("f")
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
func trackingTimer() {
    timeGeoPosition.invalidate()
    timeGeoPosition = Timer.scheduledTimer(timeInterval: 5, target: self, selector: "TrackingMyPosition", userInfo: nil, repeats: true)
    }
    func trackingTimerChild() {
    timeGeoPositionChild.invalidate()
        timeGeoPositionChild = Timer.scheduledTimer(timeInterval: 5, target: self, selector: "TrackingChildPosition", userInfo: nil, repeats: true)
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
            //self.zoneObject(id: self.index_placed, geo: NMAGeoCoordinates(latitude: latLocal, longitude: lonLocal,altitude: 1), type: "home-button-for-interface 1.png")
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
        print("\(pTemp) - ptmp")
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

extension ViewController {
    func getLive() {
        get(url: "http://172.31.18.155:8080/api/location/live")
    }
}


// MARK: - ARBI TableViewController

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = kidsTableView.dequeueReusableCell(withIdentifier: "Cell") as! KidsTableViewCell
        cell.kidName.text = kidsNamesArray[indexPath.row]
        cell.kidImage.image = kidsImagesArray[indexPath.row]
        cell.kidLocation.text = kidsLocationArray[indexPath.row]
        cell.kidCall.setTitle(kidsNamesArray[indexPath.row], for: .normal)
        
        return cell
    }
}
