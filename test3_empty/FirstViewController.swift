//
//  ViewController.swift
//  test3_empty
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
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
        //let answerList: [String]?
        //        let okAnswers      = [Bool]()
    }
    var testList: [Test] = [Test]()
    var currentTest: Int = 0 {
        didSet {
            refreshView()
        }
    }
    
    var cornerRadius: CGFloat = 10
    var tabHigh: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    @IBOutlet weak var askLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var actionsButtonStackView: UIStackView!
    @IBOutlet weak var labelLeading: NSLayoutConstraint!
    
    @IBOutlet weak var highButton1: NSLayoutConstraint!
    @IBOutlet weak var highButton2: NSLayoutConstraint!
    @IBOutlet weak var highButton3: NSLayoutConstraint!
    @IBOutlet weak var highButton4: NSLayoutConstraint!
    @IBOutlet weak var highButton5: NSLayoutConstraint!
    @IBOutlet weak var highButton6: NSLayoutConstraint!
    @IBOutlet weak var highButton7: NSLayoutConstraint!
    @IBOutlet weak var highButton8: NSLayoutConstraint!
    
    func fillOneTestAnswers() -> [Answer] {
        let isOk = [true, false, true, false]
        let titles = ["raz","dwa","trzy","cztery"]
        var answerOptions: [Answer] = []
        
        for i in 0..<titles.count {
            answerOptions.append(Answer(isOK: isOk[i], answerOption: titles[i]))
        }
        return answerOptions
    }
    func fillData(totallQuestionsCount: Int) {
        var answerList = [String]()

        for i in 1...117 {
            answerList = []
            let name = String(format: "%03d", i)
            print("name:\(name)")
            let textLines=getText(fileName: name)
            for i in 2..<textLines.count {
                if textLines[i].count > 0 {
                    answerList.append(textLines[i])
                }
            }
            let order = randomOrderList()
            let answerOptions = fillOneTestAnswers()
            let test = Test(code: textLines[0], ask: textLines[1], pict: nil, answerOptions: answerOptions, order: order, youAnswers: [])
            testList.append(test)
            print(test)
            print("\r\n")
        }
    }
    @objc func buttonAnswerPress(sender: UIButton) {
        print("buttonAnswerPress:\(sender.tag)")
        
        var found = false
        let youSelectedNumber = sender.tag
        let okAnswer = isAnswerOk(selectedOptionForTest: youSelectedNumber)
        for elem in testList[currentTest].youAnswers {
            if elem == currentTest {   found = true     }
        }
        if !found {
            testList[currentTest].youAnswers.append(youSelectedNumber)
        }
        if let button = stackView.arrangedSubviews[youSelectedNumber] as? UIButton {
            button.layer.borderWidth = 3
            button.layer.borderColor = okAnswer ? UIColor.green.cgColor : UIColor.red.cgColor
        }
        print("aswers:\(testList[currentTest].youAnswers)")
    }
    func isAnswerOk(selectedOptionForTest selectedOption: Int) -> Bool {
         var value = false
        if  selectedOption < testList[currentTest].answerOptions.count {
            value = testList[currentTest].answerOptions[selectedOption].isOK
        }
        return value
    }
    func findValue<T: Comparable>(currentList: [T], valueToFind: T) -> Bool {
        var found = false
        for i in 0..<currentList.count {
            if (currentList[i] == valueToFind)  {   found = true     }
        }
        return found
    }

    override func viewDidLoad() {
        var i = 0
        super.viewDidLoad()
        
        print("Stack count: \(actionsButtonStackView.arrangedSubviews.count)")
        stackView.arrangedSubviews.forEach { (button) in
            if let butt = button as? UIButton {
                butt.backgroundColor = .yellow
                butt.clipsToBounds = true
                butt.layer.cornerRadius = self.cornerRadius
                butt.layer.borderWidth = 1
                butt.layer.borderColor = UIColor.brown.cgColor
                butt.addTarget(self, action: #selector(buttonAnswerPress), for: .touchUpInside)
                butt.tag = i
                i += 1
            }
        }
        tabHigh.append(highButton1)
        tabHigh.append(highButton2)
        tabHigh.append(highButton3)
        tabHigh.append(highButton4)
        tabHigh.append(highButton5)
        tabHigh.append(highButton6)
        tabHigh.append(highButton7)
        tabHigh.append(highButton8)
        
        askLabel.layer.cornerRadius = self.cornerRadius
        fillData(totallQuestionsCount: 117)
        refreshView()
    }

    @IBAction func navButt1Press(_ sender: UIBarButtonItem) {
        stackView.spacing += 5
        //stackView.
//        UIView.animateWithDuration(0.25) { () -> Void in
//            newView.hidden = false
//            scroll.contentOffset = offset
//        }
    }
    
    @IBAction func nevButton2Press(_ sender: UIBarButtonItem) {
        stackView.spacing -= 5
    }
    @IBAction func ResizeButtonPlusPress(_ sender: UIBarButtonItem) {
        //labelLeading.constant += 50
        highButton1.constant -= 5
        highButton2.constant -= 5
    }
    @IBAction func ResizeButtonMinusPress(_ sender: UIBarButtonItem) {
         askLabel.layer.cornerRadius = 10
        highButton1.constant += 5
        highButton2.constant += 5
    }
    @IBAction func firstButtonPress(_ sender: UIButton) {
        currentTest = 0
    }
    @IBAction func previousButtonPress(_ sender: UIButton) {
        if currentTest > 0 {
            currentTest -= 1
        }
    }
    @IBAction func checkButtonPress(_ sender: UIButton) {
        let currTest = testList[currentTest]
        let countTest = currTest.answerOptions.count         //okAnswers.count
        for i in 0..<countTest {
            if let button = stackView.arrangedSubviews[i] as? UIButton {
                button.layer.borderWidth =  currTest.answerOptions[i].isOK ? 3 : 1
                button.layer.borderColor = currTest.answerOptions[i].isOK ? UIColor.systemGreen.cgColor : UIColor.brown.cgColor
            }
        }
    }
    @IBAction func nextButtonPress(_ sender: UIButton) {
        if currentTest<101 {
            currentTest += 1
        }
    }
    func getText(fileName: String, encodingSystem encoding: String.Encoding = .windowsCP1250) -> [String] {
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
    func refreshView() {
        var i = 0
        let totalQuest = testList[currentTest].answerOptions.count
        testList[currentTest].youAnswers = []
        for curButt in stackView.arrangedSubviews     {
            if let butt = curButt as? UIButton {
                butt.isHidden = (i < totalQuest) ? false : true
                butt.setTitle((i < totalQuest) ? testList[currentTest].answerOptions[i].answerOption : "", for: .normal)  //nswerList?[i]
                butt.layer.borderWidth = 1
                butt.layer.borderColor = UIColor.brown.cgColor
                i += 1
            }
        }
        actionsButtonStackView.arrangedSubviews[0].isHidden = (currentTest == 0)
        actionsButtonStackView.arrangedSubviews[1].isHidden = (currentTest == 0)
        askLabel.text = testList[currentTest].ask
    }
        //        let okAnswers: [Bool]
        //        let order: [Int]
        //        var youAnswers = [Int]()
        //    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        //    button.backgroundColor = .greenColor()
        //    button.setTitle("Test Button", forState: .Normal)
        //    button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        //

    func randomOrderList() -> [Int] {
        return [4,2,3,1]
    }
}

