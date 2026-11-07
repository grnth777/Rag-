<<<<<<< HEAD
# Local RAG Assistant (Windows 11)

A beginner-friendly local document chatbot. It uses **Ollama** for both the chat model and embeddings, **SQLite** to store document chunks and vectors locally, and **FastAPI** to serve a local website.

- Chat model: `qwen2.5:3b` (about 1.9 GB download, quantized)
- Embedding model: `nomic-embed-text`
- Supported files: PDF with selectable text, TXT, Markdown (`.md`), and DOCX
- Local server address: `http://127.0.0.1:8000`
- Ollama local API: `http://127.0.0.1:11434`

No paid API key is used. The website contains no external scripts or CDN resources. Keep the server bound to `127.0.0.1` unless you deliberately configure a more secure deployment.

## 1. Install Ollama and download models

1. Install Ollama for Windows from <https://ollama.com/download/windows>.
2. Open PowerShell and run:

   ```powershell
   ollama pull qwen2.5:3b
   ollama pull nomic-embed-text
   ollama list
   ```

3. Test the model once:

   ```powershell
   ollama run qwen2.5:3b
   ```

   Ask it a question, then type `/bye` to exit. Leave the Ollama app running.

## 2. Prepare Python

Use Python 3.11 if it is already installed. Open PowerShell in this project folder and run:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```

If PowerShell blocks virtual-environment activation, you can skip activation and run these instead:

```powershell
.\.venv\Scripts\python.exe -m pip install --upgrade pip
.\.venv\Scripts\python.exe -m pip install -r requirements.txt
```

## 3. Start the website

With the project folder open in PowerShell:

```powershell
python -m uvicorn app:app --host 127.0.0.1 --port 8000
```

If you skipped activation, use:

```powershell
.\.venv\Scripts\python.exe -m uvicorn app:app --host 127.0.0.1 --port 8000
```

Open <http://127.0.0.1:8000> in your browser. Keep the terminal window and Ollama running while you use the assistant.

## 4. Add your knowledge

- Use **Choose a document** and **Upload & index** to add a PDF, TXT, Markdown, or DOCX file.
- Or put files directly in `data\documents` and click **Re-index all**.
- Wait for indexing to finish. The app extracts text, splits it into chunks, asks Ollama to create a vector for each chunk, and stores chunks/vectors in `data\rag.sqlite3`.
- Ask questions about the uploaded files. The retrieved source filenames appear below answers.

PDFs must contain selectable text. Scanned/image-only PDFs need OCR, which this starter version does not include. Password-protected or corrupted files may fail.

## 5. How the project works

1. `extract_text()` reads supported file types.
2. `split_into_chunks()` makes overlapping text chunks.
3. `create_embeddings()` calls Ollama's local `/api/embed` endpoint.
4. SQLite stores the chunk text and its vector as a local binary blob.
5. `retrieve()` embeds the user's question and ranks stored vectors by cosine similarity.
6. `/api/chat` sends the top matching chunks plus the question to Ollama's `/api/chat` endpoint.
7. The static webpage calls the local FastAPI routes and shows the response.

This is retrieval-augmented generation (RAG), not model fine-tuning. The base model weights are not changed.

## Troubleshooting

### “Cannot connect to Ollama”
Open the Ollama app. Run `ollama list` in PowerShell. The local API should respond at `http://127.0.0.1:11434`.

### Missing model warning
Run these commands in PowerShell:

```powershell
ollama pull qwen2.5:3b
ollama pull nomic-embed-text
```

### `python` or `pip` not found
Check `python --version`. If needed, install Python from <https://www.python.org/downloads/windows/> and enable the PATH option in the installer.

### Answers are slow
The first answer can be slower while Ollama loads the model. Close other memory-heavy apps. The 3B model is selected as a practical starting point for 16 GB RAM and 4 GB VRAM; performance depends on your system and context size.

### The answer doesn't match the document
Check that the file appears in the sidebar and has chunks. Use a specific question and verify the source text is readable. Adjust `CHUNK_SIZE`, `CHUNK_OVERLAP`, and `TOP_K` near the top of `app.py` as you learn. RAG improves grounding but does not guarantee perfect answers.

### Changed the embedding model
Re-index **all** documents after changing `EMBED_MODEL`. Vectors from different embedding models should not be mixed.

### Reset everything
Stop the Python server, close it, then delete `data\rag.sqlite3` to clear the index. Delete files in `data\documents` too if you want to remove the source files as well. Restart the server and re-upload/re-index documents.

## Privacy and safety notes

The app binds to `127.0.0.1`, which is intended for access from this computer only. Do not expose it to your LAN or the public internet without adding authentication and other protections. Your source files, SQLite database, embeddings, and model inference stay local in this setup. You still need internet once to install packages and download model weights; after downloads, ordinary local use can work offline as long as the Python dependencies and models are already installed.
=======
# Rag-
>>>>>>> d67e5738f43831bdd606c6ad4a45bbc1f35c6d96
