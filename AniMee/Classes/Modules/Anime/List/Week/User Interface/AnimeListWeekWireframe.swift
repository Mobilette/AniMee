//
//  AnimeListWeekWireframe.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import UIKit

let AnimeListWeekViewControllerIdentifier: String = "AnimeListWeekViewController"

class AnimeListWeekWireframe//: StoryboardSegueDelegate
{
	// MARK: - Property

    weak var presenter: AnimeListWeekPresenter? = nil
    private weak var viewController: AnimeListWeekViewController? = nil

    // MARK: - Storyboard segue

    /*    
    enum SegueIdentifier: String {
        case PushTo<# Next interface name #> = "pushAnimeListWeekTo<# Next interface name #>"
    }
    */

    private var preparedSegue: UIStoryboardSegue? = nil

    // MARK: - Presentation
    
    func presentInterface(fromWindow window: UIWindow)
    {
        let navigationViewController = self.navigationControllerFromStoryboard()
        if let viewController = navigationViewController.viewControllers.first as? AnimeListWeekViewController
        {
            viewController.presenter = self.presenter
            self.viewController = viewController
            self.presenter?.view = viewController
        }
        window.rootViewController = navigationViewController
    }
    

    // MARK: - Prepare interface

    func prepareAnimeListDayInterface(date: NSDate)
    {
        let presenter = AnimeListDayPresenter()
        let interactor = AnimeListDayInteractor(date: date)
        let wireframe = AnimeListDayWireframe()
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        wireframe.presenter = presenter
        if let segue = self.preparedSegue {
            //MBLog.view(MBLog.Level.High, object: "Did prepare anime list day interface.")
            wireframe.prepareInterface(fromSegue: segue)
        }
        else {
            //MBLog.error(MBLog.Level.High, object: "Did fail to prepare anime list day interface.")
        }
    }
    
    // MARK: - Storyboard
    
    private func mainStoryboard() -> UIStoryboard
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:NSBundle.mainBundle())
        return storyboard
    }
    
    private func navigationControllerFromStoryboard() -> UINavigationController
    {
        let storyboard = self.mainStoryboard()
        let navigationController = storyboard.instantiateViewControllerWithIdentifier(AnimeListWeekViewControllerIdentifier) as! UINavigationController
        return navigationController
    }
}
