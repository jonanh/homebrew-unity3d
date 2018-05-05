cask 'unity3d-android-5.6' do
  version '5.6.5p4,10861494ddb7'
  sha256 :no_check
  url "https://beta.unity3d.com/download/#{version.after_comma}/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-#{version.before_comma}.pkg"
  name 'Unity Editor'
  homepage 'https://unity3d.com/unity/'

  depends_on cask: 'unity3d-5.6'

  preflight do
    FileUtils.cd staged_path do
      FileUtils.mkdir_p ["tmp", "AndroidPlayer", "/Applications/Unity-5.6/PlaybackEngines"]
      system_command '/usr/bin/xar', args: ['-xf', "UnitySetup-Android-Support-for-Editor-#{version.before_comma}.pkg", '-C', "tmp"]
      Dir.glob("tmp/*.pkg.tmp/**/Payload").each do |p|
        system_command '/usr/bin/tar', args: ['-C', "AndroidPlayer", '-zmxf', p]
      end
      FileUtils.rm_rf ["tmp", "/Applications/Unity-5.6/PlaybackEngines/AndroidPlayer"]
      FileUtils.ln_sf(File.join(staged_path.to_s, "AndroidPlayer"), "/Applications/Unity-5.6/PlaybackEngines")
    end
  end
  
  uninstall rmdir:   "/Applications/Unity-5.6/PlaybackEngines/AndroidPlayer"
end