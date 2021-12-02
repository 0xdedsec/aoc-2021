// dive.v
module main

import os

struct Sub {
mut:
	horizontal int
	depth int
	aim int
}

fn get_space_pos(line string) int {
	mut pos := 0
	for k,v in line {
		if v == 32 {
			pos = k
			break
		}
	}
	return pos
}

fn main() {
	file := os.read_lines("input.txt") or {
		panic("[-] Failed to read input.txt: $err")
	}

	mut p1 := Sub{0,0,0}
	mut p2 := Sub{0,0,0}

	for line in file {
		space_pos := get_space_pos(line)
		direction := line[..space_pos]
		mov := line[space_pos+1..].int()
		match direction {
			'forward' { 
				p1.horizontal += mov
				p2.horizontal += mov
				p2.depth += p2.aim * mov
			}
			'down' {
				p1.depth += mov
				p2.aim += mov
			}
			else {
				p1.depth -= mov
				p2.aim -= mov
			}
		}
	}

	answer1 := p1.horizontal * p1.depth
	answer2 := p2.horizontal * p2.depth
	println("Part1 answer: $answer1")
	println("Part2 answer: $answer2")
}