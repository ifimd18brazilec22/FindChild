//
//  SetupViewController.swift
//  FindChild
//
//  Created by Malik on 27.10.2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import Spring

class SetupViewController: UIViewController {

    @IBOutlet weak var genderOutlet: UISegmentedControl!
    @IBOutlet weak var balloonPicker: BalloonPickerView!
    @IBOutlet weak var kidsImage: SpringImageView!
    @IBAction func genderControl(_ sender: Any) {
        if genderOutlet.selectedSegmentIndex == 0 {
            kidsImage.animation = "slideLeft"
            kidsImage.image = #imageLiteral(resourceName: "bobbyfull")
            kidsImage.animate()
            
        } else {
            kidsImage.animation = "slideLeft"
            kidsImage.image = #imageLiteral(resourceName: "mashafull")
            kidsImage.animate()
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        genderOutlet.selectedSegmentIndex = 1
        balloonPicker.tintColor = #colorLiteral(red: 0.215755403, green: 0.443744421, blue: 0.4183230102, alpha: 1)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
