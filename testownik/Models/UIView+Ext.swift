//
//  UIView+Ext.swift
//  testownik
//
//  Created by Slawek Kurczewski on 18/10/2021.
//  Copyright © 2021 Slawomir Kurczewski. All rights reserved.
//

import UIKit

extension UIView {
    enum TypeAnim {
        case fade
        case moveIn
        case push
        case reveal
    }
    enum SubTypeAnim {
        case fromRight
        case fromLeft
        case fromTop
        case fromBottom
    }
    enum TimingAnim {
        case linear
        case easeIn
        case easeOut
        case easeInEaseOut
        case defaultTiming
    }
    func userAnimation(_ duration: CFTimeInterval, type: TypeAnim, subType: SubTypeAnim, timing: TimingAnim = TimingAnim.defaultTiming)  {
        var aType    = CATransitionType.push
        var aSubType = CATransitionSubtype.fromLeft
        var aTiming  = CAMediaTimingFunctionName.easeInEaseOut
        switch type {
            case .fade:     aType = CATransitionType.fade
            case .moveIn:   aType = CATransitionType.moveIn
            case .push:     aType = CATransitionType.push
            case .reveal:   aType = CATransitionType.reveal
        }
        switch subType {
            case .fromRight:    aSubType = CATransitionSubtype.fromRight
            case .fromLeft:     aSubType = CATransitionSubtype.fromLeft
            case .fromTop:      aSubType = CATransitionSubtype.fromTop
            case .fromBottom:   aSubType = CATransitionSubtype.fromBottom
        }
        switch timing {
            case .linear:        aTiming = CAMediaTimingFunctionName.linear
            case .easeIn:        aTiming = CAMediaTimingFunctionName.easeIn
            case .easeOut:       aTiming = CAMediaTimingFunctionName.easeOut
            case .easeInEaseOut: aTiming = CAMediaTimingFunctionName.easeInEaseOut
            case .defaultTiming: aTiming = CAMediaTimingFunctionName.default
        }
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: aTiming)
        animation.type = aType
        animation.subtype = aSubType
        animation.duration = duration
        //layer.add(animation, forKey: CATransitionType.push)
        layer.add(animation, forKey: "CATransitionType.push")
    }
}
