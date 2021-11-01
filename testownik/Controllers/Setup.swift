//
//  Setup.swift
//  SwiftyDocPicker
//
//  Created by Slawek Kurczewski on 05/03/2020.
//  Copyright © 2020 Abraham Mangona. All rights reserved.
//

import UIKit
import SSZipArchive

class Setup {
    enum LanguaesList: String {
        case enlish     = "en"
        case english_US = "en-US"
        case english_GB = "en-GB"
        case polish     = "pl"
        case german     = "de"
        case french     = "fr_FR"
        case spanish    = "es_ES"
    }
    static var isNumericQuestions = false
    static let askNumber = ["1️⃣","2️⃣","3️⃣","4️⃣","5️⃣","6️⃣","7️⃣","8️⃣","9️⃣","🔟"]
    static var tempStr: String  = ""
    static var currentLanguage: LanguaesList = .german
    static var placeHolderButtons: String { get {
        switch currentLanguage {
            case .enlish     : tempStr = "Question"
            case .english_US : tempStr = "Question"
            case .english_GB : tempStr = "Question"
            case .polish     : tempStr = "Pytanie"
            case .german     : tempStr = "Frage"
            case .french     : tempStr = "Question"
            case .spanish    : tempStr = "Pregunta"
        }
        return tempStr }
    }
    static var placeHolderTitle: String  { get {
        switch currentLanguage {
            case .enlish     : tempStr = "You don't have selected test. Add new test in search option."
            case .english_US : tempStr = "You don't have selected test. Add new test in search option."
            case .english_GB : tempStr = "You don't have selected test. Add new test in search option."
            case .polish     : tempStr = "Nie wybrałeś testu. Dodaj nowy test w opcji wyszukiwania."
            case .german     : tempStr = "Sie haben keinen Test ausgewählt. Neuen Test in Suchoption hinzufügen."
            case .french     : tempStr = "Vous n'avez pas sélectionné de test. Ajouter un nouveau test dans l'option de recherche."
            case .spanish    : tempStr = "No ha seleccionado la prueba. Agregue una nueva prueba en la opción de búsqueda."
        }
        return tempStr }
    }
    static var placeHolderDeleteTest: String { get {
        switch currentLanguage {
            case .enlish     : tempStr = "Do you want to delete all the tests ?"
            case .english_US : tempStr = "Do you want to delete all the tests ?"
            case .english_GB : tempStr = "Do you want to delete all the tests ?"
            case .polish     : tempStr = "Czy chcesz usunąć wszystkie testy ?"
            case .german     : tempStr = "Möchten Sie alle Tests löschen ?"
            case .french     : tempStr = "Voulez-vous supprimer tous les tests ?"
            case .spanish    : tempStr = "Quieres borrar todas las pruebas ?"
        }
        return tempStr
    }}


    
    static var cloudPicker: CloudPicker!
    
//   class func getText(fromCloudFilePath filePath: URL) -> [String] {
//        let value = getTextEncoding(filePath: filePath)
//        let data = value.data
//        let myString = data.components(separatedBy: .newlines)
//        return myString
//    //var texts: [String] = [""]
//    //texts = myString
//    //texts
//    }
//    class func getTextEncoding(filePath path: URL, defaultEncoding: String.Encoding = .windowsCP1250) -> (encoding: String.Encoding, data: String) {
//        let encodingType: [String.Encoding] = [.utf8,.windowsCP1250,.isoLatin2, .unicode, .ascii]
//        var data: String = "brakUJE"
//        var encoding: String.Encoding = .windowsCP1250
//        let val = tryEncodingFile(filePath: path, encoding: defaultEncoding)
//        if  val.data.count > 0 {
//            data = val.data
//        }
//        else {  // find encoding
//            for i in 0..<encodingType.count {
//                let value = tryEncodingFile(filePath: path, encoding: encodingType[i])
//                if value.isOk {
//                    data = value.data
//                    encoding = encodingType[i]
//                    break
//                }
//            }
//        }
//        if data == "brakUJE" {
//            print("BRAKUJE: \(path)")
//        }
//        return  (encoding, data)
//    }
//    class func tryEncodingFile(filePath path: URL, encoding: String.Encoding)  -> (isOk: Bool, data: String) {
//        do {
//            let data = try String(contentsOf: path, encoding: encoding)
//            print("enum <#name#> {

//            return (isOk: true, data: data)
//        }
//        catch {
//            return (isOk: false, data: "")
//        }
//    }
//    class func mergeText(forStrings strings: [String]) -> String {
//        var val = ""
//        for elem in strings {
//            //defer {    print("val:\(val)")   }
//            val += elem + "\n"
//        }
//        return val
//    }
    
    
    class func getNumericPict(number: Int) -> String {
        guard number < 10 else { return ""}
        return (isNumericQuestions ? " "+askNumber[number]+" " : "")
    }
    class func findValue<T: Comparable>(currentList: [T], valueToFind: T, handler: (_ currElem: T) -> Bool) -> Bool {
        var found = false
        // TODO: Finalize method
        for i in 0..<currentList.count {
            if currentList[i] == valueToFind { found = true}
        }
        return found
    }
    class func displayToast(forController controller: UIViewController, message: String, seconds delay: Double)  {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .systemYellow
        alert.view.alpha = 0.3
        alert.view.layer.cornerRadius = 10
        alert.view.clipsToBounds = true
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            alert.dismiss(animated: true)
        }
    }
    class func displayToast(forView view: UIView, message : String, seconds delay: Double) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 75, y: view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 5, delay: 11, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.2
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    class func popUp(context ctx: UIViewController, msg: String, height: CGFloat = 100) {
        let toast = UILabel(frame:
            CGRect(x: 16, y: ctx.view.frame.size.height / 2,
                   width: ctx.view.frame.size.width - 32, height: height))

        toast.backgroundColor = UIColor.lightGray
        toast.textColor = UIColor.white
        toast.textAlignment = .center;
        toast.numberOfLines = 3
        toast.font = UIFont.systemFont(ofSize: 20)
        toast.layer.cornerRadius = 12;
        toast.clipsToBounds  =  true
        toast.text = msg

        ctx.view.addSubview(toast)
        UIView.animate(withDuration: 15.0, delay: 0.2,
            options: .curveEaseOut,  animations: {
            toast.alpha = 0.0
            }, completion: {(isCompleted) in
                toast.removeFromSuperview()
        })
    }
    @objc
    class func cancelPress() {
        print("END VIEW")
    }
    class func popUpStrong(context ctx: UIViewController, msg: String, numberLines lines: Int = 6, height: CGFloat = 200)  -> UILabel   {
        let toast = UILabel(frame:
            CGRect(x: 16, y: ctx.view.frame.size.height / 2,
                   width: ctx.view.frame.size.width - 32, height: height))

        toast.backgroundColor = UIColor.systemBlue
        toast.textColor = UIColor.white
        toast.textAlignment = .center;
        toast.numberOfLines = lines
        toast.font = UIFont.systemFont(ofSize: 20)
        toast.layer.cornerRadius = 12;
        toast.clipsToBounds  =  true
        toast.isUserInteractionEnabled = true
        //toast.addGestureRecognizer = esture
        //gestures.addTapGestureToView(forView: toast)
        //gestures.addTapGestureToView()
        //toast.userAnimation(<#T##duration: CFTimeInterval##CFTimeInterval#>, type: .push, subType: ., timing: <#T##UIView.TimingAnim#>)
        //toast.addTarget(self, action: #selector(cancelPress), for: .touchUpInside)
        toast.text = msg
        
        
        ctx.view.addSubview(toast)
//        UIView.animate(withDuration: 0.9 , delay: 15.0,
//            options: .curveEaseOut,  animations: {
//            toast.alpha = 0.0
//            }, completion: {(isCompleted) in
//                toast.removeFromSuperview()
//        })
      return toast
    }
}
