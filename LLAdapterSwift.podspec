Pod::Spec.new do |s|

s.name         = 'LLAdapterSwift'
s.version      = '0.1.0'
s.summary      = '列表适配器Swift版本'
s.description  = '详细描述~'
s.homepage     = 'https://github.com/orgs/PrettyGrass'
s.license      = 'COMMERCIAL'
s.author       = { 'renxun' => '490282258@qq.com' }
s.platform     = :ios, '8.0'
s.source       = { :git => "git@g.dou-pai.com:ios_component/LLAdapterSwift.git", :branch => s.version.to_s }
s.requires_arc = true

s.source_files = 'src/**/*.swift' # 源码文件
s.dependency 'SnapKit', '4.2.0'

end

# !!!!end 后一定记得要有换行



