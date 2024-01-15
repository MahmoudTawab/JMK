//
//  AnimateTableCollection.swift
//  JMK (iOS)
//
//  Created by Emojiios on 02/02/2022.
//

import UIKit


typealias AnimationTable = (UITableViewCell, IndexPath, UITableView) -> Void
typealias AnimationCollection = (UICollectionViewCell, IndexPath, UICollectionView) -> Void

extension UITableView {
    
    func AnimateTable() {
        self.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        self.isHidden = false
        self.reloadData()
        let cells = self.visibleCells
        for cell in cells {
        if let indexPath = self.indexPath(for: cell) {
        let animation = AnimationFactory.MakeFadeTable(rowHeight: cell.frame.height ,duration: 1, delayFactor: 0.03)
        let animator = AnimatorTable(animation: animation)
        animator.TableAnimate(cell: cell, at: indexPath, in: self)
        }
        }
        }
    }
    
    func TableAnimate() {
    DispatchQueue.main.async {
    let cells = self.visibleCells

    for i in cells {
    let cell: UITableViewCell = i as UITableViewCell
        
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = 0.4
    flash.fromValue = 1 // alpha
    flash.toValue = 0.2 // alpha
    flash.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
    flash.autoreverses = true
    flash.repeatCount = 2
    cell.layer.add(flash, forKey: nil)
        
    }
        
    }
    }
    
    func addLoading(_ indexPath:IndexPath, closure: @escaping (() -> Void)) {
    if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last {
    let lastSectionIndex = numberOfSections - 1
    if indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: lastSectionIndex) - 2 {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    closure()
    }
    }
    }
    }
    
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
    guard let lastIndexPath = indexPathsForVisibleRows?.last else {
    return false
    }
    return lastIndexPath == indexPath
    }
}
    
enum AnimationFactory {

    static func MakeFadeTable(rowHeight: CGFloat,duration: TimeInterval, delayFactor: Double) -> AnimationTable {
    return { cell, indexPath, _ in
    cell.alpha = 0
    cell.transform = CGAffineTransform(translationX: 0, y: -(rowHeight))

    UIView.animate(
    withDuration: duration,
    delay: delayFactor * Double(indexPath.item),
    usingSpringWithDamping: 0.8,
    initialSpringVelocity: 0 ,
    options: [.curveEaseInOut],
    animations: {
    cell.transform = CGAffineTransform(translationX: 0, y: 0)
    cell.alpha = 1
    })
    }
    }
    
    static func MakeFadeCollection(rowHeight: CGFloat,duration: TimeInterval, delayFactor: Double) -> AnimationCollection {
    return { cell, indexPath, _ in
        
    let flash = CABasicAnimation(keyPath: "opacity")
    flash.duration = duration
    flash.fromValue = 0
    flash.toValue = 1
    cell.layer.add(flash, forKey: nil)
        
    cell.transform = CGAffineTransform(translationX: 0, y: -(rowHeight))

    UIView.animate(
    withDuration: duration,
    delay: delayFactor * Double(indexPath.item),
    usingSpringWithDamping: 0.8,
    initialSpringVelocity: 0 ,
    options: [.curveEaseInOut],
    animations: {
    cell.transform = CGAffineTransform(translationX: 0, y: 0)
    })
    }
    }
    
}


final class AnimatorTable {
    private var hasAnimatedAllCells = false
    private let animation: AnimationTable
    init(animation: @escaping AnimationTable) {
    self.animation = animation
    }

    func TableAnimate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
    guard !hasAnimatedAllCells else {return}
    animation(cell, indexPath, tableView)
    hasAnimatedAllCells = tableView.isLastVisibleCell(at: indexPath)
    }
}

final class AnimatorCollection {
    private var hasAnimatedAllCells = false
    private let animation: AnimationCollection
    init(animation: @escaping AnimationCollection) {
    self.animation = animation
    }

    func CollectionAnimate(cell: UICollectionViewCell, at indexPath: IndexPath, in CollectionView: UICollectionView) {
    guard !hasAnimatedAllCells else {return}
    animation(cell, indexPath, CollectionView)
    hasAnimatedAllCells = CollectionView.isLastVisibleCell(at: indexPath)
    }
}

extension UICollectionView {
    
    func isLastVisibleCell(at indexPath: IndexPath) -> Bool {
    guard let lastIndexPath = indexPathsForVisibleItems.last else {
    return false
    }
    return lastIndexPath == indexPath
    }
    
    func AnimateCollection() {
        self.isHidden = true
        DispatchQueue.main.async {
        self.isHidden = false
        let cells = self.visibleCells
        for cell in cells {
        if let indexPath = self.indexPath(for: cell) {
        let animation = AnimationFactory.MakeFadeCollection(rowHeight: cell.frame.height ,duration: 1, delayFactor: 0.03)
        let animator = AnimatorCollection(animation: animation)
        animator.CollectionAnimate(cell: cell, at: indexPath, in: self)
        }
        }
        }
        self.reloadData()
    }
    
    //    func AnimateCollection() {
    //    DispatchQueue.main.async {
    //    var index = 0
    //    var indexHeader = 0
    //    let CollectionHeight: CGFloat = self.bounds.size.height
    //    for _ in self.visibleCells {
    //    index += 1
    //    }
    //
    //    let headerView = self.visibleSupplementaryViews(ofKind: UICollectionView.elementKindSectionHeader)
    //    for i in headerView {
    //    let cell: UICollectionReusableView = i as UICollectionReusableView
    //    cell.alpha = 0
    //    cell.transform = CGAffineTransform(translationX: 0, y: CollectionHeight)
    //    }
    //
    //    for a in headerView {
    //    let cell: UICollectionReusableView = a as UICollectionReusableView
    //    UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options:[], animations: {
    //    cell.transform = CGAffineTransform(translationX: 0, y: 0);
    //    cell.alpha = 1
    //    }, completion: nil)
    //    indexHeader += 1
    //    }
    //    }
    //    }
}


