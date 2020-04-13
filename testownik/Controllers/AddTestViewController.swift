//
//  AddTestViewController.swift
//  testownik
//
//  Created by Slawek Kurczewski on 12/04/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class AddTestViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedCategory = ""
    var groups = ["Matematyka","Fizyka", "Chemia", "Biologia", "Historia", "Geografia", "Genetyka", "Języki obce", "Sztuka", "Geologia", "Informatyka", "Elektronika", "Literatura", "Automatyka", "Medycyna", "Telekomunikacja","I N N E", "Zologia" ].sorted()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = groups[row]
        print("EEE:\(groups[row])")
    }
    
    var folderUrlValue: String = ""
    var documentsValue : [CloudPicker.Document] = []

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var label: UILabel!

    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print("saveButtonPressed")
        saveData()
        self.performSegue(withIdentifier: "goToUnwindCloudVC", sender: nil)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        print("cancelButtonPressed")
    }
    
    @IBAction func cancelNavigatorButton(_ sender: UIBarButtonItem) {
         //self.dismiss(animated: true, completion: nil)
        print("cancelNavigatorButton")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //groups.sorted()

        label.text =  getCurrentDate()
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
    func saveData() {
        //database.allTestsTable.deleteAll()
        //database.testDescriptionTable.deleteAll()
        let uuid = UUID()
        let context = database.context
        let allTestRecord = AllTestEntity(context: context)
        allTestRecord.auto_name = label.text
        allTestRecord.user_name = textField1.text
        allTestRecord.user_description  = textField2.text
        allTestRecord.category = selectedCategory 
        allTestRecord.create_date = Date()
        allTestRecord.is_favorite = false
        allTestRecord.uuId = uuid
        let uu = UUID()
        let zz = uu.hashValue
        print("\(zz)")
        
        // toShop.productRelation=product
//        allTestRecord.toDescriptionRelationship =
//        allTestRecord.toCateoryRelationship =
        database.allTestsTable.append(allTestRecord)
        database.allTestsTable.save()
        for i in 0..<documentsValue.count {
            let record = TestDescriptionEntity(context: context)
            record.file_url = documentsValue[i].fileURL.absoluteString
            record.file_name = documentsValue[i].fileURL.lastPathComponent
            record.text = documentsValue[i].myTexts
            record.picture = documentsValue[i].myPictureData
            record.uuid_parent = uuid
            record.uuId = UUID()
            database.testDescriptionTable.append(record)
            database.testDescriptionTable.save()
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
