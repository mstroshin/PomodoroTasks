import SwiftUI

struct TaskView: View {
    @StateObject var vm: TaskViewModel

    var body: some View {
        HStack {
            VStack {
                Text(vm.title)
                Button("+") {

                }
//                .popover(
//                    unwrapping: $vm.destination,
//                    case: /MainViewModel.Destination.addingNewTask
//                ) { destination in
//                    AddingNewTaskView(vm: destination.wrappedValue)
//                }
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
