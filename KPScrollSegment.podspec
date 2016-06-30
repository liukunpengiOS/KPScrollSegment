
Pod::Spec.new do |s|

    s.name         = 'KPScrollSegment'
    s.version      = '0.0.1'
    s.summary      = 'Easy bulid a component about ScrollSegment.'
    s.homepage     = 'https://github.com/liukunpengiOS'
    s.license      = 'MIT'
    s.author       = { 'kunpeng' => '1169405067@qq.com'}
    s.platform     = :ios, "8.0"
    s.source       = { :git => 'https://github.com/liukunpengiOS/KPScrollSegment.git', :tag => '0.0.1' }
    s.source_files = 'KPScrollSegment/**/*.{h,m}'
    s.requires_arc = true
    s.dependency "INTUAnimationEngine",
end



