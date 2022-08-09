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

    var localWord: LocalWord?
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @IBAction func playPronunciationPressed(_ sender: UIButton) {
        playPronunciation()
    }

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

    private func playPronunciation() {
        if let player = player, player.isPlaying {
            //Stop playing
            playPronunciationButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            player.stop()
        } else {
            // set up and play
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
}

//MARK: - Extensio
//
//extension WordViewController: AVAudioPlayerDelegate {
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer , successfully flag: Bool) {
//        playPronunciationButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
//    }
//}
