//
//  ListSavedWordViewControllerExtension.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 10/08/2022.
//

import Foundation
import UIKit

extension ListSavedWordsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = localDictionaryService.favoriteWords.count
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListSavedWordsViewController.cellIdentifier, for: indexPath) as? WordCellTableView else {
            return UITableViewCell()
        }
        let word = localDictionaryService.favoriteWords[indexPath.row].word
        cell.configureWord(word)
        return cell
    }
}

extension ListSavedWordsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SavedWordViewController") as? SavedWordViewController {
            vc.word = localDictionaryService.favoriteWords[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ListSavedWordsViewController {
    /**
     This function requests confirmation from the user to delete the stored words. If the user confirms then they are deleted..
     */
    func requestConfirmationForRemoveWordsSaved() {
        let messageAlert = "This action will delete all saved words.\n Do you want continue?"
        let alert = UIAlertController.init(title: "Hi!", message: messageAlert, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .destructive) { _ in
            self.localDictionaryService.clearFavorites()
            self.tableView.reloadData()
            self.checkIfDisplayMessage()
            self.checkIfFavoriteListEmpty()
        }
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel)
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
}

