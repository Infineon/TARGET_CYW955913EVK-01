OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys -lstdc++ -lm)


/* This generated linker script template builds  */
/* The template makes use of preprocessor values passed on the linker command line */

/* Example: */
/*   MTB_LINKSYM_PRE_INIT_CFG:    location of firmware pointer to pre_init_cfg structure defined in spar_sdetup.c */
/*   MTB_LINKSYM_APP_SRAM_START:  start address of application in static RAM */
/*   MTB_LINKSYM_APP_SRAM_LENGTH: length of memory region for application in RAM, including HEAP */
/*   MTB_LINKSYM_APP_HEAP_SIZE:   number of bytes in HEAP */




MEMORY
{
	ram_pre_init (r) : ORIGIN = MTB_LINKSYM_PRE_INIT_CFG, LENGTH = 0x4
	ram (rwx) : ORIGIN = MTB_LINKSYM_APP_SRAM_START, LENGTH = MTB_LINKSYM_APP_SRAM_LENGTH
}

SECTIONS
{
	.bss : ALIGN(4)
	{
		CREATE_OBJECT_SYMBOLS
		app_iram_bss_begin = .;
		*(.bss)
		*(.bss.*)
		*(.gnu.linkonce.b.*)
		app_iram_bss_end = .;
	} >ram

	.noinit : ALIGN(8)
	{
		CREATE_OBJECT_SYMBOLS
		KEEP(*(.noinit))
	} >ram

	.rodata :
	{
		CREATE_OBJECT_SYMBOLS
		app_rodata_block_start = .;
		app_rodata_begin = .;
		*(.rodata)
		*(.rodata.*)
		*(.gnu.linkonce.r.*)
		*(.constdata*)
		app_rodata_end = .;
	} >ram

	.pre_init_cfg : ALIGN(4)
	{
		CREATE_OBJECT_SYMBOLS
		KEEP(*(.pre_init_cfg))
	} >ram_pre_init

	.data :
	{
		CREATE_OBJECT_SYMBOLS
		app_iram_data_begin = .;
		*(vtable)
		*(.data)
		*(.data.*)
		*(.gnu.linkonce.d.*)
		. = ALIGN(4);
		PROVIDE_HIDDEN (__preinit_array_start = .);
		KEEP(*(.preinit_array))
		PROVIDE_HIDDEN (__preinit_array_end = .);
		. = ALIGN(4);
		PROVIDE_HIDDEN (__init_array_start = .);
		KEEP(*(SORT(.init_array.*)))
		KEEP(*(.init_array))
		PROVIDE_HIDDEN (__init_array_end = .);
		. = ALIGN(4);
		PROVIDE_HIDDEN (__fini_array_start = .);
		KEEP(*(SORT(.fini_array.*)))
		KEEP(*(.fini_array))
		PROVIDE_HIDDEN (__fini_array_end = .);
		KEEP(*(.jcr*))
		. = ALIGN(4);
		app_iram_data_end = .;
	} >ram

	.ARM.extab :
	{
		CREATE_OBJECT_SYMBOLS
		__extab_start = .;
		*(.ARM.extab*)
		*(.gnu.linkonce.armextab.*)
		__extab_end = .;
	} >ram

	.ARM.exidx :
	{
		CREATE_OBJECT_SYMBOLS
		__exidx_start = .;
		*(.ARM.exidx*)
		*(.gnu.linkonce.armexidx.*)
		__exidx_end = .;
	} >ram

	.heap : ALIGN(8)
	{
		CREATE_OBJECT_SYMBOLS
		. = ALIGN(8);
		__HeapBase = .;
		__end1__ = .;
		end = __end1__;
		KEEP(*(.heap*))
		. += MTB_LINKSYM_APP_HEAP_SIZE;
		__HeapLimit = .;
	} >ram

	.app_entry :
	{
		CREATE_OBJECT_SYMBOLS
		app_entry_block_start = .;
		app_entry_begin = .;
		*(.app_entry)
		app_entry_end = .;
	} >ram

	.text :
	{
		CREATE_OBJECT_SYMBOLS
		app_text_block_start = .;
		app_text_begin = .;
		KEEP(*(.vectors))
		*(.text)
		*(.text.*)
		. = ALIGN(4);
		KEEP(*(.init))
		KEEP(*(.fini))
		KEEP(*crtbegin.o(.ctors))
		KEEP(*crtbegin?.o(.ctors))
		KEEP(*(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors))
		KEEP(*(SORT(.ctors.*)))
		KEEP(*(.ctors))
		*crtbegin.o(.dtors)
		*crtbegin?.o(.dtors)
		*(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
		*(SORT(.dtors.*))
		*(.dtors)
		*(.gnu.linkonce.t.*)
		*(.emb_text)
		*(.text_in_ram)
		*(.cy_ramfunc)
		/* DO NOT EDIT: add module select patterns for *.o to be located in RAM below */
		app_text_end = .;
	} >ram

	app_iram_length = app_text_end - app_iram_bss_begin;
	app_iram_data_begin = app_iram_bss_end;
	app_iram_data_length = app_text_end - app_iram_data_begin;
	app_irom_data_begin = app_iram_data_begin;
	app_iram_bss_length = app_iram_bss_end - app_iram_bss_begin;

}
