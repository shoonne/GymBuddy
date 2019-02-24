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
    

    weak var workout : WorkoutMO!
    
    @IBOutlet var textField1 : UITextField!
    @IBOutlet var textField2 : UITextField!
    @IBOutlet var textField3 : UITextField!
    @IBOutlet var imageView  : UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.text = workout.muscleWorkout
        textField2.text = workout.workoutDescription
        textField2.text = workout.place
        
        if let workoutImage = workout.workoutImage {
            imageView.image = UIImage(data: workoutImage as Data)
            
        }
        
        // Do any additional setup after loading the view.
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
