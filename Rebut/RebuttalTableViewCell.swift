//
//  RebuttalTableViewCell.swift
//  Rebut
//
//  Created by Rashad Abdul-Salaam on 3/27/17.
//  Copyright © 2017 Rebuttle Inc. All rights reserved.
//

import Foundation
import UIKit

protocol RebutAutoPlayDelegate {
    func shouldPressRebutPlayButton()
}

class RebuttalTableViewCell : UITableViewCell {
    
    @IBOutlet weak var rebuttalCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var titleLabel: UILabel!
    
    var rebuts = [Rebut]()
    var viewModel: RebuttalViewModel!
    let module = RebuttalModule.shared
    let identifier = "waveformCell"
    var autoPlayDelegate: RebutAutoPlayDelegate?
    var playerDelegate: RebutPlayerDelegate?
    var waveFormCellDelegate: RebutViewModelDelegate?
    var currentVisibleIndexPath: IndexPath?
    
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
        module.player = RebutPlayer(url: URL(fileURLWithPath: (rebut.recordingFilePath)))
        return cell
    }
}

extension RebuttalTableViewCell : RebutViewModelDelegate {
    func shouldPlayRebut(rebut: Rebut, playDelegate: RebutPlayerDelegate) {
        self.playerDelegate = playDelegate
        module.playerDelegate = self
        module.play(rebut: rebut)
    }
    
    func rebutIsPlaying() -> Bool {
        return module.player!.isPlaying()
    }
    
    func shouldStopPlayingRebut() {
        module.player?.stop()
    }
    
    func shouldRespondToRebut(rebut: Rebut) {
        // Initiate Response
    }
    
    func shouldLikeRebut(rebut: Rebut) {
        rebut.incrLike()
    }
}

extension RebuttalTableViewCell : RebutPlayerDelegate {
    func didFinishPlayingRebut(rebut: Rebut) {
        // Fire playerDelegate
//
//        let nextRebut = rebuts[nextIndex]
        playerDelegate?.didFinishPlayingRebut(rebut: rebut)
//        let cell = rebuttalCollectionView.visibleCells.first as! RebuttalWaveFormCell
        removeCellDelegate(for: rebut)
        autoScroll()
        // Crashes if cell not visible
//        cell.viewModelDelegate?.shouldPlayRebut(rebut: nextRebut, playDelegate: cell)
        //module.play(rebut: nextRebut)
    }
}

extension RebuttalTableViewCell : UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Fires on manaual scroll
        // Must get cell and set as delegate
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // Fires on auto-scroll
        print("Visible Index:",currentVisibleIndexPath!.row)
        let cell = rebuttalCollectionView.cellForItem(at: currentVisibleIndexPath!) as! RebuttalWaveFormCell
        self.autoPlayDelegate = cell
        cell.viewModelDelegate = self
        autoPlayDelegate?.shouldPressRebutPlayButton()
//        cell.viewModelDelegate?.shouldPlayRebut(rebut: nextRebut, playDelegate: cell)
    }
}

fileprivate extension RebuttalTableViewCell {
    func autoScroll() {
        let nextIndex = (rebuttalCollectionView.indexPathsForVisibleItems.first?.row)! + 1
        if nextRebutExists(nextIndex: nextIndex) {
//            self.rebuttalCollectionView.setContentOffset(CGPoint(x:CGFloat(Int(self.rebuttalCollectionView.frame.width)*nextIndex),y:0), animated: true)
//            UIView.animate(withDuration: 0.4, animations: {
//                self.rebuttalCollectionView.contentOffset = CGPoint(x:CGFloat(Int(self.rebuttalCollectionView.frame.width)*nextIndex),y:0)
//            })
            let indexPath = IndexPath(row: nextIndex, section: 0)
            rebuttalCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
            currentVisibleIndexPath = indexPath
        }
        
    }
    
    func nextRebutExists(nextIndex: Int) -> Bool {
        return rebuts.indices.contains(nextIndex)
    }
    
    func cellForRebut(rebut: Rebut) -> RebuttalWaveFormCell {
        let index = rebuts.index(of: rebut)
        let indexPath = IndexPath(item: index!, section: 0)
        return rebuttalCollectionView.cellForItem(at: indexPath) as! RebuttalWaveFormCell
    }
    
    func removeCellDelegate(for rebut: Rebut) {
        let cell = cellForRebut(rebut: rebut)
        cell.viewModelDelegate = nil
    }
}

