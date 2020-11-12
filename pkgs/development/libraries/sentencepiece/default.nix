{ lib
, fetchFromGitHub
, stdenv
, cmake
, gperftools

, withGPerfTools ? true
}:

stdenv.mkDerivation rec {
  pname = "sentencepiece";
  version = "0.1.94";

  src = fetchFromGitHub {
    owner = "google";
    repo = pname;
    rev = "77e3412b2c7c0d755c09e81e40d0fd40cf24604f";
    sha256 = "sha256-jquI6bIK/FtptAyyz7LELxG56JTOfcczpLWMbI3BdoY=";
  };

  nativeBuildInputs = [ cmake ] ++ lib.optional withGPerfTools gperftools;

  outputs = [ "bin" "dev" "out" ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/google/sentencepiece";
    description = "Unsupervised text tokenizer for Neural Network-based text generation";
    license = licenses.asl20;
    platforms = platforms.unix;
    maintainers = with maintainers; [ danieldk pashashocky ];
  };
}
