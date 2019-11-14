//
//  CellTableViewController.swift
//  Satveer_C0769247_Notes
//
//  Created by MacStudent on 2019-11-08.
//  Copyright © 2019 MacStudent. All rights reserved.
// github link
// https://github.com/maan-satveer/Satveer_C0769247_Notes.git

import UIKit

class CellTableViewController: UITableViewController {
    //var folder : [String]?
    var currentIndex = -1
   @IBOutlet var tabledata: UITableView!
    // var folder = Folder(folderName: "", notes: [String]())
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
               self.navigationItem.rightBarButtonItem?.tintColor = .white
self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
              self.view.backgroundColor = .lightGray
        //folder = []
    }
     // Create new folder
    @IBAction func new_folder(_ sender: UIBarButtonItem) {
        addnewfolder()
    }
    // function to create an alert
    func addnewfolder() {
        let alertctrl = UIAlertController(title: "New Folder", message: "Enter the name of folder", preferredStyle: .alert)
        alertctrl.addTextField { (textField) in
            textField.text = ""
        }
         let okAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let add = UIAlertAction(title: "AddItem", style: .default) { (action) in
            let text_name = alertctrl.textFields![0]
            var foldername = Folder(folderName: text_name.text!, notes: [] )
            var flag = false
            for i in Folder.folders{
               let name = foldername.folderName
            if name == i.folderName{
            flag = true
            break
            }
            }
               if flag == true{
                                   let alert = UIAlertController(title: "Name Taken", message: "Please choose a different name", preferredStyle: .alert)
                                   let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                                   alert.addAction(okAction)
                                   self.present(alert, animated: true, completion: nil)
                               }
                              else{
                                   foldername = Folder(folderName: text_name.text!, notes: [String]())
                                   Folder.folders.append(foldername)
                                   
                                   print(Folder.folders)
                                              self.tabledata.reloadData()
                              }
           
        }
        alertctrl.addAction(okAction)
        alertctrl.addAction(add)
        self.present(alertctrl, animated: true, completion: nil)
        alertctrl.view.tintColor = UIColor.black
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Folder.folders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell"){
            let f_name = Folder.folders[indexPath.row].folderName
            cell.textLabel?.text = f_name
            cell.imageView?.image = UIImage(named: "folder-icon")
            cell.detailTextLabel?.text = "\(Folder.folders[indexPath.row].notes.count)"
            cell.detailTextLabel?.textColor = UIColor.black
                          return cell
        }
        // Configure the cell...

        return UITableViewCell()
    }
    func reloadfolder()
    {
        tableView.reloadData()
        }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
         return "delete"
     }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Folder.folders.remove(at: indexPath.row)
              // Delete the row from the data source
                   tableView.deleteRows(at: [indexPath], with: .automatic)
                   tableView.reloadData()
               }
         
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
     if self.tableView.isEditing{
        return .none
     }
     else{
         return .delete
     }
    }
     override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
     }
     override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {

     }
    
  
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    // MARK: - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detail = segue.destination as? To_do_TableViewController{
                   detail.FoldersDelegate = self
                   
                   if let tableViewCell = sender as? UITableViewCell{
                       if let index = tableView.indexPath(for: tableViewCell)?.row {
                       currentIndex = index
                       }
                   }
               }
    }
    

}
