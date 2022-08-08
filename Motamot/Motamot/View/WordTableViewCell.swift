//
//  WordTableViewCell.swift
//  Motamot
//
//  Created by Ernesto Elias on 06/08/2022.
//

import UIKit

class WordTableViewCell: UITableViewCell {

    @IBOutlet weak var definitionTextView: UITextView!
    @IBOutlet weak var pronuciationLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!

    private var pronunciationSound: Data?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func playButtonPressed(_ sender: Any) {
        //TODO: La aplicacion va a mostrar los datos del audio."
        print(pronunciationSound ?? "No data")
    }

    func configuration (_ word: LocalWord?) {
        definitionTextView.text = word?.definition
        if word?.audio != nil {
            pronunciationSound = word?.audio
        }
    }
}
