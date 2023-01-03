import SwiftUI

struct AddingNewTaskView: View {
    @StateObject var vm: AddingNewTaskViewModel

    var body: some View {
        VStack {
            TextField("Title", text: $vm.title)
                .frame(width: 200)
            Button("Done", action: vm.doneButtonPressed)
        }
        .padding(16)
    }

}

struct AddingNewTaskView_Previews: PreviewProvider {

    static var previews: some View {
        AddingNewTaskView(vm: AddingNewTaskViewModel())
    }

}
