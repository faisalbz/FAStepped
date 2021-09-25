//
//  ViewController.swift
//  FAStepped
//
//  Created by faisalbz on 09/25/2021.
//  Copyright (c) 2021 faisalbz. All rights reserved.
//

import UIKit
import FAStepped

class ViewController: UIViewController {
    
    @IBOutlet weak var faSteppedView: FAStepped!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func stepperAction(_ sender: UIStepper) {
        faSteppedView.currentTab = Int(sender.value)
    }

}

