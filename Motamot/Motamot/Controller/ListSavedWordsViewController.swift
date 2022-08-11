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
    static var cellIdentifier = "WordCell"
    let localDictionaryService = LocalDictionaryService()

    override func viewDidLoad() {
        super.viewDidLoad()
        localDictionaryService.fetchWords()
        checkIfDisplayMessage()
        tableView.dataSource = self
        tableView.delegate = self
        print("Hay \(localDictionaryService.favoriteWords.count) palabras ya guardadas")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        localDictionaryService.fetchWords()
        checkIfDisplayMessage()
        tableView.reloadData()
        print("Hay \(localDictionaryService.favoriteWords.count) palabras ya guardadas")
    }

    private func checkIfDisplayMessage() {
        if localDictionaryService.favoriteWords.isEmpty {
            noWordsView.isHidden = false
//            tableView.backgroundView = noWordsView
            // TODO: Display message.
        } else {
            // TODO: Do not display message
            noWordsView.isHidden = true
        }
    }
}
