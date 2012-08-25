# src/Makefile for kp investor demo
# Prefiat LLC for Klickpush

demo: demo.js offer-model.js virtual-good-model.js user-location-model.js \
	claim-view.js initial-prompt-view.js thanks-view.js offers-router.js 

%.js: %.coffee
	coffee -c $<

clean:
	rm -f *.js
