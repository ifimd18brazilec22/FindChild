//
//  LaunchScreenViewController.swift
//  FindChild
//
//  Created by Malik on 27.10.2019.
//  Copyright © 2019 Артем Стратиенко. All rights reserved.
//

import UIKit
import Spring

class LaunchScreenViewController: UIViewController {
    @IBOutlet weak var bobbyImage: SpringImageView!
    @IBOutlet weak var mashaImage: SpringImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        bobbyImage.animation = "squeezeDown"
        bobbyImage.animate()
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
