# Adapted on the PR of @malob: https://github.com/NixOS/nixpkgs/pull/265946

{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder

# Build deps
, anyio
, distro
, hatchling
, httpx
, numpy
, pandas
, pandas-stubs
, pydantic
, tqdm
, typing-extensions
, hatch-fancy-pypi-readme  

# Check deps
, pytestCheckHook
, dirty-equals
, pytest-asyncio
, respx

, withOptionalDependencies ? false
}:

buildPythonPackage rec {
  pname = "openai";
  version = "1.16.2";
  pyproject = true;

  disabled = pythonOlder "3.7.1";

  src = fetchFromGitHub {
    owner = "openai";
    repo = "openai-python";
    rev = "refs/tags/v${version}";
    hash = "sha256-7JWwEoVEdAy+tPcaYUPN7xA62Egzlv/2NNcDqvmDYh4=";
  };

  nativeBuildInputs = [ hatchling ];

  propagatedBuildInputs = [
    anyio
    distro
    httpx
    pydantic
    tqdm
    typing-extensions
    hatch-fancy-pypi-readme
  ] ++ lib.optionals withOptionalDependencies passthru.optional-dependencies.datalib;

  passthru.optional-dependencies = {
    datalib = [
      numpy
      pandas
      pandas-stubs
    ];
  };

  pythonImportsCheck = [
    "openai"
  ];

  nativeCheckInputs = [
    pytestCheckHook
    dirty-equals
    pytest-asyncio
    respx
  ];

  disabledTestPaths = [
    # Tests that require network access
    "tests/api_resources"
  ];

  meta = with lib; {
    description = "Python client library for the OpenAI API";
    homepage = "https://github.com/openai/openai-python";
    changelog = "https://github.com/openai/openai-python/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}
