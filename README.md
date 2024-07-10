# Terminal-Based To-Do List

This is a terminal-based to-do list script written in Bash. It allows you to add, list, complete, remove, and delete all tasks from your to-do list. The script is designed to be used on macOS.

## Script Usage

### Adding a Task
```sh
./todo.sh add "Task description"
```

### Task list
```sh
./todo.sh list
```

### Completing a Task
```sh
./todo.sh complete <task_number>
```

### Removing a Task
```sh
./todo.sh remove <task_number>
```

### Delete all task
```sh
./todo.sh delete_all
```

### To make it easier to use the script, you can create the following aliases in your shell configuration file (.bashrc or .zshrc):

```sh
alias tda="$HOME/todo.sh add"
alias tdl="$HOME/todo.sh list"
alias tdc="$HOME/todo.sh complete"
alias tdr="$HOME/todo.sh remove"
alias tdd="$HOME/todo.sh delete_all"
```

### Adding a Task Using Alias


### Adding a Task
```sh
tda "Task description"
```
### Task list
```sh
tdl
```
### Completing a Task
```sh
tdc
```
### Removing a Task
```sh
tdr
```
### Delete all task
```sh
tdd
```



### Installation
```sh
chmod +x ~/todo.sh
source ~/.bashrc
```
