onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MIPS_TB/Processor/clk
add wave -noupdate -color {Lime Green} -radix decimal /MIPS_TB/Processor/PCcurr
add wave -noupdate -color {Lime Green} -radix decimal /MIPS_TB/Processor/PCnext
add wave -noupdate -color {Lime Green} -radix decimal /MIPS_TB/Processor/PCselect
add wave -noupdate /MIPS_TB/Processor/currentInstruction
add wave -noupdate -color Cyan /MIPS_TB/Processor/RegDst
add wave -noupdate -color Cyan /MIPS_TB/Processor/Branch
add wave -noupdate -color Cyan /MIPS_TB/Processor/MemRead
add wave -noupdate -color Cyan /MIPS_TB/Processor/MemToReg
add wave -noupdate -color Cyan /MIPS_TB/Processor/MemWrite
add wave -noupdate -color Cyan /MIPS_TB/Processor/ALUSrc
add wave -noupdate -color Cyan /MIPS_TB/Processor/RegWrite
add wave -noupdate -color Cyan /MIPS_TB/Processor/ALUOp
add wave -noupdate /MIPS_TB/Processor/readData
add wave -noupdate -color Yellow -radix decimal -radixshowbase 0 /MIPS_TB/Processor/readData1
add wave -noupdate -radixshowbase 0 /MIPS_TB/Processor/readData2
add wave -noupdate -color Yellow -radix decimal -radixshowbase 0 /MIPS_TB/Processor/inData2
add wave -noupdate /MIPS_TB/Processor/writeData
add wave -noupdate /MIPS_TB/Processor/writeReg
add wave -noupdate -color {Orange Red} /MIPS_TB/Processor/immediateOffset
add wave -noupdate -color Cyan /MIPS_TB/Processor/Instr_Type
add wave -noupdate -color Cyan /MIPS_TB/Processor/Instr_Code
add wave -noupdate -color Cyan /MIPS_TB/Processor/Zero
add wave -noupdate -color Violet -radix decimal -radixshowbase 0 /MIPS_TB/Processor/result
add wave -noupdate -radixshowbase 0 /MIPS_TB/Processor/branchALU_Result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {142 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 309
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {26 ps}
