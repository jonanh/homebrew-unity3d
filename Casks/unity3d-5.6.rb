cask 'unity3d-5.6' do
  version '5.6,10861494ddb7'
  sha256 :no_check

  url "https://netstorage.unity3d.com/unity/#{version.after_comma}/MacEditorInstaller/Unity.pkg"
  name 'Unity Editor'
  homepage 'https://unity3d.com/unity/'

  preflight do
    FileUtils.cd staged_path do
        FileUtils.mkdir_p "Unity/Unity-#{@cask.version.before_comma}"
        # xar -xf "${unity_version}.pkg" -C "${tmpDir}"
        system_command '/usr/bin/xar', args: ['-xf', "Unity-#{@cask.version.before_comma}.pkg", '-C', 'UnityPayloadTmp']
        # find "${tmpDir}" -ipath '*.pkg.tmp/*' -type f -iname 'Payload' -exec tar -C "${dst}" -zmxf {} \;
        system_command '/usr/bin/find', args: ['UnityPayloadTmp', '-ipath', '*.pkg.tmp/*', '-type', 'f', '-iname', 'Payload', '-exec', "tar -C \"Unity-#{@cask.version.before_comma}\" -zmxf {}", '\;']
        FileUtils.rm_rf ["Unity-#{@cask.version.before_comma}.pkg", 'UnityPayloadTmp']
    end
  end

  pkg 'Unity.pkg'

  uninstall quit:    'com.unity3d.UnityEditor5.x',
            pkgutil: 'com.unity3d.UnityEditor5.x',
            delete:  '/Applications/Unity/Unity-#{@cask.version.before_comma}/Unity.app',
            rmdir:   '/Applications/Unity/Unity-#{@cask.version.before_comma}'
end
