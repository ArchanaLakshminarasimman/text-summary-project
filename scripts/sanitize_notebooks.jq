.cells |= map(
  .outputs = []
  | .execution_count = null
  | .metadata |= del(.execution)
  | .source = (
      (if (.source | type) == "array" then (.source | join("")) else (.source // "") end)
      | gsub(
          "(?m)^import os\\nos\\.environ\\['KAGGLE_USERNAME'\\] = '[^']*'\\nos\\.environ\\['KAGGLE_KEY'\\] = '[^']*'\\n";
          "import os\n# Set Kaggle credentials in the environment before running this notebook.\nos.environ[\"KAGGLE_USERNAME\"] = os.getenv(\"KAGGLE_USERNAME\", \"\")\nos.environ[\"KAGGLE_KEY\"] = os.getenv(\"KAGGLE_KEY\", \"\")\n"
        )
      | gsub(
          "access_token = 'hf_[^']*'";
          "access_token = os.getenv(\"HUGGINGFACE_TOKEN\")"
        )
    )
)
