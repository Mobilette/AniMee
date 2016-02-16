//
//  AnimeListEpisodeViewController.swift
//  AniMee
//
//  Mobilette template version 1.0
//
//  Created by Benaly Issouf M'sa on 12/02/16.
//  Copyright © 2016 Mobilette. All rights reserved.
//

import Foundation
import UIKit

class AnimeListEpisodeViewController:
    UICollectionViewController,
    UICollectionViewDelegateFlowLayout,
    AnimeListEpisodeViewInterface
{
	// MARK: - Property

    var presenter: AnimeListEpisodeModuleInterface? = nil
    private var animeEpisodes: [AnimeListEpisodeViewItem] = []
    
	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.presenter?.updateView()
    }

    // MARK : - Collection view data source
    
    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView
        ) -> Int
    {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.animeEpisodes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: AnimeListEpisodeCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AnimeListEpisodeCell
        //let episodes = self.animeEpisodes[indexPath.row]
        return cell
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
    
    func setAnimeEpisodesViewList(animeListEpisodeViewItems: [AnimeListEpisodeViewItem])
    {
        self.animeEpisodes = animeListEpisodeViewItems
        self.collectionView?.reloadData()
    }
}
