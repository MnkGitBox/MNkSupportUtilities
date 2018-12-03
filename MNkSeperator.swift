//
//  MNkSeperator.swift
//  MNkSupportUtilities
//
//  Created by MNk_Dev on 3/12/18.
//

open class MNkSeperator:MNkView{
    private var color:UIColor?
    public init(_ color:UIColor,_ frame: CGRect = .zero) {
        self.color = color
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        insertAndLayoutSubviews()
        config()
    }
    override open func config() {
        backgroundColor = color
    }
    override open func insertAndLayoutSubviews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
