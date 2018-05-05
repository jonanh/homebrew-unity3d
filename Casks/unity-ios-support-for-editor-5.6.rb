cask 'unity-ios-support-for-editor-5.6' do
  version '5.6.5p4,10861494ddb7'
  sha256 :no_check
  url "https://beta.unity3d.com/download/#{version.after_comma}/MacEditorTargetInstaller/UnitySetup-Android-Support-for-Editor-#{version.before_comma}.pkg"
  name 'Unity Editor'
  homepage 'https://unity3d.com/unity/'

  preflight do
    FileUtils.cd staged_path do
      tmp_dir="tmp"
      dst_dir="/Applications/Unity/Versions/#{version.before_comma}/PlaybackEngines/AndroidPlayer"
      pkg="UnitySetup-Android-Support-for-Editor-#{version.before_comma}.pkg"
      FileUtils.mkdir_p [dst_dir,tmp_dir]
      system_command '/usr/bin/xar', args: ['-xf', pkg, '-C', tmp_dir]
      Dir.glob("#{tmp_dir}/*.pkg.tmp/**/Payload").each do |p|
        system_command '/usr/bin/tar', args: ['-C', dst_dir, '-zmxf', p]
      end
      FileUtils.rm_rf [tmp_dir]
    end
  end
end
