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
        configureView()
    }

    @IBAction func playPronunciationPressed(_ sender: UIButton) {
        print("Donde estoy?")
    }

    private func configureView() {
        wordTextLabel.text = localWord?.word.uppercased()
        
//        if localWord?.audio == nil {
//            pronunciationTextLabel.isHidden = true
//            playPronunciationButton.isHidden = true
//        }
        let formattedText =
        """
        Origin: \n\t• \(localWord?.origin ?? "---")\n
        Phonetics: \n\t• \(localWord?.phonetic ?? "---")\n
        Definition: \n\t• \(localWord?.definition ?? "---")\n
        Examples: \n\t• \(localWord?.examples ?? "---")\n
        Synonyms: \n\t• \(localWord?.synonyms ?? "---")\n
        Antonyms: \n\t• \(localWord?.antonyms ?? "---")\n
        Audio: \n\t• \(localWord?.audio?.description ?? "---")\n
        urlAudio:  \n\t• \(localWord?.urlAudio ?? "---")
        """
        definitionTextView.text = formattedText
    }

}
