import os
import sys
import cv2
import numpy as np

# Add the deepface folder to the Python path
sys.path.append(os.path.join(os.path.dirname(__file__), 'deepface'))

# Import your specific Facenet model
try:
    from deepface.deepface.models.facial_recognition import Facenet
except ImportError as e:
    print(f"Error importing Facenet model: {e}")
    sys.exit(1)

from deepface.deepface.commons import functions

class FacenetAdapter:
    """
    Adapter class to make working with your specific Facenet implementation easier
    """
    def __init__(self, model_type="512"):
        """
        Initialize the FaceNet model
        model_type: "128" or "512" for different dimensions
        """
        try:
            if model_type == "512":
                self.model = Facenet.FaceNet512()
            else:
                self.model = Facenet.FaceNet()
                
            print(f"FaceNet{model_type} model loaded successfully")
        except Exception as e:
            print(f"Error loading FaceNet model: {e}")
            raise
    
    def detect_face(self, img_path):
        """
        Detect face from image
        Returns the detected face and bounding box
        """
        try:
            if isinstance(img_path, str):
                if not os.path.exists(img_path):
                    raise ValueError(f"Image path does not exist: {img_path}")
                img = cv2.imread(img_path)
            else:
                img = img_path
                
            # Use DeepFace's built-in face detection
            face_objs = functions.extract_faces(
                img_path=img_path if isinstance(img_path, str) else img,
                target_size=(160, 160),
                detector_backend="opencv"
            )
            
            if len(face_objs) == 0:
                print("No face detected")
                return None, None
                
            # Return the first detected face
            face = face_objs[0]["face"]
            region = face_objs[0]["facial_area"]
            
            return face, region
            
        except Exception as e:
            print(f"Error in face detection: {e}")
            return None, None
    
    def represent(self, img_path):
        """
        Get face embedding from image
        """
        try:
            # Use the model's represent function directly
            embedding = self.model.represent(img_path)
            return embedding
        except Exception as e:
            print(f"Error getting embedding: {e}")
            return None
    
    def verify(self, img1_path, img2_path, threshold=0.5):
        """
        Verify if two faces match
        """
        try:
            # Get embeddings
            embedding1 = self.represent(img1_path)
            embedding2 = self.represent(img2_path)
            
            if embedding1 is None or embedding2 is None:
                return {"verified": False, "distance": 1.0, "threshold": threshold}
                
            # Calculate cosine similarity
            cosine = np.dot(embedding1, embedding2) / (
                np.linalg.norm(embedding1) * np.linalg.norm(embedding2)
            )
            
            distance = 1 - cosine
            
            verified = distance <= threshold
            
            return {
                "verified": verified,
                "distance": float(distance),
                "threshold": threshold,
                "similarity": float(cosine)
            }
            
        except Exception as e:
            print(f"Error in verification: {e}")
            return {"verified": False, "distance": 1.0, "threshold": threshold, "error": str(e)}
