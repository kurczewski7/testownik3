//
//  GenericData.swift
//  testownik
//
//  Created by Slawek Kurczewski on 27/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import Foundation
class DataOperations {
    typealias T = Test
    private var  genericArray = [T]()
    var testList: [T] {
       get {   return genericArray   }
       set {   genericArray = newValue  }
    }
    var count: Int {
        get {   return genericArray.count   }
    }
    subscript(index: Int) -> T {
       get {  _ = isIndexInRange(index: index)
           return genericArray[index]      }
       set {   _ = isIndexInRange(index: index)
           genericArray[index] = newValue  }
    }
    func isIndexInRange(index: Int, isPrintToConsol: Bool = true) -> Bool {
        if index >= count {
            if isPrintToConsol {
               print("Index \(index) is bigger then count \(count). Give correct index!")
            }
            return false
        }
        else {
            return true
        }
    }
    func first() -> T {
       _ = isIndexInRange(index: 0)
       return genericArray[0]
    }
    func last() -> T {
       let lastVal = count-1
       _ = isIndexInRange(index: lastVal)
       return genericArray[lastVal]
    }
    func add(value: T) -> Int {
        genericArray.append(value)
        return genericArray.count
    }
    func remove(at row: Int) -> Bool {
        if row < genericArray.count {
            genericArray.remove(at: row)
            return true
        }
        else {
            return false
        }
    }
    func forEach(executeBlock: (_ index: Int, _ oneElement: T?) -> Void) {
         var i = -1
         print("genericArray.count:\(genericArray.count)")
         for elem in genericArray {
             i += 1
             executeBlock(i, elem)
         }
     }
     func findValue(procedureToCheck: (_ oneElement: T?) -> Bool) -> Int {
         var i = -1
         for elem in genericArray {
             i += 1
             if procedureToCheck(elem) {
                 print("Object fond in table row \(i)")
                 return i
             }
         }
         print("Object not found in table")
         return -1
     }
}
