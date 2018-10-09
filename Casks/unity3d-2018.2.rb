
cask 'unity3d-2018.2' do
  version '2018.2.10f1'
  sha256 :no_check
  url "https://download.unity3d.com/download_unity/674aa5a67ed5/MacEditorInstaller/Unity-2018.2.10f1.pkg"
  name 'Unity Editor'
  homepage 'https://unity3d.com/unity/'

  preflight do
    FileUtils.cd staged_path do
      FileUtils.mkdir_p ['tmp', '/Applications/Unity-2018.2']
      system_command '/usr/bin/xar', args: ['-xf', 'Unity-2018.2.10f1.pkg', '-C', 'tmp']
      Dir.glob('tmp/*.pkg.tmp/**/Payload').each do |p|
        system_command '/usr/bin/tar', args: ['-C', '.', '-zmxf', p]
      end
      FileUtils.rm_rf ['tmp']
      FileUtils.mv Dir.glob('Unity/*'), '/Applications/Unity-2018.2', :force => true
    end
  end

  uninstall_preflight do
    FileUtils.rm_rf ['/Applications/Unity-2018.2']
  end
end
