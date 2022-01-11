# UIKitChain
Using the UIKitChain framework, You can create a UIKit component in one line of code.
<br>

### How to Use
Call the `.chain` method right after initializing the UI element. Then you can configure the element using dot notation and finally call `.component` to get your complete view element.
 -  Without UIKitChain
```Swift 
let circleView = UIView()
circleView.backgroundColor = .green
circleView.layer.cornerRadius = 50
circleView.layer.borderColor = UIColor.black.cgColor
circleView.layer.borderWidth = 1
circleView.clipsToBounds = true
circleView.translatesAutoresizingMaskIntoConstraints = false
```
 - With UIKitChain
```Swift
let circleView = UIView().chain.bgColor(.green).cornerRadius(50).clipToBounds(true).border(.black).activeAutoConstrant(false).component
```

### Add Missing Method or Variable

If there is any missing method or variable, You can add by extending the `UIKitChain` with the corresponding *UIKit element*.

```Swift
extension UIKitChain where Component: UIView {
    @discardableResult
    func roundView() -> Self {
        component.layer.cornerRadius = component.bounds.height/2
        return self
    }
}
```

<br><br>

You can find the original sample code [here](../../Example/MNkSupportUtilities/UIKitChain_comp.swift).

---
