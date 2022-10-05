//
//  CMTime + Extention.swift
//  MusicPlayerChallange
//
//  Created by Марк Михайлов on 03.10.2022.
//

import Foundation
import AVKit

extension CMTime {
    func toDisplayString () -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totatSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totatSeconds % 60
        let minutes = totatSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
        
    }
}
