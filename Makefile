# Makefile for generating the batch jobs

all: batch

batch: conf/init_jobs.def
	./src/gen_jobs.awk $<

add_jobs: conf/new_jobs.def
	./src/gen_jobs.awk $<

clean:
	rm -fr dist
