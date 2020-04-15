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
    let docum = [[1,2,3,4,5,6],[7,8,9,10,11]]
    var allTests: [AllTestEntity]!
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configFetch(entityName: "AllTestEntity", key: "is_favorite", ascending: true)
        allTests = database.allTestsTable.array
    }
    
    func configFetch(entityName: String = "ToShopProductTable", key: String, ascending: Bool = true) {
        let context = database.context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sort1 = NSSortDescriptor(key: key, ascending: ascending)
        fetchRequest.sortDescriptors = [sort1]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,  managedObjectContext: context,
                                                              sectionNameKeyPath: key, cacheName: "SectionCache")
        fetchedResultsController.delegate =  self
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  fetchedResultsController.sections?.count ?? 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
            //section == 0 ? database.allTestsTable.count : docum[section].count  //docum[section].count
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
            //configureCell(cell: cell, withEntity: database.allTestsTable, at: indexPath)
        }
        return cell
    }
    func configureCell(cell: FavoriteTestsTableViewCell, withEntity allTestsTable: AllTestsTable, at indexPath: IndexPath) {
        let row = indexPath.row
        //let section = indexPath.section
        cell.label1.text = "\(row)"
        cell.label1.text = "SSSS"
        cell.label1.text = "KKKK"
    }
    
//    func configureCell(cell: InBasketTableViewCell, withEntity toShopproduct: ToShopProductTable, at indexPath: IndexPath) {
//        //row: Int, section: Int
//        let row = indexPath.row
//        let section = indexPath.section
//        print("aaa\(row),\(section)")
//        if let product = toShopproduct.productRelation {
//            cell.detailLabel.text = ""
//            cell.producentLabel.text = product.producent//"aaa\(row),\(section)"
//            //cell.productNameLabel.text="cobj"
//            cell.productNameLabel.text = product.productName
//            cell.picture.image=UIImage(named: product.pictureName ?? "cameraCanon")
//            cell.accessoryType = (toShopproduct.checked ? .checkmark : .none)
//        }
//        else
//        {
//            cell.accessoryType = (toShopproduct.checked ? .checkmark : .none)
//            cell.detailLabel.text="No product"
//        }
//    }
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
