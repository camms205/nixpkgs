{
  lib,
  fetchFromGitHub,
  makeWrapper,
  python3Packages,
}:
python3Packages.buildPythonApplication rec {
  pname = "riven";
  version = "0.15.3";
  src = fetchFromGitHub {
    owner = "rivenmedia";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-Jwnb9pXhzI8yvewKGKVWLQgiSgdb4+xIaWLh/zpHP+k=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  propagatedBuildInputs = with python3Packages; [
    dill
    plexapi
    requests
    xmltodict
    lxml
    pydantic
    fastapi
    uvicorn
    apscheduler
    regex
    coverage
    cachetools
    loguru
    rich
    opentelemetry-api
    opentelemetry-sdk
    opentelemetry-exporter-prometheus
    prometheus-client
    sqlalchemy
    alembic
    psycopg2-binary
    apprise
    # subliminal
    # rank-torrent-name
    jsonschema
    # scalar-fastapi
  ];

  makeWrapperArgs = [
    "--prefix PYTHONPATH : ${python3Packages.makePythonPath propagatedBuildInputs}"
  ];

  meta = {
    description = "The frontend for riven";
    homepage = "https://github.com/rivenmedia/riven-frontend";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ camms205 ];
    platforms = lib.platforms.linux;
    mainProgram = "riven";
  };
}
