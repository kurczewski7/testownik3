//
//  Ratings.swift
//  testownik
//
//  Created by Slawek Kurczewski on 13/11/2021.
//  Copyright © 2021 Slawomir Kurczewski. All rights reserved.
//

import Foundation

class TestResult {
    var errorMultiple = 2
    private(set) var fileNumber: Int  // Not to modyfy
    private(set) var goodAnswers = 777
    private(set) var wrongAnswers = 666
    var correctionsToDo = 0
    var repetitionsToDo = 0
    var lastAnswer: Bool {
        didSet {
            if lastAnswer {
                self.goodAnswers += 1
                if self.correctionsToDo == 0 {
                    self.repetitionsToDo -= (self.repetitionsToDo > 0 ? 1 : 0)
                }
                else {
                    self.correctionsToDo -= 1
                }
            }
            else {
                self.wrongAnswers += 1
                self.correctionsToDo += errorMultiple
            }
        }
    }

    init(_ fileNumber: Int, lastAnswer: Bool) {
        self.fileNumber = fileNumber
        self.lastAnswer = lastAnswer
    }
    func resetAnswer() {
        self.goodAnswers = 0
        self.wrongAnswers = 0
    }
    func resetAll() {
        self.goodAnswers = 0
        self.wrongAnswers = 0
        self.correctionsToDo = 0
        self.repetitionsToDo = 0
    }
    func setFileNumber(_ fileNumber: Int ) {
        self.fileNumber = fileNumber
        
    }
}
//----------------
class Ratings {
    var testList: [Int] = [4,2,4,2,1,7]
    //                     2,1,2,1,0,3
    var results = [ TestResult(1, lastAnswer: false),
                    TestResult(2, lastAnswer: false),
                    TestResult(4, lastAnswer: true),
                    TestResult(7, lastAnswer: true)]    //[TestResult]()
    
    
    var currentTest = 0
    var count: Int {
        get {    return testList.count    }
    }
    subscript(index: Int) -> TestResult? {
        get {
            guard index < self.testList.count  else {   return nil  }
            self.currentTest = index
            return  find(testForValue: self.testList[index])
        }
        set(newValue) {
            //print("oldValue:\(newValue)")
            guard let newValue = newValue, index < self.testList.count   else {   return   }
            guard self.testList.first(where: {  $0 == newValue.fileNumber   }) != nil else { return }
            if let posInResults = find(posForValue: self.testList[index]) {
                if self.results[posInResults].fileNumber == newValue.fileNumber {
                    self.currentTest = index
                    self.results[posInResults] = newValue
                }
                
            }
        }
    }
    func editRating(forIndex index: Int, completion:  (_ result: TestResult) -> TestResult       ) {
        guard  index < self.testList.count   else {   return   }
        guard let testPos = find(posForValue: self.testList[index]) else { return  }
        self.results[testPos] = completion(self.results[testPos])
    }
    func addRating(_ fileNumber: Int, lastAnswer answer: Bool) {
        if let position = find(posForValue: fileNumber) {
            let oldTest = self.results[position]
            self.results.remove(at: position)
            oldTest.lastAnswer = answer
            self.results.append(oldTest)
        }
        else {
            let testResult = TestResult(fileNumber, lastAnswer: answer)
            self.results.append(testResult)
        }
    }

//     ratins[2] = TestResult(4, lastAnswer: true)
//      let xx = ratins[2]
        
    func getCurrTest(numberOnList nr: Int) -> TestResult? {
        guard nr < self.testList.count  else {   return nil  }
        return  find(testForValue: self.testList[nr])
    }
    func setCurrTest() {

        
    }
    func xxxxxx() {
        for el in self.testList {
            print("el:\(el)")
            let bb = find(testForValue: el)
            print("bb:\(bb?.fileNumber ?? 0),\(bb?.lastAnswer)")
        }
    }
    func printf() {
        print("results:\(results)")
        print("testList:\(testList)")
        
        
    }
    func findElem(searchVal: Int) {
        if let val = self.results.first(where: {  $0.fileNumber == searchVal  }) {
            print("NEative:\(val)")
        }
    }
    func find(posForValue searchVal: Int)  -> Int? {
        for (index, value) in self.results.enumerated() {
            if value.fileNumber == searchVal {
                return index
            }
        }
        return nil
    }
    func find(testForValue searchVal: Int)  -> TestResult? {
        for (index, value) in self.results.enumerated() {
            if value.fileNumber == searchVal {
                return results[index]
            }
        }
        return nil
    }
    func saveRatings() {
        database.ratingsTable.deleteAll()
        for (index, value) in self.results.enumerated() {
            let rec = RatingsEntity(context: database.context)
            let uuId = database.selectedTestTable[0]?.uuId
            rec.lp = Int16(index)
            print("index:\(index).\(uuId)")
            rec.uuId = UUID()
            rec.uuId_parent = uuId
            rec.file_number = Int16(value.fileNumber)
            rec.good_answers = Int16(value.goodAnswers)
            rec.wrong_answers = Int16(value.wrongAnswers)
            rec.last_answer = value.lastAnswer
            rec.corrections_to_do = Int16(value.correctionsToDo)
            rec.repetitions_to_do = Int16(value.repetitionsToDo)
            _ = database.ratingsTable?.add(value: rec)
        }
        database.ratingsTable?.save()
    }
    func saveTestList() {
        database.testListTable.deleteAll()
        for (index, value) in self.testList.enumerated() {
            let rec = TestListEntity(context: database.context)
            let uuId = database.selectedTestTable[0]?.uuId
            rec.lp = Int16(index)
            rec.uuId = UUID()
            rec.uuid_parent = UUID()
            rec.rating_index = Int16(value)
            rec.done = true
            
//            rec.lp = Int16(index)
//            print("index:\(index).\(uuId)")
//            rec.uuId = UUID()
//            rec.uuId_parent = uuId
//            rec.file_number = Int16(value.fileNumber)
//            rec.good_answers = Int16(value.goodAnswers)
//            rec.wrong_answers = Int16(value.wrongAnswers)
//            rec.last_answer = value.lastAnswer
//            rec.corrections_to_do = Int16(value.correctionsToDo)
//            rec.repetitions_to_do = Int16(value.repetitionsToDo)
            _ = database.testListTable?.add(value: rec)
        }
        database.ratingsTable?.save()
    }
    func restoreRatings() {
        database.ratingsTable.forEach { index, oneElement in
            print("index:\(index)")
        }
    }

}
