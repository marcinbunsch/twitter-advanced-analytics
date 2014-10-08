.PHONY: test

all:
	npm i
	bower i
	brunch build

watch:
	brunch watch --server

production:
	rm -rf public
	brunch build --production

release: production
	git checkout gh-pages
	cp -r public/* .
	git add .
	git commit -m "Production release"
	git push origin gh-pages
	git checkout master

gh-pages:
	git checkout --orphan gh-pages
	git rm -rf .
	git checkout master -- .gitignore
	git add .
	git commit -m "Start Github pages"
	git push origin gh-pages

test:
	@node_modules/.bin/mocha --compilers coffee:coffee-script/register test

