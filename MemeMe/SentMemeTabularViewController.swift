//
//  SentMemeTabularViewController.swift
//  MemeMe
//
//  Created by Abhishek Agarwal on 09/04/17.
//  Copyright © 2017 Abhishek. All rights reserved.
//

import UIKit

class SentMemeTabularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var memesTableView: UITableView!
    let cellReuseIdentifier = "memeCell"
    var memeArray = [Meme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshMemesArray()
        memesTableView.reloadData()
    }
    
    func refreshMemesArray() {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memeArray = appDelegate.memes
    }
    
    // MARK: UITableViewDataSource functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SentMemeTableViewCell
        cell.sentMemeImageView.image = memeArray[indexPath.row].memedImage
        cell.sentMemeTextLabel.text = memeArray[indexPath.row].name()
        cell.sentMemeTextLabel.lineBreakMode = .byTruncatingMiddle
        return cell
    }
    
    // MARK: UITableViewDelegate functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
