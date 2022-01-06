
# MNKViewController
A ViewController that has built on top of the UIViewController.

<br>

## Overview
MNKViewController contains several useful base functions that help programmers organize the codebase.

<br>

## Declaration

```swift
open class MNkViewController: UIViewController {

    open func createViews()

    open func insertAndLayoutSubviews()

    open func fetchData()

    open func updateUIWithNewData()

    open func config()

    open func setAppSetting()


    open var fetchingState: RepeatState

    public var isDisplayOnce: Bool

    public var safeAreaEdgeInsets: UIEdgeInsets

    public var safeAreaRect: CGRect
}
```

<br>

-  #### `createViews()`
                    
    > Use this function to create and configure subviews.

-   #### `insertAndLayoutSubviews()`

    > Use this function to insert and layout subviews to view.

-   #### `fetchData()`

    > Use this function to call API requests.

-   #### `updateUIWithNewData()`

    > You will need to manually address this function once the API response has been received. Use this function to organize the UI update configuration using API data. 

-   #### `config()`

    > Make any configuration you want to code here. In the *ViewController life circle*, it will only call once.

-   #### `setAppSetting()`

    > This will call from `viewWillAppear(_ animated: Bool)`. In the ViewController life circle, it will only call once.

    <br>

-   #### `fetchingState: RepeatState`

    > You can set the `fetchingState: RepeatState` state to `.once` or `.always`.  If you set it `.once`, it will call only once when the `viewWillAppear(_ animated: Bool)`.  When it has set to `.always`, `fetchData()` will call every `viewWillAppear(_ animated: Bool)` call in *viewController life circle*.

-   #### `isDisplayOnce: Bool`

    > You can identify whether is it is an *initial appearance* or not while using this variable.

-   #### `safeAreaEdgeInsets: UIEdgeInsets`
    > This will return the safe are edge inset values of your viewController. 

-   #### `safeAreaRect: CGRect`
    > Difference between `UIScreen.bounds` and the  `safeAreaEdgeInsets`. The filtered area frame will be returning as a `CGRect` value.
