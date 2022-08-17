//
//  ListSavedWordsViewController.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 10/08/2022.
//

import UIKit

class ListSavedWordsViewController: UIViewController {

    @IBOutlet weak var noWordsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clearFavoritesBarButton: UIBarButtonItem!
    
    static var cellIdentifier = "WordCell"
    let localDictionaryService = LocalDictionaryService()

    override func viewDidLoad() {
        super.viewDidLoad()
        localDictionaryService.fetchWords()
        checkIfDisplayMessage()
        checkIfFavoriteListEmpty()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localDictionaryService.fetchWords()
        checkIfDisplayMessage()
        checkIfFavoriteListEmpty()
        tableView.reloadData()
    }
    @IBAction func clearFavoriteWords(_ sender: UIBarButtonItem) {
        clearFavoriteWords()
    }
    
    /**
     This function checks if the user help message should be displayed.
     If the list is empty it will be displayed.
     */
    private func checkIfDisplayMessage() {
        if localDictionaryService.favoriteWords.isEmpty {
            noWordsView.isHidden = false
        } else {
            noWordsView.isHidden = true
        }
    }

    /**
     This function checks if there are items in the favorites list.
     If there are items it displays the button: trash
     which allows you to delete the entire list.
     */
    private func checkIfFavoriteListEmpty() {
        if localDictionaryService.favoriteWords.isEmpty {
            clearFavoritesBarButton.isEnabled = false
            clearFavoritesBarButton.image = nil
        } else {
            clearFavoritesBarButton.isEnabled = true
            clearFavoritesBarButton.image = UIImage(systemName: "trash")
        }
    }

    /**
     This function clears the list of words saved in favorites.
     */
    private func clearFavoriteWords() {
        localDictionaryService.clearFavorites()
        tableView.reloadData()
        checkIfDisplayMessage()
        checkIfFavoriteListEmpty()
    }
}
