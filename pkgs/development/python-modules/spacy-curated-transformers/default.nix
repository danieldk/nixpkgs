{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  curated-tokenizers,
  curated-transformers,
  spacy,
  torch,
}:

buildPythonPackage rec {
  name = "spacy-curated-transformers";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "explosion";
    repo = name;
    rev = "release-v${version}";
    hash = "sha256-3LL0ofVsyacMzLJtttg0Tl9SlkPex7TwWL/HVF4WkfI=";
  };

  dependencies = [
    curated-tokenizers
    curated-transformers
    spacy
    torch
  ];

  # Unit tests are hard to use, since most tests rely on downloading
  # models from Hugging Face Hub.
  pythonImportCheck = [ "spacy_curated_transformers" ];

  meta = with lib; {
    description = "spaCy entry points for Curated Transformers";
    homepage = "https://github.com/explosion/curated-tokenizers";
    changelog = "https://github.com/explosion/curated-tokenizers/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ danieldk ];
  };
}
