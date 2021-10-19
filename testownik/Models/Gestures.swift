//
//  Gestures.swift
//  testownik
//
//  Created by Slawek Kurczewski on 26/02/2020.
//  Copyright © 2020 Slawomir Kurczewski. All rights reserved.
//

import UIKit

protocol GesturesDelegate {
    func pinchRefreshUI(sender: UIPinchGestureRecognizer)
    func longPressRefreshUI(sender: UILongPressGestureRecognizer)
    func forcePressRefreshUI(sender: ForcePressGestureRecognizer)
    func eadgePanRefreshUI()
    func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction)
}
class Gestures {
    var view: UIView? = nil
    let xx = UITouch()
    func yy() {
        xx.force
        //xx.maximumPossibleForce = 2
        
    }
    var delegate: GesturesDelegate?
         func setView(forView view: UIView) {
                self.view = view
         }
         func addSwipeGestureToView(direction: UISwipeGestureRecognizer.Direction) {
            if view != nil {
                let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
                swipe.direction = direction
                view!.addGestureRecognizer(swipe)

            }
         }
         func addPinchGestureToView() {
             if view != nil {
                let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pichAction))
                view!.addGestureRecognizer(pinch)
             }
         }
        func addScreenEdgeGesture(edge: UIRectEdge = .left) {
             if view != nil {
                let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(eadgeAction))
                gesture.edges = edge
                view!.addGestureRecognizer(gesture)
             }
         }
         func addLongPressGesture() {
            if view != nil {
                let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
                gesture.minimumPressDuration = 1.0
                gesture.numberOfTouchesRequired = 1
                view!.addGestureRecognizer(gesture)
                print("AAAA:  addLongPressGesture")
            }
         }
         func addForcePressGesture() {
            if view != nil {
                let gesture = ForcePressGestureRecognizer(target: self, action: #selector(forcePressAction))
                //gesture.minimumPressDuration = 1.0
                //gesture.numberOfTouchesRequired = 1
                view!.addGestureRecognizer(gesture)
                print("BBB:  addForcePressGesture")
            }
         }
//func ForcePressGesture() {
//            if view != nil {
//                let gesture = ForcePressGestureRecognizer(target: self, action: #selector(forcePressAction))
//                view!.addGestureRecognizer(gesture)
//                print("AAAA:  addLongPressGesture")
//
////                gesture.
////                gesture.minimumPressDuration = 1.0
////                gesture.numberOfTouchesRequired = 1
//
//            }
//        }

    //UILongPressGestureRecognizer
        //----------------------
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
            delegate?.longPressRefreshUI(sender: sender)
         }
         @objc func  forcePressAction(sender: ForcePressGestureRecognizer) {
             delegate?.forcePressRefreshUI(sender: sender)
         }
}
