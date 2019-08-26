//
//  ChangeCityViewController.swift
//  Clima - WeatherApp
//
//  Created by Guy Yasinover on 04/09/2015.
//  Copyright Guy Yasinover. All rights reserved.
//

import UIKit
import Alamofire
import GooglePlaces

//Write the protocol declaration here:
protocol ChangeCityViewControllerDelegate : class {
    func changeCityViewController(_ controller : ChangeCityViewController, didSelectCity city : String)
}


class ChangeCityViewController: UIViewController, GMSAutocompleteResultsViewControllerDelegate, UITableViewDelegate{
    
    //Declare the delegate variable here:
    weak var delegate : ChangeCityViewControllerDelegate?
    //@IBOutlet weak var resultsSearchTableView: UITableView!
    
    var searchHistoryArray : [GMSAutocompleteResultsViewController] = []
    
    //This is the pre-linked IBOutlets to the text field:
    //@IBOutlet weak var changeCitySearchBar: UISearchBar!
    //@IBOutlet weak var searchBarContainer : UIView!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    
    
    // Create UserDefaults
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftBarButtonItem()
        setupAutoComplete()
        
/*        searchHistoryArray = defaults.array(forKey: "searchHistoryArray") as! [GMSAutocompleteResultsViewController] */
    }
    
    //convert the left bar button item to an image
    func leftBarButtonItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "left"), style: .done, target: self, action: #selector(backAction(_:)))
    }
    
    //MARK: - Google Places
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
        
    }
    
    //Animate when the back button was pressed
    @objc func backAction(_ sender : Any){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UITableViewDelegateMethods
/*    private func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) -> GMSAutocompleteResultsViewController {

        searchHistoryTableView.dequeueReusableCell(withIdentifier: "searchCell")

        return resultVC!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
 */
    
    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    @IBAction func getWeatherPressed(_ sender: AnyObject) {
        
//        //1 Get the city name the user entered in the text field
//        let cityName = changeCitySearchBar.text!
//
//        //2 If we have a delegate set, call the method userEnteredANewCityName
//        delegate?.userEnteredANewCityName(city: cityName)

        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.navigationController?.popViewController(animated: true)
        
        
/*        self.searchHistoryArray.append(self.resultVC!)

        // Save String value to UserDefaults
        self.defaults.set(self.searchHistoryArray, forKey: "searchHistoryArray")

        self.searchHistoryTableView.reloadData()
*/    }
    
    
    
    //MARK: - GMSAutocompleteResultsViewControllerDelegate
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
        if let city = place.addressComponents?.first(where: { $0.types.contains("locality") })?.name{
            delegate?.changeCityViewController(self, didSelectCity: city)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
        // TODO: Handle the error
        print("Error: \(error)")
    }
    
    
    
}

//extension ChangeCityViewController: GMSAutocompleteResultsViewControllerDelegate{
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
//        if let city = place.addressComponents?.first(where: { $0.types.contains("locality") })?.name{
//            delegate?.changeCityViewController(self, didSelectCity: city)
//        }
//        self.navigationController?.popViewController(animated: true)
//    }
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didFailAutocompleteWithError error: Error) {
//        print("Error: \(error)")
//    }
//
//}


