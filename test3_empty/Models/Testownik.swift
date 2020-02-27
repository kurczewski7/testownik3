//
//  Testownik.swift
//  testownik
//
//  Created by Slawek Kurczewski on 26/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
protocol TestownikDelegate {
    func refreshButtonUI(forCurrentTest currentTest: Int, countTest count: Int)
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
    //var testList: [Test] = [Test]()
    var filePosition = FilePosition.first
    var currentTest: Int = 0 {
        didSet {
            delegate?.refreshButtonUI(forCurrentTest: currentTest, countTest: testList.count)
            if  currentTest==0 {    filePosition = .first     }
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
                let test = Test(code: textLines[0], ask: textLines[1], pict: nil, answerOptions: sortedAnswerOptions, order: order, youAnswers: [])
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
            var texts: [String] = ["brak"]
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

}
