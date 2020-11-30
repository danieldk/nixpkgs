{ stdenv
, fetchFromGitHub
, rustPlatform
, installShellFiles
, pkg-config
, scdoc
, openssl
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "dogdns";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "ogham";
    repo = "dog";
    rev = "42be9a32e7abfbe8f7dacad98b2cc27768f7cafe";
    hash = "sha256-6D59kIcDWNrv+3LyN0Xnnusci04vwUQpt++yPQOUiEE=";
  };

  nativeBuildInputs = [ installShellFiles scdoc ]
    ++ stdenv.lib.optionals stdenv.isLinux [ pkg-config ];
  buildInputs = stdenv.lib.optionals stdenv.isLinux [ openssl ]
    ++ stdenv.lib.optionals stdenv.isDarwin [ Security ];

  cargoSha256 = "sha256-4wXfQnCy87uK7B2MbtUT+v9kLEvQbcxhTmu+rBilouA=";

  postInstall = ''
    installShellCompletion completions/dog.{bash,fish,zsh}

    scdoc < man/dog.1.scd > man/dog.1
    installManPage man/dog.1
  '';

  meta = with stdenv.lib; {
    description = "Command-line DNS client";
    homepage = "https://dns.lookup.dog";
    license = licenses.eupl12;
    maintainers = with maintainers; [ bbigras ];
  };
}
