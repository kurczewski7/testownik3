//
//  ViewController.swift
//  Testownik
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit
class TestownikViewController: UIViewController, GesturesDelegate, TestownikDelegate {
    //  MARK: variable
    var gestures:  Gestures  = Gestures()
    var testownik: Testownik = Testownik()
    var cornerRadius: CGFloat = 10
    let initalStackSpacing: CGFloat = 30.0
    var tabHigh: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    var isLightStyle = true
    let selectedColor: UIColor   = #colorLiteral(red: 0.9999151826, green: 0.9882825017, blue: 0.4744609594, alpha: 1)
    let unSelectedColor: UIColor = #colorLiteral(red: 0.8469454646, green: 0.9804453254, blue: 0.9018514752, alpha: 1)
    let okBorderedColor: UIColor = #colorLiteral(red: 0.2034551501, green: 0.7804297805, blue: 0.34896487, alpha: 1)
    let borderColor: UIColor     = #colorLiteral(red: 0.7254344821, green: 0.6902328134, blue: 0.5528755784, alpha: 1)
    let otherColor: UIColor      = #colorLiteral(red: 0.8469454646, green: 0.9804453254, blue: 0.9018514752, alpha: 1)
    
    // "testList" declared in super of Testownik
    //  MARK: IBOutlets
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
    // MARK: IBAction
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
            //testownik.currentTest -= 1
            testownik.previous()
        }
    }
    @IBAction func checkButtonPress(_ sender: UIButton) {
        guard testownik.currentTest < testownik.count else {    return        }
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
        if testownik.currentTest < testownik.count-1 {
            //testownik.currentTest += 1
            testownik.next()
        }
    }
    // MARK: viewDidLoad - initial method
    override func viewDidLoad() {
        print("TestownikViewController viewDidLoad")        
        Settings.checkResetRequest(forUIViewController: self)
//        Settings.readCurrentLanguae()
        
        print("Test name 2:\(database.selectedTestTable[0]?.toAllRelationship?.user_name)")
        super.viewDidLoad()
        var i = 0
        self.title = "Test (001)"
        gestures.setView(forView: view)
        gestures.delegate  = self
        testownik.delegate = self
        // MARKT: MAYBY ERROR
        //testownik.loadTestFromDatabase()
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
        
        
        // TODO: POPRAW
        //testownik.fillData(totallQuestionsCount: 117)
        testownik.fillDataDb()
        //testownik.fillDataXXXX()
        refreshView()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear viewWillAppear")
        Settings.readCurrentLanguae()
        
        print("Test name 3:\(database.selectedTestTable[0]?.toAllRelationship?.user_name)")
        print("Testownik count: \(testownik.count)")
//        if database.testToUpgrade {
            print("testToUpgrade NOW")
            testownik.loadTestFromDatabase()
            testownik.currentTest = 0
        
            clearView()
            refreshView()
//            database.testToUpgrade.toggle()
//        }
        super.viewWillAppear(animated)
       
    }
    //--------------------------------
    // MARK: GesturesDelegate  protocol metods
    func pinchRefreshUI(sender: UIPinchGestureRecognizer) {
        print("Pinch touches:\(sender.numberOfTouches),\(sender.scale) ")
        stackView.spacing = initalStackSpacing * sender.scale
        //view.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
    func eadgePanRefreshUI() {
        print("Edge gesture")
    }
    func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction) {
        print("=====\nA currentTest: \(testownik.currentTest)")
        switch direction {
            case .right:
                //if testownik.count > 1 {
                    testownik.previous()
                    //testownik.currentTest -=  testownik.filePosition != .first  ? 1 : 0
                //}
                print("Swipe to right")
            case .left:
                //if testownik.count > 0 {
                    testownik.next()
                    //testownik.currentTest +=  testownik.filePosition != .last  ? 1 : 0
                //}
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
         print("Y pos: \(testownik.currentTest)")
    }
    // MARK: TestownikDelegate protocol "refreshUI" metods
    func refreshButtonUI(forFilePosition filePosition: Testownik.FilePosition) {
        if filePosition == .first {
            hideButton(forButtonNumber: 0)
            hideButton(forButtonNumber: 1)
        }
        else if filePosition == .last {
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
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        else {
            buttonLayerToZ(isHide: true)
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.isNavigationBarHidden = true
        }
        print("visableLevel:\(visableLevel)")
    }
    // MARK: Shake event method
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            tabBarController?.overrideUserInterfaceStyle = isLightStyle ? .dark : .light
            isLightStyle.toggle()
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
    // MARK: Method to press answer button
    @objc func buttonAnswerPress(sender: UIButton) {
        let bgColorSelelect:   UIColor =  selectedColor
        let bgColorUnSelelect: UIColor =  unSelectedColor
        let youSelectedNumber: Int = sender.tag
        
        var isChecked:Bool = false
        print("buttonAnswerPress:\(youSelectedNumber)")
        guard testownik.currentTest < testownik.count else {  return   }
        isChecked = testownik[testownik.currentTest].youAnswer2.contains(youSelectedNumber)
        if isChecked {
            testownik[testownik.currentTest].youAnswer2.remove(youSelectedNumber)
            isChecked = false
        } else  {
            testownik[testownik.currentTest].youAnswer2.insert(youSelectedNumber)
            isChecked = true
        }
        //#colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
        //#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        
        if let button = stackView.arrangedSubviews[youSelectedNumber] as? UIButton {
            button.layer.borderWidth = 3
            //button.layer.borderColor = okAnswer ? UIColor.green.cgColor : UIColor.red.cgColor
            button.layer.backgroundColor = isChecked ?  bgColorSelelect.cgColor : bgColorUnSelelect.cgColor
        }
        //--------------------
//        var found = false
//
//        let okAnswer = isAnswerOk(selectedOptionForTest: youSelectedNumber)
//
//        for elem in testownik[testownik.currentTest].youAnswers {
//            if elem == testownik.currentTest {   found = true     }
//        }
//        if !found {
//            testownik[testownik.currentTest].youAnswers.append(youSelectedNumber)
//        }
//        if let button = stackView.arrangedSubviews[youSelectedNumber] as? UIButton {
//            button.layer.borderWidth = 3
//            button.layer.borderColor = okAnswer ? UIColor.green.cgColor : UIColor.red.cgColor
//        }
        print("aswers:\(testownik[testownik.currentTest].youAnswers5)")
        print("aswers2:\(testownik[testownik.currentTest].youAnswer2.sorted())")
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
    func clearView() {
        var i = 1
        //let totalQuest = 7
        askLabel.text = "\(Setup.placeHolderTitle)"
        for curButt in stackView.arrangedSubviews     {
            if let butt = curButt as? UIButton {
                butt.isHidden =  false
                butt.setTitle("\(Setup.placeHolderButtons) \(i)", for: .normal)
                i += 1
            }
        }
    }
    func refreshView() {
        var i = 0
        guard testownik.currentTest < testownik.count else {
            print("JEST \(testownik.count)  TESTOW")
            return            
        }
        let txtFile = testownik[testownik.currentTest].fileName
        self.title = "Test \(txtFile)"
        testownik[testownik.currentTest].youAnswer2 = []
        let totalQuest = testownik[testownik.currentTest].answerOptions.count
        testownik[testownik.currentTest].youAnswers5 = []
        askLabel.text = testownik[testownik.currentTest].ask
        for curButt in stackView.arrangedSubviews     {
            if let butt = curButt as? UIButton {
                butt.isHidden = (i < totalQuest) ? false : true
                butt.setTitle((i < totalQuest) ? testownik[testownik.currentTest].answerOptions[i].answerOption : "", for: .normal)
                butt.layer.borderWidth = 1
                butt.layer.borderColor = UIColor.brown.cgColor
                let isSelect = testownik[testownik.currentTest].youAnswer2.contains(i)
                butt.layer.backgroundColor = isSelect ? selectedColor.cgColor: unSelectedColor.cgColor
                i += 1
            }
        }
        actionsButtonStackView.arrangedSubviews[0].isHidden = (testownik.filePosition == .first)
        actionsButtonStackView.arrangedSubviews[1].isHidden = (testownik.filePosition == .first)
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

