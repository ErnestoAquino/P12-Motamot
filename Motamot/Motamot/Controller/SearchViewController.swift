//
//  SearchViewController.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 26/07/2022.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchButton.round()
    }

    @IBAction func searchButtonPressed() {
    }
    
}

//MARK: -Extension
extension SearchViewController: SearchDelegate {
    /**
 This function displays an alert to user.
 
 - parameter message: String with the message to be display in the alert.
 */
    func warningMessage(_ message: String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }

}
