// binaryDiag.v
module main

import bitfield as bf
import os

const (
	path = 'input.txt'
)

fn get_file() []string {
	f := os.read_lines(path) or { panic('[-] Failed to read input.txt: $err') }
	return f
}

fn get_common_bits(file []string, b_count int) [][]int {
	mut bits := [][]int{len: file[0].len, init: []int{len: 2, init: 0}}

	for line in file {
		l := bf.from_str(line)
		for i in 0 .. b_count {
			bits[i][l.get_bit(i)]++
		}
	}

	return bits
}

fn part1() {
	file := get_file()
	b_count := file[0].len
	bits := get_common_bits(file, b_count)
	mut gamma := bf.new(b_count)
	mut epsilon := bf.new(b_count)

	for i in 0 .. b_count {
		if bits[i][0] < bits[i][1] {
			gamma.set_bit(i)
			continue
		}
		epsilon.set_bit(i)
	}

	answer := gamma.extract(0, b_count) * epsilon.extract(0, b_count)
	println('Part1 answer: $answer')
}

fn count_bit_lines(data []string, xs_removed []bool, pos int) []int {
	mut bit_count := []int{len: 2, init: 0}
	for k, line in data {
		l := bf.from_str(line)
		if !xs_removed[k] {
			bit_count[l.get_bit(pos)]++
		}
	}
	return bit_count
}

fn search_value(common bool) u64 {
	file := get_file()
	b_len := file[0].len
	mut xs_removed := []bool{len: file.len, init: false}

	for i in 0 .. b_len {
		b_count := count_bit_lines(file, xs_removed, i)
		for k, line in file {
			if b_count[0] == 0 || b_count[1] == 0 {
				break
			}
			l := bf.from_str(line)
			bit := l.get_bit(i) & 1
			if !xs_removed[k] {
				if common {
					if (b_count[1] >= b_count[0]) != (bit == 1) {
						xs_removed[k] = true
					}
				} else {
					if (b_count[1] >= b_count[0]) == (bit == 1) {
						xs_removed[k] = true
					}
				}
			}
		}
	}

	mut value := bf.new(b_len)
	for k, v in file {
		l := bf.from_str(v)
		if !xs_removed[k] {
			value = l
		}
	}
	return value.extract(0, b_len)
}

fn part2() {
	o2 := search_value(true)
	co2 := search_value(false)
	answer := o2 * co2
	println('Part2 answer: $answer')
}

fn main() {
	part1()
	part2()
}
