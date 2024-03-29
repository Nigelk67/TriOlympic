//
//  DetailViewComponents.swift
//  TriOlympic
//
//  Created by Nigel Karan on 17.11.21.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var plan: Plan
    @ViewBuilder
    var body: some View {
        if plan.session == Sessions.swim.rawValue {
            SwimBackground()
        } else if plan.session == Sessions.ride.rawValue {
            BikeBackground()
        } else if plan.session == Sessions.run.rawValue {
            RunBackground()
        } else {
            RunBackground()
        }
    }
}

struct ImageDetailView: View {
    @ObservedObject private var scheduleVm = ScheduleViewModel()
    @State var session: String
    @State var completed: Int16?
    
    var body: some View {

        let imageName = scheduleVm.setImageNames(session: session, completed: completed ?? 0)
            Image(imageName)
                .padding(.horizontal,10)
        
    }
}

struct DayView: View {
    @State var day: String
    var body: some View {
        Text("Day: \(day)")
            .foregroundColor(Color.mainBackground)
            .font(.system(size: 28, weight: .medium, design: .rounded))
    }
}

struct TimeView: View {
    @State var minutes: String
    var body: some View {
        VStack {
            Text("Time")
                .foregroundColor(Color.mainText)
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .padding(.bottom,4)
            
            HStack(alignment: .firstTextBaseline) {
                Text(minutes)
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
                    
                Text("mins")
                    .foregroundColor(Color.mainText)
                    .font(.system(size: 14, weight: .light, design: .rounded))
                    .padding(.horizontal,-6)
            }
        }
    }
}
struct RpeView: View {
    @State var rpe: String
    var body: some View {
        VStack {
            Text("RPE")
                .foregroundColor(Color.mainText)
                .font(.system(size: 24, weight: .regular, design: .rounded))
                .padding(.bottom,4)
            Text(rpe)
                .foregroundColor(Color.mainText)
                .font(.system(size: 40, weight: .semibold, design: .rounded))
                .fontWeight(.semibold)
        }
        .padding()
    }
}
struct DescriptionView: View {
    @State var description: String
    var body: some View {
        Text(description)
            .foregroundColor(Color.mainText)
            .font(.body)
            .multilineTextAlignment(.center)
            .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
    }
}



