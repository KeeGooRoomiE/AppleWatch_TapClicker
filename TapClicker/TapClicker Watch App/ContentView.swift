import SwiftUI

struct ContentView: View {
    @State private var pressCount = 0
    @State private var maxPressCount = 0
    @State private var buttonColor = Color.white
    @State private var circle1Color = Color.white
    @State private var circle2Color = Color.white
    @State private var maxColor = Color.black
    @State private var timer: Timer?
    @State private var maxTimer: Timer?
    @State private var intHue = 0.0
    @State private var isPressed = false
    @State private var radius = 100.0

    var body: some View {
        VStack {
            Spacer() // Empty space at the top

//            VStack {
//                Text("\(pressCount)")
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//
//            }
//
//            Spacer()

            ZStack {
                Circle()
                    .fill(circle1Color)
                    .frame(height: CGFloat(min(max(radius + Double(pressCount*3), 100.0), 165.0)))
                Circle()
                    .fill(circle2Color)
                    .frame(height: CGFloat(min(max(radius + Double(pressCount)*1.2, 100.0), 150.0)))
                
                Button(action: {
                    self.setCount()
                    self.setColor()
                    self.startTimer()
                }) {
                    Text("\(pressCount)")
                        .fontWeight(.black)
                        .foregroundColor(.black)
                        .font(.system(size: 60))
                        .frame(width: 100, height: 100)
                        .scaleEffect(isPressed ? 0.9 : 1.0)
                        .padding(36)
                }
                .frame(width: 100, height: 100)
                .padding()
                .background(buttonColor)
                .clipShape(Circle())
                .buttonStyle(PlainButtonStyle()) // Remove button border
            }

            Spacer() // Empty space at the bottom
            VStack {
                            Text("\(maxPressCount)")
                                .foregroundColor(maxColor)
                                .font(.system(size: 28))
                                .fontWeight(.black)
            
                        }
            
                        Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all)) // Black screen background
    }

    func setCount() {
        pressCount += 1
    }

    func setColor() {
        let hue = intHue + (Double(pressCount) / 1000.0) // Generate a random value for hue
        let sat = Double(pressCount) / 100.0
        buttonColor = Color(hue: hue, saturation: sat, brightness: 1)
        circle1Color = Color(hue: hue, saturation: sat, brightness: 0.2)
        circle2Color = Color(hue: hue, saturation: sat, brightness: 0.4)
//        circle3Color = Color(hue: hue, saturation: sat, brightness: 0.6)
    }

    func setHue() {
        intHue = Double.random(in: 0...1)
    }
    func hintMaxColor() {
        maxColor = .white
    }
    
    func checkMaxCount() {
        if (pressCount>=maxPressCount)
        {
            maxPressCount = pressCount
            startMaxTimer()
            hintMaxColor()
        }
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            withAnimation {
                checkMaxCount()
                pressCount = 0
                setColor()
                setHue()
                
            }
        }
    }
    
    func startMaxTimer() {
        maxTimer?.invalidate()
        maxTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            withAnimation {
                maxColor = Color.black
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
