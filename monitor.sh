#!/bin/bash

# Thresholds
CPU_THRESHOLD=1
MEM_THRESHOLD=1
DISK_THRESHOLD=1

# Function to check CPU usage
check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        echo "CPU very high usage: $cpu_usage%"
    fi
}

# Function to check memory usage
check_memory_usage() {
    mem_usage=$(free | awk '/Mem:/ {print $3/$2 * 100}')
    if (( $(echo "$mem_usage > $MEM_THRESHOLD" | bc -l) )); then
        echo "Memory very high usage: $mem_usage%"
    fi
}

# Function to check disk usage
check_disk_usage() {
    disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    if [ "$disk_usage" -gt "$DISK_THRESHOLD" ]; then
        echo "Disk very high usage: $disk_usage%"
    fi
}

# Run the checks
check_cpu_usage
check_memory_usage
check_disk_usage


