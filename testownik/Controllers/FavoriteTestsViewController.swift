//
//  FavoriteTestsViewController.swift
//  testownik
//
//  Created by Slawek Kurczewski on 05/04/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import CoreData

class FavoriteTestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    //let docum = [[1,2,3,4,5,6],[7,8,9,10,11]]
    var allTests: [AllTestEntity]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.fetch[0].configFetch(entityName: "AllTestEntity", context: database.context, key: "is_favorite", ascending: false)
        database.fetch[0].fetchedResultsController.delegate = self
        allTests = database.allTestsTable.array
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  database.fetch[0].sectionCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return database.fetch[0].rowCount(forSection: section)
            //fetchedResultsController.sections?[section].numberOfObjects ?? 0
            //section == 0 ? database.allTestsTable.count : docum[section].count  //docum[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteTestsTableViewCell
        if let obj=database.fetch[0].getObj(at: indexPath) as? AllTestEntity {
            cell.label1.text = obj.user_name
            cell.label2.text = obj.user_description
            cell.label3.text = obj.category ?? "" + "\((obj.auto_name) ?? "")"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont (name: "Helvetica-Bold", size: 20)  //Helvetica-Bold "Helvetica Neue"
        if section == 0 {
            label.text = "Favorites tests  👍"
            label.textColor = .white
            label.backgroundColor = . systemGreen
        } else {
            label.text = "Others tests  👉🏻"
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
        let message = Setup.currentLanguage == .polish ? "Kasuj" : "Delete"  // static var currentLanguage: LanguaesList = .polish
               let action = UIContextualAction(style: .normal, title: message) { (act, view, exec) in
            print("leadingSwipeActionsConfigurationForRowAt")
        }
        action.backgroundColor = .red
        let swipe = UISwipeActionsConfiguration(actions: [action])
        return swipe
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    // MARK: NSFetchedResultsControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.tableView?.reloadData()
    }

    /*
    // MARK: - - Navigation
     

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
