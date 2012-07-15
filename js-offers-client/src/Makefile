# src/Makefile for kp investor demo
# Prefiat LLC for Klickpush

demo: demo.js offers-router.js initial-prompt-view.js

%.js: %.coffee
	coffee -c $<

clean:
	rm -f *.js
