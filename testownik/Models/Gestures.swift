//
//  Gestures.swift
//  testownik
//
//  Created by Slawek Kurczewski on 26/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

protocol GesturesDelegate {
    func eadgePanRefreshUI()
    func tapRefreshUI(sender: UITapGestureRecognizer)
    func pinchRefreshUI(sender: UIPinchGestureRecognizer)
    func longPressRefreshUI(sender: UILongPressGestureRecognizer)
    func forcePressRefreshUI(sender: ForcePressGestureRecognizer)
    func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction)
}
class Gestures {
    var view: UIView?  = nil
    let xx = UITouch()
    func yy() {
        xx.force
        let zz = xx.maximumPossibleForce
        let cc = xx.gestureRecognizers?[0]
        print("maximumPossibleForce:\(zz),\(cc)")
    }
    var delegate: GesturesDelegate?
    var minimumPressDuration = 0.9      // default 0.9
    var numberOfTouchesRequired = 1     // default 1
    
     func setView(forView view: UIView) {
            self.view = view
     }
    func addTapGestureToView(forView aView: UIView? = nil, numberOfTouchesRequired touchNumber: Int = 1) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        //gesture.minimumPressDuration = self.minimumPressDuration
        gesture.numberOfTouchesRequired = touchNumber
        if let aView = aView {
            aView.addGestureRecognizer(gesture)
            print("EEEE:  addLongPressGesture:\(aView.tag)")
            return
        }
        if let view = view {
            view.addGestureRecognizer(gesture)
            print("FFFF:  addLongPressGesture")
        }
    }
     func addSwipeGestureToView(direction: UISwipeGestureRecognizer.Direction) {
        if let view = view {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
            swipe.direction = direction
            view.addGestureRecognizer(swipe)
        }
     }
     func addPinchGestureToView() {
         if let view = view {
            let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pichAction))
            view.addGestureRecognizer(pinch)
         }
     }
    func addScreenEdgeGesture(edge: UIRectEdge = .left, forView aView: UIView? = nil) {
        let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(eadgeAction))
        gesture.edges = edge
        addOneGesture(gesture, forView: aView)
     }
    func addLongPressGesture(forView aView: UIView? = nil) {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        gesture.minimumPressDuration = self.minimumPressDuration
        gesture.numberOfTouchesRequired = self.numberOfTouchesRequired
        addOneGesture(gesture, forView: aView)
    }
     func addForcePressGesture(forView aView: UIView? = nil) {
         let gesture = ForcePressGestureRecognizer(target: self, action: #selector(forcePressAction))
         addOneGesture(gesture, forView: aView)
     }
    private func addOneGesture(_ gesture: UIGestureRecognizer, forView aView: UIView?)   {
        guard let v = (aView == nil ? self.view : aView) else {     return        }
        v.addGestureRecognizer(gesture)
        print("CCCC:  Gesture:\(v.tag)")
    }
    //--------------------------------------------------
    @objc func tapAction(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            delegate?.tapRefreshUI(sender: sender)
        }
    }
     @objc func swipeAction(sender: UISwipeGestureRecognizer) {
         delegate?.swipeRefreshUI(direction: sender.direction)
         //swipeRefreshUI(direction: sender.direction)
     }
     @objc func eadgeAction() {
         delegate?.eadgePanRefreshUI()
         //eadgePanRefreshUI()
     }
     @objc func pichAction(sender: UIPinchGestureRecognizer) {
         delegate?.pinchRefreshUI(sender: sender)
         //pinchRefreshUI(sender: sender)
     }
     @objc func longPressAction(sender: UILongPressGestureRecognizer) {
         if sender.state == .ended {
             delegate?.longPressRefreshUI(sender: sender)
         }
     }
     @objc func  forcePressAction(sender: ForcePressGestureRecognizer) {
         if let tag = sender.view?.tag {
             delegate?.forcePressRefreshUI(sender: sender)
         }
     }
}
