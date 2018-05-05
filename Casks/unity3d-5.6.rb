cask 'unity3d-5.6' do
  version '5.6.5p4,10861494ddb7'
  sha256 :no_check
  url "https://beta.unity3d.com/download/#{version.after_comma}/MacEditorInstaller/Unity-#{version.before_comma}.pkg"
  name 'Unity Editor'
  homepage 'https://unity3d.com/unity/'

  preflight do
    FileUtils.cd staged_path do
      FileUtils.mkdir_p ["tmp"]
      system_command '/usr/bin/xar', args: ['-xf', "Unity-#{version.before_comma}.pkg", '-C', "tmp"]
      Dir.glob("tmp/*.pkg.tmp/**/Payload").each do |p|
        system_command '/usr/bin/tar', args: ['-C', '.', '-zmxf', p]
      end
      FileUtils.rm_rf ["tmp", "/Applications/Unity-5.6"]
      FileUtils.ln_sf(File.join(staged_path.to_s, "Unity"), "/Applications/Unity-5.6")
    end
  end

  uninstall delete:  "/Applications/Unity-5.6/Unity.app/",
            rmdir:   "/Applications/Unity-5.6"
end
