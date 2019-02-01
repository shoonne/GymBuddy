//
//  Workout.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-19.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//



import Foundation

class Workout {
    var muscleWorkout: String
    var workoutImage: String
    var name : String
    var place : String
   
    
    init(muscleWorkout: String, workoutImage: String, name: String, place : String) {
        self.muscleWorkout = muscleWorkout
        self.workoutImage = workoutImage
        self.name = name
        self.place = place
        
    }
    
    convenience init() {
        self.init(muscleWorkout: "", workoutImage: "", name: "", place : "")
    }
}
