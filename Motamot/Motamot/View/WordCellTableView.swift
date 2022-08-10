//
//  WordCellTableView.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 10/08/2022.
//

import UIKit

class WordCellTableView: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureWord(_ word: String?) {
        wordLabel.text = word
    }

}
