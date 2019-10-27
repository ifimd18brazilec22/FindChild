//
//  Network.swift
//  FindChild
//
//  Created by Артем Стратиенко on 27/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import Foundation
import NMAKit
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
                 print(json)
                
            } catch {
                print(error)
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
                if id_user == 1 {
                self.createCircle(geoCoord: NMAGeoCoordinates(latitude: lat, longitude: lon), color: UIColor.purple, rad: Int(2.5))
                } else if id_user == 2 {
                self.createCircle(geoCoord: NMAGeoCoordinates(latitude: lat, longitude: lon), color: UIColor.orange, rad: Int(2.5))
                } else {
                     self.createCircle(geoCoord: NMAGeoCoordinates(latitude: lat, longitude: lon), color: UIColor.green, rad: Int(2.5))
                }
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
