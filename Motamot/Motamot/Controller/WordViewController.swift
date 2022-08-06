//
//  WordViewController.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 03/08/2022.
//

import UIKit

class WordViewController: UIViewController {

    @IBOutlet weak var wordTextLabel: UILabel!
    @IBOutlet weak var pronunciationTextLabel: UILabel!
    @IBOutlet weak var playPronunciationButton: UIButton!
    @IBOutlet weak var definitionTextView: UITextView!

    var localWord: LocalWord?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playPronunciationPressed(_ sender: UIButton) {
    }

}
