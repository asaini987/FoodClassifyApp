import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Recipe.AI")
                .font(.system(.largeTitle, design: .rounded, weight: .medium))
                .foregroundColor(.blue)
                .fontWidth(.expanded)
                .padding(.bottom)
            
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
            FoodAdderView(viewModel: FoodAdderViewModel())
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
