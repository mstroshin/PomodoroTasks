import SwiftUI

struct MainView: View {
    @StateObject private var vm = MainViewModel()

    var body: some View {
        VStack {
            Picker(selection: $vm.dayPickerSelection) {
                ForEach(Array(vm.daysOfWeek.enumerated()), id: \.offset) { _, dayOfWeek in
                    Button(dayOfWeek) {

                    }
                }
            } label: {}
            .pickerStyle(.segmented)
        }
        .frame(width: 300)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
