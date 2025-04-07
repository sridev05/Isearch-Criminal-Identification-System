# save_embeddings.py
import os
import glob
import pickle
import numpy as np
from deepface import DeepFace

CRIMINAL_DB_PATH = "D:/projects/Isearch/backend/criminal_db"
EMBEDDINGS_PATH = "D:/projects/Isearch/backend/criminal_embeddings.pkl"

embeddings = []

for criminal_id in os.listdir(CRIMINAL_DB_PATH):
    folder_path = os.path.join(CRIMINAL_DB_PATH, criminal_id)
    if not os.path.isdir(folder_path):
        continue

    image_paths = glob.glob(os.path.join(folder_path, "*.jpg"))
    if not image_paths:
        continue

    img_path = image_paths[0]  # Use first image per criminal
    try:
        embedding_data = DeepFace.represent(img_path=img_path, model_name="Facenet512", enforce_detection=False)
        if embedding_data:
            embeddings.append({
                "id": criminal_id,
                "embedding": embedding_data[0]["embedding"]
            })
            print(f"Embedding saved for ID: {criminal_id}")
    except Exception as e:
        print(f"Error processing {criminal_id}: {str(e)}")

# Save all embeddings
with open(EMBEDDINGS_PATH, 'wb') as f:
    pickle.dump(embeddings, f)

print(f"Saved {len(embeddings)} embeddings to {EMBEDDINGS_PATH}")
