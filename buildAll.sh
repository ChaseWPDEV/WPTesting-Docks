docker build -t wpphptests ./phpunit
docker build -t wpbackstoptests --build-arg UID=${UID:-1000} --build-arg GID=${GID:-1000} ./backstop
docker build -t wpjesttests ./jest