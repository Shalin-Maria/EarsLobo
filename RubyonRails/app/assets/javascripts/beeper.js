const audio = new Audio('http://soundbible.com/grab.php?id=1815&type=mp3');
document.addEventListener('click', (event)=>{
  let el = event.target;
  if (el.matches('.beeper')) {
    console.log("beep!");
    audio.play();
    el.classList.toggle("disabled");
  }
});