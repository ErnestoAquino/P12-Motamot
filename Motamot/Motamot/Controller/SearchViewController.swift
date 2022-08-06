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

    let dictionaryService = DictionaryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionaryService.viewDelegate = self

        searchButton.round()
        activityIndicator.isHidden = true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        wordTextField.resignFirstResponder()
    }

    @IBAction func searchButtonPressed() {
        dictionaryService.getDefinition(word: wordTextField.text)
    }
    
}

//MARK: -Extension
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

    func goToWordViewController() {
        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "WordViewController") as? WordViewController {
            let word = dictionaryService.myLocalWord
            destinationVC.localWord = word
            self.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }

//    func goToSearchResultViewController(recipes: [LocalRecipe], nextURL: String?) {
//        if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController {
//            let  recipeService = RecipeService(recipes: recipeService.listRecipes, nextRexipes: recipeService.nextRecipes)
//            destinationVC.recipeService = recipeService
//            self.navigationController?.pushViewController(destinationVC, animated: true)
//        }
//    }

}
