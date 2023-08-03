import SwiftUI

struct HomeView: View {
    
    var body: some View {
        VStack {
            Text("Recipe.AI")
                .font(.system(.largeTitle, design: .rounded, weight: .medium))
                .foregroundColor(.blue)
                .fontWidth(.expanded)
            
            navBar
        }
    }
    
    var navBar: some View {
        TabView {
            Text("Tracker Screen") //replace with respective View
                .tabItem {
                    Label("Macros", systemImage: "list.clipboard")
                }
            FoodScannerView()
                .tabItem {
                    Label("Scan", systemImage: "barcode.viewfinder")
                }
            Text("Favorite Recipes Screen")
                .tabItem {
                    Label("Recipes", systemImage: "fork.knife.circle")
                }
            Text("Profile Screen")
                .tabItem {
                    Label("My Profile", systemImage: "person")
                }
        }
    }
}
