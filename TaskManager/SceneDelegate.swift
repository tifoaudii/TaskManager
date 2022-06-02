//
//  SceneDelegate.swift
//  TaskManager
//
//  Created by Tifo Audi Alif Putra on 06/05/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        ColorAttributeTransformer.register()
        
        let navigationController: UINavigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let factory = ViewControllerFactory()
        let router = AppRouter(navigationController: navigationController, factory: factory, coreDataStack: CoreDataStack(inMemory: false))
        let flow = AppFlow(router: router)
        flow.start()
    }
}
