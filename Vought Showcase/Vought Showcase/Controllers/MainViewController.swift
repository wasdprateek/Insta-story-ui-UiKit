//
//  ViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setup(){
        let viewControllerToPresent = TheBoysViewController()
        
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        viewControllerToPresent.modalTransitionStyle = .coverVertical
        print("i am being called")
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop // Customize as needed
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window?.layer.add(transition, forKey: kCATransition)
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        setup()
           
    }
    
    
    
    
}

