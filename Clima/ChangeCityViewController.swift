//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlaces

//Write the protocol declaration here:
protocol ChangeCityViewControllerDelegate : class {
    func changeCityViewController(_ controller : ChangeCityViewController, didSelectCity city : String)
}


class ChangeCityViewController: UIViewController {
    
    //Declare the delegate variable here:
    weak var delegate : ChangeCityViewControllerDelegate?
    
    
    //This is the pre-linked IBOutlets to the text field:
    //@IBOutlet weak var changeCitySearchBar: UISearchBar!
    @IBOutlet weak var searchBarContainer : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //convert the left bar button item to an image
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left"), style: .done, target: self, action: #selector(backAction(_:)))

        setupAutoComplete()
    }
    
    var resultVC : GMSAutocompleteResultsViewController?
    var searchController : UISearchController?
    
    private func setupAutoComplete(){
        let resultVC = GMSAutocompleteResultsViewController()
        resultVC.delegate = self
        
        let searchController = UISearchController(searchResultsController: resultVC)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        
        searchController.searchBar.autoresizingMask = .flexibleWidth
        searchController.searchBar.searchBarStyle = .minimal
        
        
        searchController.searchBar.sizeToFit()
        
        navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        
        searchController.modalPresentationStyle = .fullScreen
        
        searchController.searchResultsUpdater = resultVC
        
        self.searchController = searchController
        self.resultVC = resultVC
        
//        searchBarContainer.addSubview(searchController.searchBar)
//
//        [
//            searchController.searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
//            searchController.searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
//            searchController.searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
//            searchController.searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor)
//            ].forEach{ $0.isActive = true }
//

        
    }
    
    //Animate when the back button was pressed
    @objc func backAction(_ sender : Any){
        navigationController?.popViewController(animated: true)
    }
    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
        //1 Get the city name the user entered in the text field
//        let cityName = changeCitySearchBar.text!
//
//        //2 If we have a delegate set, call the method userEnteredANewCityName
//        delegate?.userEnteredANewCityName(city: cityName)

        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
    
    
    
}

extension ChangeCityViewController: GMSAutocompleteResultsViewControllerDelegate{
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        if let city = place.addressComponents?.first(where: { $0.types.contains("locality") })?.name{
            delegate?.changeCityViewController(self, didSelectCity: city)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        
    }
    
    
}
