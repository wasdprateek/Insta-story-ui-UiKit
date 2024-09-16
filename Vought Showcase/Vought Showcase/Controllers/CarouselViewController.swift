//
//  CarouselViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import Foundation
import UIKit


final class CarouselViewController: UIViewController {
    
    /// Container view for the carousel
    @IBOutlet private weak var containerView: UIView!
    private var segmentedProgressBar: SegmentedProgressBar?

    /// Page view controller for carousel
    
    /// Carousel items
    private var items: [CarouselItem] = []
    
    /// Current item index
    private var currentItemIndex: Int = 0 {
        didSet {
            // Update carousel control page
            segmentedProgressBar?.currentIndex = currentItemIndex
        }
    }

    /// Initializer
    /// - Parameter items: Carousel items
    public init(items: [CarouselItem]) {
        self.items = items
        super.init(nibName: "CarouselViewController", bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        currentItemIndex = 0
//        setupSegmentedProgressBar()
//
//        showCurrentViewController()
//
//        setupGestureRecognizers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
        currentItemIndex = 0
        super.viewWillAppear(animated)
        
        setupSegmentedProgressBar()
        
        showCurrentViewController()
        
        setupGestureRecognizers()
        
        setUpPanGestureRecognizers()
    }
    
    private func setUpPanGestureRecognizers(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
                view.addGestureRecognizer(panGesture)
    }
    
    
    
    private func setupGestureRecognizers() {
            let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLeftSide(_:)))
            let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapRightSide(_:)))
            
            leftTapGesture.numberOfTapsRequired = 1
            rightTapGesture.numberOfTapsRequired = 1
            
            // Define the left and right regions as different views
            let leftTapView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.height))
            let rightTapView = UIView(frame: CGRect(x: view.frame.width / 2, y: 0, width: view.frame.width / 2, height: view.frame.height))
            
            // Set gesture recognizers to each side
            leftTapView.addGestureRecognizer(leftTapGesture)
            rightTapView.addGestureRecognizer(rightTapGesture)
            
            // Add the tap views as transparent subviews
            leftTapView.backgroundColor = .clear
            rightTapView.backgroundColor = .clear
            view.addSubview(leftTapView)
            view.addSubview(rightTapView)
        }
    
    private func setupSegmentedProgressBar() {
        // Create the SegmentedProgressBar with number of segments equal to the number of items
        segmentedProgressBar = SegmentedProgressBar(numberOfSegments: items.count)
        segmentedProgressBar?.delegate = self
        
        // Set up the frame for the progress bar
        segmentedProgressBar?.frame = CGRect(x: 0, y: 54, width: containerView.frame.width, height: 5)
        segmentedProgressBar?.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the segmented progress bar as a subview
        if let progressBar = segmentedProgressBar {
            view.addSubview(progressBar)
        }
        
//        NSLayoutConstraint.activate([
//                segmentedProgressBar!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//                segmentedProgressBar!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                segmentedProgressBar!.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            ])

        // Start the animation for the progress bar
        segmentedProgressBar?.startAnimation()
    }
    private func showCurrentViewController() {
            if let viewController = getCurrentViewController() {
                // Remove previous view controller
                for child in children {
                    child.willMove(toParent: nil)
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                }
                
                // Add new view controller
                addChild(viewController)
                
                containerView.addSubview(viewController.view)
                viewController.view.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                            viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                            viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                            viewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                            viewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
                        ])
                viewController.didMove(toParent: self)
            }
        }
    private func getCurrentViewController() -> UIViewController? {
           guard currentItemIndex < items.count else { return nil }
           return items[currentItemIndex].getController()
       }
    
    
    /// Initialize page view controller
    
    /// Initialize carousel control
    

    /// Update current page
    /// Parameter sender: UIPageControl
    
    
    /// Get controller at index
    /// - Parameter index: Index of the controller
    /// - Returns: UIViewController
    @objc private func didTapLeftSide(_ sender: UITapGestureRecognizer) {
        
            rewindSegment()
        }
        
        /// Handle tap on the right side to go to the next segment
    @objc private func didTapRightSide(_ sender: UITapGestureRecognizer) {
        
            skipSegment()
        }
    
    private func skipSegment() {
            if currentItemIndex < items.count - 1 {
//                currentItemIndex += 1
                segmentedProgressBar?.skip()
            }else{
                dismiss(animated: true, completion: nil)
            }
        }
        
        /// Rewind to the previous segment using SegmentedProgressBar's rewind()
        private func rewindSegment() {
            if currentItemIndex > 0 {
//                currentItemIndex -= 1
                segmentedProgressBar?.rewind()
            }else{
                dismiss(animated: true, completion: nil)
            }
        }
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let progress = translation.y / view.bounds.height
        
        switch gesture.state {
        case .changed:
            // Move the view down as per user's drag
            if translation.y > 0 {
                view.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            // If user has dragged enough, dismiss the view controller
            if progress > 0.3 {
                dismiss(animated: true, completion: nil)
            } else {
                // Return view to its original position if the gesture isn't strong enough
                UIView.animate(withDuration: 0.3) {
                    self.view.transform = .identity
                }
            }
        default:
            break
        }
    }
    

}

// MARK: UIPageViewControllerDataSource methods
extension CarouselViewController: SegmentedProgressBarDelegate {
    
    
    func segmentedProgressBarChangedIndex(index: Int) {
        currentItemIndex = index
        
        showCurrentViewController()
    }
    
    func segmentedProgressBarFinished() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
