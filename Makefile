SHELL= /bin/bash
entry=src/Main.elm
output=target/app.js
min=target/app.min.js

all:
	yarn
	elm make

#icons:
	#convert -resize 512x512 assets/icon.png assets/icons/android-chrome-512x512.png
	#convert -resize 192x192 assets/icon.png assets/icons/android-chrome-192x192.png
	#convert -resize 180x180 assets/icon.png assets/icons/apple-touch-icon.png
	#convert -resize 16x16 assets/icon.png assets/icons/favicon-16x16.png
	#convert -resize 32x32 assets/icon.png assets/icons/favicon-32x32.png
	#convert -resize 150x150 assets/icon.png assets/icons/mstile-150x150.png
	#convert -resize 16x16 assets/icon.png assets/icons/favicon.ico

dev:
	cp assets/statics/* target/
	elm-live src/Main.elm --dir target/ --start-page ../assets/statics/index.html -u -- --output $(output)

debug:
	cp assets/statics/* target/
	elm-live src/Main.elm --dir target/ --start-page ../assets/statics/index.html -u -- --debug --output $(output)

#prod:
	#elm make --optimize --output=$(output) $(entry)

	#uglifyjs $(output) --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | uglifyjs --mangle --output=$(min)

	#@echo "Initial size: $(shell cat $(output) | wc -c) bytes ($(output))"
	#@echo "Minified size: $(shell cat $(min) | wc -c) bytes ($(min))"
	#@echo "Gzipped size: $(shell cat $(min) | gzip -c | wc -c) bytes"

	#cp target/app*.js assets/statics/* assets/statics/.ht* assets/icons/* ../perfimmo-mobile-binaries/
