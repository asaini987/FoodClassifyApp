import SwiftUI

struct FoodAdderView: View {
    @State var scannedText = ""
    @ObservedObject var viewModel: FoodAdderViewModel
    var body: some View {
        VStack {
            Text("Food Analyzer")
                .font(.largeTitle)
                .fontWeight(.bold)
            textOutput
                .padding()
            addFoodButton
            getFoodInfoButton
        }
        
        
    }
    
    var textOutput: some View {
        TextEditor(text: $scannedText)
            .padding()
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 4, x: 2, y: 2)
    }
    
    var addFoodButton: some View {
        Button {
            Task {
                scannedText = await viewModel.addFood(food: scannedText)
            }
        } label: {
            Text("Add Food")
                .padding()
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 200, height: 50)
                .background(.blue)
                .cornerRadius(10)
        }
    }
    
    var getFoodInfoButton: some View {
        Button {
            Task {
                scannedText = await viewModel.getFoodInfo(food: scannedText)
            }
        } label: {
            Text("Get Food Info")
                .padding()
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 200, height: 50)
                .background(.blue)
                .cornerRadius(10)
        }
    }
}
