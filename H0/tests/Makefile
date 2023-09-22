USE_VALGRIND=0 

all: parallel

parallel:
	./misc/run_tests_parallel.sh $(USE_VALGRIND)

sequential:
	./misc/run_tests.sh $(USE_VALGRIND)

bitcode:
	./misc/bitcode.sh

bitcode_remove:
	rm -f test*/bitcode/*
	./misc/clean.sh

oracle:
	./misc/oracle.sh

oracle_remove:
	rm -f test*/output*/*

reinstall: bitcode_remove oracle_remove clean bitcode oracle

clean:
	./misc/clean.sh

.PHONY: parallel sequential bitcode bitcode_remove oracle oracle_remove reinstall clean
