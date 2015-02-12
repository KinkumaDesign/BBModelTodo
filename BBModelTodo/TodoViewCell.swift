//
//  TodoViewCell.swift
//  BBModelTodo
//
//  Created by Maeda Tasuku on 2/12/15.
//  Copyright (c) 2015 KinkumaDesign. All rights reserved.
//

import UIKit

class TodoViewCell: UITableViewCell {
    @IBOutlet weak var checkmark:UIImageView!
    @IBOutlet weak var todoLabel:UILabel!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let bgView = UIView()
        bgView.backgroundColor = UIColor(rgba: "#e5f6ff")
        self.selectedBackgroundView = bgView
    }
    
    func setup(){
        self.bringSubviewToFront(checkmark)
    }
    
    func updateView(todo:Todo){
        let imageName = todo.done ? "checked" : "unchecked"
        let mark:UIImage? = UIImage(named: imageName)
        checkmark.image = mark
        todoLabel.text = todo.title
    }
}