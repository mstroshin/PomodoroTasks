import SwiftUI

struct PlusButtonView: View {
    let didPressAction: () -> Void

    var body: some View {
        Image(systemName: "plus")
            .resizable()
            .foregroundColor(.white)
            .padding(12)
            .background {
                Circle()
                    .shadow(
                        color: Color(hex: 0x646E89, alpha: 0.5),
                        radius: 4,
                        x: 0,
                        y: 4
                    )
            }
            .onTapGesture(perform: didPressAction)
    }

}

struct PlusButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlusButtonView(didPressAction: {})
            .frame(width: 52, height: 52)
            .foregroundColor(.red)
    }
}
