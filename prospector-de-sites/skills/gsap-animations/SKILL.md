---
name: gsap-animations
description: Skill for creating elegant, modern, and fluid animations using GSAP. It guides on using gsap.to, gsap.from, gsap.fromTo, and stagger properties in a subtle, professional manner.
---

# GSAP Animations Skill

This skill teaches the system how to build subtle, modern, and high-performance web animations using GSAP (GreenSock Animation Platform).

## 1. CDN Script Injection
To use GSAP, inject the CDN script at the very end of the `<body>` element (before any custom scripts):
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
```

## 2. Core GSAP Functions

Use the following main functions to animate elements:

### A. `gsap.to(target, vars)`
Animates elements *from* their current state *to* the specified values in `vars`.
* **Use Case**: Animating hover states or showing active transitions.
```javascript
// Moves the button 10px to the right and fades it out
gsap.to(".cta-button", { x: 10, opacity: 0, duration: 0.5, ease: "power2.out" });
```

### B. `gsap.from(target, vars)`
Animates elements *from* the values specified in `vars` *to* their current CSS/layout values.
* **Use Case**: Page-load reveals or items sliding in from off-screen or faded states.
```javascript
// Fades in the heading from 20px below its natural position
gsap.from(".hero h1", { y: 20, opacity: 0, duration: 0.8, ease: "power3.out" });
```

### C. `gsap.fromTo(target, fromVars, toVars)`
Animates elements *from* explicit values in `fromVars` *to* explicit values in `toVars`.
* **Use Case**: When you need total control over both starting and ending values, avoiding layout jumps.
```javascript
// Fades in and scales up the image
gsap.fromTo(".hero-image", 
  { opacity: 0, scale: 0.95 },
  { opacity: 1, scale: 1, duration: 1, ease: "back.out(1.7)" }
);
```

## 3. Elegant List Animations with Stagger
When animating a grid of cards, lists, or repeated structural elements, always use the `stagger` property. It staggers the start times of each element in the group to create a sequential cascade rather than animating them all simultaneously.
* Keep stagger times between `0.05` and `0.15` seconds to prevent the animation from feeling slow.
```javascript
// Staggers the entry of service cards
gsap.from(".service-card", {
  y: 30,
  opacity: 0,
  duration: 0.6,
  stagger: 0.1, // delay of 0.1s between each card's start
  ease: "power2.out"
});
```

## 4. Visual Guidelines: Professionalism and Performance
To keep designs premium and professional, follow these guidelines:
* **Subtle is Better**: Keep motions small. Instead of sliding elements across the whole screen, translate them by `15px` to `30px`.
* **Fast Durations**: Keep duration values between `0.4` and `0.8` seconds. Anything longer feels sluggish.
* **Easing**: Use natural easing functions like `"power2.out"` or `"power3.out"` for smooth deceleration. Avoid linear movements.
* **Avoid Performance Overhead**:
  * Animate hardware-accelerated properties: `opacity`, `transform` (`x`, `y`, `scale`, `rotation`).
  * Never animate layout triggers like `width`, `height`, `top`, or `left` which cause browser repaints and lag.
* **Mobile-Friendly**: Disable animations on screens smaller than `768px` to save battery and ensure a lag-free experience.
