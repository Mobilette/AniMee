//
//  AnimeListDayViewController.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 09/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import UIKit

class AnimeListDayViewController:
    UICollectionViewController,
    UICollectionViewDelegateFlowLayout,
    AnimeListDayViewInterface
{
    // MARK: - Type
    
    enum SegueIdentifier: String {
        case PushToAnimeListEpisode = "pushAnimeListDayToAnimeListEpisode"
    }
    
	// MARK: - Property

    var presenter: AnimeListDayModuleInterface? = nil
    private var dailyEpisodes: [AnimeListDayEpisodeViewItem] = []
    
	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.presenter?.updateView()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        //self.storyboardSegueDelegate.prepareForSegue(segue, sender: sender)
    }
    
    // MARK: - Colletion view data source
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView
        ) -> Int
    {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dailyEpisodes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: AnimeListDayCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AnimeListDayCell
        let episode = self.dailyEpisodes[indexPath.row]
        cell.imageURL = episode.imageURL
        cell.name = episode.animeName
        cell.hour = episode.hour
        //        cell.number = labels[indexPath.row]
        //        cell.title = labels[indexPath.row]
        //        cell.season = labels[indexPath.row]
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // To do: implement AnimeListDayViewItem
        
        let episode = self.dailyEpisodes[indexPath.row]
        self.presenter?.showAnimeListEpisodeInterface(episode.animeName)
    }
    
    // MARK: - Collection view delegate flow layout
    
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath
        ) -> CGSize
    {
        return CGSizeMake(CGRectGetWidth( collectionView.bounds), 100)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View interface
    
    func setAnimeListDayEpisode(animeListDayEpisodeViewItems: [AnimeListDayEpisodeViewItem])
    {
        self.dailyEpisodes = animeListDayEpisodeViewItems
        self.collectionView?.reloadData()
    }
}
