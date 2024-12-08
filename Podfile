platform :ios, '13'

target 'TMMovies' do
  use_frameworks!

  # Pods for TMMovies
  pod 'FirebaseCrashlytics', '~> 11.5'
  pod 'FirebaseAnalytics', '~> 11.5'
  pod 'Kingfisher', '~> 8.1'
end

target 'TMMoviesTests' do
  inherit! :search_paths
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13'
    end
  end
end
