//
//  BrickDetailContentView.swift
//  TriOlympic
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct BrickDetailContentView: View {
    
    @Binding var plan: Plan
    @State private var showMapView: Bool = false
    @State private var showManualEntryView: Bool = false
    @State private var planComplete = false
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(plan: $plan)
                VStack {
                    DayView(day: plan.day ?? "")
                        .padding(.vertical, 30)
                    Spacer()
                    ScrollView {
                        RideStack(plan: $plan, showMapView: $showMapView, showManualEntryView: $showManualEntryView, planComplete: $planComplete)
                        RunStack(plan: $plan, showMapView: showMapView, showManualEntryView: $showManualEntryView, planComplete: $planComplete)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
            .onAppear {
                if plan.completed == 1 {
                    planComplete = true
                } else {
                    planComplete = false
                }
            }
        
        }
        
    }
}

struct RideStack: View {
    @Binding var plan: Plan
    @Binding var showMapView: Bool
    @Binding var showManualEntryView: Bool
    @Binding var planComplete: Bool
    @State private var isSwim = true
    //@Binding var showRatingsView: Bool
    var body: some View {
        VStack {
            HStack {
                EnterManuallyButton(isDisabled: $planComplete, showManualEnterView: $showManualEntryView)
            }
            HStack {
                Image(TrainingImageNames.trainingRide.rawValue)
                    .padding(.horizontal, 10)
                Spacer()
                TimeView(minutes: plan.rideTime ?? "")
                Spacer()
                RpeView(rpe: plan.rideRpe ?? "")
            }
            .padding(.horizontal,0)
            .padding(.vertical,20)
            
            DescriptionView(description: plan.rideDescription ?? "")
            
            NavigationLink(destination: EnterManualView(plan: $plan, targetTime: plan.rideTime ?? ""), isActive: $showManualEntryView) { EmptyView() }
            
            NavigationLink(destination: MapView(plan: $plan, targetTime: plan.rideTime ?? "", targetRpe: plan.rideRpe ?? "", targetDesc: plan.rideDescription ?? "", session: "Ride"), isActive: $showMapView) { EmptyView()}
            
            if plan.session == Sessions.swim.rawValue {
                LetsGoButton(isDisabled: $isSwim, showMapView: $showMapView)
                    .padding(.bottom)
            } else {
                LetsGoButton(isDisabled: $planComplete, showMapView: $showMapView)
                    .padding(.bottom)
            }
    
        }
        .frame(width: 350)
        .background(Color.white.opacity(0.5))
        .cornerRadius(20)
    }
}

struct RunStack: View {
    @Binding var plan: Plan
    @State var showMapView: Bool
    @Binding var showManualEntryView: Bool
    @Binding var planComplete: Bool
    @State private var isSwim = true
    //@Binding var showRatingsView: Bool
    var body: some View {
        VStack {
            HStack {
                EnterManuallyButton(isDisabled: $planComplete, showManualEnterView: $showManualEntryView)
            }
            HStack {
                Image(TrainingImageNames.trainingRun.rawValue)
                    .padding(.horizontal, 10)
                Spacer()
                TimeView(minutes: plan.runTime ?? "")
                Spacer()
                RpeView(rpe: plan.runRpe ?? "")
            }
            .padding(.horizontal,0)
            .padding(.vertical,20)
            
            DescriptionView(description: plan.runDescription ?? "")
            
            NavigationLink(destination: EnterManualView(plan: $plan, targetTime: plan.runTime ?? ""), isActive: $showManualEntryView) { EmptyView() }
            
            NavigationLink(destination: MapView(plan: $plan, targetTime: plan.runTime ?? "", targetRpe: plan.runRpe ?? "", targetDesc: plan.runDescription ?? "", session: "Run"), isActive: $showMapView) { EmptyView()}
            
            if plan.session == Sessions.swim.rawValue {
                LetsGoButton(isDisabled: $isSwim, showMapView: $showMapView)
                    .padding(.bottom)
            } else {
                LetsGoButton(isDisabled: $planComplete, showMapView: $showMapView)
                    .padding(.bottom)
            }
        }
        .frame(width: 350)
        .background(Color.white.opacity(0.5))
        .cornerRadius(20)
    }
}

//struct BrickDetailContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrickDetailContentView(plan: .constant(Plan()))
//    }
//}
