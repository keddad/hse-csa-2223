# I'm lazy

for filename in *.s; do
    as --gstabs -o "${filename%%.*}".o "${filename%%.*}".s
    gcc "${filename%%.*}".o -o "${filename%%.*}".bin
done