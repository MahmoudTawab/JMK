//
//  FPNCountryListViewController.swift
//  FlagPhoneNumber
//
//  Created by Aurélien Grifasi on 06/08/2017.
//  Copyright (c) 2017 Aurélien Grifasi. All rights reserved.
//

import UIKit


open class FPNCountryListViewController: UITableViewController, UISearchResultsUpdating, UISearchControllerDelegate {

    open var repository: FPNCountryRepository?
    open var showCountryPhoneCode: Bool = true
    open var searchController: UISearchController = UISearchController(searchResultsController: nil)
    open var didSelect: ((FPNCountry) -> Void)?

    var results: [FPNCountry]?

    override open func viewDidLoad() {
        super.viewDidLoad()
    

        tableView.tableFooterView = UIView()

        tableView.backgroundColor = .white
        initSearchBarController()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black ,.font: UIFont(name: "Raleway-BoldItalic", size: ControlWidth(15)) ?? UIFont.systemFont(ofSize: ControlWidth(15))]
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    open func setup(repository: FPNCountryRepository) {
        self.repository = repository
    }

    private func initSearchBarController() {
        searchController.searchResultsUpdater = self
        searchController.delegate = self
            
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.tintColor = .black
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundColor = .white
        searchController.searchBar.keyboardAppearance = .light
        searchController.searchBar.barStyle = .black
        
        searchController.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }

    private func getItem(at indexPath: IndexPath) -> FPNCountry {
        if searchController.isActive && results != nil && results!.count > 0 {
            return results![indexPath.row]
        } else {
            return repository!.countries[indexPath.row]
        }
    }

    override open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            if let count = searchController.searchBar.text?.count, count > 0 {
                return results?.count ?? 0
            }
        }
        return repository?.countries.count ?? 0
    }

    override open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let country = getItem(at: indexPath)

        cell.imageView?.image = country.flag
        cell.textLabel?.text = country.name
        
        cell.backgroundColor = .white

        tableView.rowHeight = ControlWidth(50)
        
        if showCountryPhoneCode {
            cell.detailTextLabel?.text = country.phoneCode
        }
        cell.textLabel?.font = UIFont.systemFont(ofSize: ControlWidth(17))
        cell.textLabel?.textColor = .black
        
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: ControlWidth(17))
        cell.detailTextLabel?.textColor = .black
        
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
        cell.imageView?.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor , constant: ControlX(10)).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: ControlWidth(30)).isActive = true
        cell.imageView?.heightAnchor.constraint(equalToConstant: ControlWidth(24)).isActive = true
        
        cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
        cell.textLabel?.leadingAnchor.constraint(equalTo: cell.leadingAnchor ,constant: ControlWidth(55)).isActive = true
        cell.textLabel?.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
    
        cell.accessoryType = index == getItem(at: indexPath).name ? .checkmark:.none
        return cell
    }

    
    var index = String()
    override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = getItem(at: indexPath)
        index = country.name
        
        tableView.deselectRow(at: indexPath, animated: true)

        didSelect?(country)

        searchController.isActive = false
        searchController.searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }

    // UISearchResultsUpdating

    open func updateSearchResults(for searchController: UISearchController) {
        guard let countries = repository?.countries else { return }

        if countries.isEmpty {
            results?.removeAll()
            return
        } else if searchController.searchBar.text == "" {
            results?.removeAll()
            tableView.reloadData()
            return
        }

        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            results = countries.filter({(item: FPNCountry) -> Bool in
                if item.name.lowercased().range(of: searchText.lowercased()) != nil {
                    return true
                } else if item.code.rawValue.lowercased().range(of: searchText.lowercased()) != nil {
                    return true
                } else if item.phoneCode.lowercased().range(of: searchText.lowercased()) != nil {
                    return true
                }
                return false
            })
        }
        tableView.reloadData()
    }

    // UISearchControllerDelegate

    open func willDismissSearchController(_ searchController: UISearchController) {
        results?.removeAll()
    }
}


func ControlWidth(_ ControlW:CGFloat) -> CGFloat {
let width = 375.0
let widthRat:CGFloat = UIScreen.main.bounds.width / CGFloat(width)
let W = ControlW * widthRat
return W
}

func ControlX(_ ControlX:CGFloat) -> CGFloat {
let width = 375.0
let widthRat:CGFloat = UIScreen.main.bounds.maxX / CGFloat(width)
let X = ControlX * widthRat
return X
}
