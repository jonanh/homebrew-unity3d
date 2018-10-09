
cask 'unity3d-android-2018.2' do
  version '2018.2.10f1'
  sha256 :no_check
  url "https://download.unity3d.com/download_unity/674aa5a67ed5/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-2018.2.10f1.pkg"
  name 'android'
  homepage 'https://unity3d.com/unity/'

  depends_on cask: 'unity3d-2018.2'

  preflight do
    FileUtils.cd staged_path do
      FileUtils.mkdir_p ['tmp', '/Applications/Unity-2018.2/PlaybackEngines/AndroidPlayer']
      system_command '/usr/bin/xar', args: ['-xf', "UnitySetup-Android-Support-for-Editor-2018.2.10f1.pkg", '-C', 'tmp']
      Dir.glob('tmp/*.pkg.tmp/**/Payload').each do |p|
        system_command '/usr/bin/tar', args: ['-C', '/Applications/Unity-2018.2/PlaybackEngines/AndroidPlayer', '-zmxf', p]
      end
      FileUtils.rm_rf ['tmp']
    end
  end

  uninstall_preflight do
    FileUtils.rm_rf ['/Applications/Unity-2018.2/PlaybackEngines/AndroidPlayer']
  end
end
