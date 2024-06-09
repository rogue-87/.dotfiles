# For sourcing bash files in _profile directory
for file in ~/.bashrc-ext/_profile/*.bash; do
    source $file
done

# For sourcing bash files in _funcs directory
for file in ~/.bashrc-ext/_funcs/*.bash; do
    source $file
done
