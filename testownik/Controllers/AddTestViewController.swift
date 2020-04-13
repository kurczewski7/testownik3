//
//  AddTestViewController.swift
//  testownik
//
//  Created by Slawek Kurczewski on 12/04/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class AddTestViewController: UIViewController {
    var folderUrlValue: String = ""
    var documentsValue : [CloudPicker.Document] = []

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var label: UILabel!

    

    @IBAction func cancelNavigatorButton(_ sender: UIBarButtonItem) {
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buttonPress(_ sender: UISegmentedControl) {
        //sender.selectedSegmentIndex = -1
        if sender.selectedSegmentIndex == 0 {
            sender.selectedSegmentTintColor = .red
            //segment.selectedSegmentTintColor = .red
             print("Cancel pressed")
            //self.dismiss(animated: true)
            //self.dismiss(animated: true, completion: nil)
        }
         if sender.selectedSegmentIndex == 1 {
            sender.selectedSegmentTintColor = .green
           print("Save pressed")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        segment.selectedSegmentIndex = -1
//        //segment.setTitle("Anuluj", forSegmentAt: 0)
//        //segment.setTitle("Zapisz", forSegmentAt: 1)
//        let imageOk = UIImage(named: "save_filled")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
//        let imageCancel = UIImage(named: "cancel_filled")?.withTintColor(.systemRed)
//        imageCancel?.withTintColor(.cyan)
//
//
//        if #available(iOS 13.0, *) {
//           segment.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//           segment.selectedSegmentTintColor = UIColor.blue
//        } else {
//           segment.tintColor = UIColor.blue
//        }
//
//
//        segment.setImage(imageCancel, forSegmentAt: 0)
//        segment.setImage(imageOk, forSegmentAt: 1)
//        segment.tintColor = .purple
        //segment.selectedSegmentTintColor = .red
        label.text =  getCurrentDate()
      
        
//        let origImage = UIImage(named: "imageName")
//        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
//        btn.setImage(tintedImage, for: .normal)
//        btn.tintColor = .red
        
        
        if documentsValue.count > 0 {
            textField2.text = "\(documentsValue[0].myTexts)"
            textField3.text = "\(documentsValue.count)"
        }
        //database.testDescriptionTable[0].file_name
        // Do any additional setup after loading the view.
    }
    func getCurrentDate() -> String {
       let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd  HH:mm:ss"
        return "Test  "+formatter.string(from: currentDateTime)
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
