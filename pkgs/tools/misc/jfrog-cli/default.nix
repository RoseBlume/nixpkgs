{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "jfrog-cli";
  version = "2.45.0";

  src = fetchFromGitHub {
    owner = "jfrog";
    repo = "jfrog-cli";
    rev = "refs/tags/v${version}";
    hash = "sha256-NSkSE1NZIwCCSlCo7hGWq82JvH48uI8fV2RIZHwS5JI=";
  };

  vendorHash = "sha256-fk+Lhmb+LgjSuGlDfHkentF10TOgqIxbZ1VVGmAmkME=";

  postInstall = ''
    # Name the output the same way as the original build script does
    mv $out/bin/jfrog-cli $out/bin/jf
  '';

  # Some of the tests require a writable $HOME
  preCheck = "export HOME=$TMPDIR";

  meta = with lib; {
    homepage = "https://github.com/jfrog/jfrog-cli";
    description = "Client for accessing to JFrog's Artifactory and Mission Control through their respective REST APIs";
    changelog = "https://github.com/jfrog/jfrog-cli/releases/tag/v${version}";
    license = licenses.asl20;
    mainProgram = "jf";
    maintainers = with maintainers; [ detegr ];
  };
}
