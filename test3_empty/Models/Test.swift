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
    var answerOptions           = [Testownik.Answer]()
    var order                   = [Int]()
    var youAnswers              = [Int]()
    var youAnswer2: Set<Int>    = []
    var currentRating  = 0
    var maxRating      = 0
}
// var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
// letters.insert("a")
//for genre in favoriteGenres.sorted() {
//    print("\(genre)")
//}
