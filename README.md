# beatString
use a string to create a pattern useable in SonicPis "play_nested_pattern" function

How to use.

1.) Download the files.

2.) in beatString.rb - change '/path/to/foxdot_snd/' to your soundFolder.

Foxdot-Repository is here: https://github.com/Qirky/FoxDot

3.) require the two files in your Project.

4.) copy the code from https://github.com/samaaron/sonic-pi/blob/master/app/server/sonicpi/lib/sonicpi/lang/pattern.rb into a buffer and hit run.

5.) Now you can use the play_nested_pattern function (mode: :samples) and the beatPattern function like this
'''ruby
use_bpm 110

live_loop :foo do
  play_nested_pattern(beatPattern("x-[o-](-:1l)", tick),
                      mode: :samples,
                      beat_length: 0.5)
end
'''
