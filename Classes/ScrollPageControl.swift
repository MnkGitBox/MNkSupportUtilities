//
//  ScrollPageControl.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 5/31/19.
//

import Foundation

public protocol ScrollPageControl:OriginCellPointControl{}

extension ScrollPageControl{
    public func setCurrPage(in collectionView:UICollectionView)->UICollectionViewCell?{
        guard let contentView = collectionView.superview,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            else{return nil}
        
        let contentSize = layout.collectionViewContentSize
        let minLineSpace = layout.minimumLineSpacing
        
        let visibleCellRects = collectionView.indexPathsForVisibleItems.map{(indexPath:$0,rect:collectionView.convert((collectionView.attributeFrame(forCellAt: $0) ?? .zero),
                                                                                                                      to: contentView))}
        let cellSize = visibleCellRects.first?.rect.size ?? .zero
        let paginAreaOrigin:CGPoint
        
        switch pageDisplayPoint {
        case .centerEdge:
            paginAreaOrigin = CGPoint.init(x: (contentSize.width/2) - (cellSize.width/2),
                                           y: 0)
        case .leftEdge:
            paginAreaOrigin = CGPoint.init(x: minLineSpace,
                                           y: 0)
        case .none:
            paginAreaOrigin = .zero
        }
        
        let paginAreaRect = CGRect.init(origin: paginAreaOrigin, size: cellSize)
        
        let clippingCells = visibleCellRects.filter{paginAreaRect.intersects($0.rect)}
        let maxClipCell = clippingCells.map{(indexPath:$0.indexPath,clippingWidth:abs(contentView.bounds.midX - $0.rect.midX))}.max {return $0.clippingWidth > $1.clippingWidth}
        
        guard let _maxClipCell = maxClipCell else{return nil}
        let scrollPosition:UICollectionView.ScrollPosition?
        switch pageDisplayPoint{
        case .centerEdge:
            scrollPosition = .centeredHorizontally
        case .leftEdge:
            scrollPosition = .left
        case .none:
            scrollPosition = nil
        }
        guard let _scrollPosition = scrollPosition else{return nil}
        collectionView.scrollToItem(at:_maxClipCell.indexPath, at:_scrollPosition, animated: true)
        
        return collectionView.cellForItem(at: _maxClipCell.indexPath)
    }
}
