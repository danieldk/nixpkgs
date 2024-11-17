{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  curated-tokenizers,
  huggingface-hub,
  tokenizers,
  torch,
}:

buildPythonPackage rec {
  name = "curated-transformers";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "explosion";
    repo = name;
    rev = "v${version}";
    hash = "sha256-QhJZnQIa9TilwdQCUlxnQCEc6Suj669cht6WHUAr/Gw=";
  };

  dependencies = [
    curated-tokenizers
    huggingface-hub
    tokenizers
    torch
  ];

  # Unit tests are hard to use, since most tests rely on downloading
  # models from Hugging Face Hub.
  pythonImportCheck = [ "curated_transformers" ];

  meta = with lib; {
    description = "PyTorch library of curated Transformer models and their composable components";
    homepage = "https://github.com/explosion/curated_transformers";
    changelog = "https://github.com/explosion/curated_transformers/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ danieldk ];
  };
}
