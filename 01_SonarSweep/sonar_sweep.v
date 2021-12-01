// sonar_sweep.v
module main

import os

fn main() {
	file := os.read_lines("input.txt") or {
		println(err)
		exit(-1)
	}

	mut answer := 0
	mut prev := -1

	for line in file {
		x := line.int()
		if prev >= 0 && x > prev {
			answer++
		}
		prev = x
	}

	println("Part1 answer: $answer")
}