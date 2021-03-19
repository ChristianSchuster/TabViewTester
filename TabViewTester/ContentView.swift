//
//  ContentView.swift
//  TabViewTester
//
//  Created by Christian Schuster on 19.03.21.
//

import SwiftUI


class ViewModel: ObservableObject {
    
    // Currently selected tab
    @Published var tabSelection: Int = 0
    
    // Timer for cycling throu views
    private var cycleTimer: Timer?
    
    
    func startAutocycle() {
        self.cycleTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (timer) in
            print("Tab thru timer fired.")
            self.autocycle()
        }
        
    }
    
    
    func stopAutocycle() {
        self.cycleTimer?.invalidate()
        self.cycleTimer = nil
    }
    
    /* *********************************************** */
    /* ****** Mark: Here the index is changed ******** */
    /* *********************************************** */
    
    
    func autocycle() {
        
        withAnimation(.interactiveSpring()) {
            if ( self.tabSelection < 3 ) {
                self.tabSelection += 1
            } else {
                self.tabSelection = 0
            }
        }
    }

}

struct ContentView: View {
    
    @StateObject var model: ViewModel = ViewModel()
    
    var body: some View {
        
        TabView(selection: self.$model.tabSelection)  {
                    Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous).foregroundColor(.blue))
                    Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous).foregroundColor(.green))
                    Text("Tab Content 3").tabItem { Text("Tab Label 3") }.tag(3)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous).foregroundColor(.red))
                }
        .tabViewStyle(PageTabViewStyle())
        .foregroundColor(.white)
        .onAppear(){
            self.model.startAutocycle()
        }
        
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
