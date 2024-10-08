const cards = [
  { front: 'What is HTML?', back: 'HyperText Markup Language' },
  { front: 'What is CSS?', back: 'Cascading Style Sheets' },
  { front: 'What is JavaScript?', back: 'A programming language for the web' },
];

let currentCardIndex = 0;

const cardElement = document.getElementById('card');
const frontContent = document.getElementById('front-content');
const backContent = document.getElementById('back-content');
const prevBtn = document.getElementById('prev-btn');
const nextBtn = document.getElementById('next-btn');

function updateCard() {
  frontContent.textContent = cards[currentCardIndex].front;
  backContent.textContent = cards[currentCardIndex].back;
  cardElement.classList.remove('flipped');
}

function nextCard() {
  currentCardIndex = (currentCardIndex + 1) % cards.length;
  updateCard();
}

function prevCard() {
  currentCardIndex = (currentCardIndex - 1 + cards.length) % cards.length;
  updateCard();
}

cardElement.addEventListener('click', () => {
  cardElement.classList.toggle('flipped');
});

nextBtn.addEventListener('click', nextCard);
prevBtn.addEventListener('click', prevCard);

// Swipe detection
let touchStartX = 0;
let touchEndX = 0;

cardElement.addEventListener('touchstart', e => {
  touchStartX = e.changedTouches[0].screenX;
});

cardElement.addEventListener('touchend', e => {
  touchEndX = e.changedTouches[0].screenX;
  handleSwipe();
});

function handleSwipe() {
  if (touchEndX < touchStartX) nextCard();
  if (touchEndX > touchStartX) prevCard();
}

// Initialize the first card
updateCard();