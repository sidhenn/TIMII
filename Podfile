# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'TIMII' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Firebase
  pod 'FirebaseUI/Database', '~> 5.0'
  pod 'FirebaseUI/Storage', '~> 5.0'
  pod 'FirebaseUI/Auth', '~> 5.0'
  pod 'FirebaseUI/Facebook', '~> 5.0'
  
  # Pods for TIMII
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'

  # Pods for TIMII testing use
  target 'TIMIITests' do
    inherit! :search_paths
    pod 'Firebase/Core'
  end

  # Pods for Autolayout Library SnapKit
  # pod 'SnapKit', '~> 4.0.0'
  
  # Pod for Swift Layout Framework
  pod 'Layout', '~> 0.6'

end
