//
//  SavedWordViewController.swift
//  Motamot
//
//  Created by Ernesto Elias on 11/08/2022.
//

import UIKit
import AVFoundation
import Mixpanel

class SavedWordViewController: UIViewController {

    @IBOutlet weak var wordTextLabel: UILabel!
    @IBOutlet weak var pronunciationTextLabel: UILabel!
    @IBOutlet weak var playPronunciationButton: UIButton!
    @IBOutlet weak var definitionTextView: UITextView!
    @IBOutlet weak var saveWordButton: UIBarButtonItem!

    private var localDictionaryService = LocalDictionaryService()
    var word: FavoriteWord?
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    @IBAction func playPronunciationPressed() {
        playPronunciation()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        deleteWord()
    }
    
    /**
     This method configures the properties of the visual elements.
     */
    private func configureView() {
        saveWordButton.image =  UIImage(systemName: "heart.fill")
        wordTextLabel.text = word?.word?.uppercased()

        if word?.audio == nil {
            pronunciationTextLabel.isHidden = true
            playPronunciationButton.isHidden = true
        }

        let formattedText =
        """
        Origin: \n\t• \(word?.origin ?? "---")\n
        Phonetics: \n\t• \(word?.phonetic ?? "---")\n
        Definition: \n\t• \(word?.definition ?? "---")\n
        Examples: \n\t• \(word?.examples ?? "---")\n
        Synonyms: \n\t• \(word?.synonyms ?? "---")\n
        Antonyms: \n\t• \(word?.antonyms ?? "---")\n
        Audio: \n\t• \(word?.audio?.description ?? "---")\n
        urlAudio:  \n\t• \(word?.urlAudio ?? "---")
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
                guard let audioPronunciation = word?.audio else {return}
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
     This method removes the word from the database.
     */
    private func deleteWord() {
        if saveWordButton.image == UIImage(systemName: "heart.fill") {
            localDictionaryService.deleteWord(word)
            Mixpanel.mainInstance().track(event: "Word has bee deleted")
            saveWordButton.image = UIImage(systemName: "suit.heart")
            saveWordButton.isEnabled = false
            saveWordButton.image = nil
        }
    }
}
