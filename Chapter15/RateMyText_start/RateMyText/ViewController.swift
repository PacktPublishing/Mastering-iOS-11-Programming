//
//  ViewController.swift
//  RateMyText
//
//  Created by Donny Wals on 11/09/2017.
//  Copyright © 2017 DonnyWals. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.layer.cornerRadius = 6
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
    }

    @IBAction func analyze() {
        
    }
}

