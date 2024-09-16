//
//  TheBoysViewController.swift
//  Vought Showcase
//
//  Created by Prateek Kumar Rai on 14/09/24.
//

import UIKit

class TheBoysViewController: UIViewController {
    let fullScreenView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullScreenView.frame = self.view.bounds
        self.view.addSubview(fullScreenView)
        initCarouselView()
        // Do any additional setup after loading the view.
    }
    
    private func initCarouselView() {
        // Create a carousel item provider
        let carouselItemProvider = CarouselItemDataSourceProvider()
        
        // Create carouselViewController
        let carouselViewController = CarouselViewController(items: carouselItemProvider.items())
        
        // Add carousel view controller in container view
        add(asChildViewController: carouselViewController, containerView: fullScreenView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
