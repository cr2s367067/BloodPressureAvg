//
//  ContentView.swift
//  BloodPresureAvg
//
//  Created by Kuan on 2022/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var server: ServerClient
    
//    @State var firstBloodPressure: String = ""
//    @State var secondBloodPressure: String = ""
//
//    @State var firstShrink: String = ""
//    @State var secondShrink: String = ""
//
//    @State var firstBit: String = ""
//    @State var secondBit: String = ""
//
//    @State var avgExpand: String = "0"
//    @State var avgShrink: String = "0"
//    @State var avgBit: String = "0"

    @FocusState var isFocus: Bool

    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("使用者姓名")
                TextField("", text: $server.userBloodPressure.userName)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .shadow(radius: 5)
                    .focused($isFocus)
            }
            .padding()
            nameWithField(fieldName: "第一次收縮壓", fieldContian: $server.userBloodPressure.firstDiastolic)
            nameWithField(fieldName: "第一次舒張壓", fieldContian: $server.userBloodPressure.firstSystolic)
            nameWithField(fieldName: "第一次脈搏", fieldContian: $server.userBloodPressure.firstPulse)
            nameWithField(fieldName: "第二次收縮壓", fieldContian: $server.userBloodPressure.secondDiastolic)
            nameWithField(fieldName: "第二次舒張壓", fieldContian: $server.userBloodPressure.secondSystolic)
            nameWithField(fieldName: "第二次脈搏", fieldContian: $server.userBloodPressure.secondPulse)
            VStack(alignment: .leading, spacing: 10) {
                Text("使用者 姓名: \(server.getResult.encryptName)")
                Text("平均收縮壓: \(server.getResult.avgDiastolic)")
                Text("平均舒張壓: \(server.getResult.avgSystolic)")
                Text("平均脈搏: \(server.getResult.avgPulse)")
                Text("血壓狀態: \(server.getResult.pressureStatus)")
            }
            HStack {
                Spacer()
                Button("Result") {
                    Task {
//                        print(server.userBloodPressure)
                        try await server.getBloodAvgWithUserInfo(userData: server.userBloodPressure)
//                        try await server.getHello()
                        print(server.getResult)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    isFocus = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    @ViewBuilder
    func nameWithField(fieldName: String, fieldContian: Binding<String>) -> some View {
        VStack(alignment: .leading) {
            Text(fieldName)
            TextField("", text: fieldContian)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .shadow(radius: 5)
                .focused($isFocus)
        }
        .padding()
    }

//    func avg() {
//        let convertIntFirstExpand = Int(firstBloodPressure) ?? 0
//        let convertIntSecondExpand = Int(secondBloodPressure) ?? 0
//        let convertIntFirstShrink = Int(firstShrink) ?? 0
//        let convertIntSecondShrink = Int(secondShrink) ?? 0
//        let convertIntFirstBit = Int(firstBit) ?? 0
//        let convertIntSecondBit = Int(secondBit) ?? 0
//        var sumExpand = 0
//        var sumShrink = 0
//        var sumBit = 0
//        sumExpand = convertIntFirstExpand + convertIntSecondExpand
//        sumShrink = convertIntFirstShrink + convertIntSecondShrink
//        sumBit = convertIntFirstBit + convertIntSecondBit
//
//        avgExpand = String(sumExpand / 2)
//        avgShrink = String(sumShrink / 2)
//        avgBit = String(sumBit / 2)
//    }
}
