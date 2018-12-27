//
//  MNkBaseCollectionVC.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit
open class MNKCollectionViewController:MNkViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    open var scrollDirection:UICollectionViewScrollDirection{
        return .horizontal
    }
    
    public lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    open override func insertAndLayoutSubviews() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
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

    public var cellID:String = "GenericCellID \(arc4random())"
    
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
