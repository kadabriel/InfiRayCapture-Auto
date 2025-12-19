import SwiftUI

struct TemperatureRangeControls: View {
    @EnvironmentObject var uiState: UIState
    @EnvironmentObject var model: Camera
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Toggle("Manual Range", isOn: $uiState.manualRangeEnabled)
                .toggleStyle(.checkbox)
            
            if uiState.manualRangeEnabled {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Range:")
                                .font(.headline)
                            Spacer()
                            Text("\(uiState.temperatureFormat.format(uiState.temperatureFormat.convert(uiState.manualMinTemp))) - \(uiState.temperatureFormat.format(uiState.temperatureFormat.convert(uiState.manualMaxTemp)))")
                                .font(.subheadline)
                                .monospacedDigit()
                        }
                        
                        RangeSlider(
                            lowValue: $uiState.manualMinTemp,
                            highValue: $uiState.manualMaxTemp,
                            range: -20...150
                        )
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.vertical, 10)
                
                HStack {
                    Button("Reset to Current") {
                        uiState.manualMinTemp = model.minTemperature
                        uiState.manualMaxTemp = model.maxTemperature
                    }
                    .buttonStyle(.link)
                    
                    Spacer()
                    
                    Button("Reset to Default") {
                        uiState.manualMinTemp = 20.0
                        uiState.manualMaxTemp = 40.0
                    }
                    .buttonStyle(.link)
                }
                .padding(.top, 10)
            }
        }
        .padding()
        .frame(width: 320)
    }
}
