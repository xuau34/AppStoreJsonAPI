//
//  AppsSearchControllerCollectionViewController.swift
//  AppStoreJsonAPI
//
//  Created by 李宓2號 on 2020/7/10.
//  Copyright © 2020 Mia. All rights reserved.
//

import UIKit


class AppsSearchController: BaseCollectionViewController, UISearchBarDelegate {
    
    func handleAppResults(results: JsonAppResults?, err: Error?) {
        if let err = err {
            print("Failed on fetching feed:", err)
            return
        }
        guard let results = results else {return}
        DispatchQueue.main.async {
            self.apps = results.results
            self.collectionView.reloadData()
        }
    }
    
    
    private var apps: [JsonApp]?
    private let cellId = "AppsSearchControllerCellId"
    
    private let searchController = UISearchController()
    private var searchBarTimer: Timer?
    private let reminderLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        setupSearchbar()
        
        collectionView.addSubview(reminderLabel)
        reminderLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reminderLabel.isHidden = (apps?.count ?? 0) > 0
        return apps?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.app = apps?[indexPath.item] // better use .item in collectionView
        return cell
    }
    
    // this is optional function
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return .init(width: view.frame.width, height: 330)
    }
    
    private func setupSearchbar() {
        navigationItem.searchController = self.searchController
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
    }
    
    /*
    // It still could fire multiple tasks, which will result in unmatch of the list and the search term
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTimer?.invalidate()
        searchBarTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {
            _ in
            Service.shared.fetchITunesApps(term: searchText, completion: self.handleAppResults(results:))
        })
    }
     */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        Service.shared.fetchITunesApps(term: searchText, completion: self.handleAppResults)
    }
}
