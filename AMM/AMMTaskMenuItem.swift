//
//  AMMTaskMenuItem.swift
//  AMM
//
//  Created by Sinkerine on 30/01/2017.
//  Copyright © 2017 sinkerine. All rights reserved.
//

import Cocoa

class AMMTaskMenuItem: NSMenuItem {
    var viewController: AMMTaskMenuItemViewController? = nil
    var task: Aria2Task = Aria2Task()
    var isDisplayed: Bool = false{
        didSet {
            if isDisplayed {
                self.isHidden = false
                self.isEnabled = true
                self.view = self.viewController?.view
            } else {
                self.isHidden = true
                self.view = nil
            }
        }
    }
    
    init() {
        self.viewController = AMMTaskMenuItemViewController(task: Aria2Task())
        super.init(title: "", action: nil, keyEquivalent: "")
        self.isHidden = true
        self.view = nil
    }
    
    func updateView(withTask task: Aria2Task) {
        self.task.copy(fromTask: task)
        self.viewController?.task.copy(fromTask: task)
        self.isDisplayed = true
    }
    
    required init(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
