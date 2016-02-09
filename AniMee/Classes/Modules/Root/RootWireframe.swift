//
//  RootWireframe.swift
//  AniMee
//
//  Created by Issouf M'sa Benaly on 9/15/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import UIKit

class RootWireframe
{
    let RootViewController: String = "RootViewController"
    
    // MARK: - Presentation
    
    func presentRootViewController(fromWindow window: UIWindow)
    {
        self.presentAnimeListWeekViewController(fromWindow: window)
    }
    
    private func presentAnimeListWeekViewController(fromWindow window: UIWindow)
    {
        let presenter = AnimeListWeekPresenter()
        let interactor = AnimeListWeekInteractor()
        let networkController = AnimeListWeekNetworkController()
        let wireframe = AnimeListWeekWireframe()
        interactor.networkController = networkController
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        wireframe.presenter = presenter
        wireframe.presentInterface(fromWindow: window)
    }
    
    private func mainStoryboard() -> UIStoryboard
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:NSBundle.mainBundle())
        return storyboard
    }
    
    private func viewControllerFromStoryboard() -> UIViewController
    {
        let storyboard = self.mainStoryboard()
        let viewController = storyboard.instantiateViewControllerWithIdentifier(RootViewController)
        return viewController
    }
}
