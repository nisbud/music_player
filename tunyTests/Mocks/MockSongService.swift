//
//  MockSongService.swift
//  tunyTests
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import Foundation
@testable import tuny

final class MockSongService: SongServicable {
	var shouldReturnError = false
	var queriedText: String?
	var mockResults: [FreesoundSoundResponse] = []
	
	func querySongs(query: String, completion: @escaping (Result<FreesoundQueryResponse, Error>) -> Void) {
		queriedText = query
		if shouldReturnError {
			completion(.failure(NSError(domain: "TestError", code: 0)))
		} else {
			completion(.success(FreesoundQueryResponse.init(count: mockResults.count, next: "", results: mockResults, previous: "")))
		}
	}
	
	func generateMockResults() {
		mockResults = [
			FreesoundSoundResponse(id: 1, name: "name1", username: "username1", duration: 1.0, description: "desc1",
								   previews: FreesoundPreviews(previewHqMp3: "previewHq", previewLqMp3: "previewLq"),
								   images: WaveImages(waveformLarge: "wfL", waveformMedium: "wfM", spectralLarge: "sL", spectralMedium: "sM"))
		]
	}
}
