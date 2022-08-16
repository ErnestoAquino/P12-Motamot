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
        isFavoriteListEmpty()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localDictionaryService.fetchWords()
        checkIfDisplayMessage()
        isFavoriteListEmpty()
        tableView.reloadData()
    }
    @IBAction func clearFavoriteWords(_ sender: UIBarButtonItem) {
        clearFavoriteWords()
    }
    
    private func checkIfDisplayMessage() {
        if localDictionaryService.favoriteWords.isEmpty {
            noWordsView.isHidden = false
        } else {
            noWordsView.isHidden = true
        }
    }

    private func isFavoriteListEmpty() {
        if localDictionaryService.favoriteWords.isEmpty {
            clearFavoritesBarButton.isEnabled = false
            clearFavoritesBarButton.image = nil
        } else {
            clearFavoritesBarButton.isEnabled = true
            clearFavoritesBarButton.image = UIImage(systemName: "trash")
        }
    }

    private func clearFavoriteWords() {
        localDictionaryService.clearFavorites()
        tableView.reloadData()
        checkIfDisplayMessage()
        isFavoriteListEmpty()
    }
}
