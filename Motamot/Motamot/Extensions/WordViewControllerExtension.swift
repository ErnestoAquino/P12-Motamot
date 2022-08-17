//
//  WordViewControllerExtension.swift
//  Motamot
//
//  Created by Ernesto Elias on 09/08/2022.
//

import Foundation
import UIKit
import AVFoundation

extension WordViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer , successfully flag: Bool) {
//      When the audio has finished playing.
//      the image of the playPronunciation button is changed.
        playPronunciationButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
    }
}
