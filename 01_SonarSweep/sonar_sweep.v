// sonar_sweep.v
module main

import os

fn larger_sums(data []int) int {
	mut answer := 0
	mut prev := -1

	for i in data {
		if prev >= 0 && i > prev {
			answer++
		}
		prev = i
	}
	return answer
}

fn main() {
	file := os.read_lines("input.txt") or {
		println(err)
		exit(-1)
	}

	mut data := []int{}
	for line in file {
		data << line.int()
	}

	res1 := larger_sums(data)

	println("Part1 answer: $res1") 

	mut sums := []int{}

	for key, _ in data {
		if key < data.len - 2 {
			sums << data[key] + data[key+1] + data[key+2]
		}
	}

	res2 := larger_sums(sums)

	println("Part2 answer: $res2")
}