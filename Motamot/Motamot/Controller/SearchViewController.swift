//
//  SearchViewController.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 26/07/2022.
//

import UIKit
import Mixpanel

class SearchViewController: UIViewController {

    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    static var cellidentifier = "WordCell"
    
    let dictionaryService = DictionaryService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dictionaryService.viewDelegate = self
        self.wordTextField.delegate = self

        searchButton.round()
        activityIndicator.isHidden = true
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        wordTextField.resignFirstResponder()
    }

    @IBAction func searchButtonPressed() {
        dictionaryService.getDefinition(word: wordTextField.text)
        Mixpanel.mainInstance().track(event: "Button search pressed")
    }
}
