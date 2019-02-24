//
//  WorkoutFactsTableTableViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-02-10.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit

class WorkoutFactsTableTableViewController: UITableViewController {
    // MARK - WORKOUT FACTS TEXT
    let legFacts = NSLocalizedString("In case you missed it: Strong legs are super-important—beyond just looking awesome in a booty pic. They’re literally what keep you moving all day, so building strength in your lower half (yes, butt included) is crucial. Unfortunately, too many people neglect leg day a) because they think they’re already working their legs all day and b) because the leg muscles are so large to begin with, it takes longer to see results, says Emily Samuel, a NASM-certified trainer at the Dogpound in New York City. Don’t do that! “You should be training your legs at least once a week,” she says. #NeverSkipLegDay. Start working three or four of these moves into your workout routine, and switching things up every couple of weeks. You may not see the difference right away, but you’ll definitely feel it.Leg day consists of exercises for several muscle groups, as discussed above, and many of the exercises are among the most demanding movements you'll do in any given week. Sometimes that makes training hamstrings an afterthought. Rather than trying to muster the energy to push through ham-specific movements, many bodybuilders simply opt to train their hammies on another day, often separated by at least 48 hours from their main quad session.", comment: "Leg Facts")
    var armsFacts = NSLocalizedString("Resistance training that improves your upper body strength is the best way to get lean, toned and strong. Use your own body weight or, even better, add dumbbells or kettlebells. A great starting point is with five- to 10-pound dumbbells or a 15- to 20-pound kettlebell – but remember, good form and control is important. To avoid injury, move up to heavier weights only when you are comfortable that you’re strong enough to handle it.Next time you're looking to get in an arm workout at home, try combining 4 to 6 of the 16 moves below to create a workout—doing 45 seconds of each move, with 15 seconds of rest in between, and then repeating the whole thing three times, is a good place to start. Some of these arm exercises focus more on specific muscles like the triceps, while others will really challenge the shoulder muscles (including the deltoids and rhomboids), the pecs, and latissimus dorsi (or the lats, the broadest muscles on each side of your back). These are all important areas to strengthen, not only so you can lift heavier weights, but also so you can comfortably perform activities of daily living like carrying grocery bags or lifting your suitcase.Sticking to the same grip from workout to workout, month after month, is a mistake. This is a problem if you're wanting jacked arms. Without variety, you're overstressing the same movement and muscle recruitment patterns. Your arms adapt from the same form of stress. A lack of variety can lead to a desensitized training effect, aggravate the elbow from overuse, and leave you with unbalanced arm development.While you can't completely isolate a muscle within a muscle group, you can give the elbows a rest from redundant movement patterns, and stimulate stagnant muscle fibers. Here's a quick overview of different hand positions and how they'll affect your training response.", comment: "Arm facts")
    var backFacts = NSLocalizedString("If you are—or aspire to be—a physique competitor or bodybuilder, I don't need to impress upon you how critical it is to have a well-developed back. As for the rest of you, I get that it may take some convincing. You don't see your back when you're looking in the mirror, and people don't see it when you're entering a room, so it's understandable if back development isn't at the top of your workout schedule. But ask yourself this: What do people see when they look at you from behind? Are they dazzled by a rugged, thick, flaring wedge of iron? Or is there a void between your shoulders; a flat, muscle-less expanse that cries weakness? You've got to respect your back, brother, so here are six workouts for six specific back-development goals. Choose the one (or more) that matches your individual needs, then go after it for 4-6 weeks to become a true 360-degree badass.", comment: "Back facts")
      var absFacts = NSLocalizedString("How do you train to get six-pack abs? You can do it with long and complicated training, like many people do, but in my book, the best ab workout is the one you'll do over and over again.Yes, it's true that that abs are earned in the kitchen—not the gym. But if six-pack abs are your goal, it's also important to pick the right ab workout for the job. Here is the thing that many people, including a lot of trainers, overlook: diet. The single most important tool that you need in order to develop your abs is diet. Regardless of what you've heard, or what the latest hyped up fat loss pill promised you, abs are made in the kitchen and not in the gym. You could have the best training program of all time, but if your diet sucks, so will your abs. In fact, diet is responsible for about 90% of your results. The secret to six pack abs is not locked in a supplement pill or found in an ab workout or gadget. Instead of falling for the empty promises, spend your time focusing on the things that matter, like solid nutrition principles, and leave the rest of the stuff alone.So, no, the odds are not in your favor, but you can work toward a more defined midsection by developing core strength and reducing overall body fat. Although everyone responds differently to diet and exercise — and you should consult with a healthcare provider before changing things up — here are the lifestyle tips that have worked for three trainers who have particularly chiseled abs. Eat carbs. Though protein is a big part of her diet, Gozo says she doesn't shy away from carbohydrate-packed foods like fruit, rice, and other whole grains. That's because these foods are also rich sources of fiber, which aid in digestion and reduce bloating.", comment: "Abs facts")
    var conditionFacts = NSLocalizedString("The short, non-scientific answer to how often to do cardio workouts is to do more than you probably think you should and more than you really want to or have the time for.The longer answer is that it depends on your fitness level, schedule, and goals. If you want to be healthy and aren't worried about losing weight, getting in 20-30 minutes of moderate activity every day can do you some good. But, for weight loss, it's a whole other story. And it's not just about frequency. It's about intensity as well. If you only do moderate workouts, you can probably workout every day. But, if you do high-intensity interval training, you may need more rest days in between workout days. The bottom line is that it's better to have a mixture of the two so that you're working different energy systems and giving your body something different to do so you don't burn out.Frequency is the number of cardio training sessions performed per day or per week. This will be dependent on training status and intensity. 2 to 5 sessions per week will suffice. This depends on concurrent training — in other words, what other activities and/or sports you’re doing. You can attain health benefits by expending as little as 150 calories per day via cardio training. 20 minutes of cardio training, 3 times per week can maintain cardiovascular fitness levels (assuming the intensity is appropriate).Intensity of the cardio training can be monitored via heart rate response or oxygen uptake. The most practical method is measuring heart rate using a heart rate monitor or a simple pulse count. To attain optimal cardiovascular fitness, exercise between 60-90% of maximal heart rate (50-85% of heart rate reserve).", comment: "Conditino facts")
    
