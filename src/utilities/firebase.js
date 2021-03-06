import firebase from "firebase/app";
import "firebase/auth";
import 'firebase/database';

const firebaseConfig = {
    databaseURL: process.env.VUE_APP_FIREBASE_DATABASE_URL,
    apiKey: process.env.VUE_APP_FIREBASE_API_KEY,
    authDomain: process.env.VUE_APP_FIREBASE_AUTH_DOMAIN,
    projectId: process.env.VUE_APP_FIREBASE_PROJECT_ID,
    storageBucket: process.env.VUE_APP_FIREBASE_STORAGE_BUCKET,
    messagingSenderId: process.env.VUE_APP_FIREBASE_MESSAGING_SENDER_ID,
    appId: process.env.VUE_APP_FIREBASE_APP_ID
}

firebase.initializeApp(firebaseConfig);


const database = firebase.database();
export const chatsRef = database.ref('chats');


export default firebase;

