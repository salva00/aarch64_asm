# Variables
AS      := as
LD      := ld
ASFLAGS := -arch arm64
LDFLAGS := -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64

# Executable name
EXEC    := HelloWorld

# Lists all the .s files in the current directory
SOURCES := $(wildcard *.s)

# Generates the list of .o files
OBJS    := $(SOURCES:.s=.o)

# Default target
all: $(EXEC)

# Linking the object files
$(EXEC): $(OBJS)
	$(LD) -o $@ $^ $(LDFLAGS)

# Compiling the assembly files
%.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<

# Cleaning the object files and the executable
clean:
	rm -f $(OBJS) $(EXEC)
