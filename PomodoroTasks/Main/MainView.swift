import SwiftUI
import SwiftUINavigation

struct MainView: View {
    @StateObject private var vm: MainViewModel
    @EnvironmentObject private var q: MainViewModel

    init(vm: MainViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            weekDaysPicker

            ForEach(vm.tasks) { taskViewModel in
                TaskView(vm: taskViewModel)
            }

            addNewTaskButton
        }
        .frame(width: 300)
        .padding()
    }

    private var weekDaysPicker: some View {
        Picker(selection: $vm.dayPickerSelection) {
            ForEach(Array(vm.daysOfWeek.enumerated()), id: \.offset) { _, dayOfWeek in
                Button(dayOfWeek) {

                }
            }
        } label: {}
        .pickerStyle(.segmented)
    }

    private var addNewTaskButton: some View {
        Button("+", action: vm.addNewTaskButtonPressed)
            .popover(
                unwrapping: $vm.destination,
                case: /MainViewModel.Destination.addingNewTask
            ) { destination in
                AddingNewTaskView(vm: destination.wrappedValue)
            }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: MainViewModel())
            .environmentObject(MainViewModel())
        MainView(vm: MainViewModel())
    }
}
