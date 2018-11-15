//
//  MNkBaseCollectionVC.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//
import UIKit
open class MNkBaseCollectionVC<T,C:MNkBaseCVCell<T>>: MNkBasicViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    public var data:[T] = []{didSet{didSetData()}}
    
    open var scrollDirection:UICollectionViewScrollDirection{
        return .horizontal
    }
    
    public lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(C.self, forCellWithReuseIdentifier: cellID)
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
    
    open func didSetData(){}
    
    public var cellID:String = "GenericCellID \(arc4random())"
    
    open  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return data.count}
    open  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {return .zero}
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

