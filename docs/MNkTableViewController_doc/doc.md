# MNKTabelViewController
This ViewController component helps to show data in table view using a small amount of code. 

<br>

## Declaration

```swift
class TableViewController_Sample: MNkTableViewController_Parameter_CellType<UserData, TableViewCell> {
    
    override func fetchData() {
        
        data = [UserData.init(name: "Malith Nadeeshan", age: 29),
                UserData.init(name: "Nimesha Gunathilaka", age: 28),
                UserData.init(name: "Asali Ananya", age: 1)]
        
    }
}
```
`MNkTableViewController_Parameter_CellType<DataType, CellType>` required two generic paramters *CellType* and *DataType* when the subclassing.
<br><br>
- `DataType` - You can use any type here.
```swift
struct UserData {
    var name: String
    var age: Int
}
``` 
- `CellType` - Subclassing the `MNkTVCell_Parameter<DataType>`, you can create any type of *TableViewCell* to use.
```swift
class TableViewCell: MNkTVCell_Parameter<UserData> {
    private var nameLabel: UILabel 
    
    private var ageLabel: UILabel
    
    override func updateUI(with data: UserData) {
}
```
*You can update the UI using model data using `updateUI(with data: UserData)` method*
```Swift
override func updateUI(with data: UserData) {
    nameLabel.text = data.name
    let yearLabel = data.age > 1 ? "years" : "year"
    ageLabel.text =  "\(data.age) \(yearLabel) old"
}
```
<br>

## Other Helpful Classes

- This will show given empty cell when the data array is empty.
``` Swift 
class MNkTVC_Parameter_Cell_EmptyCellType<DataType,CellType,EmptyCellType> {}


class MNkTVC_Parameter_EmptyCellType<DataType, EmptyCellType> {}


```
- We can use this Type when have to show diffrent kind of cell type using one data stream. 
```Swift
class MNkTableViewController_Parameter<DataType>
```


