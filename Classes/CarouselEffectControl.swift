//
//  CarouselEffectControl.swift
//  MNkSupportUtilities
//
//  Created by Malith Nadeeshan on 5/31/19.
//

import Foundation

public protocol CarouselEffectControl:OriginCellPointControl{
    var carouselMinPreAlpha:CGFloat{get}
    var carouselMinScalePreVal:CGFloat{get}
    var carouselOpenPoint:CGFloat{get}
}
extension CarouselEffectControl{
    /*.......................................................................
     MARK:- Play carousel when user scroll through uicollection view
     .......................................................................*/
    public func playCarosel(in collectionView:UICollectionView,animation isAnmating:Bool = true){
        guard let contentView = collectionView.superview else{return}
        
        let visibleCellsIndexes = collectionView.indexPathsForVisibleItems
        let cellMidXs = visibleCellsIndexes.map{(middleX:collectionView.convert((collectionView.attributeFrame(forCellAt: $0) ?? .zero),
                                                                                to: contentView).midX,indexPath:$0)}
        
        let cellPrecetXs = cellMidXs.map{(indexPath:$0.indexPath,precentX:(abs($0.middleX - carouselOpenPoint))/carouselOpenPoint*100)}
        
        for cellPrecetX in cellPrecetXs{
            guard let cell = collectionView.cellForItem(at: cellPrecetX.indexPath)else{continue}
            setCellCarosel(to:cell, at:cellPrecetX.indexPath, in: collectionView)
        }
    }
    
    /*.......................................................................
     MARK:- Set carousel effect for send cell from didScroll or reload cells
     .......................................................................*/
    public func setCellCarosel(to cell:UICollectionViewCell,at indexPath:IndexPath,in collectionView:UICollectionView){
        let visibleRect = CGRect.init(origin:collectionView.contentOffset,
                                      size: collectionView.bounds.size)
        let attribRect = collectionView.attributeFrame(forCellAt: indexPath) ?? .zero
        let isVisible = visibleRect.intersects(attribRect)
        
        guard isVisible else{return}
        
        let carouselPrecentage = precentage(forCellAt: indexPath, in: collectionView)
        let scale = 1.0 - (self.carouselMinScalePreVal*carouselPrecentage)
        let alpha = 1.0 - (self.carouselMinPreAlpha*carouselPrecentage)
        let transform = CGAffineTransform.init(scaleX:scale, y: scale)
        
        cell.alpha = alpha
        cell.transform = transform
    }
    
    /*.......................................................................
     MARK:- Calculate presentage val from carousel open location to cell midX
     .......................................................................*/
    func precentage(forCellAt indexPath:IndexPath,in collectionView:UICollectionView)->CGFloat{
        guard let contentView = collectionView.superview else{return 1}
        let cellMidX = collectionView.convert(collectionView.attributeFrame(forCellAt: indexPath) ?? .zero, to: contentView).midX
        let cellPreX = abs((cellMidX-carouselOpenPoint)/carouselOpenPoint*100)
        let carouselPrecentage = (cellPreX/100)
        return carouselPrecentage
    }
}
