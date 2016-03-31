//
//  ViewController.swift
//  To do List
//
//  Created by Mehta on 03/02/16.
//  Copyright © 2016 Mehta. All rights reserved.
//

import UIKit

var todolist = [String]()

class ViewController: UIViewController, UITextFieldDelegate {
  
    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var item: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(NSUserDefaults.standardUserDefaults().objectForKey("key") != nil){
            todolist = NSUserDefaults.standardUserDefaults().objectForKey("key") as! [String]
        }
        self.item.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        return todolist.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(todolist[indexPath.row])"
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            todolist.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(todolist, forKey: "key")
            TableView.reloadData()
        }
    }

    @IBAction func Done(sender: UIButton) {
        if((item.text) != ""){
            todolist.append(item.text!)
            item.text = ""
            NSUserDefaults.standardUserDefaults().setObject(todolist, forKey: "key")
            TableView.reloadData()
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        item.resignFirstResponder()
        return true
        
    }
 
    override func viewDidAppear(animated: Bool) {
        TableView.reloadData()
    }

}

