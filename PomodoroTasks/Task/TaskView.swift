import SwiftUI
import SwiftUINavigation

struct TaskView: View {
    @StateObject var vm: TaskViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(vm.title)

                HStack {
                    ForEach(vm.timers) { timer in
                        Text("\(timer.time.timeIntervalSince1970)")
                    }

                    Button("+", action: vm.addingPomodoroButtonPressed)
                        .popover(
                            unwrapping: $vm.destination,
                            case: /TaskViewModel.Destination.addingNewPomodoro
                        ) { destination in
                            AddingPomodoroView(vm: destination.wrappedValue)
                        }
                }
            }

            Spacer()
        }
    }

}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(vm: TaskViewModel(title: "First Task"))
        TaskView(vm: TaskViewModel(title: "Second Task"))
    }
}
