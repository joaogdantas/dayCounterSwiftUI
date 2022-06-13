import SwiftUI

class Counter: ObservableObject {
    
    @Published var days = 0
    @Published var hours = 0
    @Published var minutes = 0
    @Published var seconds = 0
    
    var selectedDate = Date()
    
    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            
            print(currentDate ?? 0)
            
            let selectedComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.selectedDate)
            
            var eventDataComponents = DateComponents()
            eventDataComponents.year = selectedComponents.year
            eventDataComponents.month = selectedComponents.month
            eventDataComponents.day = selectedComponents.day
            eventDataComponents.hour = selectedComponents.hour
            eventDataComponents.minute = selectedComponents.minute
            eventDataComponents.second = selectedComponents.second
            
            let eventDate = calendar.date(from: eventDataComponents)
            
            print(eventDate ?? 0)
            
            let timeLeft = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: eventDate!)
            
            if (timeLeft.second! >= 0) {
                
                self.days = timeLeft.day ?? 0
                self.hours = timeLeft.hour ?? 0
                self.minutes = timeLeft.minute ?? 0
                self.seconds = timeLeft.second ?? 0
                
            }
        }
    }
}

struct ContentView: View {
    @StateObject var counter = Counter()
    
    var body: some View {
        VStack {
            
            DatePicker(selection: counter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute, .date]) {
                Text("Selecione a data: ")
            }
            
            HStack {
                Text("\(counter.days) dias")
                Text("\(counter.hours) horas")
                Text("\(counter.minutes) min")
                Text("\(counter.seconds) seg")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
