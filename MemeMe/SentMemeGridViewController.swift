//
//  SentMemeGridViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 09/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class SentMemeGridViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var memesCollectionView: UICollectionView!
    let cellReuseIdentifier = "memeCell"
    var memeArray = [Meme]()
    
    func setUpLayoutForOrientation(_ whileLoading: Bool = false) {
        let space:CGFloat = 3.0
        let dimension: CGFloat = calculateDimensionBasedOnOrientation(whileLoading, space)
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    //This function is called when a view is about to change to the desired orientation. So the frames will be opposite.
    //For example, when user rotates the device to landscape, view frame will be of portrait when this function is called.
    
    func calculateDimensionBasedOnOrientation(_ whileLoading: Bool = false,_ space: CGFloat) -> CGFloat {
        let isLandscape = UIDevice.current.orientation.isLandscape
        
        //Displaying 3 items per row for portrait and 6 items per row for landscape
        if whileLoading {
            if isLandscape {
                return (view.frame.size.width - (5 * space)) / 6.0
            } else {
                return (view.frame.size.width - (2 * space)) / 3.0
            }
        } else {
            if isLandscape {
                return (view.frame.size.height - (5 * space)) / 6.0
            } else {
                return (view.frame.size.height - (2 * space)) / 3.0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial setup of layout when view appears
        setUpLayoutForOrientation(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMemesArray()
        memesCollectionView.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //Adjust collection view layout for current orientation
        if flowLayout != nil && memesCollectionView != nil {
            setUpLayoutForOrientation()
            memesCollectionView.setNeedsLayout()
        }
    }
    
    func refreshMemesArray() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memeArray = appDelegate.memes
    }
    
    // MARK: UICollectionViewDataSource functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! SentMemeCollectionViewCell
        cell.sentMemeImageView.image = memeArray[indexPath.row].memedImage
        return cell
    }
    
    // MARK: UICollectionViewDelegate functions
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeSelected = memeArray[indexPath.row]
        performSegue(withIdentifier: "memeDetail", sender: memeSelected)
    }
    
    // MARK: Preparing for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memeDetail" {
            let memeDetailVC = segue.destination as! MemeDetailViewController
            let meme = sender as! Meme
            memeDetailVC.meme = meme
        }
    }
}
