//
//  DetailViewController.swift
//  SwiftyDocPicker
//
//  Created by Slawek Kurczewski on 04/03/2020.
//  Copyright © 2020 Abraham Mangona. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var textViewValue = ""
    var descriptionLabelValue = ""
    var indexpathValue = IndexPath(item: 0, section: 0)
    var imageOnSwitch = !true
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = descriptionLabelValue
        textView.text = textViewValue
        refreshView()

        
        picture.image = UIImage(named: "100.png")
       
        print("=================\nDetailViewController, self.indexpathValue 3:\(self.indexpathValue)")
        //textView.text =  textViewValue
    }
    func refreshView() {
        textView.isHidden = !imageOnSwitch
        picture.isHidden = imageOnSwitch
    }
    
    @IBAction func switchPicture(_ sender: UIBarButtonItem) {
        imageOnSwitch.toggle()
        refreshView()
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

