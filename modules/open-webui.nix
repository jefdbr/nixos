{
  pkgs,
  ...
}:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    loadModels = [
      "qwen3:14b"
      "bge-m3"
    ];
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "16384";
      HIP_VISIBLE_DEVICES = "0"; # verify with: rocminfo | grep gfx
    };
  };

  virtualisation.podman.enable = true;

  virtualisation.oci-containers.containers.open-webui = {
    image = "ghcr.io/open-webui/open-webui:main";
    volumes = [ "open-webui:/app/backend/data" ];
    extraOptions = [ "--network=host" ];
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      RAG_EMBEDDING_ENGINE = "ollama";
      RAG_EMBEDDING_MODEL = "bge-m3";
      ENABLE_RAG_HYBRID_SEARCH = "true";
      ANONYMIZED_TELEMETRY = "false";
      DO_NOT_TRACK = "true";
      SCARF_NO_ANALYTICS = "true";
    };
  };
}
