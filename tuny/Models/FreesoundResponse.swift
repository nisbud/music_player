//
//  FreesoundResponse.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 16/07/25.
//

import Foundation

struct FreesoundPreviews: Codable {
	let previewHqMp3: String?
	let previewLqMp3: String?
	
	enum CodingKeys: String, CodingKey {
		case previewHqMp3 = "preview-hq-mp3"
		case previewLqMp3 = "preview-lq-mp3"
	}
}

struct WaveImages: Codable {
	let waveformLarge: String?
	let waveformMedium: String?
	let spectralLarge: String?
	let spectralMedium: String?
	
	enum CodingKeys: String, CodingKey {
		case waveformLarge = "waveform_l"
		case waveformMedium = "waveform_m"
		case spectralLarge = "spectral_l"
		case spectralMedium = "spectral_m"
	}
}

struct FreesoundSoundResponse: Codable {
	let id: Int
	let name: String
	let username: String
	let duration: Double
	let description: String
	let previews: FreesoundPreviews
	let images: WaveImages
}

struct FreesoundQueryResponse: Codable {
	let count: Int
	let next: String?
	let results: [FreesoundSoundResponse]
	let previous: String?
}
