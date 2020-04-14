//
//  FavoriteTestsViewController.swift
//  testownik
//
//  Created by Slawek Kurczewski on 05/04/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class FavoriteTestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let docum = [[1,2,3,4,5,6],[7,8,9,10,11]]
    var allTests: [AllTestEntity]!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  2 //allTests.count   //docum.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? database.allTestsTable.count : docum[section].count  //docum[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteTestsTableViewCell
         if indexPath.section == 0 {
            cell.label1.text = "\(database.allTestsTable[indexPath.row].user_name ?? " ")"
            cell.label2.text = "\(database.allTestsTable[indexPath.row].user_description ?? " ")"
            cell.label3.text = "\(database.allTestsTable[indexPath.row].category ?? " ")" +
            " (\(database.allTestsTable[indexPath.row].auto_name ?? ""))"
        }
        if indexPath.section == 1 {
            cell.label1.text = "AAAA: \(docum[indexPath.section][indexPath.row])"
            cell.label2.text = "aaaa: \(indexPath.section)"
            cell.label3.text = "cccc: \(indexPath.row)"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Helvetica-Bold", size: 20)  //Helvetica-Bold "Helvetica Neue"
        if section == 0 {
            label.text = "Favorites tests"
            label.textColor = .white
            label.backgroundColor = . systemGreen
        } else {
            label.text = "Others tests"
            label.textColor = .black
            label.backgroundColor = . lightGray
        }
        return label
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "    "
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "AAAA") { (act, view, exec) in
            print("trailingSwipeActionsConfigurationForRowAt")
        }
        action.backgroundColor = .green
        let swipe = UISwipeActionsConfiguration(actions: [action])
        return swipe
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
               let action = UIContextualAction(style: .normal, title: "BBBB") { (act, view, exec) in
            print("leadingSwipeActionsConfigurationForRowAt")
        }
        action.backgroundColor = .red
        let swipe = UISwipeActionsConfiguration(actions: [action])
        return swipe

    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        allTests = database.allTestsTable.array
        // Do any additional setup after loading the view.
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
