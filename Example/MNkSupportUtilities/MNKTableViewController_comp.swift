//
//  MNKTableViewController_comp.swift
//  MNkSupportUtilities_Example
//
//  Created by Malith Kamburapola on 2022-01-10.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import MNkSupportUtilities

class TableViewController_Sample: MNkTableViewController_Parameter_CellType<UserData, TableViewCell> {
    
    override func fetchData() {
        
        data = [UserData.init(name: "Malith Nadeeshan", age: 29),
                UserData.init(name: "Nimesha Gunathilaka", age: 28),
                UserData.init(name: "Asali Ananya", age: 1)]
        
    }
}




//MARK: - TABLEVIEW CELL WITH GENERIC PARAMETERS

class TableViewCell: MNkTVCell_Parameter<UserData> {
    private var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 17, weight: .medium)
        return lbl
    }()
    
    private var ageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.6)
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    
    override func insertAndLayoutSubviews() {
        let stackView = UIStackView.init(arrangedSubviews: [nameLabel, ageLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        NSLayoutConstraint.activate([stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                                                        constant: 20),
                                     stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                                                         constant: -20),
                                     stackView.topAnchor.constraint(equalTo: self.topAnchor,
                                                                    constant: 20),
                                     stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                                       constant: -4)])
    }
    
    override func updateUI(with data: UserData) {
        nameLabel.text = data.name
        let yearLabel = data.age > 1 ? "years" : "year"
        ageLabel.text =  "\(data.age) \(yearLabel) old"
    }
}
