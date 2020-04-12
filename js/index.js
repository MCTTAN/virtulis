<!-- Firebase Login -->
    
    <!-- The core Firebase JS SDK is always required and must be listed first -->
    <script src="https://www.gstatic.com/firebasejs/7.14.0/firebase-app.js"></script>
    
    <!-- TODO: Add SDKs for Firebase products that you want to use
         https://firebase.google.com/docs/web/setup#available-libraries -->
    
    
      // Your web app's Firebase configuration
      var firebaseConfig = {
        apiKey: "AIzaSyBxpChnKp_r1fy7B9931Cnxqe0T-OftvgY",
        authDomain: "virtulis-da62b.firebaseapp.com",
        databaseURL: "https://virtulis-da62b.firebaseio.com",
        projectId: "virtulis-da62b",
        storageBucket: "virtulis-da62b.appspot.com",
        messagingSenderId: "727096552336",
        appId: "1:727096552336:web:3434a5e281580db3"
      };
      // Initialize Firebase
      firebase.initializeApp(firebaseConfig);
   
// References any collection. just add ".(collection)" to specify a specific collection.
var messagesRef = firebase.database();
    
firebase.auth().onAuthStateChanged(function(user) {
  if(user) {
    // User is signed in.
    // document.getElementById("login-div").style.display = "none";
    // document.getElementById("user-div").style.display = "initial";
    
    // document.getElementById("login-div").addEventListener('sign-in-facebook-button', submitForm);
    // document.getElementById("login-div").addEventListener('sign-in-twitter-button', submitForm);
    // document.getElementById("login-div").addEventListener('sign-in-google-button', submitForm);
    
  }
  if(user !== null){
    var email_id = user.email;
    document.getElementById("logged-in-message").innerHTML = "Welcome User: " + email_id;
  }
  
  else {
    // No user is signed in.
    document.getElementById("login-div").style.display = "none";
    document.getElementById("user-div").style.display = "block";
  }
});

document.getElementById("login-div").addEventListener('sign-in-general-button', sign-up);

function sign-up(e) {
  e.preventDefault();
  
  var user-email = getInputVal('email-string');
  var user-password = getInputVal('password-string');
  
  save(user-email, user-password);
}

function getInputVal(id) {
  return document.getElementById(id).value;
}

// Save the values to firebase
function save(email-string, password-string) {
  var newMessagesRef = messagesRef.push();
  newMessagesRef.set({
    user-email: email-string,
    user-password: password-string;
  })
  
}

function login() {
  var userEmail = document.getElementById("email-string").value;
  var userPassword = document.getElementById("password-string").value;
  
  firebase.auth().signInWithEmailAndPassword(userEmail, userPassword).catch(function(error) {
    // Handle Errors here.
    var errorCode = error.code;
    var errorMessage = error.message;
    
    window.alert("Error: " + errorMessage);
  });
}

function logout() {
  firebase.auth().signOut();
}