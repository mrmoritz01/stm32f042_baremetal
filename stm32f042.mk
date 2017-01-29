SRC = 	main.c \
		startup.c \
		system_stm32f0xx.c

OUTDIR=.debug
TARGET=STM32F042
FCPU=48000000U

CFLAGS = 	-mthumb \
			-mcpu=cortex-m0 \
			-O0 \
			-D$(TARGET) \
			-DFCPU=$(FCPU) \
			-ffunction-sections \
			-I. \
			-nostartfiles \
			-std=gnu99 \
			-I. \
			-ffunction-sections\
			-fdata-sections \
			-MD \
			-std=c99 \
			-Wall \
			-g

LDFLAGS = 	-gc-sections

OBJ = $(SRC:.c=.o)
OBJS = $(patsubst %,$(OUTDIR)/%,$(OBJ))

export PATH:=/c/compiler/arm-none-eabi-5.4/bin:$(PATH)
CC=arm-none-eabi-gcc

all: clean $(OBJS) $(OUTDIR)/$(TARGET).elf $(OUTDIR)/$(TARGET)

$(OUTDIR)/%.o: %.c
	@mkdir -p $(OUTDIR)
	@echo Compiling ${<}...
	@$(CC) -c $(CFLAGS) ${<} -o ${@}

${OUTDIR}/${TARGET}.elf:
	@echo Linking
	arm-none-eabi-gcc -o ${OUTDIR}/${TARGET}.elf $(OBJS) -Tstm32f042f4p6.ld $(CFLAGS) $(LDFLAGS) 
	
$(OUTDIR)/$(TARGET): $(OUTDIR)/$(TARGET).elf
	@echo Finishing
	arm-none-eabi-objcopy -Obinary $(OUTDIR)/$(TARGET).elf $(OUTDIR)/$(TARGET).bin
	arm-none-eabi-objdump -s -S -D -l -EL -h $(OUTDIR)/$(TARGET).elf > $(OUTDIR)/$(TARGET).lss
	
clean:
	@rm -rf $(OUTDIR)