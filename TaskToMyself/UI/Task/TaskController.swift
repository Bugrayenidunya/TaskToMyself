//
//  TaskViewController.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 10.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import CoreData
import Firebase
import UIKit

class TaskController: UIViewController {
    
    let viewModel = TaskViewModel()
    
    // Reference to managed object context for Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: Outlets
    
    @IBOutlet weak var taskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTableView.delegate = self
        taskTableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        
        // Load Data
        viewModel.fetchTask { (result) in
            switch result {
            case .success(let success):
                print(success)
                DispatchQueue.main.async {
                    self.taskTableView.reloadData()
                }
            case .failure(let error):
                print("Error occured while fetching data: \(error). File: \(#file), Line: \(#line)")
            }
        }
        
        // Reload data if needed
        viewModel.readyToRefreshTable = {
            self.taskTableView.reloadData()
        }
    }
    
    // MARK: Actions
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let title = "Alert.addNewTaskTitle".localized
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Alert.addButtonText".localized, style: .default) { (action) in
            
            guard let task = textField.text else { return }
            
            self.viewModel.addNewTask(task: task) { (result) in
                switch result {
                case .success(let task):
                    print("Task saved: \(task)")
                    // After add a new Task, Reload the tableView
                    self.viewModel.fetchTask { (result) in
                        switch result {
                        case .success( _):
                            // If fetch is success
                            DispatchQueue.main.async {
                                self.taskTableView.reloadData()
                            }
                        case .failure(let error):
                            print("Error occured while fetching data: \(error). File: \(#file), Line: \(#line)")
                        }
                    }
                case .failure(let error):
                    print("Error occured when adding Data: \(error). File: \(#file), Line: \(#line)")
                }
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Alert.textFieldPlaceholder".localized
            textField = alertTextField
        }
        // Add action to created alert
        alert.addAction(action)
        // Show  alert
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        viewModel.logoutFirebase { (result) in
            switch result{
            case .success(let success):
                self.navigationController?.popToRootViewController(animated: true)
                print("Logout Successful: \(success)")
            case .failure(let error):
                print("Error occured while trying to logout: \(error). File: \(#file), Line: \(#line)")
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TaskController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = viewModel.tasks[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CellIdintifierConstant.taskCell) else { return UITableViewCell() }
        
        cell.textLabel?.text = task.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // swipe to left and delete func
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            // Which Task will be removed
            let taskToRemove = viewModel.tasks[indexPath.row]
            // Remove the object
            self.context.delete(taskToRemove)
            // Save data
            do {
                try self.context.save()
            } catch {
                
            }
            // Reload the tableView
            viewModel.fetchTask { (result) in
                switch result {
                case .success( _):
                    print("Table reloaded after deleting a Task.")
                    DispatchQueue.main.async {
                        self.taskTableView.reloadData()
                    }
                case .failure(let error):
                    print("Error occured while fetching data: \(error). File: \(#file), Line: \(#line)")
                }
            }
            self.taskTableView.deleteRows(at: [indexPath], with: .fade)
            break
        default:
            break
        }
    }
}
