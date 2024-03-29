//
//  DetailContentView.swift
//  TriOlympic
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct DetailContentView: View {
    
    @Binding var plan: Plan
    //@Binding var showRatingsView: Bool
    @State private var showMapView = false
    @State private var showManualEntryView = false
    @State private var planComplete = false
    @State private var isSwim = true
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView(plan: $plan)
                VStack {
                    CancelButton(presentationMode: presentationMode)
                        .padding(.leading,30)
                    
                    DayView(day: plan.day ?? "")
                        .padding(.vertical, 30)
                    
                    scrollView

                }
                .onAppear {
                    setUI()
                }
            }
            .navigationBarHidden(true)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CancelButton(presentationMode: presentationMode)
                }
            }
        }
    }
    
}

extension DetailContentView {
    
    private var scrollView: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    EnterManuallyButton(isDisabled: $planComplete, showManualEnterView: $showManualEntryView)
                }
                HStack {
                    ImageDetailView(session: plan.session ?? "", completed: plan.completed)
                    Spacer()
                    setTime()
                    Spacer()
                    setRpe()
                }
                .padding(.horizontal,0)
                .padding(.vertical,20)
                
                setDescription()
                
                NavigationLink(destination: EnterManualView(plan: $plan), isActive: $showManualEntryView) { EmptyView() }
                
                NavigationLink(destination: MapView(plan: $plan), isActive: $showMapView) { EmptyView() }
                
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
    
    private func setTime() -> TimeView {
        if plan.session == Sessions.swim.rawValue {
            let time = plan.swimTime
            return TimeView(minutes: time ?? "")
        } else if plan.session == Sessions.ride.rawValue {
            let time = plan.rideTime
            return TimeView(minutes: time ?? "")
        } else if plan.session == Sessions.run.rawValue {
            let time = plan.runTime
            return TimeView(minutes: time ?? "")
        }
        return TimeView(minutes: "")
    }
    
    private func setRpe() -> RpeView {
        if plan.session == Sessions.swim.rawValue {
            let rpe = plan.swimRpe
            return RpeView(rpe: rpe ?? "")
        } else if plan.session == Sessions.ride.rawValue {
            let rpe = plan.rideRpe
            return RpeView(rpe: rpe ?? "")
        } else if plan.session == Sessions.run.rawValue {
            let rpe = plan.runRpe ?? ""
            return RpeView(rpe: rpe)
        }
        return RpeView(rpe: "")
    }
    
    private func setDescription() -> DescriptionView {
        if plan.session == Sessions.swim.rawValue {
            let desc = plan.swimDescription
            return DescriptionView(description: desc ?? "")
        } else if plan.session == Sessions.ride.rawValue {
            let desc = plan.rideDescription
            return DescriptionView(description: desc ?? "")
        } else if plan.session == Sessions.run.rawValue {
            let desc = plan.runDescription
            return DescriptionView(description: desc ?? "")
        }
        return DescriptionView(description: "")
    }
    
    private func setUI() {
        if plan.completed == 1 {
            planComplete = true
        } else {
            planComplete = false
        }
    }
    
}


//struct DetailContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailContentView(plan: .constant(Plan()))
//    }
//}
