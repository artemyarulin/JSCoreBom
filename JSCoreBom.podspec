Pod::Spec.new do |s|
  s.name          = "JSCoreBom"
  s.version       = "1.1.0"
  s.summary       = "Extension for JavaScriptCore/JSContext that allows you to start using browser object model function: setTimeout, console.log, etc."
  s.description   = "JavaScriptCore is missing some things you get used to - setTimeout, XMLHttpRequest, console.log, etc. This projects extends JSContext with native implementation of BOM using Objective-C"
  s.homepage      = "https://github.com/artemyarulin/JSCoreBom"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "Artem Yarulin" => "artem.yarulin@fessguid.com" }
  s.platform      = :ios, "7.0"
  s.source        = { :git => "https://github.com/artemyarulin/JSCoreBom.git", :tag => "1.1.0" }
  s.source_files  = "JSCoreBom/JSCoreBom.{h,m}", "JSCoreBom/Modules/*"
  s.public_header_files = "JSCoreBom/JSCoreBom.h"
  s.framework  = "JavaScriptCore"
  s.requires_arc  = true
end
