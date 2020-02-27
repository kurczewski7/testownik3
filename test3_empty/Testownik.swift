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
class Testownik {
    
    struct Answer {
            let isOK: Bool
            let answerOption: String
        }
        struct Test {
            let code: String?
            let ask: String?
            let pict: UIImage?
            var answerOptions  = [Answer]()
            var order          = [Int]()
            var youAnswers     = [Int]()
            var currentRating  = 0
            var maxRating      = 0
        }
        var delegate: TestownikDelegate?
        var testList: [Test] = [Test]()
        var currentTest: Int = 0 {
            didSet {
                delegate?.refreshButtonUI(forCurrentTest: currentTest, countTest: testList.count)
                //refreshButtonUI(forCurrentTest: currentTest, countTest: testList)
            }
        }
        var visableLevel: Int = 2 {
            didSet {
                delegate?.refreshTabbarUI(visableLevel: visableLevel)
                //refreshTabbarUI(visableLevel: visableLevel)
            }
        }
        var count: Int {
            return testList.count
        }
        subscript(index: Int) -> Test {
            get {
                return testList[index]
            }
            set(newValue) {
                
                testList[index] = newValue
            }
        }
//        func buttonLayerToZ(isHide: Bool) {
//            for elem in actionsButtonStackView.arrangedSubviews {
//                elem.layer.zPosition = isHide ? -1 : 0
//            }
//        }
            
//        @IBOutlet weak var askLabel: UILabel!
//        @IBOutlet weak var stackView: UIStackView!
//        @IBOutlet weak var actionsButtonStackView: UIStackView!
//        @IBOutlet weak var labelLeading: NSLayoutConstraint!
//
//        @IBOutlet weak var highButton1: NSLayoutConstraint!
//        @IBOutlet weak var highButton2: NSLayoutConstraint!
//        @IBOutlet weak var highButton3: NSLayoutConstraint!
//        @IBOutlet weak var highButton4: NSLayoutConstraint!
//        @IBOutlet weak var highButton5: NSLayoutConstraint!
//        @IBOutlet weak var highButton6: NSLayoutConstraint!
//        @IBOutlet weak var highButton7: NSLayoutConstraint!
//        @IBOutlet weak var highButton8: NSLayoutConstraint!
        
//        // GesturesDelegate  protocol metods
//        func pinchRefreshUI(sender: UIPinchGestureRecognizer) {
//            print("Pinch touches:\(sender.numberOfTouches),\(sender.scale) ")
//            stackView.spacing = initalStackSpacing * sender.scale
//            //view.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
//        }
//        func eadgePanRefreshUI() {
//            print("Edge gesture")
//        }
//        func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction) {
//            switch direction {
//                case .right:
//                    currentTest = currentTest > 0 ? currentTest-1 : currentTest
//                    print("Swipe to right")
//                case .left:
//                    currentTest = currentTest < testList.count-1 ? currentTest+1 : currentTest
//                    print("Swipe  & left ")
//                case .up:
//                    print("Swipe up")
//                    visableLevel +=  visableLevel < 2 ? 1 : 0
//                case .down:
//                    print("Swipe down")
//                    visableLevel -= visableLevel > 0 ? 1 : 0
//                default:
//                    print("Swipe unrecognized")
//                }
//        }
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            //gestures =  Gestures(forView: view)
//            gestures.setView(forView: view)
//            gestures.delegate = self
//
//            var i = 0
//            print("Stack count: \(actionsButtonStackView.arrangedSubviews.count)")
//            stackView.arrangedSubviews.forEach { (button) in
//                if let butt = button as? UIButton {
//                    butt.backgroundColor = #colorLiteral(red: 0.8469454646, green: 0.9804453254, blue: 0.9018514752, alpha: 1)
//                    butt.layer.cornerRadius = self.cornerRadius
//                    butt.layer.borderWidth = 1
//                    butt.layer.borderColor = UIColor.brown.cgColor
//                    butt.addTarget(self, action: #selector(buttonAnswerPress), for: .touchUpInside)
//                    butt.tag = i
//                    i += 1
//                }
//            }
//            tabHigh.append(highButton1)
//            tabHigh.append(highButton2)
//            tabHigh.append(highButton3)
//            tabHigh.append(highButton4)
//            tabHigh.append(highButton5)
//            tabHigh.append(highButton6)
//            tabHigh.append(highButton7)
//            tabHigh.append(highButton8)
//
//            gestures.addSwipeGestureToView(direction: .right)
//            gestures.addSwipeGestureToView(direction: .left)
//            gestures.addSwipeGestureToView(direction: .up)
//            gestures.addSwipeGestureToView(direction: .down)
//            gestures.addPinchGestureToView()
//            gestures.addScreenEdgeGesture()
//
//            askLabel.layer.cornerRadius = self.cornerRadius
//            fillData(totallQuestionsCount: 117)
//            refreshView()
//        }

//        func resizeView(toMaximalize: Bool? = nil) {
//            if let toAddSize = toMaximalize {
//                stackView.spacing += toAddSize ? 1 : -1
//            }
//        }
//        override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
//            if motion == .motionShake {
//                print("Shake")
//            }
//        }
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
//        @objc func buttonAnswerPress(sender: UIButton) {
//            print("buttonAnswerPress:\(sender.tag)")
//
//            var found = false
//            let youSelectedNumber = sender.tag
//            let okAnswer = isAnswerOk(selectedOptionForTest: youSelectedNumber)
//            for elem in testList[currentTest].youAnswers {
//                if elem == currentTest {   found = true     }
//            }
//            if !found {
//                testList[currentTest].youAnswers.append(youSelectedNumber)
//            }
//            if let button = stackView.arrangedSubviews[youSelectedNumber] as? UIButton {
//                button.layer.borderWidth = 3
//                button.layer.borderColor = okAnswer ? UIColor.green.cgColor : UIColor.red.cgColor
//            }
//            print("aswers:\(testList[currentTest].youAnswers)")
//        }
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


//        @IBAction func navButt1Press(_ sender: UIBarButtonItem) {
//            stackView.spacing += 5
//    //        stackView.
//    //        UIView.animateWithDuration(0.25) { () -> Void in
//    //            newView.hidden = false
//    //            scroll.contentOffset = offset
//    //        }
//        }
//        @IBAction func nevButton2Press(_ sender: UIBarButtonItem) {
//            stackView.spacing -= 5
//        }
//        @IBAction func ResizeButtonPlusPress(_ sender: UIBarButtonItem) {
//            for buttHight in tabHigh {
//                buttHight.constant -= 2
//            }
//
//            //          labelLeading.constant += 50
//            //        highButton1.constant -= 5
//            //        highButton2.constant -= 5
//        }
//        @IBAction func ResizeButtonMinusPress(_ sender: UIBarButtonItem) {
//             askLabel.layer.cornerRadius = 10
//            for buttHight in tabHigh {
//                buttHight.constant += 2
//            }
//        }
//        @IBAction func firstButtonPress(_ sender: UIButton) {
//            currentTest = 0
//        }
//        @IBAction func previousButtonPress(_ sender: UIButton) {
//            if currentTest > 0 {
//                currentTest -= 1
//            }
//        }
//        @IBAction func checkButtonPress(_ sender: UIButton) {
//            let currTest = testList[currentTest]
//            let countTest = currTest.answerOptions.count         //okAnswers.count
//            for i in 0..<countTest {
//                if let button = stackView.arrangedSubviews[i] as? UIButton {
//                    button.layer.borderWidth =  currTest.answerOptions[i].isOK ? 3 : 1
//                    button.layer.borderColor = currTest.answerOptions[i].isOK ? UIColor.systemGreen.cgColor : UIColor.brown.cgColor
//                }
//            }
//        }
//        @IBAction func nextButtonPress(_ sender: UIButton) {
//            if currentTest < testList.count {
//                currentTest += 1
//            }
//        }
    
//        func hideButton(forButtonNumber buttonNumber: Int, isHide: Bool = true) {
//            if let button = actionsButtonStackView.arrangedSubviews[buttonNumber] as? UIButton {
//                button.isHidden = isHide
//            }
//        }
    
//        func refreshView() {
//            var i = 0
//            let totalQuest = testList[currentTest].answerOptions.count
//            testList[currentTest].youAnswers = []
//            for curButt in stackView.arrangedSubviews     {
//                if let butt = curButt as? UIButton {
//                    butt.isHidden = (i < totalQuest) ? false : true
//                    butt.setTitle((i < totalQuest) ? testList[currentTest].answerOptions[i].answerOption : "", for: .normal)  //nswerList?[i]
//                    butt.layer.borderWidth = 1
//                    butt.layer.borderColor = UIColor.brown.cgColor
//                    i += 1
//                }
//            }
//            actionsButtonStackView.arrangedSubviews[0].isHidden = (currentTest == 0)
//            actionsButtonStackView.arrangedSubviews[1].isHidden = (currentTest == 0)
//            askLabel.text = testList[currentTest].ask
//        }
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
