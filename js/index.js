firebase.auth().onAuthStateChanged(function(user) {
  if(user) {
    // User is signed in.
    // document.getElementById("login-div").style.display = "none";
    // document.getElementById("user-div").style.display = "initial";
    document.getElementById("login-div").addEventListener('sign-in-general-button', submitForm);
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

function submitForm(e) {
  e.preventDefault();
  console.log(123);
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