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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		title = "Tuny Player"
		
		setupSearchBar()
		setupTableView()
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
}

