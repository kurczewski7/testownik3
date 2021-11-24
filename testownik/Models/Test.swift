//
//  Test.swift
//  testownik
//
//  Created by Slawek Kurczewski on 27/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
struct Answer {
        let isOK: Bool
        let answerOption: String
}
struct Test {
    let code: String?
    let ask: String?
    let pict: UIImage?
    var answerOptions           = [Answer]()
    var order                   = [Int]()
    var youAnswers5              = [Int]()
    var youAnswer2: Set<Int>    = []
    var currentRating  = 0
    var maxRating      = 0
    var fileName: String 
}
