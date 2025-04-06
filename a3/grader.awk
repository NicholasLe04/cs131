BEGIN {
    FS = ","
    highest = -1
    lowest = 999999
}

# Function to print student report
function print_student_report(name) {
    if (avgs[name] >= 70) {
        status = "Pass"
    } else {
        status = "Fail"
    }
    print "Name:", name, "\tTotal:", scores[name], "\tAverage:", avgs[name], "\tStatus:", status
}

# Skip column names
NR > 1 {
    name = $2
    total = $3 + $4 + $5
    avg = total / 3

    # Store in associative arrays
    scores[name] = total
    avgs[name] = avg

    # Update highest and lowest scoreres
    if (total > highest) {
        highest = total
        top = name
    }
    if (total < lowest) {
        lowest = total
        bottom = name
    }
}

# Print results
END {
    for (name in scores) {
        print_student_report(name)
    }
    print "Top Scorer:", top
    print "Lowest Scorer:", bottom
}

