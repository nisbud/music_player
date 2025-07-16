//
//  SongListViewModel.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import Foundation

final class SongListViewModel {
	
	var isFetching: Bool = false
	var onDoneFetch: (() -> Void)?
	
	private(set) var songs: [Song] = []
	private let service: SongServicable
	
	init(service: SongServicable = SongService.shared) {
		self.service = service
	}
	
//	func fetchSong(id: Int) {
//		isFetching = true
//		
//		service.fetchSong(id: id) { [weak self] result in
//			
//			switch result {
//			case .success(let sound):
//				let song = Song(from: sound)
//				self?.songs.append(song)
//				
//			case .failure(let error):
//				print("Error loading sound: \(error)")
//			}
//			
//			self?.isFetching = false
//			self?.onDoneFetch?()
//		}
//	}
	
	func querySongs(query: String) {
		
		guard !isFetching else {
			return
		}
		
		isFetching = true
		
		service.querySongs(query: query) { [weak self] result in
			
			switch result {
			case .success(let soundList):
				self?.songs = soundList.results.map({ sound in
					return Song(from: sound)
				})
				// No paging for now only take first page of result
				
			case .failure(let error):
				print("Error loading sound: \(error)")
			}
			
			self?.isFetching = false
			self?.onDoneFetch?()
		}
	}
}
