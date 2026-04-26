# Abstractive News Summarization with BART and Mistral

This repository contains my NLP course project on abstractive news summarization using transformer models. The work compares pretrained and LoRA fine-tuned versions of `facebook/bart-large-cnn` and `mistralai/Mistral-7B-Instruct-v0.2` on a 3,000-sample subset of the CNN/DailyMail dataset.

The project was completed for `EDS 6397 - Natural Language Processing` at the University of Houston and focuses on how model architecture and parameter-efficient fine-tuning affect summarization quality.

## Project Overview

The goal of this project was to generate concise, coherent summaries for long-form news articles and compare the performance of:

- Pretrained BART
- LoRA fine-tuned BART
- Pretrained Mistral
- LoRA fine-tuned Mistral

The evaluation used standard summarization metrics:

- `ROUGE-1`
- `ROUGE-2`
- `ROUGE-L`
- `ROUGE-Lsum`
- `BERTScore (F1)`

## Dataset

- Dataset: CNN/DailyMail news summarization dataset
- Working subset: 3,000 records
- Split strategy: 80% training and 20% testing
- Source used in notebooks: Kaggle-hosted copy of the dataset

## Approach

### 1. Preprocessing

- Removed HTML tags
- Normalized Unicode text
- Cleaned whitespace and punctuation artifacts
- Converted records into Hugging Face `Dataset` objects

### 2. Modeling

#### BART pipeline

- Base model: `facebook/bart-large-cnn`
- Summarization setup: beam search, max input length of 1024, max summary length of 150
- Fine-tuning: LoRA adapters on the seq2seq architecture

#### Mistral pipeline

- Base model: `mistralai/Mistral-7B-Instruct-v0.2`
- Prompted as an instruction-following summarization task
- 4-bit quantization used to fit GPU constraints
- Fine-tuning: LoRA adapters on decoder attention projections

## Results

| Model | ROUGE-1 | ROUGE-2 | ROUGE-L | ROUGE-Lsum | BERTScore (F1) |
| --- | ---: | ---: | ---: | ---: | ---: |
| Pretrained BART | 0.39 | 0.18 | 0.27 | 0.27 | 0.85 |
| Fine-Tuned BART | 0.40 | 0.19 | 0.29 | 0.29 | 0.87 |
| Pretrained Mistral | 0.12 | 0.07 | 0.09 | 0.09 | 0.82 |
| Fine-Tuned Mistral | 0.17 | 0.08 | 0.12 | 0.15 | 0.83 |

### Key Takeaways

- BART delivered the strongest overall summarization performance.
- LoRA fine-tuning produced measurable gains for both model families.
- Mistral improved after fine-tuning, but still trailed BART on all reported metrics.
- The project showed that parameter-efficient tuning can improve summarization quality without full-model retraining.

## Repository Structure

```text
.
├── notebooks/
│   ├── bart/
│   ├── mistral/
│   └── analysis/
├── docs/
│   ├── proposal/
│   └── reports/
├── examples/
├── scripts/
├── requirements.txt
└── README.md
```

## Important Files

### Notebooks

- `notebooks/bart/bart_pretrained_and_lora.ipynb`
- `notebooks/mistral/mistral_pretrained.ipynb`
- `notebooks/mistral/mistral_lora_finetuned.ipynb`
- `notebooks/analysis/mistral_fine_tune_graph.ipynb`
- Archived rough experiment: `archive/mistral_train_test_kaggle.ipynb`

### Documentation

- Final report: `docs/reports/final-report.pdf`
- Original report draft: `docs/reports/report-original.docx`
- Updated report draft: `docs/reports/report-updated.docx`
- Proposal: `docs/proposal/news-summarization-proposal.pdf`
- Presentation deck: `docs/presentation/news-summarization-presentation.pptx`

## Reproducing the Work

These notebooks were originally developed in Google Colab and Kaggle-style environments, so GPU access is strongly recommended.

1. Create a Python environment and install dependencies from `requirements.txt`.
2. Configure Kaggle access using either environment variables or a local `kaggle.json`.
3. If running the Mistral notebooks, provide a Hugging Face access token through `HUGGINGFACE_TOKEN`.
4. Open the notebooks in Jupyter, Colab, or Kaggle and run the cells in sequence.

Example environment variables:

```bash
export KAGGLE_USERNAME="your_kaggle_username"
export KAGGLE_KEY="your_kaggle_key"
export HUGGINGFACE_TOKEN="your_hf_token"
```

## Limitations

- The experiments used a reduced 3,000-record subset due to compute limits.
- Training large models on Google Colab introduced memory and runtime constraints.
- The work relied on automatic metrics rather than human evaluation.
- Mistral fine-tuning was more sensitive to setup and hyperparameter choices.

## Future Improvements

- Train on a larger portion of the dataset
- Run longer fine-tuning schedules for Mistral
- Add human evaluation for fluency and factual consistency
- Package the best model into a cleaner demo application

## Notes

- Notebook outputs were cleared and sensitive tokens were removed before preparing this repository for GitHub.
- The main notebooks were lightly polished with intro cells so the repo is easier to browse in GitHub.
- This repository preserves the original project artifacts while reorganizing them into a cleaner portfolio-friendly layout.
