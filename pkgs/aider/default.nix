{ lib
, python3Packages
, fetchFromGitHub
}:

python3Packages.buildPythonApplication rec {
  pname = "aider";
  version = "0.30.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "paul-gauthier";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-qRe5cSCDsHB5atNIQQyDpT/Te21F6MkNbmNOMfGe8aw=";
  };

  doCheck = false;

  buildInputs = with python3Packages; [
    setuptools
  ];

  propagatedBuildInputs = with python3Packages; [
    configargparse
    gitpython
    openai
    tiktoken
    jsonschema
    rich
    prompt-toolkit
    numpy
    scipy
    backoff
    pathspec
    networkx
    diskcache
    grep-ast
    packaging
    sounddevice
    soundfile
    beautifulsoup4
    pyyaml
    pillow
    diff-match-patch
    playwright
    pypandoc
    httpx
  ];

  meta = with lib; {
    description = ''
      aider is AI pair programming in your terminal
    '';
    homepage = "https://aider.chat/";
    license = licenses.asl20;
    maintainers = with maintainers; [ breakds ];
  };
}
