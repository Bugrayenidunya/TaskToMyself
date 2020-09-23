//
//  TaskViewModel.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 18.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import CoreData
import Firebase

class TaskViewModel {
    
    // Listen for if needed to reload data
    var readyToRefreshTable: (() -> Void)?
    
    // Reference to managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    var tasks: [Task] = []
    
    func addNewTask(task: String, completion: @escaping(Swift.Result<Task, TaskError>) -> Void) {
        
        let newTask = Task(context: self.context)
        newTask.body = task
        newTask.isDone = false
        newTask.dueDate = Date()
        
        // Save the data
        do {
            try self.context.save()
            completion(Swift.Result.success(newTask))
        } catch  {
            print("Error occured when saving Task: \(error). File: \(#file), Line: \(#line)")
        }
        readyToRefreshTable?()
    }
    
    // Get Task from Core Data
    func fetchTask(completion: @escaping(Swift.Result<Bool, Error>) -> Void) {
        do {
            let request = Task.fetchRequest() as NSFetchRequest<Task>
            
            self.tasks = try context.fetch(request)
            
            completion(Swift.Result.success(true))
            
            readyToRefreshTable?()
        } catch {
            print("Error occured while fetching data: \(error). File: \(#file), Line: \(#line)")
        }
    }
    
    func logoutFirebase(completion: @escaping(Swift.Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            
            completion(Swift.Result.success(true))
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
