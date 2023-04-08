//
//  HomeView.swift
//  LearningProject
//
//  Created by Arthur ? on 06.04.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var currentPage: String = ""
    @State private var listOfPages: [Page] = []
    @State private var fakedPages: [Page] = []
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            TabView(selection: $currentPage) {
                ForEach(fakedPages) { page in
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(page.color.gradient)
                        .frame(width: 300, height: size.height)
                        .tag(page.id.uuidString)
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndex(of: page)))
                            
                            let pageProgress = pageOffset / size.width
                            if -pageProgress < 1.0 {
                                // moving to the last page
                                if fakedPages.indices.contains(fakedPages.count - 1) {
                                    currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                                }
                            }
                            if -pageProgress > CGFloat(fakedPages.count - 1) {
                                // moving to the first page
                                if fakedPages.indices.contains(1) {
                                    currentPage = fakedPages[1].id.uuidString
                                }
                            }
                        }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: realIndex(of: currentPage))
                    .offset(y: -15)
            }
        }
        .frame(height: 450)
        .onAppear {
            guard fakedPages.isEmpty else { return }
            
            for color in [Color.red, Color.blue, Color.yellow, Color.black, Color.brown] {
                listOfPages.append(Page(color: color))
            }
            fakedPages.append(contentsOf: listOfPages)
            
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                currentPage = firstPage.id.uuidString
                
                firstPage.id = .init()
                lastPage.id = .init()
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        }
    }
    
    func fakeIndex(of page: Page) -> Int {
        return fakedPages.firstIndex(of: page) ?? 0
    }
    
    func realIndex(of id: String) -> Int {
        return listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
