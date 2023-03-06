//
//  FloatingMenu.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

struct FloatingMenu: View {

    @Binding var openValue: CGFloat
    @Binding var isMenuOpen: Bool {
        didSet {
            self.showMenu()
        }
    }
    @State var showMenuItem0 = false
    @State var showMenuItem1 = false
    @State var showMenuItem2 = false
    @State var showMenuItem3 = false
    @State var offsetValue: CGFloat = 0
    private let fontColor: Color = .white

    var showMenuProjectClosure: () -> Void
    var showMenuLargeTaskClosure: () -> Void
    var showMenuMediumTaskClosure: () -> Void
    var showMenuSmallTaskClosure: () -> Void

    var body: some View {
        ZStack {
            Color.black
                .opacity(openValue)
                .ignoresSafeArea()
                .animation(.easeInOut, value: openValue)
                .onTapGesture {
                    self.hideMenu()
                }
            VStack {
                Spacer()
                VStack {
                    getMenuViews()
                }.offset(x: 0, y: offsetValue)
                HStack {
                    Spacer()
                    Button(action: {
                        self.hideMenu()
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(.white)
                                .frame(width: 80, height: 80)
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color(.redPigment))
                                .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                                .zIndex(1)
                        }
                    }
                }
            }
            .padding([.trailing, .bottom], 16)
        }
    }

    func hideMenu() {
        self.isMenuOpen.toggle()
        if isMenuOpen {
            openValue = 0.8
        } else {
            openValue = 0
        }
    }

    func showMenu() {
        withAnimation {
            self.showMenuItem3.toggle()
            if self.showMenuItem3 == false {
                self.offsetValue = 64
            } else {
                self.offsetValue = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.showMenuItem2.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            withAnimation {
                self.showMenuItem1.toggle()
            }
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            withAnimation {
                self.showMenuItem0.toggle()
            }
        })
    }

    @ViewBuilder
    func getMenuViews() -> some View {
        if showMenuItem0 {
            HStack {
                Spacer()
                Text("PROJECT")
                    .foregroundColor(fontColor)
                MenuItem(icon: "map.circle.fill")
            }
            .onTapGesture {
                showMenuProjectClosure()
                hideMenu()
            }
        }
        if showMenuItem1 {
            HStack {
                Spacer()
                Text("LARGE Task > 45 mins")
                    .foregroundColor(fontColor)
                MenuItem(icon: "l.circle.fill")
            }
            .onTapGesture {
                showMenuLargeTaskClosure()
                hideMenu()
            }
        }
        if showMenuItem2 {
            HStack {
                Spacer()
                Text("MEDIUM Task < 15 mins")
                    .foregroundColor(fontColor)
                MenuItem(icon: "m.circle.fill")
            }
            .onTapGesture {
                showMenuLargeTaskClosure()
                hideMenu()
            }
        }
        if showMenuItem3 {
            HStack {
                Spacer()
                Text("SMALL Task < 5 mins")
                    .foregroundColor(fontColor)
                MenuItem(icon: "s.circle.fill")
            }
            .onTapGesture {
                showMenuLargeTaskClosure()
                hideMenu()
            }
        }
    }
}

struct MenuItem: View {

    var icon: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color(.redPigment))
                .frame(width: 55, height: 55)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
    }
}
