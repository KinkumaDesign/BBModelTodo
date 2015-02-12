//
//  Todo.swift
//  BBModelTodo
//
//  Created by Maeda Tasuku on 2/12/15.
//  Copyright (c) 2015 KinkumaDesign. All rights reserved.
//

import Foundation

class Todo: Model {
    
    var title:String?{
        get{ return self.get("title") as? String }
        set{ self.set("title", newValue!) }
    }
    
    var done:Bool{
        get{
            let aDone:Bool? = self.get("done") as? Bool
            return aDone ?? false
        }
        set{ self.set("done", newValue)}
    }
    
    override init(attributes: [String : Any]? = nil) {
        super.init(attributes: attributes)
        self.done = false
    }
    
    func toggle(){
        self.done = !self.done
    }
}