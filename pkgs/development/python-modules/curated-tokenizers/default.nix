{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  cython,
  regex,
  pytestCheckHook,
}:

buildPythonPackage rec {
  name = "curated-tokenizers";
  version = "0.0.8";

  src = fetchFromGitHub {
    owner = "explosion";
    repo = name;
    rev = "v${version}";
    hash = "sha256-otAws63xa6if9uKtMPM5HLTbp5TMLEqf76nVHqxbq6o=";
    fetchSubmodules = true;
  };

  build-system = [
    cython
  ];

  dependencies = [
    regex
  ];

  checkInputs = [
    pytestCheckHook
  ];

  # Explicitly set the path to avoid running vendored
  # sentencepiece tests.
  pytestFlagsArray = [ "tests" ];

  preCheck = ''
    # avoid local paths, relative imports wont resolve correctly
    mv curated_tokenizers/tests tests
    rm -r curated_tokenizers
  '';

  meta = with lib; {
    description = "Lightweight piece tokenization library";
    homepage = "https://github.com/explosion/curated-tokenizers";
    changelog = "https://github.com/explosion/curated-tokenizers/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ danieldk ];
  };
}
