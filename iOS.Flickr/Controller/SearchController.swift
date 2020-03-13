//
//  SearchController.swift
//  iOS.Flickr
//
//  Created by Aleksandr Kurdiukov on 07.03.20.
//  Copyright © 2020 Zizlak. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    
    // MARK: - Private Properties
    private let scElements = SC_Elements()
    private var cameras: [CurrentCamera] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var timer: Timer?
    private var activityIndicator = UIActivityIndicatorView()
    private let errorLabel = UILabel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    private func stateSetup(stateOfSearch: SC_Elements.state){
        scElements.setupState(label: errorLabel, activityIndicator: activityIndicator, stateOfSearch: stateOfSearch)
    }
    
    // MARK: - View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        scElements.setupActivityIndicator(activityIndicator: &activityIndicator, vc: self)
        scElements.setupErrorLabel(label: errorLabel, vc: self)
        self.stateSetup(stateOfSearch: .textFieldIsEmpty)
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Navigation Bar
    
    private func setupNavigationBar() {
        navigationItem.title = "Search camera"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Type any camera brand"
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cameras.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let camera = cameras[indexPath.row]
        
        if !camera.details.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellLarge", for: indexPath) as! TableViewCellLarge
            cell.setCell(camera: camera)
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellSmall", for: indexPath) as! TableViewCellSmall
            cell.setCell(camera: camera)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cameras[indexPath.row].details.isEmpty ? 80 : 120
    }
}

// MARK: - SearchController: TextDidChange

extension SearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.stateSetup(stateOfSearch: .searching)
            NetworkService.fetchCameras(camera: searchText, activityIndicator: self.activityIndicator){ [weak self] (searchResults) in
                
                self?.cameras = searchResults ?? []
                
                if searchResults!.isEmpty {
                    searchText.isEmpty ? self!.stateSetup(stateOfSearch: .textFieldIsEmpty) : self!.stateSetup(stateOfSearch: .nothingWasFound)
                } else {
                    self!.stateSetup(stateOfSearch: .succeed)
                }
            }
        }
        )
    }
}
