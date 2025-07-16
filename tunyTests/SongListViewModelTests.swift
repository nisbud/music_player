//
//  SongListViewModelTests.swift
//  tunyTests
//
//  Created by Anisa Budi Arthati on 17/07/25.
//

import XCTest
@testable import tuny

final class SongListViewModelTests: XCTestCase {
	
	func testQuerySongs_successfulFetch_populatesSongsAndCallsCompletion() {
		let mockService = MockSongService()
		mockService.generateMockResults()
		
		let viewModel = SongListViewModel(service: mockService)
		
		let expectDoneFetch = expectation(description: "onDoneFetch should be called")
		
		viewModel.onDoneFetch = {
			expectDoneFetch.fulfill()
		}
		
		viewModel.querySongs(query: "testQuery")
		
		wait(for: [expectDoneFetch], timeout: 1.0)
		
		XCTAssertFalse(viewModel.isFetching)
		XCTAssertEqual(viewModel.songs.count, 1)
		XCTAssertEqual(viewModel.songs.first?.title, "name1")
		XCTAssertEqual(mockService.queriedText, "testQuery")
	}
	
	func testQuerySongs_errorStillCallsCompletion() {
		let mockService = MockSongService()
		mockService.shouldReturnError = true
		
		let viewModel = SongListViewModel(service: mockService)
		
		let expectDoneFetch = expectation(description: "onDoneFetch should be called even on error")
		
		viewModel.onDoneFetch = {
			expectDoneFetch.fulfill()
		}
		
		viewModel.querySongs(query: "error")
		
		wait(for: [expectDoneFetch], timeout: 1.0)
		
		XCTAssertFalse(viewModel.isFetching)
		XCTAssertEqual(viewModel.songs.count, 0)
	}
	
	func testQuerySongs_doesNotRefetchIfAlreadyFetching() {
		let mockService = MockSongService()
		let viewModel = SongListViewModel(service: mockService)
		viewModel.isFetching = true
		
		viewModel.querySongs(query: "ignoredQuery")
		
		XCTAssertNil(mockService.queriedText, "Should not start new query if isFetching is true")
	}
}
