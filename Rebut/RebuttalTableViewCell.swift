//
//  RebuttalTableViewCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/27/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

protocol RebutPlayerDelegate{
    func shouldPlayRebut(with rebut: Rebut)
}

class RebuttalTableViewCell : UITableViewCell {
    @IBOutlet weak var scrollView: UIScrollView! // Will eventually replace as CollectionView
    @IBOutlet weak var rebuttalCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    var rebuts = [Rebut]()
    var viewModel: RebuttalViewModel!
    let module = RebuttalModule.shared
    let identifier = "waveformCell"
    var playerDelegate: RebutPlayerDelegate?
    
    override func awakeFromNib() {
        rebuttalCollectionView.delegate = self
        rebuttalCollectionView.dataSource = self
        rebuttalCollectionView.isPagingEnabled = true
        
        // Configure flowLayout
        flowLayout.minimumLineSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width:self.frame.width, height:125)
    }
    
    func configureCell(with rebuts: [Rebut]) {
       // viewModel = RebuttalViewModel(rebuts: rebuts, scrollView: scrollView)
        self.rebuts = rebuts
        let post = module.getPost()
        self.titleLabel.text = post?.title
        rebuttalCollectionView.reloadData()
    }
}

extension RebuttalTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get the url & play audio
        let rebut = rebuts[indexPath.row]
        module.play(rebut: rebut)
    }
}

extension RebuttalTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rebuts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let rebut = rebuts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! RebuttalWaveFormCell
        cell.configureCell(with: rebut, delegate: self)
        return cell
    }
}

extension RebuttalTableViewCell : PlayRebutDelegate {
    func shouldPlayRebut(rebut: Rebut) {
        module.play(rebut: rebut)
    }
}

