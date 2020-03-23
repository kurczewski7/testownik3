//
//  CloudsViewController.swift
//  testownik
//
//  Created by Slawek Kurczewski on 27/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class CloudsViewController: UIViewController, DocumentDelegate {
    
    //CloudPickerDeleate

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    var documents = [CloudPicker.Document]()
    var cloudPicker: CloudPicker!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addFiles(_ sender: UIBarButtonItem) {
        //documents = []
        cloudPicker.present(from: view)
        tableView.reloadData()
    }
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
          tableView.reloadData()
    }
    @objc private func refreshData(_ sender: Any) {
        print("Refresh Data")
        DispatchQueue.main.async {  self.tableView.reloadData()   }
        self.refreshControl.endRefreshing()
    }
    func didPickDocuments(documents: [CloudPicker.Document]?) {
        documents?.forEach {
            self.documents.append($0)
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        cloudPicker = CloudPicker(presentationController: self)
        cloudPicker.delegate = self
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor =  UIColor.orange        //UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl .attributedTitle = NSAttributedString(string: "Proszę czekać...odświeżanie", attributes: .none)
    }
    func documentsPicked(documents: [CloudPicker.Document]?) {
        print("documentsPicked:\(String(describing: documents))")
        documents?.forEach({ (elem) in
            self.documents.append(elem)
        })
        print("XXX:\(String(describing: documents))")
    }
    }
    extension CloudsViewController: UITableViewDelegate,UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return documents.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(indexPath.row):  \(documents[indexPath.row].fileURL.lastPathComponent)"
            cell.detailTextLabel?.text = "\(documents[indexPath.row].fileURL)"
            return cell
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
