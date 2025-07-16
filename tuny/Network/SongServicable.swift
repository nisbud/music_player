//
//  SongServicable.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import Foundation

protocol SongServicable {
	
	func querySongs(query: String, completion: @escaping (Result<FreesoundQueryResponse, Error>) -> Void)
}

