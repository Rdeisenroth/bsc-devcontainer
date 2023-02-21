CMP = bsc

NAME?=Testbench
TOP_FILE=$(NAME).bsv
MOD_NAME:=mk$(NAME)
EXE=$(MOD_NAME)_sim

BUILD_DIR=build
SIM_DIR=sim

CARGS?=
ARGS_FIXED ?= -show-schedule
ARGS=$(ARGS_FIXED) $(CARGS) 

all: $(EXE)

$(BUILD_DIR)/$(MOD_NAME).ba: $(TOP_FILE)
	@mkdir -p $(BUILD_DIR)
	$(CMP) -bdir $(BUILD_DIR) -u -sim -g $(MOD_NAME) $(ARGS) -u $<

clean:
	rm -f $(EXE) $(EXE_V) *.so
	rm -rf $(BUILD_DIR) $(SIM_DIR)

$(EXE): $(BUILD_DIR)/$(MOD_NAME).ba
	@mkdir -p $(SIM_DIR)
	$(CMP) -bdir $(BUILD_DIR) -simdir $(SIM_DIR) -u -sim -e $(MOD_NAME) $(ARGS) -o $@

sim: $(EXE)
	@echo Starting Bluesim simulation...
	./$<

vcd: $(EXE)
	@echo Starting Bluesim simulation with vcd output...
	./$< -V dump.vcd
	

# How to use:
# Default top module name is mkTestbench and default top module file is Testbench.bsv
# Place Makefile in same folder as .bsv file

#  make  								to produce executable
#  make sim  							to compile and execute

#  make NAME="Test" 					to produce executable from file Test.bsv with top module mkTest
#  make sim NAME="Test"	  				to compile and execute source code from file Test.bsv with top module mkTest

#  make sim CARGS="-D "CYCLES=10""  	to add macro definition as required in task 1

#  make clean  							to delete build and sim folder and executables

#  make vcd  							to compile, execute and generate vcd waveforms
