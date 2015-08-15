//
//  FlipSegue.swift
//  Medications
//
//  Created by Lukas Schmidt on 15.08.15.
//  Copyright © 2015 Lukas Schmidt. All rights reserved.
//

import UIKit

class FlipSegue: UIStoryboardSegue {
    override func perform() {
        UIView.transitionWithView(sourceViewController.navigationController!.view, duration: 0.2, options: UIViewAnimationOptions.TransitionFlipFromLeft, animations: {sourceViewController.navigationController?.pushViewController(destinationViewController, animated: false)}, completion: nil)
    }
}

