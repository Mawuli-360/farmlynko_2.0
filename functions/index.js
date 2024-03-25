/* eslint-disable max-len */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

const axios = require("axios");
const twilio = require("twilio");

admin.initializeApp(functions.config().firebase);

const twilioClient = twilio("AC0ab11c1ba3832ab86671280bdd1cf391", "a6976fc244ea1876eec500f98fbb48d3");

exports.triggerNotifications = functions.pubsub.schedule("0 8-18/2 * * *").timeZone("GMT").onRun(async (context) => {
  try {
    const usersRef = admin.firestore().collection("user");
    const usersSnapshot = await usersRef.get();

    usersSnapshot.forEach(async (userDoc) => {
      const userData = userDoc.data();
      if (userData.notificationPreference === "API") {
        const userAPIEndpoint = userData.apiEndpoint; // Replace with your field name
        try {
          const response = await axios.get(userAPIEndpoint);
          const responseData = response.data;
          console.log("API triggered successfully for user:", userDoc.id, responseData);
        } catch (error) {
          console.error("Error triggering API for user:", userDoc.id, error);
        }
      } else if (userData.notificationPreference === "sms") {
        const userPhoneNumber = userData.phoneNumber; // Replace with your field name
        const smsMessage = "Hello user, it will not rain today.";
        try {
          await twilioClient.messages.create({
            body: smsMessage,
            to: userPhoneNumber,
            from: "+13202628283",
          });
          console.log("SMS sent successfully to user:", userDoc.id);
        } catch (error) {
          console.error("Error sending SMS to user:", userDoc.id, error);
        }
      }
    });
  } catch (error) {
    console.error("Error fetching users:", error);
  }

  return null;
});
