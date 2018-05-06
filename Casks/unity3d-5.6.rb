cask 'unity3d-5.6' do
  version '5.6.5p4,10861494ddb7'
  sha256 :no_check
  url "https://beta.unity3d.com/download/#{version.after_comma}/MacEditorInstaller/Unity-#{version.before_comma}.pkg"
  name 'Unity Editor'
  homepage 'https://unity3d.com/unity/'

  preflight do
    FileUtils.cd staged_path do
      FileUtils.mkdir_p ["tmp", "/Applications/Unity-5.6"]
      system_command '/usr/bin/xar', args: ['-xf', "Unity-#{version.before_comma}.pkg", '-C', "tmp"]
      Dir.glob("tmp/*.pkg.tmp/**/Payload").each do |p|
        system_command '/usr/bin/tar', args: ['-C', '.', '-zmxf', p]
      end
      FileUtils.rm_rf ["tmp"]
      FileUtils.mv Dir.glob('Unity/*'), "/Applications/Unity-5.6", :force => true
    end
  end

  uninstall_preflight do
    FileUtils.rm_rf ["/Applications/Unity-5.6"]
  end
end
