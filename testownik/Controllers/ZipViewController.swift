//
//  ZipViewController.swift
//  SwiftyDocPicker
//
//  Created by Slawek Kurczewski on 18/03/2020.
//  Copyright © 2020 Abraham Mangona. All rights reserved.
//

import UIKit

class ZipViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var zipFileNameValue = ""
    var urlValue = ""
    
    var cloudPicker: CloudPicker!
    var documents : [CloudPicker.Document] = []
    var indexpath = IndexPath(row: 0, section: 0)
    //var tmpDoc = [CloudPicker.Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("--------------------\nZipViewController,urlValue=\(urlValue)")
        cloudPicker = CloudPicker(presentationController: self)
        if !urlValue.isEmpty  {
            print(",,,,,,,,,,,")
            let urlStr = urlValue
            let url = URL(fileURLWithPath: urlStr, isDirectory: true)
            print("--------\nurlStr:=:=  \(urlStr)")
            print("--------\nFolder URL=  \(url)")
            documents = cloudPicker.documentFromZip(pickedURL: url)
            print("++++++\n\(documents.count)")
        }
        else {
            print("Error Display Zip")
        }
        
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("cellForItemAt:\(indexPath.row),\(indexPath.section)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "zipCell", for: indexPath) as! ZipCollectionViewCell
//        cell.backgroundColor = .brown
        //cell.titleLabel.text =  tmpDoc[indexPath.item].fileURL.lastPathComponent    // "\(indexPath.item)"
        cell.configure(document: documents[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
        self.indexpath = indexPath
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        performSegue(withIdentifier: "showZipDetail", sender: cell)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      // 1
      switch kind {
      // 2
      case UICollectionView.elementKindSectionHeader:
        // 3  \(ZipSectionHeaderView.self)  sectionHeader
        guard
          let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "zipSectionHeader",
            for: indexPath) as? ZipSectionHeaderView
          else {
            fatalError("Invalid view type")
        }

        //let searchTerm = searches[indexPath.section].searchTerm
        headerView.label.text = zipFileNameValue    //searchTerm
        return headerView
      default:
        // 4
        assert(false, "Invalid element type")
      }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("showZipDetail")
        if segue.identifier == "showZipDetail" {
            if let nextViewController = segue.destination as? DetailViewController {
                nextViewController.cloudPickerValue = cloudPicker
                nextViewController.documentsValue = documents
                nextViewController.indexpathRow = indexpath.row
            }
         print("showArchiveDetail")
        }
    }
}