    // MARK - WORKOUT MUSCLE GROUPS
    var leg = NSLocalizedString("Leg", comment: "Legs")
    var arm = NSLocalizedString("Arms", comment: "Arms")
    var back = NSLocalizedString("Back", comment: "Back")
    var abs = NSLocalizedString("Abs", comment: "Abs")
    var condition = NSLocalizedString("Condition", comment: "Condition")

    
    
    var workoutsExercises : [String] = []
    var workoutPictures : [String] = []
    var workoutImages = ["Leg", "Arms", "Back", "Abs","Condition"]
    var workoutIcons = ["ILegs", "IArms", "IBack", "IAbs","ICondition"]
    var workoutFacts: [String] = []
    

    
    // 569
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white
        // APPEND THE LEG FACTS
        workoutFacts.append(legFacts)
        workoutFacts.append(armsFacts)
        workoutFacts.append(backFacts)
        workoutFacts.append(absFacts)
        workoutFacts.append(conditionFacts)
        
        // APPEND THE MUSCLES
        workoutsExercises.append(leg)
        workoutsExercises.append(arm)
        workoutsExercises.append(back)
        workoutsExercises.append(abs)
        workoutsExercises.append(condition)
        
        // APPEND THE IMAGE NAMES
        
        workoutPictures.append(leg)
        workoutPictures.append(arm)
        workoutPictures.append(back)
        workoutPictures.append(abs)
        workoutPictures.append(condition)
        






        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workoutsExercises.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "dataCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! WorkoutFactsTableViewCell
        cell.workoutNameLabel?.text = workoutsExercises[indexPath.row]
        cell.workoutImage?.image = UIImage(named: workoutsExercises[indexPath.row])
        
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWorkoutFactsDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! WorkoutFactsDetailViewController
                destinationController.workoutImageName = workoutImages[indexPath.row]
                destinationController.workoutDescription = workoutFacts[indexPath.row]
                destinationController.workoutIconImageName = workoutIcons[indexPath.row]
                
            }
        }
    }
 

}
