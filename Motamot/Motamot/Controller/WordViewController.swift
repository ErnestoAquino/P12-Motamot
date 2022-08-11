//
//  WordViewController.swift
//  Motamot
//
//  Created by Ernesto Elias Aquino Cifuentes on 03/08/2022.
//

import UIKit
import AVFoundation

class WordViewController: UIViewController {

    @IBOutlet weak var wordTextLabel: UILabel!
    @IBOutlet weak var pronunciationTextLabel: UILabel!
    @IBOutlet weak var playPronunciationButton: UIButton!
    @IBOutlet weak var definitionTextView: UITextView!
    @IBOutlet weak var saveWordButton: UIBarButtonItem!

    private var localDictionaryService = LocalDictionaryService()
    var player: AVAudioPlayer?
    var localWord: LocalWord?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        isSaved(localWord?.word)
    }

    @IBAction func playPronunciationPressed(_ sender: UIButton) {
        playPronunciation()
    }

    @IBAction func saveWordButtonPressed(_ sender: UIBarButtonItem) {
        saveWord()
    }

    /**
     This method configures the properties of the visual elements.
     */
    private func configureView() {
 
        wordTextLabel.text = localWord?.word.uppercased()
        if localWord?.audio == nil {
            pronunciationTextLabel.isHidden = true
            playPronunciationButton.isHidden = true
        }
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

    /**
     This method plays the audio stored in the word structure.
     */
    private func playPronunciation() {
        if let player = player, player.isPlaying {
            playPronunciationButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            player.stop()
        } else {
            playPronunciationButton.setImage(UIImage(systemName: "stop.circle"), for: .normal)
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                guard let audioPronunciation = localWord?.audio else {return}
                player = try AVAudioPlayer(data: audioPronunciation)
                guard let player = player else {return}
                player.delegate = self
                player.play()
            } catch  {
                print("Something went wrong")
            }
        }
    }

    /**
     This method stores the word in the database. If it is called a second time it deletes it.
     */
    private func saveWord() {
        if saveWordButton.image == UIImage(systemName: "suit.heart") {
            saveWordButton.image = UIImage(systemName: "heart.fill")
            localDictionaryService.saveWord(localWord)
        } else {
            saveWordButton.image = UIImage(systemName: "suit.heart")
            if let wordToDelete =  localWord?.word {
                localDictionaryService.deleteWord(wordToDelete)
            }
        }
    }

    /**
     This method checks if the word is stored in the database.  If it already exists, it modifies the save word buton image so that the saveWordButton deletes the word if it is pressed.
     
     - parameter word: String of the word to be verified.
     */
    private func isSaved(_ word: String?) {
        if localDictionaryService.controlWord(localWord?.word) {
            saveWordButton.image = UIImage(systemName: "heart.fill")
        } else {
            saveWordButton.image = UIImage(systemName: "suit.heart")
        }
    }
}
