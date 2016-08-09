SRC = 	main.c \
		startup.c

OUTDIR=.debug
TARGET=STM32F042

CFLAGS = 	-mthumb \
			-mcpu=cortex-m0 \
			-O0 \
			-D$(TARGET) \
			-ffunction-sections \
			-I. \
			-std=gnu99 \
			-nostdlib \
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
include $(COMPILER)/arm-gcc-483.gnu.mak

all: clean $(OBJS) $(OUTDIR)/$(TARGET).elf $(OUTDIR)/$(TARGET)

$(OUTDIR)/%.o: %.c
	@mkdir -p $(OUTDIR)
	@echo Compiling ${<}...
	@arm-none-eabi-gcc -c $(CFLAGS) ${<} -o ${@}

${OUTDIR}/${TARGET}.elf:
	@echo Linking
	arm-none-eabi-ld -o ${OUTDIR}/${TARGET}.elf $(OBJS) -Tstm32f042f4p6.ld $(LDFLAGS) 
	
$(OUTDIR)/$(TARGET): $(OUTDIR)/$(TARGET).elf
	@echo Finishing
	arm-none-eabi-objcopy -Obinary $(OUTDIR)/$(TARGET).elf $(OUTDIR)/$(TARGET).bin
	arm-none-eabi-objdump -S $(OUTDIR)/$(TARGET).elf > $(OUTDIR)/$(TARGET).lss
	
clean:
	@rm -rf $(OUTDIR)