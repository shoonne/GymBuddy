//
//  DetailViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-19.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: WorkoutDetailViewHeader!
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutDetailIconTextCell.self), for: indexPath) as! WorkoutDetailIconTextCell
            cell.workoutDescriptionLabel.text = workout.workoutDescription
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutDetailSeperatorCell.self), for: indexPath) as! WorkoutDetailSeperatorCell
            cell.titleLabel.text = "WORKOUT LOCATION"
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutDetailMapCell.self), for: indexPath) as! WorkoutDetailMapCell
            if let place = workout.place {
                cell.configure(location: place)
            }
            return cell


        default:
            fatalError("failed")
        }
    }
    
    
   

    
    weak var workout : WorkoutMO!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    
        headerView.workoutMuscleLabel.text = workout.muscleWorkout
        if let workoutImage = workout.workoutImage {
            headerView.headerImageView.image = UIImage(data: workoutImage as Data)

        }
        
        navigationController?.navigationBar.tintColor = .black
        

        // Do any additional setup after loading the view.
    }
    
    // Pass data to the new segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditView" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! EditWorkoutViewController
                destinationController.workout.muscleWorkout = workout.muscleWorkout
                
            }
        }
    }
    
   
    

  
}
