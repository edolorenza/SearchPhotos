//
//  ViewController.swift
//  PhotoSearch
//
//  Created by Edo Lorenza on 18/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    private var results = [Result]()
    private var viewModel = [PhotosCellViewModel]()
    private let photosCellIdentifier = "PhotosCell"
    private var searchController = UISearchController()
    private let searchBar = UISearchBar()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.register(PhotosCell.self, forCellWithReuseIdentifier: photosCellIdentifier)
        return cv
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search Image"
        view.addSubview(collectionView)
        collectionView.fillSuperview()
        configureSearchController()
    }

    
    //MARK: - Helpers
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosCellIdentifier, for: indexPath) as! PhotosCell
        let resultUrl = results[indexPath.row].urls.small
        cell.viewModel = PhotosCellViewModel(result: resultUrl)
        return cell
    }
}


//MARK: - UISearchResultUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        APICaller.shared.fetchPhotos(query: searchText) { results in
            if results.count > 0 {
                DispatchQueue.main.async {
                    self.results = results
                }
            }
        }
        self.collectionView.reloadData()
    }
   
}

//MARK: -UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width - 8) / 2
        return CGSize(width: width, height: width)
    }
}

