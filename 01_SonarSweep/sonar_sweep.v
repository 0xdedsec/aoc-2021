// sonar_sweep.v
module main

import os { read_lines }

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
		panic("[-] Failed to read input.txt: $err")
	}

	mut data := []int{cap: 2000}
	for line in file {
		data << line.int()
	}

	mut sums := []int{cap: 2000}

	for key, _ in data {
		if key < data.len - 2 {
			sums << data[key] + data[key+1] + data[key+2]
		}
	}

	res1 := larger_sums(data)
	res2 := larger_sums(sums)

	println("Part1 answer: $res1") 
	println("Part2 answer: $res2")
}