//
//  TrainingArrayViewModel.swift
//  TriOlympic
//
//  Created by Nigel Karan on 13.11.21.
//

import SwiftUI
import Combine

class TrainingPlanArrayViewModel: ObservableObject {
    
    @Published var trainingPlan = Array<Dictionary<String, Any>>()
    @Published var isSaving: Bool = false
    @Published var hasLoadedPlans: Bool = false
    @Published var numberOfTrainingDaysArray = ["3","4","5"]
    
    func fetchPlanArray(name: String) {
        let resource = "\(name)Day"
        let path = Bundle.main.path(forResource: resource, ofType: "plist")
        var array: NSArray?
        array = NSArray(contentsOfFile: path!)
        trainingPlan = array as! [Dictionary<String, Any>]
        
        savePlanToCoreData(trainingPlan: trainingPlan)
    }
    
    func savePlanToCoreData(trainingPlan: [Dictionary<String, Any>]) {
        for dict in trainingPlan {
            
            let training = TrainingPlan(dictionary: dict)
            let context = PersistenceController.shared.container.viewContext
            let plan = Plan(context: context)
            plan.completed = Int16(training.completed)
            plan.week = Int16(training.week)
            plan.session = training.session
            plan.phase = training.phase
            plan.day = training.day
            plan.swimDescription = training.swimDescription
            plan.swimRpe = training.swimRpe
            plan.swimTime = training.swimTime
            plan.rideRpe = training.rideRpe
            plan.rideTime = training.rideTime
            plan.rideDescription = training.rideDescription
            plan.runTime = training.runTime
            plan.runRpe = training.runRpe
            plan.runDescription = training.runDescription
            
            do {
                try context.save()
            } catch {
                print("Error saving to CoreData")
            }
        }
        
        

    }
    
    func showLoadingSpinner() {
        self.isSaving = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isSaving = false
            self.hasLoadedPlans = true
        }
    }
}

