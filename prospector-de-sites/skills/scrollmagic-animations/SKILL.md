---
name: scrollmagic-animations
description: Skill for triggering GSAP animations based on page scroll using ScrollMagic. It covers controller initialization, scene configuration, and setTween bindings.
---

# ScrollMagic Skill

This skill teaches the system how to trigger animations dynamically based on the user's scroll position, integrating ScrollMagic with GSAP.

## 1. CDN Script Injection
To use ScrollMagic integrated with GSAP, inject these two CDN scripts at the end of the `<body>` element, right after importing GSAP:
```html
<!-- GSAP must be imported first -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

<!-- ScrollMagic and the GSAP plugin for ScrollMagic -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/plugins/animation.gsap.min.js"></script>
```

## 2. Initialization and Key Concepts

To control and trigger animations on scroll, you need a **Controller** and a **Scene**.

### A. The Controller
The main coordinator of ScrollMagic. A single page needs only one controller.
```javascript
const controller = new ScrollMagic.Controller();
```

### B. The Scene
Defines when and where an event (animation, class toggle, etc.) should be triggered.
```javascript
const scene = new ScrollMagic.Scene({
  triggerElement: "#my-section", // Element that triggers the scene when it hits the viewport
  triggerHook: 0.8,              // Viewport hook position (0 = top, 0.5 = middle, 0.8 = bottom)
  reverse: false                 // Set false so the animation only plays once (highly recommended for performance)
});
```

## 3. Linking Scenes with GSAP animations (`.setTween()`)

To make GSAP animations play in response to scroll triggers:
1. Define the GSAP animation (Tween).
2. Instantiate the ScrollMagic Scene.
3. Link the Scene and GSAP Tween using `.setTween(tween)`.
4. Add the Scene to the controller using `.addTo(controller)`.

```javascript
document.addEventListener("DOMContentLoaded", function() {
  // 1. Initialize Controller
  const controller = new ScrollMagic.Controller();

  // 2. Create the GSAP Tween (starts hidden and offset, animates to fully visible)
  const anim = gsap.fromTo("#feature-box", 
    { opacity: 0, y: 30 }, 
    { opacity: 1, y: 0, duration: 0.8, ease: "power2.out" }
  );

  // 3. Create Scene and bind the Tween
  new ScrollMagic.Scene({
    triggerElement: "#feature-box",
    triggerHook: 0.8, // Play animation when #feature-box is 80% down the screen
    reverse: false    // Do not replay when scrolling back up
  })
  .setTween(anim)     // Link GSAP Tween
  .addTo(controller); // Add to Controller
});
```

## 4. Scroll Scrubbing (Direct Scroll Mapping)
To tie the progress of a GSAP animation directly to the scrollbar (so scrolling forward advances the animation, and scrolling backward reverses it):
* Set `duration` (in pixels) on the Scene.
```javascript
// The animation's progress will be stretched across 400px of scrolling
new ScrollMagic.Scene({
  triggerElement: "#interactive-section",
  duration: 400, // duration in pixels
  triggerHook: 0.5
})
.setTween(gsap.to("#spinning-logo", { rotation: 360 }))
.addTo(controller);
```

## 5. Performance and Mobile Guidelines
* **Use `reverse: false` by default**: Once a section animate-in sequence triggers, it doesn't need to fade back out when scrolling up, saving rendering calculations.
* **Skip on Mobile**: Mobile viewports trigger scroll events differently, which can cause jittery behaviors. Wrap ScrollMagic code in media checks or disable it under `768px`.
