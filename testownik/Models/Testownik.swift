//
//  Testownik.swift
//  testownik
//
//  Created by Slawek Kurczewski on 26/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
import  CoreData // to delete

protocol TestownikDelegate {
    func refreshButtonUI(forFilePosition filePosition: Testownik.FilePosition)
    func refreshTabbarUI(visableLevel: Int)
    //refreshButtonUI
}
class Testownik: DataOperations {
    enum FilePosition {
        case first
        case last
        case other
    }
    struct Answer {
            let isOK: Bool
            let answerOption: String
    }
    var delegate: TestownikDelegate?
    //var testList: [Test] = [Test]()
    var filePosition = FilePosition.first
    var currentTest: Int = 0 {
        didSet {
            //delegate?.refreshButtonUI(forCurrentTest: currentTest, countTest: testList.count)
            delegate?.refreshButtonUI(forFilePosition: filePosition)
            if  currentTest == 0 {    filePosition = .first     }
            else if  currentTest == count-1 {   filePosition = .last     }
            else  {  filePosition = .other      }
        }
    }
    var visableLevel: Int = 2 {
        didSet {     delegate?.refreshTabbarUI(visableLevel: visableLevel)    }
    }
        func fillData(totallQuestionsCount: Int) {
            var titles = [String]()
            for i in 201...204 { //117
                titles = []
                let name = String(format: "%03d", i)
                print("name:\(name)")
                let textLines=getText(fileName: name)
                for i in 2..<textLines.count {
                    if textLines[i].count > 0 {    titles.append(textLines[i])      }
                }
                let order = [99,5,7]
                let isOk = getAnswer(textLines[0])
                let answerOptions = fillOneTestAnswers(isOk: isOk, titles: titles)
                let sortedAnswerOptions = changeOrder(forAnswerOptions: answerOptions)
                let test = Test(code: textLines[0], ask: textLines[1], pict: nil, answerOptions: sortedAnswerOptions, order: order, youAnswers5: [])
                testList.append(test)
                print(test)
                print("\r\n")
            }
        }
        func changeOrder(forAnswerOptions answerOptions: [Answer]) -> [Answer] {            
            var position = 0
            var sortedAnswerOptions = [Answer]()
            var srcAnswerOptions = answerOptions
            
            for _ in 1...srcAnswerOptions.count {
                position = randomOrder(toMax: srcAnswerOptions.count-1)
                let elem = srcAnswerOptions[position]
                sortedAnswerOptions.append(elem)
                srcAnswerOptions.remove(at: position)
            }
            return sortedAnswerOptions
        }
        func randomOrder(toMax: Int) -> Int {
            return Int(arc4random_uniform(UInt32(toMax)))
        }
        func fillOneTestAnswers(isOk: [Bool], titles: [String]) -> [Answer] {
            var answerOptions: [Answer] = []
            let lenght = isOk.count < titles.count ? isOk.count : titles.count
            for i in 0..<lenght {
                answerOptions.append(Answer(isOK: isOk[i], answerOption: titles[i]))
            }
            return answerOptions
        }
        func isAnswerOk(selectedOptionForTest selectedOption: Int) -> Bool {
             var value = false
            if  selectedOption < testList[currentTest].answerOptions.count {
                value = testList[currentTest].answerOptions[selectedOption].isOK
            }
            return value
        }
        func findValue<T: Comparable>(currentList: [T], valueToFind: T) -> Int {
            var found = -1
            for i in 0..<currentList.count {
                if (currentList[i] == valueToFind)  {   found = i     }
            }
            return found
        }
        func getText(fileName: String, encodingSystem encoding: String.Encoding = .utf8) -> [String] {  //windowsCP1250
            var texts: [String] = ["brak danych"]
            if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path ,encoding: encoding)
                    let myStrings = data.components(separatedBy: .newlines)
                    texts = myStrings
                }
                catch {
                    print(error)
                }
            }
            return texts
        }
        func getAnswer(_ codeAnswer: String) -> [Bool] {
            var answer = [Bool]()
            let myLenght=codeAnswer.count
            print("myLenght:\(myLenght)")
            for i in 1..<myLenght {
                answer.append(codeAnswer.suffix(codeAnswer.count)[i]=="1" ? true : false)
            }
            print("answer,\(answer)")
            return answer
        }
        // MARK: Methods for Testownik database
    func getCurrentDb() {
        print("-----------\ngetCurrentDb")
        database.selectedTestTable.loadData()
        print("selectedTestTable.count:\(database.selectedTestTable.count),\(String(describing: database.selectedTestTable[0].uuId))")
        if let selectedUuid = database.selectedTestTable[0].uuId {
            //database.testDescriptionTable.loadData(forFilterField: "uuId", fieldValue: UUID(uuidString: "9398c9196abd4142926c35fc2d4763ac"))
            database.testDescriptionTable.loadData(forFilterField: "file_name", fieldValue: "201.txt")
            
            print("\(database.testDescriptionTable.count)")
            
            print("TXT:\(String(describing: database.testDescriptionTable[0].file_name))")
            print("TXT:\(String(describing: database.testDescriptionTable[0].text))")
            
//            let testDescription = database.testDescriptionTable.findValue { (entity ) -> Bool in
//                let text = entity?.text
//                let picture = entity?.picture
//                let fileName = entity?.file_name
//                print("text:\(String(describing: text)),picture:\(String(describing: picture)),fileName:\(String(describing: fileName))")
//
//                database.testDescriptionTable.loadData(forFilterField: "uuId", fieldValue: selectedUuid)
//                print("TXT:\(database.testDescriptionTable[0].text)")
//                return true
//            }
            print("====   =====")
        }
    }
//        func loadData(tableNameType tabName : DbTableNames, categoryId: Int16 = 0) {
//            var request : NSFetchRequest<NSFetchRequestResult>?
//            var groupPredicate:NSPredicate?
//
//            switch tabName {
//            case .products       :
//                request = ProductTable.fetchRequest()
//                groupPredicate = NSPredicate(format: "%K = %@", "categoryId", "\(categoryId)")
//                //groupPredicate = NSPredicate(format: "%K = %@", "categoryId", "\(self.selectedCategory?.id ?? 9)")
//                request?.predicate = groupPredicate
//            case .basket         :
//                request = BasketProductTable.fetchRequest()
//            }
//            do {    let newArray     = try context.fetch(request!)
//                // Todo- error out of range
//
//                if newArray.count == 0  {
//                    print("Error loading empty data")
//                }
//                switch tabName {
//                    case .products        :
//                        product.array = newArray as! [ProductTable]
//                    case .basket           :
//                        basketProduct.array = newArray as! [BasketProductTable]
//                }
//            }
//            catch { print("Error fetching data from context \(error)")   }
//        }
    
//        func configFetch(entityName: String, context: NSManagedObjectContext, key: String, ascending: Bool = true) {
//            let context = database.context
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
//            let sort1 = NSSortDescriptor(key: key, ascending: ascending)
//            fetchRequest.sortDescriptors = [sort1]
//            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,  managedObjectContext: context,
//                                                                  sectionNameKeyPath: key, cacheName: "SectionCache")
//            do {
//                try fetchedResultsController.performFetch()
//            } catch let error as NSError {
//                print("Error: \(error.localizedDescription)")
//            }
//        }


}
