
import SwiftUI

struct HomeView: View {
    
    
    @State var timeIsShowing: Bool = false
    
    var body: some View {
        VStack {
                
            HStack {
                Spacer()
                VStack {
                    Text("20\nPoints")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(45)
                        .foregroundColor(.white)
                }.background(.pomodoroRed)
                    .clipShape(Corners(corner: [.bottomLeft], size: CGSize(width: 50, height: 50)))
            }
                        
            Spacer()
            
            VStackLayout(alignment: .leading, spacing: 10) {
                Text("Ready to be productive?")
                    .font(.title)
                    .fontWeight(.bold)
                Text("Complete a Pomodoro Session and collect points.")
            }.padding(20)

            Image("Pomodoro")
                .resizable()
                .scaledToFit()
                .padding([.leading, .trailing, .bottom], 40)
            
            Button("Start Pomodoro Session") {
               timeIsShowing = true
            }.font(.largeTitle)
                .foregroundColor(.pomodoroRed)
                .padding(.bottom, 60)
            
                .sheet(isPresented: $timeIsShowing){
                    NavigationView(){
                        PomodoroView()
                    }
                }
        }.edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomeView()
}
