//
//  SceneDelegate.swift
//  Undo Challenge
//
//  Created by Marcel Mierzejewski on 12/12/2019.
//  Copyright © 2019 marcelmierzejewski. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()

        window?.makeKeyAndVisible()
    }
}
