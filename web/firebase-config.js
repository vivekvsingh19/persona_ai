// Firebase Web Configuration
// Import Firebase modules
import { initializeApp } from 'https://www.gstatic.com/firebasejs/10.7.0/firebase-app.js';
import { getAuth } from 'https://www.gstatic.com/firebasejs/10.7.0/firebase-auth.js';
import { getAnalytics } from 'https://www.gstatic.com/firebasejs/10.7.0/firebase-analytics.js';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyALFBmvJ01wIjSchY2Kz0FhVB6J2vnSR20",
  authDomain: "persona-ai-b0d88.firebaseapp.com",
  projectId: "persona-ai-b0d88",
  storageBucket: "persona-ai-b0d88.firebasestorage.app",
  messagingSenderId: "158986913917",
  appId: "1:158986913917:web:c88fef3b15dbabe7070914",
  measurementId: "G-DXET062F2T"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);

// Initialize Firebase Authentication and get a reference to the service
const auth = getAuth(app);

// Initialize Analytics
const analytics = getAnalytics(app);

// Set persistence to LOCAL (keeps user logged in across sessions)
import { setPersistence, browserLocalPersistence } from 'https://www.gstatic.com/firebasejs/10.7.0/firebase-auth.js';
setPersistence(auth, browserLocalPersistence).catch((error) => {
  console.error('Error setting persistence:', error);
});

export { auth, app, analytics };
