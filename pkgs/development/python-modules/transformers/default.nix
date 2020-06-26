{ buildPythonPackage
, stdenv
, fetchFromGitHub
, boto3
, filelock
, regex
, requests
, numpy
, sacremoses
, sentencepiece
, timeout-decorator
, tokenizers
, tqdm
, pytest
}:

buildPythonPackage rec {
  pname = "transformers";
  version = "2.11.0";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = pname;
    rev = "v${version}";
    sha256 = "1caqz5kp8mfywhiq8018c2jf14v15blj02fywh9xgvpq2dns9sc1";
  };

  propagatedBuildInputs = [
    boto3
    filelock
    numpy
    regex
    requests
    sacremoses
    sentencepiece
    tokenizers
    tqdm
  ];

  checkInputs = [
    pytest
    timeout-decorator
  ];

  # Disable tests that require network access.
  checkPhase = ''
    cd tests
    HOME=$TMPDIR pytest -k "\
       not test_all_tokenizers and \
       not test_config_from_model_shortcut and \
       not test_config_model_type_from_model_identifier and \
       not test_from_pretrained_use_fast_toggle and \
       not test_hf_api and \
       not test_tokenizer_from_model_type and \
       not test_tokenizer_from_model_type and \
       not test_tokenizer_from_pretrained and \
       not test_tokenizer_identifier_with_correct_config"
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/huggingface/transformers";
    description = "State-of-the-art Natural Language Processing for TensorFlow 2.0 and PyTorch";
    license = licenses.asl20;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ pashashocky ];
  };
}
