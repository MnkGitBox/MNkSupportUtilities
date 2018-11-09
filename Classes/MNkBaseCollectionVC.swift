//
//  MNkBaseCollectionVC.swift
//  FBSnapshotTestCase
//
//  Created by MNk_Dev on 2/11/18.
//

import UIKit
open class MNkBaseCollectionVC<T,C:MNkBaseCVCell<T>>: UICollectionViewController{
    
    public var data:[T] = []{didSet{collectionView?.reloadData()}}
    public var cellID:String{return"GenericCellID \(arc4random())"}
    
    open func configCollectionView(){
        collectionView?.register(C.self, forCellWithReuseIdentifier: cellID)
        collectionView?.dataSource = self
        collectionView?.delegate = self
    }
    open func fetchData(){}
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        fetchData()
        view.backgroundColor = .white
    }
    
    
    open override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {return data.count}
    open override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! C
        cell.data = data[indexPath.item]
        return cell
    }
    
}

