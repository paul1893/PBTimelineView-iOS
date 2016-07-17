Pod::Spec.new do |s|

  s.platform = :ios
  s.name         = "PBTimelineView"
  s.version      = "1.0.0"
  s.summary      = "A tree view to show your events or anything else."
  s.description  = <<-DESC
  This library has been created to show events or anything else in a tree view
                   DESC
  s.homepage     = "https://github.com/paul1893/PBTimelineView-iOS"
  s.screenshots  = "https://raw.githubusercontent.com/paul1893/PBTimelineView-iOS/master/Screenshots/demo.gif"
  s.author             = { "paul1893" => "pspol@hotmail.fr" }
  s.license      = '{ :type => "MIT", :file => "license" }'
  s.social_media_url   = "https://github.com/paul1893"
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/paul1893/PBTimelineView-iOS.git", :tag => s.version }
  s.source_files  = "PBTimelineView/lib/**/*"
  s.exclude_files = "PBTimelineView/example/**/*", "PBTimelineView/Base.lproj/**/*"

  s.frameworks  = "UIKit", "Foundation"
  s.requires_arc = true

end