//
//  ViewController.swift
//  test3_empty
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var askLabel: UILabel!
    
    @IBOutlet weak var butt1: UIButton!
    @IBOutlet weak var butt2: UIButton!
    @IBOutlet weak var butt3: UIButton!
    @IBOutlet weak var butt4: UIButton!
    @IBOutlet weak var butt5: UIButton!
    @IBOutlet weak var butt6: UIButton!
    @IBOutlet weak var butt7: UIButton!
    @IBOutlet weak var butt8: UIButton!
    
    @IBOutlet weak var highButton1: NSLayoutConstraint!
    @IBOutlet weak var highButton2: NSLayoutConstraint!
    @IBOutlet weak var highButton3: NSLayoutConstraint!
    @IBOutlet weak var highButton4: NSLayoutConstraint!
    @IBOutlet weak var highButton5: NSLayoutConstraint!
    @IBOutlet weak var highButton6: NSLayoutConstraint!
    @IBOutlet weak var highButton7: NSLayoutConstraint!
    @IBOutlet weak var highButton8: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var labelLeading: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        askLabel.layer.cornerRadius = 10
        butt1.layer.cornerRadius = 10
        butt2.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    @IBAction func navButt1Press(_ sender: UIBarButtonItem) {
        stackView.spacing += 5
    }
    
    @IBAction func nevButton2Press(_ sender: UIBarButtonItem) {
        stackView.spacing -= 5
    }
    @IBAction func ResizeButtonPlusPress(_ sender: UIBarButtonItem) {
        //labelLeading.constant += 50
        highButton1.constant += 5
        highButton2.constant += 5
       
         butt1.titleLabel?.text = "Jaka jest odległość ziemi od księżyca"
        
    }
    @IBAction func ResizeButtonMinusPress(_ sender: UIBarButtonItem) {
        //butt4.contentRect(forBounds: CGRect(x: 0, y: 0, width: 150, height: 50))
        askLabel.layer.cornerRadius = 1
        butt6.layer.cornerRadius = 5
        butt7.sizeThatFits(CGSize(width: 150, height: 50))
    }
}

