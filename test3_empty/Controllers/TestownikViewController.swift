//
//  ViewController.swift
//  test3_empty
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
class TestownikViewController: UIViewController, GesturesDelegate, TestownikDelegate {
    var gestures:  Gestures  = Gestures()
    var testownik: Testownik = Testownik()
    var cornerRadius: CGFloat = 10
    let initalStackSpacing: CGFloat = 30.0
    var tabHigh: [NSLayoutConstraint] = [NSLayoutConstraint]()

    //var testList: [Test] = [Test]()

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
    
    @IBAction func navButtSpaseAddPress(_ sender: UIBarButtonItem) {
        stackView.spacing += 5
//        stackView.
//        UIView.animateWithDuration(0.25) { () -> Void in
//            newView.hidden = false
//            scroll.contentOffset = offset
//        }
    }
    @IBAction func nevButtonSpaceSubPress(_ sender: UIBarButtonItem) {
        stackView.spacing -= 5
    }
    @IBAction func ResizeButtonPlusPress(_ sender: UIBarButtonItem) {
        for buttHight in tabHigh {
            buttHight.constant += 2
        }

        //          labelLeading.constant += 50
    }
    @IBAction func ResizeButtonMinusPress(_ sender: UIBarButtonItem) {
         askLabel.layer.cornerRadius = 10
        for buttHight in tabHigh {
            buttHight.constant -= 2
        }
    }
    @IBAction func firstButtonPress(_ sender: UIButton) {
        testownik.currentTest = 0
    }
    @IBAction func previousButtonPress(_ sender: UIButton) {
        if testownik.currentTest > 0 {
            testownik.currentTest -= 1
        }
    }
    @IBAction func checkButtonPress(_ sender: UIButton) {
        let currTest = testownik[testownik.currentTest]
        let countTest = currTest.answerOptions.count         //okAnswers.count
        for i in 0..<countTest {
            if let button = stackView.arrangedSubviews[i] as? UIButton {
                button.layer.borderWidth =  currTest.answerOptions[i].isOK ? 3 : 1
                button.layer.borderColor = currTest.answerOptions[i].isOK ? UIColor.systemGreen.cgColor : UIColor.brown.cgColor
            }
        }
    }
    @IBAction func nextButtonPress(_ sender: UIButton) {
        if testownik.currentTest < testownik.count {
            testownik.currentTest += 1
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        gestures.setView(forView: view)
        gestures.delegate  = self
        testownik.delegate = self
        
        var i = 0
        print("Stack count: \(actionsButtonStackView.arrangedSubviews.count)")
        stackView.arrangedSubviews.forEach { (button) in
            if let butt = button as? UIButton {
                butt.backgroundColor = #colorLiteral(red: 0.8469454646, green: 0.9804453254, blue: 0.9018514752, alpha: 1)
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
        
        gestures.addSwipeGestureToView(direction: .right)
        gestures.addSwipeGestureToView(direction: .left)
        gestures.addSwipeGestureToView(direction: .up)
        gestures.addSwipeGestureToView(direction: .down)
        gestures.addPinchGestureToView()
        gestures.addScreenEdgeGesture()
        
        askLabel.layer.cornerRadius = self.cornerRadius
        testownik.fillData(totallQuestionsCount: 117)
        refreshView()
    }
    //--------------------------------
    // GesturesDelegate  protocol metods
    func pinchRefreshUI(sender: UIPinchGestureRecognizer) {
        print("Pinch touches:\(sender.numberOfTouches),\(sender.scale) ")
        stackView.spacing = initalStackSpacing * sender.scale
        //view.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    func eadgePanRefreshUI() {
        print("Edge gesture")
    }
    func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction) {
        switch direction {
            case .right:
                testownik.currentTest -=  testownik.filePosition != .first  ? 1 : 0
                print("Swipe to right")
            case .left:
                testownik.currentTest +=  testownik.filePosition != .last  ? 1 : 0
                print("Swipe  & left ")
            case .up:
                print("Swipe up")
                testownik.visableLevel +=  testownik.visableLevel < 2 ? 1 : 0
            case .down:
                print("Swipe down")
                testownik.visableLevel -= testownik.visableLevel > 0 ? 1 : 0
            default:
                print("Swipe unrecognized")
            }
    }
    // TestownikDelegate protocol metods
    func refreshButtonUI(forCurrentTest currentTest: Int, countTest count: Int) {
        if currentTest == 0 {
            hideButton(forButtonNumber: 0)
            hideButton(forButtonNumber: 1)
        }
        else if currentTest == count-1 {
            hideButton(forButtonNumber: 3)
        }
        else {
            hideButton(forButtonNumber: 0, isHide: false)
            hideButton(forButtonNumber: 1, isHide: false)
            hideButton(forButtonNumber: 3, isHide: false)
        }
        refreshView()
    }
    func refreshTabbarUI(visableLevel: Int) {
        if visableLevel == 2 {
            buttonLayerToZ(isHide: false)
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.isNavigationBarHidden = false
        } else if  visableLevel == 1 {
            buttonLayerToZ(isHide: true)
            self.tabBarController?.tabBar.isHidden = false
            self.navigationController?.isNavigationBarHidden = false
        }
        else {
            buttonLayerToZ(isHide: true)
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.isNavigationBarHidden = true
        }
        print("visableLevel:\(visableLevel)")
    }
    //---------------------------
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shake")
        }
    }
    func buttonLayerToZ(isHide: Bool) {
        for elem in actionsButtonStackView.arrangedSubviews {
            elem.layer.zPosition = isHide ? -1 : 0
        }
    }
    func resizeView(toMaximalize: Bool? = nil) {
        if let toAddSize = toMaximalize {
            stackView.spacing += toAddSize ? 1 : -1
        }
    }
    @objc func buttonAnswerPress(sender: UIButton) {
        print("buttonAnswerPress:\(sender.tag)")
        
        var found = false
        let youSelectedNumber = sender.tag
        let okAnswer = isAnswerOk(selectedOptionForTest: youSelectedNumber)
        
        for elem in testownik[testownik.currentTest].youAnswers {
            if elem == testownik.currentTest {   found = true     }
        }
        if !found {
            testownik[testownik.currentTest].youAnswers.append(youSelectedNumber)
        }
        if let button = stackView.arrangedSubviews[youSelectedNumber] as? UIButton {
            button.layer.borderWidth = 3
            button.layer.borderColor = okAnswer ? UIColor.green.cgColor : UIColor.red.cgColor
        }
        print("aswers:\(testownik[testownik.currentTest].youAnswers)")
    }
    func isAnswerOk(selectedOptionForTest selectedOption: Int) -> Bool {
         var value = false
        if  selectedOption < testownik[testownik.currentTest].answerOptions.count {
            value = testownik[testownik.currentTest].answerOptions[selectedOption].isOK
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
    func hideButton(forButtonNumber buttonNumber: Int, isHide: Bool = true) {
        if let button = actionsButtonStackView.arrangedSubviews[buttonNumber] as? UIButton {
            button.isHidden = isHide
        }
    }
    func refreshView() {
        var i = 0
        let totalQuest = testownik[testownik.currentTest].answerOptions.count
        testownik[testownik.currentTest].youAnswers = []
        for curButt in stackView.arrangedSubviews     {
            if let butt = curButt as? UIButton {
                butt.isHidden = (i < totalQuest) ? false : true
                butt.setTitle((i < totalQuest) ? testownik[testownik.currentTest].answerOptions[i].answerOption : "", for: .normal)
                butt.layer.borderWidth = 1
                butt.layer.borderColor = UIColor.brown.cgColor
                i += 1
            }
        }
        actionsButtonStackView.arrangedSubviews[0].isHidden = (testownik.filePosition == .first)
        actionsButtonStackView.arrangedSubviews[1].isHidden = (testownik.filePosition == .first)
        askLabel.text = testownik[testownik.currentTest].ask
    }
    func getText(fileName: String, encodingSystem encoding: String.Encoding = .utf8) -> [String] {  //windowsCP1250
        var texts: [String] = ["brak"]
        if let path = Bundle.main.path(forResource: fileName, ofType: "txt") {
            do {
//                let charSetFileType = NSHFSTypeOfFile(path)
//                print("File char set: \(charSetFileType)")
                //let xx = String("ąćśżź")
                //xx.encode(to: <#T##Encoder#>)
                //stringWithContentsOfFile;: aaa, usedEncoding:error: )
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
        //    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        //    button.backgroundColor = .greenColor()
        //    button.setTitle("Test Button", forState: .Normal)
        //    button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        //
}

