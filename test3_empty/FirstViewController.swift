//
//  ViewController.swift
//  test3_empty
//
//  Created by Slawek Kurczewski on 14/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    struct Test {
        let code: String?
        let ask: String?
        let pict: UIImage?
        let answerList: [String]?
        let okAnswer: Int
    }
    var testList: [Test] = [Test]()
    var currentTest: Int = 0 {
        didSet {
            refreshView()
        }
    }
    var tabButt: [UIButton] = [UIButton]()
    var tabHigh: [NSLayoutConstraint] = [NSLayoutConstraint]()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var askLabel: UILabel!
    
    
    @IBOutlet weak var butt1: UIButton!
    @IBOutlet weak var butt2: UIButton!
    @IBOutlet weak var butt3: UIButton!
    @IBOutlet weak var butt4: UIButton!
    @IBOutlet weak var butt5: UIButton!
    @IBOutlet weak var butt6: UIButton!
    @IBOutlet weak var butt7: UIButton!
    @IBOutlet weak var butt8: UIButton!
    
    @IBOutlet weak var highButton1: NSLayoutConstraint!
    @IBOutlet weak var highButton2: NSLayoutConstraint!
    @IBOutlet weak var highButton3: NSLayoutConstraint!
    @IBOutlet weak var highButton4: NSLayoutConstraint!
    @IBOutlet weak var highButton5: NSLayoutConstraint!
    @IBOutlet weak var highButton6: NSLayoutConstraint!
    @IBOutlet weak var highButton7: NSLayoutConstraint!
    @IBOutlet weak var highButton8: NSLayoutConstraint!
    
    @IBAction func buttonPress(_ sender: UISegmentedControl) {
        print("sender:\(sender.selectedSegmentIndex)")
        if sender.selectedSegmentIndex == 0 {
            currentTest -= 1
        }
        else {
            currentTest += 1
        }
    }
    @IBOutlet weak var labelLeading: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tabButt.append(butt1)
        tabButt.append(butt2)
        tabButt.append(butt3)
        tabButt.append(butt4)
        tabButt.append(butt5)
        tabButt.append(butt6)
        tabButt.append(butt7)
        tabButt.append(butt8)
        
        tabHigh.append(highButton1)
        tabHigh.append(highButton2)
        tabHigh.append(highButton3)
        tabHigh.append(highButton4)
        tabHigh.append(highButton5)
        tabHigh.append(highButton6)
        tabHigh.append(highButton7)
        tabHigh.append(highButton8)
        
        askLabel.layer.cornerRadius = 10
        butt1.layer.cornerRadius = 10
        butt2.layer.cornerRadius = 5
        
        
        fillData(totallQuestionsCount: 117)
        refreshView()
        butt4.titleLabel?.text = "AAAAAABBBBB"
        
//        let x = getText(fileName: "045")  //"059"
//        for tx in x {
//            print("\(tx)")
//        }
        // Do any additional setup after loading the view.
    }

    @IBAction func navButt1Press(_ sender: UIBarButtonItem) {
        stackView.spacing += 5
        butt7.isHidden.toggle()
    }
    
    @IBAction func nevButton2Press(_ sender: UIBarButtonItem) {
        stackView.spacing -= 5
        butt6.isHidden.toggle()
    }
    @IBAction func ResizeButtonPlusPress(_ sender: UIBarButtonItem) {
        //labelLeading.constant += 50
        highButton1.constant += 5
        highButton2.constant += 5
       
         butt1.titleLabel?.text = "Jaka jest odległość ziemi od księżyca"
        
    }
    @IBAction func ResizeButtonMinusPress(_ sender: UIBarButtonItem) {
        //butt4.contentRect(forBounds: CGRect(x: 0, y: 0, width: 150, height: 50))
        askLabel.layer.cornerRadius = 1
        butt6.layer.cornerRadius = 5
        butt7.sizeThatFits(CGSize(width: 150, height: 50))
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
    func fillData(totallQuestionsCount: Int) {
        for i in 1...117 {
            let name = String(format: "%03d", i)
            print("name:\(name)")
            let textLines=getText(fileName: name)
            let answerList=[textLines[2],textLines[3],textLines[4]]
            let test=Test(code: textLines[0], ask: textLines[1], pict: nil, answerList: answerList, okAnswer: 1)
            testList.append(test)
            print(test)
        }
    }
    func refreshView() {
        let currTest = testList[currentTest]
        if  let totalQuest = currTest.answerList?.count  {
            var i = 0
            for curButt in tabButt {
                if i < totalQuest {
                    curButt.isHidden = false
                }
                else {
                    curButt.isHidden = true
                }
                i += 1
            }
            for i in 0..<totalQuest {
                tabButt[i].setTitle(currTest.answerList?[i], for: .normal)
            }
            
        }
        askLabel.text = currTest.ask
        
        //    let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        //    button.backgroundColor = .greenColor()
        //    button.setTitle("Test Button", forState: .Normal)
        //    button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        //

        
    }
        
        

}

