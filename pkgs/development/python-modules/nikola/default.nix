{ lib
, aiohttp
, babel
, blinker
, buildPythonPackage
, python-dateutil
, docutils
, doit
, fetchPypi
, freezegun
, ghp-import
, hsluv
, html5lib
, ipykernel
, jinja2
, lxml
, mako
, markdown
, micawber
, mock
, natsort
, notebook
, phpserialize
, piexif
, pillow
, pygal
, pygments
, pyphen
, pyrss2gen
, pytestCheckHook
, pythonOlder
, requests
, ruamel-yaml
, stdenv
, toml
, typogrify
, unidecode
, watchdog
, yapsy
}:

buildPythonPackage rec {
  pname = "nikola";
  version = "8.2.3";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-c8eadkmYWS88nGwi6QwPqHg7FBXlkdazKSrbWDMw/UA=";
  };

  propagatedBuildInputs = [
    aiohttp
    babel
    blinker
    python-dateutil
    docutils
    doit
    ghp-import
    hsluv
    html5lib
    ipykernel
    jinja2
    lxml
    mako
    markdown
    micawber
    natsort
    notebook
    phpserialize
    piexif
    pillow
    pygal
    pygments
    pyphen
    pyrss2gen
    requests
    ruamel-yaml
    toml
    typogrify
    unidecode
    watchdog
    yapsy
  ];

  nativeCheckInputs = [
    freezegun
    mock
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.cfg \
      --replace "--cov nikola --cov-report term-missing" ""
  '';

  disabledTests = [
    # AssertionError
    "test_compiling_markdown"
  ];

  pythonImportsCheck = [ "nikola" ];

  meta = with lib; {
    description = "Static website and blog generator";
    homepage = "https://getnikola.com/";
    license = licenses.mit;
    maintainers = with maintainers; [ jluttine ];
    # All tests fail
    broken = stdenv.isDarwin;
  };
}
