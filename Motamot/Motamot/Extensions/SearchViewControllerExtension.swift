//
//  SearchViewControllerExtension.swift
//  Motamot
//
//  Created by Ernesto Elias on 06/08/2022.
//

import Foundation
import UIKit
import Mixpanel

//MARK: -This extension conforms the SearchViewController class with the SearchDelegate protocol.
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

// Methode for got to word view controlller.
    func goToWordViewController() {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "WordViewController") as? WordViewController {
            let word = dictionaryService.myLocalWord
            destinationVC.localWord = word
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}

//MARK: - This extension conforms the SearchViewController class with the UITextFieldDelegate protocol.
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Defines the behavior of the keyboard search key.
        dictionaryService.getDefinition(word: wordTextField.text)
        wordTextField.resignFirstResponder()
        Mixpanel.mainInstance().track(event: "Keyboard for search")
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Allows hide the keyboard when touching the screen.
        self.wordTextField.resignFirstResponder()
    }
}

//MARK: - This extension conforms the SearchViewController class with the UITableViewDataSource protocol.
extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numbersOfRows = dictionaryService.wordsSearched.count
        return numbersOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WordCelling", for: indexPath) as? WordTableViewCell else {
            return UITableViewCell()
        }
        let word = dictionaryService.wordsSearched[indexPath.row].word
        cell.configuration(word)
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Search history"
    }
}

//MARK: - This extension conforms the SearchViewController class with the UITableViewDelegate protocol.
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "WordViewController") as? WordViewController {
            destinationVC.localWord = dictionaryService.wordsSearched[indexPath.row]
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dictionaryService.wordsSearched.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - Extension  SearchViewController class
extension SearchViewController {
    /**
     This function checks if the user help message should be displayed.
     If the list is empty it will be displayed.
     */
    func checkIfDisplayMessage() {
        if dictionaryService.wordsSearched.isEmpty {
            tableView.isHidden = true
        } else {
            tableView.isHidden = false
        }
    }
}
