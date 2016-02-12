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
    let labels: [String] = ["12:45", "12:45", "12:45"] // Temporary data
    
	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.presenter?.updateView()
    }

    override func numberOfSectionsInCollectionView(
        collectionView: UICollectionView
        ) -> Int
    {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return labels.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: AnimeListEpisodeCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AnimeListEpisodeCell
        //cell.title = labels[indexPath.row]
        return cell
    }
    
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
}
