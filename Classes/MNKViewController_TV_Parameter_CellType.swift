//
//  MNKViewController_TV_Parameter_CellType.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 14/12/18.
//

import Foundation

class MNKViewController_TV_Parameter_CellType<T,C:MNkBaseTVCell<T>>: MNKViewController_TV_Parameter<T>{
    
    override func config() {
        tableview.register(C.self, forCellReuseIdentifier: cellID)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! C
        return cell
    }
}
