# Advent of Code 2021
Decided to learn and use [Vlang](https://vlang.io) for this year's Advent of Code.

## Getting AoC Input for Puzzles
I wrote a Vlang program to download the input data from the AoC website. You will need to grab your cookie from Chrome developer tools and place it in a file named **.cookie**. The cookie file will need to be placed in the same directory as the **get_input** binary. Then you can run the following:

```bash
./get_input path/to/file/input.txt
```