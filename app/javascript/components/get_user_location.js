const getUserLocation = () => {
  const x = document.getElementById("location");

  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(savePosition);
  } else {
    x.innerHTML = "Geolocation is not supported by this browser.";
  }

  function savePosition(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;
    document.cookie = "cl=" + latitude + "&" + longitude + ";";
  }
}

export { getUserLocation };
