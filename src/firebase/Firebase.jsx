// Import the functions you need from the SDKs
import { initializeApp } from "firebase/app";
import { getAuth } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

// Firebase configuration object
const firebaseConfig = {
  apiKey: "AIzaSyCEfMaRKOG0Vb4PdWBayHX4qz_JxTPQL9Q",
  authDomain: "voluntrack-ad4a8.firebaseapp.com",
  projectId: "voluntrack-ad4a8",
  storageBucket: "voluntrack-ad4a8.appspot.com",
  messagingSenderId: "254557740372",
  appId: "1:254557740372:web:5d83d361365ff8f8f27cc1"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firebase Authentication and Firestore
export const auth = getAuth(app); // Pass app to getAuth to ensure proper initialization
export const db = getFirestore(app); // Firestore database instance
export default app;
