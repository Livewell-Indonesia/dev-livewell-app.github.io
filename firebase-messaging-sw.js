if ('serviceWorker' in navigator) {
    navigator.serviceWorker
      .register('../firebase-messaging-sw.js')
      .then(function (registration) {
        console.log('Registration successful, scope is:', registration.scope)
      })
      .catch(function (err) {
        console.log('Service worker registration failed, error:', err)
      })
  
      importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
      importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');
      
      firebase.initializeApp({
        apiKey: "AIzaSyAc-eYwFgTwe2w7jZuae_jmjrn0oBUowzE",
        authDomain: "livewell-apps.firebaseapp.com",
        projectId: "livewell-apps",
        storageBucket: "livewell-apps.appspot.com",
        messagingSenderId: "649229634613",
        appId: "1:649229634613:web:4214220332235e2665357c",
      });
      
      const messaging = firebase.messaging();
  }