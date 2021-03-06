//
//  AnimeListDayWireframe.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import UIKit
import MBLogger

let AnimeListDayViewControllerIdentifier: String = "AnimeListDayViewController"

class AnimeListDayWireframe//: StoryboardSegueDelegate
{
	// MARK: - Property

    weak var presenter: AnimeListDayPresenter? = nil
    private weak var viewController: AnimeListDayViewController? = nil

    // MARK: - Storyboard segue

    enum SegueIdentifier: String {
        case PushToAnimeListEpisode = "pushAnimeListDayToAnimeListEpisode"
    }

    private var preparedSegue: UIStoryboardSegue? = nil

    // MARK: - Storyboard Segue Delegate
    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        self.preparedSegue = segue
    }
    
    // MARK: - Presentation

    func prepareInterface(fromSegue segue: UIStoryboardSegue)
    {
        let viewController = segue.destinationViewController as! AnimeListDayViewController
        viewController.presenter = self.presenter
        self.viewController = viewController
        self.presenter?.view = viewController
    }

    /*
    func prepareInterface(fromSegue segue: UIStoryboardSegue)
    {
        let navigationViewController = segue.destinationViewController as! UINavigationController
        if let viewController = navigationViewController.viewControllers.first as? AnimeListDayViewController {
            viewController.presenter = self.presenter
            self.viewController = viewController
            self.presenter?.view = viewController
        }
    }
    */

    /*
    func presentInterface(fromWindow window: UIWindow)
    {
    	/*
        let viewController = self.viewControllerFromStoryboard()
        */

    	/*
        let navigationViewController = self.navigationControllerFromStoryboard()
        if let viewController = navigationViewController.viewControllers.first as? AnimeListDayViewController
        */

        viewController.presenter = self.presenter
        self.viewController = viewController
        self.presenter?.view = viewController
    }
    */

    // MARK: - Prepare interface

    func prepareAnimeListEpisodeInterface(animeName: String)
    {
        let presenter = AnimeListEpisodePresenter()
        let interactor = AnimeListEpisodeInteractor(name: animeName)
        let wireframe = AnimeListEpisodeWireframe()
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        wireframe.presenter = presenter
        if let segue = self.preparedSegue {
            MBLog.view(MBLog.Level.High, object: "Did prepare anime list episodes interface.")
            wireframe.prepareInterface(fromSegue: segue)
        }
        else {
            MBLog.error(MBLog.Level.High, object: "Did fail to prepare anime list episodes interface.")
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
    let navigationController = storyboard.instantiateViewControllerWithIdentifier(AnimeListDayViewControllerIdentifier) as! UINavigationController
    return navigationController
    }
}

