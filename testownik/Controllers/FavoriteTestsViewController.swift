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
    let colorFavorite = Colors().green[1]
    let colorOther =  Colors().kindaBlue[1]
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func luckNavigatorButtonPress(_ sender: UIBarButtonItem) {
        var ikonName: String = ""
        let statusOn = self.tableView.isEditing
        self.tableView.isEditing = !statusOn
        ikonName = statusOn ? "unlock" : "lock"
        let image = UIImage(named: ikonName)
        navigationItem.rightBarButtonItem?.image = image
    }
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
     }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! FavoriteTestsTableViewCell
        if let obj=database.fetch[0].getObj(at: indexPath) as? AllTestEntity {
            cell.label1.text = obj.user_name
            cell.label2.text = obj.user_description
            cell.label3.text = obj.category ?? "" + "\((obj.auto_name) ?? "")"
            //cell.accessoryType = obj.is_selected ? .checkmark : .none
            let selectedUuid = database.selectedTestTable[0].uuId
            cell.accessoryType = obj.uuId == selectedUuid ? .checkmark : .none
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
            label.backgroundColor = self.colorFavorite
        } else {
            label.text = "Others tests  👉🏻"
            label.textColor = .black
            label.backgroundColor = self.colorOther
        }
        return label
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "    "
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var actions = [UIContextualAction]()
        let action = UIContextualAction(style: .normal, title: "Empty") { (act, view, exec) in
            print("trailingSwipeActionsConfigurationForRowAt")
            let selectedTest = database.fetch[0].getObj(at: indexPath) as! AllTestEntity
            selectedTest.is_favorite.toggle()
            database.fetch[0].save()
            tableView.reloadData()
            exec(true)
         }
        if indexPath.section == 0 {
            action.backgroundColor = self.colorOther
             action.title = "Unselect"
            action.image = UIImage(named: "thumbs_down_big")?.imageWithColor(.red)
         } else {
            action.backgroundColor = self.colorFavorite
            action.title = "Select"
            action.image = UIImage(named: "thumbs_up_big")
        
         }
        let actionSet = UIContextualAction(style: .normal, title: "❤️ Test") { (act, view, exec) in
            let selectedTest = database.fetch[0].getObj(at: indexPath) as! AllTestEntity
            database.selectedTestTable[0].uuId = selectedTest.uuId
            database.selectedTestTable[0].toAllRelationship = selectedTest
             print("Testing set")
            exec(true)
        }
        actionSet.backgroundColor = .cyan
        actionSet.image = UIImage(named: "student_big")?.imageWithColor(.purple)
        
        if indexPath.section == 0 {
            actions = [action, actionSet]
        }
        else {
            actions = [action]
        }
        let swipe = UISwipeActionsConfiguration(actions: actions)
        return swipe
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let message = Setup.currentLanguage == .polish ? "Kasuj" : "Delete"  // static var currentLanguage: LanguaesList = .polish
               let action = UIContextualAction(style: .normal, title: message) { (act, view, exec) in
                print("leadingSwipeActionsConfigurationForRowAt")
                let selectedTest = database.fetch[0].getObj(at: indexPath) as! AllTestEntity
                database.fetch[0].context.delete(selectedTest)
                database.fetch[0].save()
                exec(true)
        }
        action.backgroundColor = .red
        action.image=UIImage(named: "full_trash_big")
        let swipe = UISwipeActionsConfiguration(actions: [action])
        return swipe
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section {
             let selectedTest = database.fetch[0].getObj(at: sourceIndexPath) as! AllTestEntity
            selectedTest.is_favorite.toggle()
            database.fetch[0].save()
        }
//        contactList.remove(at: sourceIndexPath.row)
//        contactList.insert(objectToMove, at: destinationIndexPath.row)
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    
    // MARK: NSFetchedResultsControllerDelegate
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.tableView?.reloadData()
//          switch (type) {
//          case .insert:
//            if let indexPath = newIndexPath {
//              tableView.insertRows(at: [indexPath], with: .fade)
//            }
//            break;
//          case .delete:
//            if let indexPath = indexPath {
//              tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//            break;
//          case .update:
//            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) {
//                cell.textLabel?.text = "AAASfghh"
//            }
//            break;
//
//          case .move:
//            if let indexPath = indexPath {
//              tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//
//            if let newIndexPath = newIndexPath {
//              tableView.insertRows(at: [newIndexPath], with: .fade)
//            }
//            break;
//
//          @unknown default:
//            fatalError()
//        }
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
