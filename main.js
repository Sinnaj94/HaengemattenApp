function main(){
  console.log("main");
  Notification.requestPermission().then(function(result) {
    console.log('CLIENT: Notification', result);
    if (result === 'denied') {
       console.log('Permission wasn\'t granted. Allow a retry.');
       return;
     }
     if (result === 'default') {
       console.log('The permission request was dismissed.');
       return;
     }
  });

  if ('serviceWorker' in navigator && 'PushManager' in window) {
    console.log('Service Worker and Push is supported');
	window.addEventListener('load', function() {
		navigator.serviceWorker.register('/sw.js', { updateViaCache: 'none', scope: '/' }).then(function(registration) {
		  console.log('ServiceWorker registration successful with scope: ', registration);

		}, function(err) {
		  console.log('ServiceWorker registration failed: ', err.message, err);
		});
	});
  }
  
  setTimeout(() => {
		const img = new Image();
		img.src = 'images/dog.svg';
		document.getElementById("spawn_image").appendChild(img);
	}, 3000);
}

function displayNotification() {
  if (Notification.permission == 'granted') {
    navigator.serviceWorker.getRegistration().then(function(reg) {
      var options = {
        body: 'Here is a notification body!',
        icon: 'images/example.png',
        vibrate: [100, 50, 100],
        data: {
          dateOfArrival: Date.now(),
          primaryKey: 1
        }
      };
      reg.showNotification('Hello world!', options);
    });
  }
}
