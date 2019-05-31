//
//  OriginCellPointControl.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 5/31/19.
//

import Foundation
public protocol OriginCellPointControl{
    var pageDisplayPoint:PageDisplayPoint{get}
}

extension OriginCellPointControl{
    /*........................................
     MARK:- Page display point helper function
     ..........................................*/
    public func setPosition(of collectionView:UICollectionView){
        guard let contentView = collectionView.superview,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
            else{return}
        
        let visibleCellRects = collectionView.indexPathsForVisibleItems.map{(indexPath:$0,rect:collectionView.convert((collectionView.attributeFrame(forCellAt: $0) ?? .zero),
                                                                                                                      to: contentView))}
        let cellSize = visibleCellRects.first?.rect.size ?? .zero
        let minLineSpace = layout.minimumLineSpacing
        
        let padding:CGFloat
        
        switch pageDisplayPoint {
        case .centerEdge:
            padding = ((contentView.bounds.size.width/2) - (cellSize.width/2)) - (minLineSpace / 2)
            collectionView.contentInset.left = padding
            collectionView.contentInset.right = padding
            collectionView.contentOffset.x = -padding
        case .leftEdge:
            padding = contentView.bounds.size.width - (cellSize.width+minLineSpace)
            collectionView.contentInset.right = padding
            collectionView.contentOffset.x = -minLineSpace
        case .none:
            padding = 0
        }
    }
}
