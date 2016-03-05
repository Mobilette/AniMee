//
//  AnimeListWeekViewController.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import UIKit
import MBLogger

class AnimeListWeekViewController:
    UICollectionViewController,
    UICollectionViewDelegateFlowLayout,
    AnimeListWeekViewInterface
{
    // MARK: - Type
    
    enum SegueIdentifier: String {
        case PushToAnimeListDay = "pushAnimeListWeekToAnimeListDay"
    }
    
	// MARK: - Property
    
    private var dailyEpisodes: [AnimeListWeekViewItem] = []
    
    var presenter: AnimeListWeekModuleInterface? = nil
    var sizeCell: CGSize = CGSizeZero
    
    var storyboardSegueDelegate: StoryboardSegueDelegate! = nil
    
	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.sizeCell = self.sizeForCell()
        self.presenter?.updateView()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // To do: Doesn't work test after merge perform
        
        // self.storyboardSegueDelegate.prepareForSegue(segue, sender: sender)
        //        if let identifier = segue.identifier {
        //            switch identifier {
        //            case SegueIdentifier.PushToAnimeListDay.rawValue:
        //                MBLog.view(MBLog.Level.Low, object: "Did prepare selected day to be pushed to anime list day view.")
        //                self.presenter?.showAnimeListDayInterface()
        //                break
        //            default:
        //                break
        //            }
        //        }
    }
    
    // MARK: - Collection view data source
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView
        ) -> Int
    {
        return self.dailyEpisodes.count
    }
    
    override func collectionView(
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int
    {
        let dailyEpisode = self.dailyEpisodes[section]
        if dailyEpisode.episodes.count == 1 {
            let emptyAnimeListWeekEpisodeViewItem = AnimeListWeekEpisodeViewItem()
            dailyEpisode.episodes.append(emptyAnimeListWeekEpisodeViewItem)
        }
        return dailyEpisode.episodes.count + 1
    }
    
    override func collectionView(
        collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath
        ) -> UICollectionViewCell
    {
        let animeListWeekHeaderCellIdentifier = "AnimeListWeekHeaderCell"
        let animeListWeekEpisodeCellIdentifier = "AnimeListWeekEpisodeCell"
        let cellIdentifier: String = (self.isHeaderCell(forIndexPath: indexPath) == true) ? animeListWeekHeaderCellIdentifier : animeListWeekEpisodeCellIdentifier
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) 

        let dailyEpisode = self.dailyEpisodes[indexPath.section]
        switch cellIdentifier {
        case animeListWeekHeaderCellIdentifier:
            let title = dailyEpisode.title
            let animeListWeekHeaderCell = cell as! AnimeListWeekHeaderCell
            animeListWeekHeaderCell.title = title ?? ""
        case animeListWeekEpisodeCellIdentifier:
            let episode = dailyEpisode.episodes[indexPath.row - 1]
            let animeListWeekEpisodeCell = cell as! AnimeListWeekEpisodeCell
            animeListWeekEpisodeCell.title = episode.title
            animeListWeekEpisodeCell.imageURL = episode.imageURL
        default:
            break
        }
        
        return cell
    }
    
    // MARK: - Selected cell data source
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let episode = self.dailyEpisodes[indexPath.section].episodes[indexPath.row - 1]
        self.presenter?.showAnimeListDayInterface(episode.releaseDate)
    }
    
    // MARK: - Collection view delegate flow layout
    
    func collectionView(
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath
        ) -> CGSize
    {
        if self.isHeaderCell(forIndexPath: indexPath) {
            let headerSize = CGSizeMake(CGRectGetWidth( collectionView.bounds), 50)
            return headerSize
        }
        else {
            return self.sizeCell
        }
    }
    
    // MARK: - Anime list week view interface
    
    func setWeeklyEpisodeList(
        animeListWeekViewItems: [AnimeListWeekViewItem]
        )
    {
        self.dailyEpisodes = animeListWeekViewItems
        self.collectionView?.reloadData()
    }
    
    // MARK: - Collection view cell
    
    private func sizeForCell() -> CGSize
    {
        if let collectionView = self.collectionView {
            let maxCells: CGFloat = 4
            let width = CGRectGetWidth(collectionView.bounds) / maxCells
            let height = width + 15
            return CGSizeMake(width, height)
        }
        return CGSizeZero
    }
    
    private func isHeaderCell(
        forIndexPath indexPath: NSIndexPath
        ) -> Bool
    {
        var numberOfItems = 0
        let dailyEpisode = self.dailyEpisodes[indexPath.section]
        numberOfItems += 1
        if numberOfItems == indexPath.row + 1 {
            return true
        }
        numberOfItems += dailyEpisode.episodes.count
        if numberOfItems >= indexPath.row + 1 {
            return false
        }
        return false
    }
}








