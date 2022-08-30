//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Max Shu on 26.08.2022.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showingSorting = false
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
//                    VStack(alignment: .leading) {
//                        Text(prospect.name)
//                            .font(.headline)
//                        Text(prospect.emailAddress)
//                            .foregroundColor(.secondary)
//                    }
                    
                    // 1. Add an icon to the “Everyone” screen showing whether a prospect was contacted or not.
                HStack {
                        Image(systemName: prospect.isContacted ?
                              "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.fill.badge.xmark")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .foregroundColor(prospect.isContacted ? .green : .red)
                        
                    VStack(alignment: .leading) {
                        Text(prospect.name)
                            .font(.headline)
                        Text(prospect.emailAddress)
                            .foregroundColor(.secondary)
                        }
                }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.red)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
                // 3. Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent.
                
                ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            showingSorting = true
                        } label: {
                            Label("Sorting", systemImage: "arrow.up.arrow.down")
                        }
                        .contextMenu {
                            sortingFilter
                        }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Max Shu\nshulyakmaksim@gmail.com", completion: handleScan)
            }
            
            // 3. Use a confirmation dialog to customize the way users are sorted in each tab – by name or by most recent.
            .confirmationDialog("Sorting", isPresented: $showingSorting) {
                sortingFilter
            }
        }
    }
    
    var sortingFilter: some View {
        VStack {
            Button {
                prospects.toggle(.nameAscending)
            } label: {
                Text("By name")
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh!")
                    }
                }
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scanning failure: \(error.localizedDescription)")
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
