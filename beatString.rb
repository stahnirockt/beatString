def setSounds(str = '/path/to/foxdot_snd/')
  #this is the path to /foxdot_snd - folder
  
  @path = str
  
  #this hash is the dictionary for the sounds -> each letter one soundfolder
  @sounds = {:a => @path+'a/lower/',
             :b => @path+'b/lower/',
             :c => @path+'c/lower/',
             :d => @path+'d/lower/',
             :e => @path+'e/lower/',
             :f => @path+'f/lower/',
             :g => @path+'g/lower/',
             :h => @path+'h/lower/',
             :i => @path+'i/lower/',
             :j => @path+'j/lower/',
             :k => @path+'k/lower/',
             :l => @path+'l/lower/',
             :m => @path+'m/lower/',
             :n => @path+'n/lower/',
             :o => @path+'o/lower/',
             :p => @path+'p/lower/',
             :q => @path+'q/lower/',
             :r => @path+'r/lower/',
             :s => @path+'s/lower/',
             :t => @path+'t/lower/',
             :u => @path+'u/lower/',
             :v => @path+'v/lower/',
             :w => @path+'w/lower/',
             :x => @path+'x/lower/',
             :y => @path+'y/lower/',
             :z => @path+'z/lower/',
             :A => @path+'a/upper/',
             :B => @path+'b/upper/',
             :C => @path+'c/upper/',
             :D => @path+'d/upper/',
             :E => @path+'e/upper/',
             :F => @path+'f/upper/',
             :G => @path+'g/upper/',
             :H => @path+'h/upper/',
             :I => @path+'i/upper/',
             :J => @path+'j/upper/',
             :K => @path+'k/upper/',
             :L => @path+'l/upper/',
             :M => @path+'m/upper/',
             :N => @path+'n/upper/',
             :O => @path+'o/upper/',
             :P => @path+'p/upper/',
             :Q => @path+'q/upper/',
             :R => @path+'r/upper/',
             :S => @path+'s/upper/',
             :T => @path+'t/upper/',
             :U => @path+'u/upper/',
             :V => @path+'v/upper/',
             :W => @path+'w/upper/',
             :X => @path+'x/upper/',
             :Y => @path+'y/upper/',
             :Z => @path+'z/upper/',
             :hyphen => @path+'_/hyphen/',
             :whitespace => 'silent'}
end


def checkStringElement(scanner, pattern)
  if scanner.scan(/(\w\:\d+)/)
    soundBank = scanner[0].scan(/\w+/)
    pattern << (sample_paths @sounds[soundBank[0].to_sym])[soundBank[1].to_i]
  elsif scanner.scan(/\w/)
    pattern << @sounds[scanner[0].to_sym]
  elsif scanner.scan(/\-\:\d+/)
    soundBank = scanner[0].scan(/\d+/)
    pattern << (sample_paths @sounds[:hyphen])[soundBank[0].to_i]
  elsif scanner.scan(/\-/)
    pattern << @sounds[:hyphen]
  elsif scanner.scan(/\ /)
    pattern << @sounds[:whitespace]
  elsif scanner.scan(/\[/)
    arryResult = createArray(scanner)
    pattern << arryResult#[0]
    #scanner.pos = arryResult[1]
  elsif scanner.scan(/\(/) != nil
    arryResult = createArray(scanner)
    pattern << arryResult.ring#[0].ring
    #scanner.pos = arryResult[1]
  else
    scanner.scan(/./)
  end
end

#this functions parses the string with Rubys StringScanner
def parseBeatString(str)
  pattern = []
  scanner = StringScanner.new(str)
  until scanner.pos == str.length
    checkStringElement(scanner, pattern)
  end
  pattern
end

def createArray(scanner)
  pattern = []
  until scanner.scan(/\]/) or scanner.scan(/\)/)
    checkStringElement(scanner, pattern)
  end
  return pattern #, scanner.pos
end


def set_beatPattern(patternArray, lookValue)
  patternArray.map do |element|
    if element.kind_of?(SonicPi::Core::RingVector)
      element.alternate(lookValue)
    elsif
      element.kind_of?(Array)
      set_beatPattern(element, lookValue)
    else
      element
    end
  end
end


def beatPattern(patternString, lookValue, str = '/path/to/foxdot_snd/')
  setSounds(str)
  pattern = parseBeatString(patternString)
  set_beatPattern(pattern, lookValue)
end