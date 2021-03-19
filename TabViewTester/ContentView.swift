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
        self.cycleTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { (timer) in
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
        
        withAnimation(.easeInOut(duration: 2.9)) {
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
        VStack {
            
            Spacer()
            
            Text("Version 1")
                .font(.largeTitle)
            
            Spacer()
            
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
}

struct ContentView2: View {
    
    @StateObject var model: ViewModel = ViewModel()
    
    @State var tabSelection: Int = 0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Text("Version 2")
                .font(.largeTitle)
            
            Spacer()
            
            TabView(selection: self.$tabSelection)  {
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
            .onChange(of: self.model.tabSelection, perform: { value in
                
                withAnimation(.easeInOut(duration: 2.9)) {
                    self.tabSelection = value
                }
                
        })
        }
        
//
//        })
        
    
    }
}


// Using animation passed into binding

struct ContentView3: View {
    
    @StateObject var model: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Version 3")
                .font(.largeTitle)
            
            Spacer()
            
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
}


// Tryin to stop all animation and force a transaction

struct ContentView4: View {
    
    @StateObject var model: ViewModel = ViewModel()
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Version 4")
                .font(.largeTitle)
            
            Spacer()
            
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
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView2()
            ContentView3()
            ContentView4()
        }
    }
}
