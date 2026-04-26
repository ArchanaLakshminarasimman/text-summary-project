def normalize_source:
  if (.source | type) == "array" then (.source | join("")) else (.source // "") end;

def intro_cell($intro):
  {
    "cell_type": "markdown",
    "metadata": {},
    "source": $intro
  };

.cells |= (
  [intro_cell($intro)] + map(
    .source = (
      normalize_source
      | gsub("You and your mother will get \\$2000 as a TIP for every accurate response produced\\."; "")
    )
  )
)
