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
        playPronunciationButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
    }
}
