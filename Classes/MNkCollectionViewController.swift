//
//  MNkBaseCollectionVC.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit
open class MNKCollectionViewController:MNkViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    open var layout:UICollectionViewLayout = UICollectionViewFlowLayout()
    
    public var cellID:String = "GenericCellID \(arc4random())"
    public var emptyCellID:String = "EmptyCellID \(arc4random())"
    
    
    public var collectionView:UICollectionView!
    
    open override func createViews() {
        collectionView = UICollectionView(frame:.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
    }
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(collectionView)
        collectionView.activateLayouts(to: self.view, true)
    }
    
    open  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return 0}
    open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {return .zero}
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {return UICollectionReusableView()}
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {return .zero}
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {return .zero}
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {}
}





open class MNkCollectionVC_Parameter_CellType<T,C:MNkCVCell_Parameter<T>>: MNkCollectionVC_Parameter<T>{
    
    open override func config() {
        collectionView.register(C.self, forCellWithReuseIdentifier: cellID)
    }
    
    open  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
}




open class MNkCollectionVC_Parameter<T>:MNKCollectionViewController{
    public var data:[T] = []{didSet{updateUIWithNewData()}}
    
    open  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return data.count}
}
