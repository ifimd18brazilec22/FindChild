//
//  ViewController.swift
//  FindChild
//
//  Created by Артем Стратиенко on 26/10/2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import NMAKit

class ViewController: UIViewController {
    @IBOutlet weak var mapHere: NMAMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapHere.copyrightLogoPosition = NMALayoutPosition.bottomLeft
               self.mapHere.orientation = 35
               self.mapHere.mapScheme = NMAMapSchemeNormalDay
               self.mapHere.positionIndicator.isVisible = true
        // Do any additional setup after loading the view.
    }


}

