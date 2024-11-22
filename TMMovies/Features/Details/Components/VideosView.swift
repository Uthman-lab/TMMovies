//
//  VideoCard.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/22/24.
//

import SwiftUI

struct VideosView: View {
    @State var showMedia = false
    @State var mediaURL: URL?
    @Binding var videos: [MovieVideo]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 12) {
                ForEach(videos) { video in
                    VideoCard(video: video, action: {
                        if let url = video.youtubeURL {
                            mediaURL = url
                        }
                    })
                }
            }
        }
        .onChange(of: mediaURL) {
            if mediaURL != nil {
                showMedia = true
            }
        }
        .sheet(isPresented: $showMedia) {
            if let url = mediaURL {
                WebView(url: url)
                    .frame(height: 300)
                    .cornerRadius(8)
            }
        }
    }
}

private struct VideoCard: View {
    let video: MovieVideo
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: action) {
                RoundedImage(
                    url: video.thumbNailURL,
                    isVideo: true
                )
            }
            .frame(height: 100)
            Text(video.name)
                .customFont(.semiBold, size: 10)
                .lineLimit(3)
        }
        .frame(width: 150)
    }
}

#Preview {
    VideosView(
        videos: .constant(
            [
                MovieVideo.dummyVideo,
                MovieVideo.dummyVideo
            ]
        )
    )
}
