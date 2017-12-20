Pod::Spec.new do |s|

    s.name         = 'LYEmptyView'

    s.version      = '1.0.1'

    s.summary      = 'so esay integrate empty content view'

    s.homepage     = 'https://github.com/yangli-dev/LYEmptyView'

    s.license      = 'MIT'

    s.authors      = {'Yang LI' => 'liyang040899@163.com'}

    s.platform     = :ios, '7.0'

    s.source       = {:git => 'https://github.com/yangli-dev/LYEmptyView.git', :tag => s.version}

    s.source_files = 'LYEmptyView/**/*.{h,m}'

    s.requires_arc = true

end