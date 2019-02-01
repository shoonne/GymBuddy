//
//  EditWorkoutViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-01-26.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit
import CoreData

class EditWorkoutViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var workoutArray = [WorkoutMO]()

    
    @IBOutlet weak var muscleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!


    var workout : WorkoutMO!
    var managedObjectContext : NSManagedObjectContext!
    var entry : NSManagedObject!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        muscleTextField.text = workoutArray[0].muscleWorkout
        
        
        // Do any additional setup after loading the view.
    }
    
    func loadItems(){
        // Create a new constant and specify it as a NSFetchRequest
        // And make it fetch data in form of Item. You have to specify the type
        let request : NSFetchRequest<WorkoutMO> = WorkoutMO.fetchRequest()
        
        do{
            workoutArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
