//
//  AnimeListWeekViewController.swift
//  AniMee
//
//  Created by Romain ASNAR on 9/12/15.
//  Copyright (c) 2015 Mobilette. All rights reserved.
//

import Foundation
import UIKit

class AnimeListWeekViewController:
    UICollectionViewController,
    UICollectionViewDelegateFlowLayout,
    AnimeListWeekViewInterface
{
	// MARK: - Property
    
    private var dailyEpisodes: [AnimeListWeekViewItem] = []
    
    var presenter: AnimeListWeekModuleInterface? = nil
    var sizeCell: CGSize = CGSizeZero
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
            dailyEpisode.episodes.append("")
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
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell

        switch cellIdentifier {
        case animeListWeekHeaderCellIdentifier:
            let title = self.dailyEpisode(forIndexPath: indexPath)
            let animeListWeekHeaderCell = cell as! AnimeListWeekHeaderCell
            animeListWeekHeaderCell.title = title ?? ""
        case animeListWeekEpisodeCellIdentifier:
            if let episodeImageURLString = self.dailyEpisode(forIndexPath: indexPath) {
                let animeListWeekEpisodeCell = cell as! AnimeListWeekEpisodeCell
                if let url = NSURL(string: episodeImageURLString) {
                    animeListWeekEpisodeCell.imageURL = url
                }
            }
        default:
            break
        }
        
        return cell
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
    
    private func dailyEpisode(
        forIndexPath indexPath: NSIndexPath
        ) -> String?
    {
        var numberOfItems = 0
        let dailyEpisode = self.dailyEpisodes[indexPath.section]
        numberOfItems += 1
        if numberOfItems == indexPath.row + 1 {
            return dailyEpisode.title
        }
        let numberOfDailyEpisode = dailyEpisode.episodes.count
        numberOfItems += numberOfDailyEpisode
        if numberOfItems >= indexPath.row + 1 {
            let index = indexPath.row - (numberOfItems - numberOfDailyEpisode)
            return dailyEpisode.episodes[index]
        }
        return nil
    }
}





