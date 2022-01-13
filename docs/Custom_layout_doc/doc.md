# Custom Layout
Auto Layout made easy with the Custom Layout.
<br>

### How to Use
You can call `activateLayouts` method provided by the **Custom Layout** framework. Then provided layout will activate to *superView*.

 -  Without Custom Layout
```Swift 
view.addSubview(redView)

view.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([redView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                    constant: 50),
                            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                    constant: -50),
                            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                                    constant: 40),
                            redView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                    constant: -20)])
```
 - With Custom Layout
```Swift
view.addSubview(redView)

redView.activateLayouts([.leading: 50, .traling: -50, .top: 40, .bottom: -20], layoutToSafeArea: true)
```

### Layout to sibling views
Custom Layout not only helps to layout subviews to its super view. We can use it to layout view components with other views who share the same ancestors.
```Swift
blueView.activateLayouts(to: [redView : [.leading: 0, .traling: 0, .height: 50],
                                         view : [.centerY: 0]], layoutToSafeArea: true)
```

<br><br>

You can find the original sample code [here](../../Example/MNkSupportUtilities/CustomLayout_comp.swift).

---