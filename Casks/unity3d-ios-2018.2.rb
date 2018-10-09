
cask 'unity3d-ios-2018.2' do
  version '2018.2.10f1'
  sha256 :no_check
  url "https://download.unity3d.com/download_unity/674aa5a67ed5/MacEditorTargetInstaller/UnitySetup-iOS-Support-for-Editor-2018.2.10f1.pkg"
  name 'ios'
  homepage 'https://unity3d.com/unity/'

  depends_on cask: 'unity3d-2018.2'

  preflight do
    FileUtils.cd staged_path do
      FileUtils.mkdir_p ['tmp', '/Applications/Unity-2018.2/PlaybackEngines']
      system_command '/usr/bin/xar', args: ['-xf', "UnitySetup-iOS-Support-for-Editor-2018.2.10f1.pkg", '-C', 'tmp']
      Dir.glob('tmp/*.pkg.tmp/**/Payload').each do |p|
        system_command '/usr/bin/tar', args: ['-C', '/Applications/Unity-2018.2/PlaybackEngines', '-zmxf', p]
      end
      FileUtils.rm_rf ['tmp']
    end
  end

  uninstall_preflight do
    FileUtils.rm_rf ['/Applications/Unity-2018.2/PlaybackEngines']
  end
end
