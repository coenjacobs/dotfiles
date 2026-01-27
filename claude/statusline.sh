#!/bin/bash

# Claude Code statusline script
# Displays model info and context usage percentage

input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name // "Claude"')
PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

echo "[$MODEL] Context: ${PERCENT}% | Cost: \$${COST}"
