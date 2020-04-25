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
    var filePosition = FilePosition.first
    var currentTest: Int = 0 {
        didSet {
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
        var textLines = [String]()
        for i in 201...204 { //117
            titles = []
            let name = String(format: "%03d", i)
            print("name:\(name)")
            textLines=getText(fileName: name)
            if textLines[textLines.count-1].isEmpty {    textLines.remove(at: textLines.count-1) }
            for i in 2..<textLines.count {
                if !textLines[i].isEmpty  {    titles.append(textLines[i])      }
            }
            print("i:\(i), textLines: \(textLines)")
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
    func fillDataDb(totallQuestionsCount: Int) {
        var titles = [String]()
        var textLines = [String]()
        //let dbArray = database.testDescriptionTable
        database.testDescriptionTable.forEach { (index, testRecord) in
            if let txt = testRecord?.text {
                textLines=getTextDb(txt: txt)
                
                print("index:\(index), textLines: \(textLines)")
                for i in 2..<textLines.count {
                    if !textLines[i].isEmpty  {    titles.append(textLines[i])      }
                }
            }
        }
        let order = [99,5,7]
        let isOk = getAnswer(textLines[0])
        let answerOptions = fillOneTestAnswers(isOk: isOk, titles: titles)
        let sortedAnswerOptions = changeOrder(forAnswerOptions: answerOptions)
        let test = Test(code: textLines[0], ask: textLines[1], pict: nil, answerOptions: sortedAnswerOptions, order: order, youAnswers5: [])
        let test2 = Test(code: textLines[0], ask: "Co to jest?", pict: nil, answerOptions: sortedAnswerOptions, order: order, youAnswers5: [])
        testList.append(test)
        testList.append(test2)
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
                print("texts:\(texts)")
            }
            catch {
                print(error.localizedDescription)
            }
        }
        return texts
    }
    func getTextDb(txt: String, encodingSystem encoding: String.Encoding = .utf8) -> [String]  {
        var texts: [String] = ["brak danych"]
        
        do {
            //let data = try String(contentsOfFile: txt ,encoding: encoding)
            let myStrings = txt.components(separatedBy: .newlines)
            texts = myStrings
            print("texts:\(texts)")
        }
        catch {
            print(error.localizedDescription)
        }
        return texts
    }
    //        let xxx = "first\nsecond\nferd"
    //        let z = xxx.split(separator: "\n")
    //        let cc = xxx.data(using: String.Encoding.utf8)
    //        let dd = xxx.data(using: String.Encoding.windowsCP1250)
    //        var ff = Data(base64Encoded: xxx)
    //        print("ccc:\(String(describing: cc))")
    //        print("ccc:\(String(describing: dd))")
    //
    //        let ttt =  xxx.components(separatedBy: .newlines)
    //        print("ttt:\(ttt)")


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
    func loadTestFromDatabase() {
        database.selectedTestTable.loadData()
        guard database.selectedTestTable.count > 0 else {   return     }
        if  let selectedUuid = database.selectedTestTable[0].toAllRelationship?.uuId {
            database.testDescriptionTable.loadData(forUuid: "uuid_parent", fieldValue: selectedUuid)
            if database.testDescriptionTable.count > 0 {
                print("TXT:\(String(describing: database.testDescriptionTable[0].file_name))")
                print("TXT:\(String(describing: database.testDescriptionTable[0].text))")
            }
        }
    }
}
