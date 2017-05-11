//
//  TableViewController.swift
//  SwiftPropertyListDemo
//
//  Created by Cntt27 on 5/10/17.
//  Copyright © 2017 Cntt27. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var isColorInverted = true
    var color1 = UIColor(red: 0.3, green: 0.3, blue: 0.0, alpha: 1.0)
    let color2 = UIColor(white: 0.9, alpha: 1.0)
    var pies = ["Pizza","Chicken Pot","Shepherd's"]
    func readPropertyList(){
        
        var format = PropertyListSerialization.PropertyListFormat.xml //format of the property list
        var plistData:[String:AnyObject] = [:]  //our data
        let plistPath:String? = Bundle.main.path(forResource: "data", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)! //the data in XML format
        do{ //convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML,options: .mutableContainersAndLeaves,format: &format)as! [String:AnyObject]
            
            //assign the values in the dictionary to the properties
            isColorInverted = plistData["Inverse Color"] as! Bool
            
            let red = plistData["Red"] as! CGFloat
            let green = plistData["Green"] as! CGFloat
            let blue = plistData["Blue"] as! CGFloat
            color1 = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
            pies = plistData["Pies"] as! [String]
        }
        catch{ // error condition
            print("Error reading plist: \(error), format: \(format)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        readPropertyList()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let row = indexPath.row
        cell.textLabel?.text = pies[row]
        if isColorInverted { //invert colors by flag status
            cell.backgroundColor = color2
            cell.textLabel?.textColor = color1
        }else{
            cell.backgroundColor = color1
            cell.textLabel?.textColor = color2
        }
        return cell
    }
    
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pies"
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
