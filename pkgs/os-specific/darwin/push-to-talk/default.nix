{ lib
, stdenv
, fetchFromGitHub
, xcodeenv
, which
}:

stdenv.mkDerivation rec {
  pname = "push-to-talk";
  version = "0.1.5";

  src = fetchFromGitHub rec {
    name = "osx-push-to-talk";
    owner = "yulrizka";
    repo = name;
    rev = "v${version}";
    sha256 = "1yfb87wds7br2i2lghss9p1cninhs41k6ghpg7xjaxjs8x4hnwfi";
  };
  
  doCheck = true;

  xcodeWrapper = xcodeenv.composeXcodeWrapper { version = "13.1"; };

  nativeBuildInputs = [ xcodeWrapper which ];

  # buildPhase = "xcodebuild -target PushToTalk -configuration Release";
  buildPhase = ''
    export PATH=${xcodeWrapper}/bin:$PATH
    xcodebuild -target PushToTalk -configuration Release
  '';
  # buildPhase = "which xcodebuild";

  meta = with lib; {
    description = "Mutes and unmutes the system microphone via a keypress.";
    longDescription = ''
      OSX PushToTalk mutes and unmutes the microphone via a keypress. This globally works for
      multiple video conference solutions (Google meet, Zoom, Skype, etc).
    '';
    homepage = "https://github.com/yulrizka/osx-push-to-talk";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
