//
//  SongService.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 16/07/25.
//

import Foundation

final class SongService {
	static let shared = SongService()
	
	func querySongs(query: String, completion: @escaping (Result<FreesoundQueryResponse, Error>) -> Void) {
		guard let url = Constants.getSearchURL(query: query) else {
			completion(.failure(NSError(domain: "bad_url", code: 0)))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				completion(.failure(NSError(domain: "no_data", code: 0)))
				return
			}
			
			do {
				let song = try JSONDecoder().decode(FreesoundQueryResponse.self, from: data)
				completion(.success(song))
			} catch {
				completion(.failure(error))
			}
		}.resume()
	}
	
//	func fetchSong(id: Int, completion: @escaping (Result<FreesoundSoundResponse, Error>) -> Void) {
//		let songId: String = String(id)
//		guard let url = Constants.getSongURL(id: songId) else {
//			completion(.failure(NSError(domain: "bad_url", code: 0)))
//			return
//		}
//		
//		URLSession.shared.dataTask(with: url) { data, response, error in
//			if let error = error {
//				completion(.failure(error))
//				return
//			}
//			
//			guard let data = data else {
//				completion(.failure(NSError(domain: "no_data", code: 0)))
//				return
//			}
//			
//			do {
//				let song = try JSONDecoder().decode(FreesoundSoundResponse.self, from: data)
//				completion(.success(song))
//			} catch {
//				completion(.failure(error))
//			}
//		}.resume()
//	}
}
