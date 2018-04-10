//
//  SlideSegue.swift
//  Securis
//
//  Created by Derek Roberts on 2/20/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit

class SlideSegue: UIStoryboardSegue {
    override func perform() {
        slideIn()
    }
    
    func slideIn() {
        let toViewController = self.destination
        let fromViewController = self.source
        let containerView = fromViewController.view.superview

        toViewController.view.transform = CGAffineTransform(translationX: 512, y: 0)
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
}

class UnwindSlideSegue: UIStoryboardSegue {
    override func perform() {
        slideIn()
    }
    
    func slideIn() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        fromViewController.view.superview?.insertSubview(toViewController.view, at: 0)
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.transform = CGAffineTransform(translationX: 512, y: 0)
        }, completion: { success in
            fromViewController.dismiss(animated: false, completion: nil)
        })
    }
}
