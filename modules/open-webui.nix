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
  };

  services.open-webui = {
    enable = true;
    port = 8080;
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      RAG_EMBEDDING_ENGINE = "ollama";
      RAG_EMBEDDING_MODEL = "bge-m3";
      ENABLE_RAG_HYBRID_SEARCH = "true";
      ANONYMIZED_TELEMETRY = "false";
    };
  };
}
