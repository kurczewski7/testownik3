//
//  Test.swift
//  testownik
//
//  Created by Slawek Kurczewski on 27/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

struct Test {
    let code: String?
    let ask: String?
    let pict: UIImage?
    var answerOptions  = [Testownik.Answer]()
    var order          = [Int]()
    var youAnswers     = [Int]()
    var currentRating  = 0
    var maxRating      = 0
}
