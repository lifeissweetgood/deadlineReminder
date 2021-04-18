//
//  ContentView.swift
//  deadlineReminder
//
//  Created by Daphne Larose on 4/16/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @State var weekendsRemaining = determineHowManyWeekendsLeft();
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.purple.ignoresSafeArea()
            VStack {
                Text("# of Weekends Until End of August:\n")
                    .font(.system(size: 40, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Text("\(weekendsRemaining)")
                    .font(.system(size: 100, weight: .bold, design: .serif))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.orange)
                    .onReceive(timer) { _ in
                        weekendsRemaining = determineHowManyWeekendsLeft()
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().navigationTitle("Deadline for MR Augmented Show")
    }
}

func determineHowManyWeekendsLeft() -> Int {
    let today = Date()
    var comps = DateComponents.init()
    comps.weekday = 7 // saturday
    
    var matchingDates = [Date]()
    let cal = Calendar.autoupdatingCurrent
    let endComps = DateComponents.init(year: 2021, month: 8, day: 31)
    let endDate = cal.date(from: endComps)!
    cal.enumerateDates(startingAfter: today,
                       matching: comps,
                       matchingPolicy: .nextTime) { (date, strict, stop) in
        if let date = date {
            if date <= endDate {
                matchingDates.append(date)
            } else {
                stop = true
            }
        }
    }
//    print("Matching dates = \(matchingDates)") // for debugging
    return matchingDates.count;
}
