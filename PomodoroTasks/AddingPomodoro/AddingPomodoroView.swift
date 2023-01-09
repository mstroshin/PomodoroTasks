import SwiftUI

struct AddingPomodoroView: View {
    @StateObject var vm: AddingPomodoroViewModel

    init(vm: AddingPomodoroViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            Picker(selection: $vm.type) {
                ForEach(TimerType.allCases) { type in
                    Text(type.rawValue)
                        .tag(type)
                }
            } label: {}
            .pickerStyle(.segmented)

            DatePicker(
                "Time",
                selection: $vm.time,
                displayedComponents: .hourAndMinute
            )
            .frame(width: 100)

            Button("Done", action: vm.doneButtonPressed)
        }
        .padding(16)
        .frame(width: 200)
    }

}

struct AddingPomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        AddingPomodoroView(vm: AddingPomodoroViewModel())
    }
}
