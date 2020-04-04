//
//  CloudViewController.swift
//  SwiftyDocPicker
//
//  Created by Abraham Mangona on 9/14/19.
//  Copyright © 2019 Abraham Mangona. All rights reserved.
//

import UIKit


class CloudViewController: UIViewController, CloudPickerDelegate  {  //SSZipArchiveDelegate
    var cloudPicker: CloudPicker!
    var documents : [CloudPicker.Document] = []
    var indexpath = IndexPath(row: 0, section: 0)
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        //collectionView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        //collectionView.register(DocumentCell.self, forCellWithReuseIdentifier: "documentCell")
        //        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //            return cell
        //        }
        super.viewDidLoad()
        print("CloudViewController")
        self.documents =  []
        cloudPicker = CloudPicker(presentationController: self)
        cloudPicker.delegate = self
        Setup.popUp(context: self, msg: "Your message")
    }
    func didPickDocuments(documents: [CloudPicker.Document]?) {
        self.documents = []
        documents?.forEach {
            self.documents.append($0)
        }
        self.documents.sort {
            $0.fileURL.lastPathComponent < $1.fileURL.lastPathComponent
        }
        collectionView.reloadData()
    }
    @IBAction func pickPressed(_ sender: UIBarButtonItem) {
        cloudPicker.present(from: view)
    }
    
    @IBAction func trashPressed(_ sender: UIBarButtonItem) {
        cloudPicker.cleadData()
        documents.removeAll()
        collectionView.reloadData()
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("------\nsegue: \(String(describing: segue.identifier))")
        let document = documents[self.indexpath.row]
        if segue.identifier == "showDetail" {
            if let nextViewController = segue.destination as? DetailViewController {
                nextViewController.dataValue = document.myPictureData
                nextViewController.descriptionLabelValue = document.fileURL.lastPathComponent
                nextViewController.textViewValue = document.myTexts
                nextViewController.indexpathValue = indexpath
                nextViewController.totalItemValue = documents.count
                nextViewController.fileExtensionValue = cloudPicker.splitFilenameAndExtension(fullFileName: document.fileURL.lastPathComponent).fileExt
                
                Setup.displayToast(forView: self.view, message: "Druga wiadomość", seconds: 3)
                Setup.popUp(context: self, msg: "Trzecia wiadomość")
                
                print("nextViewController:\(nextViewController)")
                print("fileURL: \(document.fileURL)")
                print("self.indexpath 2:\(self.indexpath)")
                
                

                
                
                
            }
      }
      if segue.identifier == "showArchive" {
        if let nextViewController = segue.destination as? ZipViewController {
            nextViewController.zipFileNameValue = document.fileURL.lastPathComponent
            
            //Setup.unzipFile(atPath: document.fileURL.absoluteString, delegate: self)
            let urlStr = cloudPicker.unzip(document: document)
            print(":::\(urlStr)")
            nextViewController.urlValue = urlStr
        }
         print("showArchive")
      }
    }
}

extension CloudViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return documents.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "documentCell", for: indexPath) as? DocumentCell
        cell?.configure(document: documents[indexPath.row])
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.indexpath = indexPath
        print("self.indexpath 1:\(self.indexpath)")
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        let noZip = cloudPicker.sourceType != .filesZip
        if noZip {
          performSegue(withIdentifier: "showDetail", sender: cell)
        }
        else {
            //Setup.popUp(context: self, msg: "Zbior ZIP")
            performSegue(withIdentifier: "showArchive", sender: cell)
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //let folderName = cloudPicker.sourceType == .folder ? "Folder: \(cloudPicker.folderName)" : cloudPicker.folderName
        let folderName = (cloudPicker.sourceType == .folder ? "Folder: " : "") +  cloudPicker.folderName
        // 1
           switch kind {
           // 2
           case UICollectionView.elementKindSectionHeader:
             // 3  \(ZipSectionHeaderView.self)  sectionHeader
             guard
               let headerView = collectionView.dequeueReusableSupplementaryView(
                 ofKind: kind,
                 withReuseIdentifier: "detailSectionHeader",
                 for: indexPath) as? DetailSectionHeaderView
               else {
                 fatalError("Invalid view type")
             }

             //let searchTerm = searches[indexPath.section].searchTerm
             headerView.label.text =  folderName   //searchTerm
             return headerView
           default:
             // 4
             assert(false, "Invalid element type")
           }
    }
}
        //--------
//        if kind == UICollectionView.elementKindSectionHeader {
//            guard let headerView = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind,
//                withReuseIdentifier: "detailSectionHeader",
//                for: indexPath) as? DetailSectionHeaderView
//              else {
//                fatalError("Invalid view type")
//            }
//
//            //let searchTerm = searches[indexPath.section].searchTerm
//            headerView.label.text = "Folder AAAAAA"    //searchTerm
//            return headerView
//        }
//        else {
//            return UICollectionReusableView()
//        }

