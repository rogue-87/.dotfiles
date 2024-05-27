# This is where you should be sourcing bashrc-ext(bashrc extensions)

for file in ~/.bashrc-ext/_profile/*.bash; do
    source $file
done
