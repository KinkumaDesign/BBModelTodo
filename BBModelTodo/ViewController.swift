//
//  ViewController.swift
//  BBModelTodo
//
//  Created by Maeda Tasuku on 2/12/15.
//  Copyright (c) 2015 KinkumaDesign. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var inputTextField:UITextField!
    @IBOutlet weak var todoListTableView:UITableView!
    @IBOutlet weak var clearButton:UIButton!
    private var todoListTableViewTapGesture:UITapGestureRecognizer!
    
    private var _todos:Todos = Todos(models: nil, options: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        todoListTableViewTapGesture = UITapGestureRecognizer(target: self, action: "onTodoListTableViewTap")
        todoListTableViewTapGesture.cancelsTouchesInView = false
        todoListTableView.addGestureRecognizer(todoListTableViewTapGesture)
        
        inputTextField.delegate = self
        
        self._todos.on(Collection.Event.ADD) {
            [unowned self](model, collection, options) in
            let addIndexPath = NSIndexPath(forRow: collection.length - 1, inSection: 0)
            self.todoListTableView.insertRowsAtIndexPaths([addIndexPath],
                withRowAnimation: UITableViewRowAnimation.Automatic)
            self.todoListTableView.scrollToRowAtIndexPath(addIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
        
        self._todos.on(Collection.Event.REMOVE) {
            [unowned self](model, collection, options:[String:Any]?) in
            let removeIndex = options?["index"] as Int
            let removeIndexPath = NSIndexPath(forRow: removeIndex, inSection: 0)
            self.todoListTableView.deleteRowsAtIndexPaths([removeIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        inputTextField.resignFirstResponder()
    }

    @IBAction func onClearButtonTap(){
        let completedTodos = self._todos.getCompletedTodos()
        self._todos.remove(completedTodos)
    }
    
    func onTodoListTableViewTap(){
        self.inputTextField.resignFirstResponder()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _todos.length
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TodoViewCell? = tableView.dequeueReusableCellWithIdentifier("TodoViewCell", forIndexPath: indexPath) as? TodoViewCell
        cell?.setup()
        let todo:Todo = _todos.at(indexPath.row) as Todo
        cell?.updateView(todo)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.inputTextField.resignFirstResponder()
        
        var cell:TodoViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? TodoViewCell
        if let aCell = cell {
            var todo:Todo = _todos.at(indexPath.row) as Todo
            todo.toggle()
            aCell.updateView(todo)
            aCell.selected = false
        }
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let text = textField.text
        if let aText = text {
            if countElements(aText) > 0 {
                let todo = Todo()
                todo.title = aText
                self._todos.add(todo)
                textField.text = ""
                textField.resignFirstResponder()
            }
        }
        return true
    }
}


