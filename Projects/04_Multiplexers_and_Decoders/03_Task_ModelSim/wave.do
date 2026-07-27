onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_decoder/A
add wave -noupdate /tb_decoder/B
add wave -noupdate /tb_decoder/Y0
add wave -noupdate /tb_decoder/Y1
add wave -noupdate /tb_decoder/Y2
add wave -noupdate /tb_decoder/Y3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {300 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 139
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
WaveRestoreZoom {0 ps} {1032 ps}
