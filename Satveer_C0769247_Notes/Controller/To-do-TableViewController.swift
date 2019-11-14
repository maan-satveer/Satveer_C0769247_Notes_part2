//
//  To-do-TableViewController.swift
//  Satveer_C0769247_Notes
//
//  Created by MacStudent on 2019-11-11.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class To_do_TableViewController: UITableViewController {
    //var list: [String]?
    var currentIndex = -1
    var FoldersDelegate: CellTableViewController?
    var folder_notes = Folder(folderName: "", notes : [String]())
     var selectedRows: [IndexPath]?
    
    @IBOutlet weak var delete: UIBarButtonItem!
   
    
    @IBOutlet weak var move_obj: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        move_obj.isEnabled = false
        delete.isEnabled = false
        tableView.allowsMultipleSelection = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //list = []
    }
    
    @IBAction func editing(_ sender: Any) {
        if move_obj.isEnabled == false && delete.isEnabled == false{
            move_obj.isEnabled = true
             delete.isEnabled = true
             
        }
        else {
             move_obj.isEnabled = false
            delete.isEnabled = false
        }
       
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Folder.folders[(FoldersDelegate?.currentIndex)!].notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath)

        // Configure the cell...
        let listname = Folder.folders[(FoldersDelegate?.currentIndex)!].notes[indexPath.row]

      cell.textLabel?.text = listname

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let detail = segue.destination as? NotesViewController{
                   detail.text_string = self
             
               if let tableViewCell = sender as? UITableViewCell{
                    if let index = tableView.indexPath(for: tableViewCell)?.row {
                        detail.Text_Note = Folder.folders[(FoldersDelegate?.currentIndex)!].notes[index]
                          currentIndex = index
        //            }
                      }
            }
//            if let moveFolder = segue.destination as? MoveViewController{
//                               moveFolder.notesDelegate = self
//                
//            }
        //
            
                }
    }
    func moveNotes(index: Int){
          
          selectedRows = tableView.indexPathsForSelectedRows!
          
          for i in selectedRows!{
              let move = Folder.folders[(FoldersDelegate?.currentIndex)!].notes[i.row]
              Folder.folders[index].notes.append(move)
          }
          
          deleteRow()
      }
    
    
    @IBAction func delete_object(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete", message: "Are you sure", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
             cancelAction.setValue(UIColor.brown, forKey: "titleTextColor")
            let deleteAction = UIAlertAction(title: "Delete", style: .default) { (action ) in
             
                self.deleteRow()
            }
            deleteAction.setValue(UIColor.red, forKey: "titleTextColor")
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
             self.present(alertController, animated: true, completion: nil)
    }
    
    func updateText(text: String) {
           //var newValue = text
           tableView.reloadData()
                 FoldersDelegate?.reloadfolder()
        guard Folder.folders[(FoldersDelegate?.currentIndex)!].notes != [] && currentIndex != -1 else {
                   
                   Folder.folders[(FoldersDelegate?.currentIndex)!].notes.append(text)
                   tableView.reloadData()
                   FoldersDelegate?.reloadfolder()
                   return
               }
               Folder.folders[(FoldersDelegate?.currentIndex)!].notes[currentIndex] = text
                let indexPath = IndexPath(item: currentIndex, section: 0)
               tableView.reloadRows(at: [indexPath], with: .middle)

       }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
      }
      override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
          tableView.cellForRow(at: indexPath)?.accessoryType = .detailButton
      }
     func deleteRow()
         {
    //         selectedRows = tableView.indexPathsForSelectedRows{
            selectedRows = tableView.indexPathsForSelectedRows
                var item = [String]()
                for indexPath in selectedRows!{
                    item.append(Folder.folders[(FoldersDelegate?.currentIndex)!].notes[indexPath.row])
                }
                for i in item {
                    if let index = Folder.folders[(FoldersDelegate?.currentIndex)!].notes.firstIndex(of: i)
                    {
                        Folder.folders[(FoldersDelegate?.currentIndex)!].notes.remove(at: index)
                    }
                }
                tableView.reloadData()
                FoldersDelegate?.tableView.reloadData()
            }
   
    

}
