//
//  DetailViewController.swift
//  SwiftyDocPicker
//
//  Created by Slawek Kurczewski on 04/03/2020.
//  Copyright © 2020 Abraham Mangona. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: Parameters for segue
    var textViewValue = ""
    var descriptionLabelValue = ""
    var indexpathValue = IndexPath(item: 0, section: 0)
    var pictureValue: UIImage?  //= UIImage(named: "ask.png")!
    var fileExtensionValue = ""
    var dataValue: Data? = nil
    var totalItemValue = 0
    

    
    
    var imageOffSwitch = false {
        didSet {
            refreshView()
        }
    }
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageOffSwitch = fileExtensionValue == "TXT"
        //pictureValue = UIImage(named: "100.png")
        descriptionLabel.text = descriptionLabelValue + "   (\(indexpathValue.row+1)/\(totalItemValue))"
        if imageOffSwitch {
            textView.text = textViewValue
            refreshView()
        }
        else {
            if let  dateTmp = dataValue, let  pict = UIImage(data: dateTmp)  {
                picture.image = pict
                print("picture.image")
            }
            else {
                 print("else picture.image")
            }
        }


        print("=================\nDetailViewController, self.indexpathValue 3:\(self.indexpathValue)")
        //textView.text =  textViewValue
    }
    func refreshView() {
        textView.isHidden = !imageOffSwitch
        picture.isHidden = imageOffSwitch
    }
    
    @IBAction func switchPicture(_ sender: UIBarButtonItem) {
        imageOffSwitch.toggle()
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

