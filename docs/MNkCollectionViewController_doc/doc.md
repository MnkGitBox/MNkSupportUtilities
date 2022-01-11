# MNKCollectionViewController
This ViewController component helps to show data in collection view using a small amount of code. 

![build screenshot](build_screenshot.png) 

<br>

## Declaration

```swift
class CollectionViewController_Sample: MNkCollectionVC_Parameter_CellType<DataType, CellType> {
    
    override func fetchData() {
        
        data = [UserData.init(name: "Malith Nadeeshan", age: 29, profileImage: .profileMan),
                UserData.init(name: "Nimesha Gunathilaka", age: 28, profileImage: .profileWomen),
                UserData.init(name: "Asali Ananya", age: 1, profileImage: .profileBaby)]
        
    }
}
```
`class CollectionViewController_Sample: MNkCollectionVC_Parameter_CellType<DataType, CellType>` required two generic paramters *CellType* and *DataType* when the subclassing.
<br><br>
- `DataType` - You can use any type here.
```swift
struct UserData {
    var name: String
    var age: Int
    
    var profileImage: UIImage?
}
``` 
- `CellType` - Subclassing the `MNkCVCell_Parameter<DataType>`, you can create any type of *CollectionViewCell* to use.
```swift
class CollectionViewCell: MNkCVCell_Parameter<UserData> {
    
    private var nameLabel: UILabel 
    
    private var ageLabel: UILabel 
    
    private var profileImageView: UIImageView  
    
    private var cardView: UIView 
    
    override func updateUI(with data: UserData)
}
```
*You can update the UI using model data using `updateUI(with data: UserData)` method*
```Swift
override func updateUI(with data: UserData) {
    nameLabel.text = data.name
    let yearLabel = data.age > 1 ? "years" : "year"
    ageLabel.text =  "\(data.age) \(yearLabel) old"
     profileImageView.image = data.profileImage
}
```

<br>

## Other Helpful Classes

- This will show given empty cell when the data array is empty.
``` Swift 
class MNkCVC_Parameter_Cell_EmptyCellType<DataType,CellType,EmptyCellType> {}


class MNkCVC_Parameter_EmptyCellType<DataType, EmptyCellType> {}

class MNkCVC_EmptyCellType<EmptyCellType> {}


```
- We can use this Type when have to show diffrent kind of cell type using one data stream. 
```Swift
 class MNkCollectionVC_Parameter<DataType>
```
<br><br>
You can find the original sample code [here](../../Example/MNkSupportUtilities/MNkCollectionViewController_comp.swift).

---




