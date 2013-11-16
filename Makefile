all:
	lt-comp lr apertium-slk.slk.dix slk.automorf.bin
	lt-comp rl apertium-slk.slk.dix slk.autogen.bin

clean:
	rm *.bin
