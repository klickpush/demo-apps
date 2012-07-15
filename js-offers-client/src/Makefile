# src/Makefile for kp investor demo
# Prefiat LLC for Klickpush

demo: demo.js offer-model.js claim-view.js initial-prompt-view.js offers-router.js

%.js: %.coffee
	coffee -c $<

clean:
	rm -f *.js
