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
    func eadgePanRefreshUI()
    func swipeRefreshUI(direction: UISwipeGestureRecognizer.Direction)
}
class Gestures {
    var view: UIView? = nil
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
         func addScreenEdgeGesture() {
             if view != nil {
                let gesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(eadgeAction))
                gesture.edges = .left
                view!.addGestureRecognizer(gesture)
             }

         }
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
}
