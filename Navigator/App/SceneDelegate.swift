//
//  SceneDelegate.swift
//  Navigator
//
//  Created by Алексей Сердюк on 18.09.2024.
//

import UIKit
import StorageServices
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let feedViewController = UINavigationController(rootViewController: FeedViewController())
        
        let vc = LogInViewController()
        vc.loginDelegate = MyLoginFactory().makeLoginInspector()
        let profileViewController = UINavigationController(rootViewController: vc)
        
        let contentViewController = UINavigationController(rootViewController: ContentViewController())
        let passwordViewController = UINavigationController(rootViewController: PasswordViewController())
        let favoriteViewController = UINavigationController(rootViewController: FavoriteViewController())
        
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedViewController, contentViewController, passwordViewController, profileViewController, favoriteViewController]
        
        let feedItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "newspaper"), tag: 0)
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        let contentItem = UITabBarItem(title: "Content", image: UIImage(systemName: "folder"), tag: 2)
        let passwordItem = UITabBarItem(title: "Password", image: UIImage(systemName: "lock.square"), tag: 3)
        let favoriteItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star.bubble"), tag: 4)
        
        feedViewController.tabBarItem = feedItem
        profileViewController.tabBarItem = profileItem
        contentViewController.tabBarItem = contentItem
        passwordViewController.tabBarItem = passwordItem
        favoriteViewController.tabBarItem = favoriteItem
        
        //CoreDateServices.shared.clear()
        
        
//        let appConfig = AppConfiguration.first
//        NetworkService.request(for: appConfig)
        
//        NetworkService.hw1()
//        NetworkService.hw2()
        
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
