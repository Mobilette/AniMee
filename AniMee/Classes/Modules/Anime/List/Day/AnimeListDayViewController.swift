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
	// MARK: - Property

    var presenter: AnimeListDayModuleInterface? = nil
    let labels: [String] = ["12:45", "12:45", "12:45"] // This variable has to be deleted
    
	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.presenter?.updateView()
    }

    // MARK: - Colletion view data source
    
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
        let cell: AnimeListDayCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! AnimeListDayCell
        cell.hour = labels[indexPath.row]
//        cell.imageURL = NSURL()
//        cell.name = labels[indexPath.row]
//        cell.season = labels[indexPath.row]
//        cell.number = labels[indexPath.row]
//        cell.title = labels[indexPath.row]
        
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
}
