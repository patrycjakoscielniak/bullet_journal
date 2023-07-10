import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

admin.initializeApp();

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

exports.createUserRecordInFirebase = functions.auth.user().onCreate((user) => {
    console.log('user created in Firebase', user.uid);
    return admin.firestore().collection('users').doc(user.uid);
});

exports.deleteUserRecordInFirebase = functions.auth.user().onDelete((user)=> {
    console.log('user deleted in Firebase', user.email, user.uid);
    return admin.firestore().collection('users').doc(user.uid).delete();
});