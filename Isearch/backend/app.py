from flask import Flask, request, jsonify
import os
import cv2
import numpy as np
from PIL import Image
import io
import base64
import pandas as pd
import pickle
from deepface import DeepFace

app = Flask(__name__)

# Paths
CSV_PATH = "D:/projects/Isearch/backend/csv_outputfin.csv"
EMBEDDINGS_PATH = "D:/projects/Isearch/backend/criminal_embeddings.pkl"

# Load criminal metadata
try:
    criminals_df = pd.read_csv(CSV_PATH)
    print(f"✅ Loaded {len(criminals_df)} criminal records from CSV")
except Exception as e:
    print(f"❌ Error loading CSV: {str(e)}")
    criminals_df = pd.DataFrame()

# Load precomputed embeddings
try:
    with open(EMBEDDINGS_PATH, 'rb') as f:
        precomputed_embeddings = pickle.load(f)
    print(f"✅ Loaded {len(precomputed_embeddings)} face embeddings")
except Exception as e:
    print(f"❌ Failed to load embeddings: {e}")
    precomputed_embeddings = []

@app.route('/')
def home():
    return jsonify({"message": "Welcome to Isearch - Face Identification API"})

@app.route('/identify', methods=['POST'])
def identify_person():
    try:
        image_np = None

        if request.is_json and 'image' in request.json:
            base64_str = request.json['image']
            if ',' in base64_str:
                base64_str = base64_str.split(',')[1]
            image_bytes = base64.b64decode(base64_str)
            image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
            image_np = cv2.cvtColor(np.array(image), cv2.COLOR_RGB2BGR)

        elif 'image' in request.files:
            file = request.files['image']
            image_bytes = file.read()
            nparr = np.frombuffer(image_bytes, np.uint8)
            image_np = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        if image_np is None:
            return jsonify({"error": "Invalid image data"}), 400

        person_id = find_face_in_database(image_np)
        if not person_id:
            return jsonify({"error": "No matching criminal found in database"}), 404

        person_details = get_criminal_details(person_id)
        return jsonify({
            "person_id": person_id,
            "person_details": person_details
        })

    except Exception as e:
        return jsonify({"error": f"Error during identification: {str(e)}"}), 500

def find_face_in_database(query_image):
    try:
        temp_query_path = "temp_query.jpg"
        cv2.imwrite(temp_query_path, query_image)

        query_embedding_data = DeepFace.represent(
            img_path=temp_query_path, 
            model_name="Facenet512", 
            enforce_detection=False
        )
        if not query_embedding_data:
            print("❌ Failed to extract query embedding")
            return None

        query_embedding = query_embedding_data[0]["embedding"]
        best_match = None
        best_similarity = -1

        for item in precomputed_embeddings:
            criminal_id = item["id"]
            criminal_embedding = item["embedding"]

            similarity = cosine_similarity(query_embedding, criminal_embedding)

            if similarity > best_similarity and similarity > 0.5:
                best_similarity = similarity
                best_match = criminal_id
                print(f"🔍 Match: {criminal_id} (similarity: {similarity:.4f})")

        if os.path.exists(temp_query_path):
            os.remove(temp_query_path)

        return best_match

    except Exception as e:
        print(f"❌ Error in find_face_in_database: {e}")
        return None

def cosine_similarity(vec1, vec2):
    return np.dot(vec1, vec2) / (np.linalg.norm(vec1) * np.linalg.norm(vec2))

def get_criminal_details(criminal_id):
    try:
        if criminals_df.empty:
            return {"message": "Criminal database not available"}

        try:
            criminal_id_int = int(criminal_id)
            record = criminals_df[criminals_df['ID'] == criminal_id_int]
        except:
            record = criminals_df[criminals_df['ID'].astype(str) == str(criminal_id)]

        if record.empty:
            return {"message": f"No details found for ID: {criminal_id}"}

        details = record.iloc[0].to_dict()
        return {key: str(value) if pd.notna(value) else "N/A" for key, value in details.items()}

    except Exception as e:
        print(f"❌ Error getting details: {e}")
        return {"error": "Failed to retrieve details"}

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
