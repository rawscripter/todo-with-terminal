#!/bin/bash

TODO_FILE="$HOME/.todo_list"

# ANSI color codes
COLOR_GREEN='\033[0;32m'  # Green
COLOR_RED='\033[0;31m'    # Red
COLOR_RESET='\033[0m'     # Reset color

# Load tasks from file
load_tasks() {
    if [[ -f "$TODO_FILE" ]]; then
        tasks=()
        while IFS= read -r line; do
            tasks+=("$line")
        done < "$TODO_FILE"
    else
        tasks=()
    fi
}

# Save tasks to file
save_tasks() {
    printf "%s\n" "${tasks[@]}" > "$TODO_FILE"
}

# Add a new task
add_task() {
    local task="$*"
    tasks+=("$task|0")
    save_tasks
    echo -e "${COLOR_GREEN}Added task: $task${COLOR_RESET}"
}

# List all tasks
list_tasks() {
    load_tasks
    for i in "${!tasks[@]}"; do
        IFS='|' read -r task completed <<< "${tasks[i]}"
        status="[ ]"
        color="$COLOR_RED"
        [[ "$completed" -eq 1 ]] && status="[✓]" && color="$COLOR_GREEN"
        echo -e "${color}$((i + 1)). $status $task${COLOR_RESET}"
    done
}

# Mark a task as completed
complete_task() {
    local index=$(( $1 - 1 ))
    if [[ $index -ge 0 && $index -lt ${#tasks[@]} ]]; then
        IFS='|' read -r task completed <<< "${tasks[index]}"
        tasks[index]="$task|1"
        save_tasks
        echo -e "${COLOR_GREEN}Completed task: $task${COLOR_RESET}"
    else
        echo "Invalid task number: $1"
    fi
}

# Remove a task
remove_task() {
    local index=$(( $1 - 1 ))
    if [[ $index -ge 0 && $index -lt ${#tasks[@]} ]]; then
        unset 'tasks[index]'
        tasks=("${tasks[@]}")
        save_tasks
        echo -e "${COLOR_RED}Removed task $1${COLOR_RESET}"
    else
        echo "Invalid task number: $1"
    fi
}

# Delete all tasks
delete_all_tasks() {
    echo -n "Are you sure you want to delete all tasks? (y/n): "
    read confirm
    if [[ "$confirm" == "y" ]]; then
        tasks=()
        save_tasks
        echo "All tasks deleted."
    else
        echo "Delete operation canceled."
    fi
}

# Main function
main() {
    load_tasks
    case "$1" in
        add)
            shift
            add_task "$@"
            ;;
        list)
            list_tasks
            ;;
        complete)
            complete_task "$2"
            ;;
        remove)
            remove_task "$2"
            ;;
        delete_all)
            delete_all_tasks
            ;;
        *)
            echo "Usage: $0 {add|list|complete|remove|delete_all} [task]"
            ;;
    esac
}

main "$@"
