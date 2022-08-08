//
//  SearchViewControllerExtension.swift
//  Motamot
//
//  Created by Ernesto Elias on 06/08/2022.
//

import Foundation
import UIKit


extension SearchViewController: SearchDelegate {

    /**
 This function displays an alert to user.
 
 - parameter message: String with the message to be display in the alert.
 */
    func warningMessage(_ message: String) {
        let alert: UIAlertController = UIAlertController(title: "Hi!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }

    /**
     This button shows (or hides) the activity indicator.
     
     - parameter value: True to show. False to hide.
     */
    func showActivityIndicator(_ value: Bool) {
        searchButton.isHidden = value
        activityIndicator.isHidden = !value
    }

// Methode for got to new controlller.
//TODO: Este metodo podria ser eliminado mas adelante
    func goToWordViewController() {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "WordViewController") as? WordViewController {
            let word = dictionaryService.myLocalWord
            destinationVC.localWord = word
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

    /**
     Reloads the row  of the table view.
     */
    func reloadTableView() {
        tableView.reloadData()
    }
}

//extension SearchViewController: UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//}
