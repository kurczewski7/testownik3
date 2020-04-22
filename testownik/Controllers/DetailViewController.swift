//
//  DetailViewController.swift
//  SwiftyDocPicker
//
//  Created by Slawek Kurczewski on 04/03/2020.
//  Copyright © 2020 Abraham Mangona. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, GesturesDelegate {
    var documentsValue : [CloudPicker.Document] = []
    var indexpathRow: Int = 0
    
    // MARK: Parameters for segue
    var textViewValue = ""
    var descriptionLabelValue = ""
    //var indexpathValue = IndexPath(item: 0, section: 0)
    var pictureValue: UIImage?  //= UIImage(named: "ask.png")!
    var fileExtensionValue = "" {
        didSet {
            imageOffSwitch = fileExtensionValue == "TXT"
            refreshView()
        }
    }
    var dataValue: Data? = nil
    var totalItemValue = 0
    var gestures = Gestures()
    
    var imageOffSwitch = false
//    {
//        didSet {
//            refreshView()
//        }
//    }
    // textView descriptionLabel picture
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var picture: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestures.setView(forView: view)
        gestures.delegate  = self        
        gestures.addSwipeGestureToView(direction: .right)
        gestures.addSwipeGestureToView(direction: .left)
        
        //imageOffSwitch = fileExtensionValue == "TXT"
        //pictureValue = UIImage(named: "100.png")
//        descriptionLabel.text = descriptionLabelValue + "   (\(indexpathValue.row+1)/\(totalItemValue))"
        refreshTextContent()
        if imageOffSwitch {
//            textView.text = textViewValue
            refreshView()
        }
        else {
            if let  dateTmp = dataValue, let  pict = UIImage(data: dateTmp)  {
                picture?.image = pict
                print("picture.image")
            }
            else {
                 print("else picture.image")
            }
        }
        print("=================\nDetailViewController, self.indexpathValue 3:\(self.indexpathRow)")
        //textView.text =  textViewValue
    }
    func refreshView() {
        textView?.isHidden = !imageOffSwitch
        picture?.isHidden = imageOffSwitch
    }
    // MARK: - Gesture delegate methods
    @IBAction func switchPicture(_ sender: UIBarButtonItem) {
        imageOffSwitch.toggle()
        refreshView()
    }
    func pinchRefreshUI(sender: UIPinchGestureRecognizer) {
        print("pinchRefreshUI")
    }
    func eadgePanRefreshUI() {
        print("eadgePanRefreshUI")
    }
    func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction) {
        var newRow = self.indexpathRow
        switch direction {
            case .right:
                 newRow -= newRow > 0 ? 1 : 0
                refreshTextContent()
                print("Swipe to right")
            case .left:
                 newRow += newRow < self.totalItemValue ? 1 : 0
                refreshTextContent()
                print("Swipe  & left ")
            default:
                print("Swipe unrecognized")
            }
         self.indexpathRow =  newRow
    }
    func refreshTextContent() {
        let newRow = self.indexpathRow
        if newRow < documentsValue.count {
            let document = documentsValue[newRow]
            self.textView?.text = document.myTexts
            self.descriptionLabel?.text = document.fileURL.lastPathComponent + "   (\(newRow+1)/\(self.totalItemValue))"
            self.totalItemValue = documentsValue.count
            self.fileExtensionValue = CloudPicker(presentationController: self).splitFilenameAndExtension(fullFileName: document.fileURL.lastPathComponent).fileExt  //"PNG"
            if let data = document.myPictureData {
               self.picture?.image = UIImage(data:  data)
            }
        }
       
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

