//
//  Todos.swift
//  BBModelTodo
//
//  Created by Maeda Tasuku on 2/12/15.
//  Copyright (c) 2015 KinkumaDesign. All rights reserved.
//

import Foundation

class Todos: Collection {

    override init(models: [Model]?, options: [String : Any]?) {
        super.init(models: models, options: options)
        self.model = Todo.self
    }
    
    func getCompletedTodos()->[Todo]{
        var completedTodos = [Todo]()
        for aTodo in self.models {
            let todo = aTodo as Todo
            if todo.done {
                completedTodos.append(todo)
            }
        }
        return completedTodos
    }
}