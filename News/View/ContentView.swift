//
//  ContentView.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            
            List {
                Section(header: Text("Top")) {
                    if let article = viewModel.topArticle {
                        NavigationLink(destination: WebView(url: article.url)) {
                            TallerNewsView(article: article) {
                                viewModel.bookMark(article: article)
                            }
                            
                        }
                    }
                }
                Section(header: Text("Popular")) {
                    ForEach(viewModel.popularArticles) { article in
                        NavigationLink(destination: WebView(url: article.url)) {
                            NormalNewsView(article: article) {
                                viewModel.bookMark(article: article)
                            }
                        }
                    }
                }
            }
            .navigationBarItems(leading: Text("Global News"), trailing: HeaderView())
            .listStyle(GroupedListStyle())
            .onAppear {
                viewModel.fetchHomeScreenContents()
            }
        }
    }
}


extension ContentView {
    struct HeaderView: View {
        var body: some View {
            
            HStack {
                NavigationLink(destination: BookMarksView()) {
                    Image(systemName: "star")
                }
                
                NavigationLink(destination: SearchBarView()) {
                    Text("S")
                }
            }
        }
    }
}

struct BookMarksView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var bookMarks: FetchedResults<CDArticle>
    
    var body: some View {
        Text("")
        //        NavigationView {
        //            List {
        //                ForEach(bookMarks) { bookMark in
        //                    NavigationLink(destination: WebView(url: bookMark.url ?? "")) {
        //                                                NormalNewsView(article: bookMark) {
        //                    }
        //                }
        //            }
        //        }
    }
}

struct SearchBarView: View {
    var body: some View {
        SearchBar()
    }
}


struct TallerNewsView: View {
    @State var isSelected = false
    let article: Article
    var onBookMarkTapped: () -> ()
    var body: some View {
        VStack {
            RemoteImage(url: article.urlToImage)
            NewsText(text: article.title)
            NewsText(text: article.articleDescription, font: .caption)
            HStack {
                CapsuleText(text: article.source.name)
                Spacer()
                
                Button("BookMark") {
                    isSelected.toggle()
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct NormalNewsView: View {
    let article: Article
    var onBookMarkTapped: () -> ()
    
    var body: some View {
        HStack {
            RemoteImage(url: article.urlToImage)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80)
            VStack {
                NewsText(text: article.title)
                    .font(.title)
                NewsText(text: article.articleDescription, font: .caption)
                    .font(.caption)
                
                HStack {
                    CapsuleText(text: article.source.name)
                    Spacer()
                    Button("BookMark") {
                        onBookMarkTapped()
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.caption2)
            .padding()
            .foregroundColor(.black)
            .frame(height: 30, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 4).stroke())
    }
}

struct NewsText: View {
    
    let text: String
    let font: Font
    
    init(text: String, font: Font = .body) {
        self.text = text; self.font = font
    }
    
    var body: some View {
        Text(text)
            .font(font)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
