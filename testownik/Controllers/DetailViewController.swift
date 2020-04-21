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
    var indexpath: IndexPath = IndexPath(row: 0, section: 0)
    
    // MARK: Parameters for segue
    var textViewValue = ""
    var descriptionLabelValue = ""
    var indexpathValue = IndexPath(item: 0, section: 0)
    var pictureValue: UIImage?  //= UIImage(named: "ask.png")!
    var fileExtensionValue = ""
    var dataValue: Data? = nil
    var totalItemValue = 0
    var gestures = Gestures()
    
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
        gestures.setView(forView: view)
        gestures.delegate  = self        
        gestures.addSwipeGestureToView(direction: .right)
        gestures.addSwipeGestureToView(direction: .left)
        
        
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
        switch direction {
            case .right:
                refreshTextContent(direction: direction)
                print("Swipe to right")
            case .left:
                refreshTextContent(direction: direction)
                print("Swipe  & left ")
            case .up:
                print("Swipe up")
            case .down:
                print("Swipe down")
            default:
                print("Swipe unrecognized")
            }
    }
    func refreshTextContent(direction: UISwipeGestureRecognizer.Direction) {
        var newRow = self.indexpathValue.row
        self.descriptionLabel.text = " AAAA:\(newRow)"
        if direction == .left {
            newRow -= newRow > 0 ? 1 : 0
        }
        if direction == .right {
            newRow += newRow < self.totalItemValue-1 ? 1 : 0
        }
        if newRow < documentsValue.count - 1 {
            let document = documentsValue[newRow]
            self.textView.text = document.myTexts
        }
        self.indexpathValue = IndexPath(row: newRow, section: 0)
    }
    //    let document = documents[self.indexpath.row]
    //    if let nextViewController = segue.destination as? DetailViewController {
    //        nextViewController.dataValue = document.myPictureData


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

