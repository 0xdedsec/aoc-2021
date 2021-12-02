// get_input.v
module main

import net.http
import os 
import time

fn get_cookie(path string) string {
	file := os.read_file(path) or {
		panic("[-] Failed to read cookie: $err")
	}
	return file
}

fn get_input() string {
	t := time.now()
	day := t.day
	year := t.year
	cookie := get_cookie(".cookie")
	config := http.FetchConfig{
		url: "https://adventofcode.com/$year/day/$day/input"
		cookies: {"session": cookie}
	}
	resp := http.fetch(config) or {
		panic("[-] Failed to fetch data: $err")
	}
	return resp.text 
}

fn write_file(path string) {
	data := get_input()
	os.write_file(path, data) or {
		panic("[-] Failed to write file: $err")
	}
}

fn main() {
	if os.args.len < 2 {
		print("usage: get_input <path/to/file>\n\n")
		exit(-1)
	}
	path := os.args[1]
	write_file(path)
}