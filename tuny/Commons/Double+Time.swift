//
//  Double+Time.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import Foundation

extension Double {
	
	func asTime() -> String {
		let totalSeconds = Int(self)
		let hours = totalSeconds / 3600
		let minutes = (totalSeconds % 3600) / 60
		let secs = totalSeconds % 60
		
		if hours > 0 {
			return String(format: "%d:%02d:%02d", hours, minutes, secs)
		} else {
			return String(format: "%d:%02d", minutes, secs)
		}
	}
}
