//
//  SceneDelegate.swift
//  tuny
//
//  Created by Anisa Budi Arthati on 15/07/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		
		let window = UIWindow(windowScene: windowScene)
		window.rootViewController = HomeViewController(songListViewModel: SongListViewModel(),
													   playerViewModel: PlayerViewModel())
		self.window = window
		window.makeKeyAndVisible()
	}
}

