//
//  MNkCollectionViewController_comp.swift
//  MNkSupportUtilities_Example
//
//  Created by Malith Kamburapola on 2022-01-10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//
import MNkSupportUtilities

class CollectionViewController_Sample: MNkCollectionVC_Parameter_CellType<UserData, CollectionViewCell> {
    private var kNumberOfHorizontalCells: CGFloat {2}
    
    override func config() {
        super.config()
        
        guard let `layout` = layout as? UICollectionViewFlowLayout else { return }
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    }
    
    override func fetchData() {
        
        data = [UserData.init(name: "Malith Nadeeshan", age: 29, profileImage: .profileMan),
                UserData.init(name: "Nimesha Gunathilaka", age: 28, profileImage: .profileWomen),
                UserData.init(name: "Asali Ananya", age: 1, profileImage: .profileBaby)]
        
    }
}

// DELEGATE PROTOCOL IMPLIMENTATION
extension CollectionViewController_Sample {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = collectionView.bounds.size.width / kNumberOfHorizontalCells
        
        return .init(width: length,
                     height: length)
    }
}



//MARK: - COLLECTIONVIEW CELL WITH GENERIC PARAMETERS

class CollectionViewCell: MNkCVCell_Parameter<UserData> {
    private var kLabelPosibleHeight: CGFloat {68}
    
    private var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.setContentHuggingPriority(.defaultHigh, for: .vertical)
        lbl.textAlignment = .center
        lbl.minimumScaleFactor = 0.8
        lbl.sizeToFit()
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private var ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.6)
        lbl.font = .systemFont(ofSize: 14)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var profileImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.08)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func insertAndLayoutSubviews() {
        let labelVStackView = UIStackView.init(arrangedSubviews: [nameLabel, ageLabel])
        labelVStackView.axis = .vertical
        labelVStackView.spacing = 4
        
        let mainVStackView = UIStackView.init(arrangedSubviews: [profileImageView, labelVStackView])
        mainVStackView.axis = .vertical
        mainVStackView.alignment = .center
        mainVStackView.translatesAutoresizingMaskIntoConstraints = false
        mainVStackView.spacing = 8
        
        addSubview(cardView)
        NSLayoutConstraint.activate([cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                        constant: -10),
                                     cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                                     constant: 10),
                                     cardView.topAnchor.constraint(equalTo: self.topAnchor,
                                                                   constant: 10),
                                     cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        
        cardView.addSubview(mainVStackView)
        NSLayoutConstraint.activate([mainVStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,
                                                                            constant: 10),
                                     mainVStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,
                                                                             constant: -10),
                                     mainVStackView.topAnchor.constraint(equalTo: cardView.topAnchor,
                                                                        constant: 10),
                                     mainVStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,
                                                                           constant: -10)])
        
        NSLayoutConstraint.activate([profileImageView.heightAnchor.constraint(equalTo: self.cardView.heightAnchor,
                                                                              constant: -kLabelPosibleHeight),
                                     profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)])
    }
    
    override func updateUI(with data: UserData) {
        nameLabel.text = data.name
        let yearLabel = data.age > 1 ? "years" : "year"
        ageLabel.text =  "\(data.age) \(yearLabel) old"
        profileImageView.image = data.profileImage
    }
}
