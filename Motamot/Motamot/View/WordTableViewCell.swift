//
//  WordTableViewCell.swift
//  Motamot
//
//  Created by Ernesto Elias on 06/08/2022.
//

import UIKit

class WordTableViewCell: UITableViewCell {
    @IBOutlet weak var wordUILabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configuration (_ word: String?) {
        wordUILabel.text = word
    }
}
