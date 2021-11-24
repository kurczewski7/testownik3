//
//  TestPlan.swift
//  testownik
//
//  Created by Slawek Kurczewski on 23/11/2021.
//  Copyright © 2021 Slawomir Kurczewski. All rights reserved.
//

import Foundation

class TestPlan : DataOperations {
    struct TestInfo {
        var fileNumber:   Int
        var groupNumber:  Int
        var reapetNumber: Int
        var wrongNumber:  Int
        var completed:    Bool
    //    var extra:
    }
    
    var rawCount: Int = 836
    var group:   [[TestInfo]] = [[TestInfo]]()
    var rawTests:  [TestInfo] = [TestInfo]()
    var errorTest: [TestInfo] = [TestInfo]()
    
    var lastFileNr  = 0
    var currentFile = 0
    var firstFreq   = 7
    var totalIndex  = 0
    var groupIndex  = 0
    var groupNumber = 1
    
    let x0 = TestInfo(fileNumber: 0, groupNumber: 0, reapetNumber: 0, wrongNumber: 0, completed: false)
    let x1 = TestInfo(fileNumber: 1, groupNumber: 1, reapetNumber: 1, wrongNumber: 1, completed: true)
    let x2 = TestInfo(fileNumber: 2, groupNumber: 2, reapetNumber: 2, wrongNumber: 2, completed: false)
    let x3 = TestInfo(fileNumber: 3, groupNumber: 3, reapetNumber: 3, wrongNumber: 3, completed: true)
    let x4 = TestInfo(fileNumber: 4, groupNumber: 4, reapetNumber: 4, wrongNumber: 4, completed: false)
    
    func initalTest(forQuantity countTest: Int) {
        var filesNumber = [Int]()
        var i = 1
        let dbCount = database.testDescriptionTable.count
        for el in testList {
            print("lP:\(i),|\(el.fileName)|")
            //filesNumber.append(Int(el.fileName)) // el.fileName
            i += 1
        }
        
        self.rawTests = [TestInfo](repeating: x0, count: countTest)
    }
    func fillDataDb() {
        var titles = [String]()
        var textLines = [String]()
        print("database.testDescriptionTable.count fillDataDb:\(database.testDescriptionTable.count)")
        database.testDescriptionTable.forEach { (index, testRecord) in
            if let txt = testRecord?.text, !txt.isEmpty {
                titles.removeAll()
                textLines = getTextDb(txt: txt)
                guard textLines.count > 2 else {    return     }
                for i in 2..<textLines.count {
                    if !textLines[i].isEmpty  {    titles.append(textLines[i])      }
                }
                // TODO: order
                let order = [99,5,7]
                let isOk = getAnswer(textLines[0])
                let answerOptions = fillOneTestAnswers(isOk: isOk, titles: titles)
                let sortedAnswerOptions = changeOrder(forAnswerOptions: answerOptions)
                let fileName = testRecord?.file_name?.components(separatedBy: ".")[0] ?? ""
                let test = Test(code: textLines[0], ask: textLines[1], pict: nil, answerOptions: sortedAnswerOptions, order: order, youAnswers5: [], fileName: fileName)
                self.testList.append(test)
            }
        }
     }
    func getTextDb(txt: String, encodingSystem encoding: String.Encoding = .utf8) -> [String]  {
        var texts: [String] = ["brak danych"]
        do {
            //let data = try String(contentsOfFile: txt ,encoding: encoding)
            let myStrings = txt.components(separatedBy: .newlines)
            texts = myStrings
            //print("texts:\(texts)")
        }
//        catch {
//            print(error.localizedDescription)
//        }
        return texts
    }
    func fillOneTestAnswers(isOk: [Bool], titles: [String]) -> [Answer] {
        var answerOptions: [Answer] = [Answer]()
        let lenght = isOk.count < titles.count ? isOk.count : titles.count
        for i in 0..<lenght {
            answerOptions.append(Answer(isOK: isOk[i], answerOption: titles[i]))
        }
        return answerOptions
    }
    func changeOrder(forAnswerOptions answerOptions: [Answer]) -> [Answer] {
        var position = 0
        var sortedAnswerOptions = [Answer]()
        var srcAnswerOptions = answerOptions
        for _ in 1...srcAnswerOptions.count {
            position = randomOrder(toMax: srcAnswerOptions.count-1)
            sortedAnswerOptions.append(srcAnswerOptions[position])
            srcAnswerOptions.remove(at: position)
        }
        return sortedAnswerOptions
    }
    func loadTestFromDatabase() {
        database.selectedTestTable.loadData()
        //print("\nselectedTestTable.coun = \(database.selectedTestTable.count)")
        guard database.selectedTestTable.count > 0 else {   return     }
        if  let selectedUuid = database.selectedTestTable[0]?.toAllRelationship?.uuId {
            database.testDescriptionTable.loadData(forUuid: "uuid_parent", fieldValue: selectedUuid)
            if database.testDescriptionTable.count > 0 {
                print("file_name:\(String(describing: database.testDescriptionTable[0]?.file_name))")
                print("TEXT:\(String(describing: database.testDescriptionTable[0]?.text))")
                
                // TODO: clear data
                let txtVal = getTextDb(txt: database.testDescriptionTable[0]?.text ?? " ")
                if  txtVal.count < 3 {
                    print("Pusty rekord")
                    self.clearData()  }
                else    {
                    print("Pełny rekord")
                    fillDataDb()
                }
            }
        }
    }
    func randomOrder(toMax: Int) -> Int {
        return Int(arc4random_uniform(UInt32(toMax)))
    }
    func getAnswer(_ codeAnswer: String) -> [Bool] {
        var answer = [Bool]()
        let myLenght=codeAnswer.count
        //print("myLenght:\(myLenght)")
        for i in 1..<myLenght {
            answer.append(codeAnswer.suffix(codeAnswer.count)[i]=="1" ? true : false)
        }
        //print("answer,\(answer)")
        return answer
    }
    func start() {
        var aa: [TestInfo] = [TestInfo]()
        
        aa.append(x3)
        aa.append(x2)
        aa.append(x1)
        group.append(aa)
        
        aa.removeAll()
        aa.append(x1)
        aa.append(x4)
        aa.append(x2)
        group.append(aa)
        
        aa.removeAll()
        aa.append(x1)
        aa.append(x3)
        aa.append(x4)
        group.append(aa)
        
        aa.removeAll()
        aa.append(x1)
        aa.append(x2)
        aa.append(x3)
        aa.append(x4)
        aa.append(x3)
        group.append(aa)

        print("group.count:\(group.count)")
        print("group[3].count:\(group[3].count)")
        initalTest(forQuantity: 25)
    }
    
    

    
}

