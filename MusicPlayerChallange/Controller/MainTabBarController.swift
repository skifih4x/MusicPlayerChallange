//
//  MainTabBarController.swift
//  IMusic
//
//  Created by Алексей Пархоменко on 11/08/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol MainTabBarControllerDelegate: AnyObject {
    func minimazeTrackDetailController()
    func maximazeTrackDetailController(viewModel: Tracks?)
}

class MainTabBarController: UITabBarController {
    
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    let searchVC: SearchViewController = SearchViewController()
    let trackDetailsView = Bundle.main.loadNibNamed("TrackDetailView", owner: MainTabBarController.self)?.first as! TrackDetalViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrack()
        
        searchVC.tabBarDelegate = self
    }

    
    func setupTrack() {
        

        trackDetailsView.backgroundColor = .green
        trackDetailsView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailsView.tabBarDelegate = self
//        trackDetailsView.delegate = searchVC
        
        view.insertSubview(trackDetailsView, belowSubview: tabBar)
        
        //use auto layout
        
        maximizedTopAnchorConstraint = trackDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        minimizedTopAnchorConstraint = trackDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64)
        bottomAnchorConstraint = trackDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true
        
        maximizedTopAnchorConstraint.isActive = true
//        trackDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        trackDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        trackDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
    }
}

extension MainTabBarController: MainTabBarControllerDelegate {
    
    func maximazeTrackDetailController(viewModel: Tracks?) {
        
        maximizedTopAnchorConstraint.isActive = true
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.constant = 0
        bottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations:  {
            self.view.layoutIfNeeded()
        })
        
        guard let viewModel = viewModel else { return }
        trackDetailsView.set(viewModel: viewModel)
    }
    
    func minimazeTrackDetailController() {
        
        maximizedTopAnchorConstraint.isActive = false
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations:  {
            self.view.layoutIfNeeded()
        })
    }
    
    
}
