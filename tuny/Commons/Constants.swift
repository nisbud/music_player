//
//  Constants.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 16/07/25.
//

import Foundation

final class Constants {
	static let freesoundApiKey: String = "fPFEcUirFEQaWMkcLao4jpDv6ab6sIIVMPgTOq8k"
	static let freesoundBaseURL: String = "https://freesound.org/apiv2"
	static let searchPath: String = "/search/text/?query="
	static let songPath: String = "/sounds/"
	static let tokenComponent: String = "token="
	static let fieldsQuery: String = "&fields=id,name,username,duration,description,previews,images"
	
	static func getSearchURL(query: String) -> URL? {
		return URL(string: "\(freesoundBaseURL)\(searchPath)\(query)&\(tokenComponent)\(freesoundApiKey)\(fieldsQuery)")
	}
	
	static func getSongURL(id: String) -> URL? {
		return URL(string: "\(freesoundBaseURL)\(songPath)\(id)/?\(tokenComponent)\(freesoundApiKey)")
	}
}
