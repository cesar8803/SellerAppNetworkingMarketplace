Pod::Spec.new do |s|
s.name         = "SellerAppNetworkingMarketplace"
s.swift_version = '3.2'
s.version      = "1.0.1"
s.summary      = "Pod con la colección de servicios de Marketplace - Mirakl."

s.description  = "Pod con la colección de servicios de Marketplace - Mirakl."

s.homepage     = "https://www.liverpool.com.mx"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

#s.license      = "MIT"
s.license      = { :type => "MIT", :file => "LICENSE" }

s.author             = { "adairliver" => "harojasd@liverpool.com.mx" }
# Or just: s.author    = "JJMaqueda"
# s.authors            = { "JJMaqueda" => "jjmaquedaf@liverpool.com.mx" }

# s.platform     = :ios
s.platform     = :ios, "9.0"

#  When using multiple platforms
s.ios.deployment_target = "9.0"
# s.osx.deployment_target = "10.7"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"

s.source       = { :git => "https://github.com/cesar8803/SellerAppNetworkingMarketplace.git", :tag => "#{s.version}" }

s.source_files = "SellerAppNetworkingMarketplace/**/*"
#s.source_files  = "Classes", "Classes/**/*.{h,m}"
#s.exclude_files = "Classes/Exclude"

# s.public_header_files = "Classes/**/*.h"

s.framework  = "Foundation"
# s.frameworks = "SomeFramework", "AnotherFramework"

# s.library   = "iconv"
# s.libraries = "iconv", "xml2"

# ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  If your library depends on compiler flags you can set them in the xcconfig hash
#  where they will only apply to your library. If you depend on other Podspecs
#  you can include multiple dependencies to ensure it works.

s.requires_arc = true

# s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
s.dependency "Alamofire"#, "~> 4.0"
s.dependency "AlamofireObjectMapper"#, "~> 4.0"

end

