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
