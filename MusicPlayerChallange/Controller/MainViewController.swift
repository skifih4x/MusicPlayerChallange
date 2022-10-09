//
//  ViewController.swift
//  MusicPlayerChallange
//
//  Created by Артем Орлов on 20.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    let manager = MusicManager()
    var collId = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = layout
        registerCells()
        manager.performRequest()
        print(collId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? AlbumViewController else { return }
        destVC.almobeLabelText = collId
    }
    let layout: UICollectionViewCompositionalLayout = {
        
        let inset: CGFloat = 2.5
        
        //Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        
        //Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.4))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        //Section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        // Supplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        // Section Configuration
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        
        return UICollectionViewCompositionalLayout(section: section, configuration: config)
    }()
    
    // MARK: - Private Methods
    private func registerCells() {
        collectionView.register(UINib(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderView")
        collectionView.register(UINib(nibName: C.mainScreenCell, bundle: nil), forCellWithReuseIdentifier: C.mainScreenCell)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 2 ? 15 : 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCell", for: indexPath) as? ContentCell else { return  UICollectionViewCell() }
        
        switch indexPath.section {
        case 0:
            NetworkFetch.shared.albumeFetchRammstein { result in
                print(result)
                switch result {
                case .success(let success):
                    cell.configure(albumeModel: success.results[indexPath.item])
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        default:
            NetworkFetch.shared.albumeFetchSystem { result in
                print(result)
                switch result {
                case .success(let success):
                    cell.configure(albumeModel: success.results[indexPath.item])
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        
        view.title = indexPath.section == 1 ? "Music to listen" : "Recently viewed"
        return view
    }
    
  
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
//        self.navigationController?.pushViewController(vc!, animated: true)
        switch indexPath.section {
        case 0:
            NetworkFetch.shared.albumeFetchRammstein { result in
                print(result)
                switch result {
                case .success(let success):
                    self.collId =  "https://itunes.apple.com/lookup?id=\(success.results[indexPath.row].collectionId)&entity=song"
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        default:
            NetworkFetch.shared.albumeFetchSystem { result in
                print(result)
                switch result {
                case .success(let success):
                    print(success.results[indexPath.row].collectionId)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        performSegue(withIdentifier: "ShowDetailsAlbum", sender: nil)
        
    }
}
