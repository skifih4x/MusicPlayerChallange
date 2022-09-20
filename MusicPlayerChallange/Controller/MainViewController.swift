//
//  ViewController.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 20.09.2022.
//

import UIKit

final class MainViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    private let compositionalLayout: UICollectionViewCompositionalLayout = {
        let inset: CGFloat = 8
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: inset, bottom: 0, trailing: inset)
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        section.orthogonalScrollingBehavior = .continuous
        
        // Supplementary Item - HEADER
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        headerItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: inset, bottom: 8, trailing: inset)
        section.boundarySupplementaryItems = [headerItem]
        
        // Decoration Item - BACKGROUND
        let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: "background")
        section.decorationItems = [backgroundItem]
        
        // Section Configuration
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        // Make UICollectionViewCompositionalLayout
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        layout.register(BackgroundDecorationView.self, forDecorationViewOfKind: "background")
        
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = compositionalLayout
    }

    
    // MARK: - Private Methods
    private func registerCells() {
        collectionView.register(UINib(nibName: "ContentCell", bundle: nil), forCellWithReuseIdentifier: "ContentCell")
        collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "ContentHeader")
    }

    
    
    
    
}

