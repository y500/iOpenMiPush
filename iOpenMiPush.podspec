Pod::Spec.new do |s|
  s.name                = "iOpenMiPush"
  s.version             = "0.0.2"
  s.summary             = "小米推送SDK"
  s.description         = <<-DESC
                          iOS版本的小米推送是基于Apple的APNs(Apple Push Notification Service)实现的，开发者只需在原有编码基础上添加少许代码即可使用，与Android版的小米推送类似，iOS版也提供了推送工具和数据统计等服务。
                          DESC
  s.homepage            = "http://dev.xiaomi.com/doc/?page_id=1670"
  s.license             = { :type => 'LGPL', :text => <<-LICENSE
                                                   小米科技 京ICP备10046444号 京公网安备1101080212535.
                                                   LICENSE
                          }
  s.author              = { "小米科技" => "xiaomi.com" }
  s.platform            = :ios
  s.source              = { :git => "https://github.com/y500/iOpenMiPush.git", :tag => "0.0.1" }
  s.source_files        = 'SDK/*.{h,m,a}'
  s.vendored_libraries  = 'SDK/libMiPushSDK.a'
  s.frameworks = 'SystemConfiguration', 'CFNetwork', 'MobileCoreServices', 'CoreTelephony'
  s.library = 'resolv', 'xml2', 'z'
end
