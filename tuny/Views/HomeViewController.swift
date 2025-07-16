//
//  HomeViewController.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

final class HomeViewController: UIViewController, UISearchBarDelegate {
	
	private let searchBar = UISearchBar()
	private let tableView = SongTableView(viewModel: SongListViewModel())
	private var musicControllerView = MusicControllerView()
	private var musicControllerBottomConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Tuny Player"
		
		setupSearchBar()
		setupTableView()
		setupMusicController()
	}
	
	private func setupSearchBar() {
		searchBar.placeholder = "Search"
		searchBar.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(searchBar)
		
		NSLayoutConstraint.activate([
			searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	
	private func setupTableView() {
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func setupMusicController() {
		musicControllerView.translatesAutoresizingMaskIntoConstraints = false
		musicControllerView.isHidden = false
		view.addSubview(musicControllerView)
		
		musicControllerBottomConstraint = musicControllerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		
		NSLayoutConstraint.activate([
			musicControllerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			musicControllerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			musicControllerBottomConstraint,
			musicControllerView.heightAnchor.constraint(equalToConstant: 150)
		])
	}
}

